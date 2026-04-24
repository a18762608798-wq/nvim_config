return {
  {
    "Vigemus/iron.nvim",
    ft = { "python", "quarto", "markdown", "julia" },
    config = function()
      local iron = require("iron.core")
      local view = require("iron.view")
      local common = require("iron.fts.common")

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

      local function current_python()
        -- 1. 如果 shell 已经激活了 venv / conda，优先用它
        local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX
        if venv and venv ~= "" then
          local py = venv .. "/bin/python"
          if vim.fn.executable(py) == 1 then
            return { py }
          end
        end

        -- 2. 否则找最近的 Julia Project.toml
        local project_dir = find_project_dir()
        if project_dir then
          -- 3. 使用这个 Julia project 里的 CondaPkg Python
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

        -- 4. 最后 fallback 到系统 Python
        return { "python3" }
      end

      local function current_julia()
        local project_dir = find_project_dir()

        if project_dir then
          return { "julia", "--project=" .. project_dir }
        end

        return { "julia" }
      end

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

          -- 不要把 quarto 永远强制成 julia
          repl_filetype = function(_, ft)
            return ft
          end,

          repl_open_cmd = view.split.vertical.botright(50),
        },
        keymaps = {
          send_code_block = "<leader>rc",
          send_code_block_and_move = "<leader>rn",
          visual_send = "<leader>rs",
          send_line = "<leader>rl",
          send_file = "<leader>rf",
          interrupt = "<leader>rq",
        },
        ignore_blank_lines = true,
      })

      -- ======================
      -- Julia REPL 快捷键
      -- ======================

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

      -- ======================
      -- Python REPL 快捷键
      -- ======================

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

      -- ======================
      -- Quarto 发送到指定 REPL
      -- ======================
      --
      -- <leader>qj: 当前 cell 发到 Julia REPL
      -- <leader>qy: 当前 cell 发到 Python REPL

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
    end,
  },
}
