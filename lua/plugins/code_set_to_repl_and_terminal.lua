return {
  {
    -- the statement of plugin and load condition.
    "Vigemus/iron.nvim",
    ft = { "python", "quarto", "markdown", "julia" },
    config = function()
      -- load mdould.
      local iron = require("iron.core")
      local view = require("iron.view")
      local common = require("iron.fts.common")

      -- Definite a function to find project dir
      local function find_project_dir()
        local project = vim.fs.find("Project.toml", {
          path = vim.fn.expand("%:p:h"),
          upward = true,
        })[1]
        if project then
          return vim.fs.dirname(project)
        end
        return nil
      end

      -- Definite a function to find python environment.
      local function current_python()
        -- 1. 如果 shell 已经激活了 venv / conda，优先用它
        local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX
        if venv and venv ~= "" then
          local py = venv .. "/bin/python"
          if vim.fn.executable(py) == 1 then
            return { py }
          end
        end

        local project_dir = find_project_dir() -- find the project

        if project_dir then
          -- 3. If we in the project dir, 使用这个 Julia project 里的 CondaPkg Python
          local result = vim
            .system({
              "julia",
              "--project=" .. project_dir,
              "-e",
              'using CondaPkg; print(CondaPkg.which("python"))',
            }, { text = true })
            :wait() -- wait

          if result.code == 0 then
            local py = vim.trim(result.stdout)
            if py ~= "" and vim.fn.executable(py) == 1 then
              return { py }
            end
          end
        end

        -- 4. 最后 fallback 到系统 Python
        return { "python3" }
      end

      -- Definite a function to choose julia environment
      local function current_julia()
        local project_dir = find_project_dir()

        if project_dir then
          return { "julia", "--project=" .. project_dir }
        end

        return { "julia" }
      end

      -- find the file dir
      local function file_dir()
        return vim.fn.expand("%:p:h")
      end

      -- run julia or python and put output in scratch buffer, no terminal split
      local run_output_buf = nil

      local function get_run_output_buf()
        local output_buf_name = "[Run Output]"

        -- 1. 优先复用本次 nvim session 里记录的 buffer
        if run_output_buf and vim.api.nvim_buf_is_valid(run_output_buf) then
          vim.bo[run_output_buf].buflisted = true
          return run_output_buf
        end

        -- 2. 如果 buffer 已经存在，就按名字找回来
        for _, b in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(b) then
            local name = vim.api.nvim_buf_get_name(b)

            -- 注意：这里必须 vim.pesc，因为 [Run Output] 里面有 []
            if name:match(vim.pesc(output_buf_name) .. "$") then
              run_output_buf = b
              vim.bo[run_output_buf].buflisted = true
              return run_output_buf
            end
          end
        end

        -- 3. 真的不存在时才新建
        run_output_buf = vim.api.nvim_create_buf(true, true)
        vim.api.nvim_buf_set_name(run_output_buf, output_buf_name)

        vim.bo[run_output_buf].buflisted = true
        vim.bo[run_output_buf].buftype = "nofile"
        vim.bo[run_output_buf].bufhidden = "hide"
        vim.bo[run_output_buf].swapfile = false
        vim.bo[run_output_buf].filetype = "log"
        vim.bo[run_output_buf].modifiable = true
        vim.bo[run_output_buf].modified = false

        return run_output_buf
      end

      local function run_in_scratch_buffer(cmd, opts)
        opts = opts or {}

        local buf = get_run_output_buf()

        -- 不新建 split，只在当前窗口显示输出 buffer
        vim.api.nvim_set_current_buf(buf)

        vim.bo[buf].modifiable = true

        vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
          "Running:",
          table.concat(cmd, " "),
          "",
          "Output:",
          "",
        })

        vim.bo[buf].modified = false

        vim.system(cmd, {
          cwd = opts.cwd or file_dir(),
          text = true,
        }, function(result)
          vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(buf) then
              return
            end

            vim.bo[buf].modifiable = true

            local lines = {}

            if result.stdout and result.stdout ~= "" then
              vim.list_extend(lines, vim.split(result.stdout, "\n", { plain = true }))
            end

            if result.stderr and result.stderr ~= "" then
              if #lines > 0 then
                table.insert(lines, "")
              end
              table.insert(lines, "Errors:")
              vim.list_extend(lines, vim.split(result.stderr, "\n", { plain = true }))
            end

            table.insert(lines, "")
            table.insert(lines, "Exit code: " .. result.code)

            vim.api.nvim_buf_set_lines(buf, 5, -1, false, lines)
            vim.bo[buf].modified = false
          end)
        end)
      end

      local function run_current_file()
        vim.cmd("write")

        local ft = vim.bo.filetype
        local file = vim.fn.expand("%:p")
        local project_dir = find_project_dir()
        local cwd = project_dir or file_dir()

        if ft == "python" then
          local cmd = vim.list_extend(current_python(), { file })
          run_in_scratch_buffer(cmd, { cwd = cwd })
        elseif ft == "julia" then
          local cmd = vim.list_extend(current_julia(), { file })
          run_in_scratch_buffer(cmd, { cwd = cwd })
        else
          vim.notify("Only python and julia files are supported", vim.log.levels.WARN)
        end
      end

      -- Use the iron.nvim to call repl
      iron.setup({
        config = {
          scratch_repl = true,
          repl_definition = {
            python = {
              command = current_python,
              format = common.bracketed_paste_python,
              block_dividers = { "# %%", "#%%" },
              env = { PYTHON_BASIC_REPL = "1" },
            },
            julia = {
              command = current_julia,
            },
          },
          repl_filetype = function(_, ft)
            return ft
          end,
          repl_open_cmd = view.split.vertical.botright(50),
        },
        keymaps = {},
        ignore_blank_lines = true,
      })

      -- keymaps
      -- julia
      vim.keymap.set("n", "<leader>jr", function()
        require("iron.core").focus_on("julia")
      end, { desc = "Open/Focus Julia REPL", silent = true })

      vim.keymap.set("n", "<leader>jh", function()
        vim.cmd("IronHide julia")
      end, { desc = "Hide Julia REPL", silent = true })

      vim.keymap.set("n", "<leader>jR", function()
        local iron = require("iron.core")
        iron.close_repl("julia")
        iron.repl_for("julia")
      end, { desc = "Restart Julia REPL", silent = true })

      -- Python REPL 快捷键
      vim.keymap.set("n", "<leader>pr", function()
        require("iron.core").focus_on("python")
      end, { desc = "Open/Focus Python REPL", silent = true })

      vim.keymap.set("n", "<leader>ph", function()
        vim.cmd("IronHide python")
      end, { desc = "Hide Python REPL", silent = true })

      vim.keymap.set("n", "<leader>pR", function()
        local iron = require("iron.core")
        iron.close_repl("python")
        iron.repl_for("python")
      end, { desc = "Restart Python REPL", silent = true })

      -- Quarto 发送到指定 REPL
      vim.keymap.set("n", "<leader>qj", function()
        local iron = require("iron.core")

        iron.repl_for("julia")
        require("quarto.runner").run_cell()

        vim.schedule(function()
          iron.repl_for("julia")
        end)
      end, { desc = "Quarto Run Cell in Julia REPL", silent = true })

      vim.keymap.set("n", "<leader>qp", function()
        local iron = require("iron.core")

        iron.repl_for("python")
        require("quarto.runner").run_cell()

        vim.schedule(function()
          iron.repl_for("python")
        end)
      end, { desc = "Quarto Run Cell in Python REPL", silent = true })

      vim.keymap.set("n", "<leader>rf", run_current_file, {
        desc = "Run current Python/Julia file in scratch buffer",
        silent = true,
      })
    end,
  },
}
