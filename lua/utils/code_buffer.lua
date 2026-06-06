-- 把当前 Python / Julia 文件跑进一个 terminal buffer

local repl = require("utils.venv_choice")

local M = {}

local run_term_buf = nil
local run_term_job = nil

function M.run_in_terminal_buffer(cmd, opts)
  opts = opts or {}

  -- 如果上一次运行的 job 还在，先停掉
  if run_term_job then
    pcall(vim.fn.jobstop, run_term_job)
    run_term_job = nil
  end

  -- 如果上一次的 terminal buffer 还在，删掉
  if run_term_buf and vim.api.nvim_buf_is_valid(run_term_buf) then
    pcall(vim.api.nvim_buf_delete, run_term_buf, { force = true })
    run_term_buf = nil
  end

  -- 新建一个 buffer，用来承载 terminal
  run_term_buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_name(run_term_buf, "[Run Terminal]")
  vim.api.nvim_set_current_buf(run_term_buf)

  -- Neovim 0.11+ 推荐用 jobstart(..., { term = true }) 替代 termopen(...)
  run_term_job = vim.fn.jobstart(cmd, {
    term = true,
    cwd = opts.cwd or repl.file_dir(),
    on_exit = function(_, code, _)
      run_term_job = nil

      vim.schedule(function()
        vim.notify("Run finished with exit code " .. code, vim.log.levels.INFO)
      end)
    end,
  })

  if run_term_job <= 0 then
    vim.notify("Failed to start terminal job", vim.log.levels.ERROR)
    run_term_job = nil
    return
  end

  vim.cmd("startinsert")
end

function M.run_current_file()
  vim.cmd("write")

  local ft = vim.bo.filetype
  local file = vim.fn.expand("%:p")
  local project_dir = repl.find_project_dir()
  local cwd = project_dir or repl.file_dir()

  if ft == "python" then
    local cmd = vim.list_extend(repl.current_python(), { file })
    M.run_in_terminal_buffer(cmd, { cwd = cwd })
  elseif ft == "julia" then
    local cmd = vim.list_extend(repl.current_julia(), { file })
    M.run_in_terminal_buffer(cmd, { cwd = cwd })
  else
    vim.notify("Only python and julia files are supported", vim.log.levels.WARN)
  end
end

return M
