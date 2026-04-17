return {
  {
    "Vigemus/iron.nvim",
    ft = { "python", "quarto", "markdown", "julia" },
    config = function()
      local iron = require("iron.core")
      local view = require("iron.view")
      local common = require("iron.fts.common")

      local function current_python()
        local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX
        if venv and venv ~= "" then
          local py = venv .. "/bin/python"
          if vim.fn.executable(py) == 1 then
            return { py }
          end
        end
        return { "python3" }
      end

      local function current_julia()
        local project = vim.fs.find("Project.toml", {
          path = vim.fn.expand("%:p:h"),
          upward = true,
        })[1]

        if project then
          return { "julia", "--project=" .. vim.fs.dirname(project) }
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
          repl_filetype = function(_, ft)
            if ft == "quarto" then
              return "julia"
            end
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
      vim.keymap.set("n", "<leader>rr", function()
        require("iron.core").focus_on("julia")
      end, { desc = "Open/Focus Julia REPL", silent = true })

      vim.keymap.set("n", "<leader>ro", function()
        require("iron.core").focus_on("julia")
      end, { desc = "Open/Focus Julia REPL", silent = true })

      vim.keymap.set("n", "<leader>rh", function()
        vim.cmd("IronHide julia")
      end, { desc = "Hide Julia REPL", silent = true })

      vim.keymap.set("n", "<leader>rR", function()
        local iron = require("iron.core")
        iron.close_repl("julia")
        iron.repl_for("julia")
      end, { desc = "Restart Julia REPL", silent = true })
    end,
  },
}
