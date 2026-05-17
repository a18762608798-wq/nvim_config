--判断当前项目该用哪个 Python / Julia。

local M = {}

function M.find_project_dir()
  local project = vim.fs.find("Project.toml", {
    path = vim.fn.expand("%:p:h"),
    upward = true,
  })[1]

  if project then
    return vim.fs.dirname(project)
  end

  return nil
end

function M.file_dir()
  return vim.fn.expand("%:p:h")
end

function M.current_python()
  local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX

  if venv and venv ~= "" then
    local py = venv .. "/bin/python"
    if vim.fn.executable(py) == 1 then
      return { py }
    end
  end

  local project_dir = M.find_project_dir()

  if project_dir then
    local result = vim
      .system({
        "julia",
        "--project=" .. project_dir,
        "-e",
        'using CondaPkg; print(CondaPkg.which("python"))',
      }, { text = true })
      :wait()

    if result.code == 0 then
      local py = vim.trim(result.stdout)
      if py ~= "" and vim.fn.executable(py) == 1 then
        return { py }
      end
    end
  end

  return { "python3" }
end

function M.current_julia()
  local project_dir = M.find_project_dir()

  if project_dir then
    return { "julia", "--project=" .. project_dir }
  end

  return { "julia" }
end

return M
