-- 只声明 iron 插件，配置 REPL，设置 related keymap。
return {
  {
    "Vigemus/iron.nvim",
    ft = { "python", "quarto", "markdown", "julia" },
    config = function()
      local iron = require("iron.core")
      local view = require("iron.view")
      local common = require("iron.fts.common")

      local repl = require("utils.repl")
      local code_runner = require("utils.code_runner")

      iron.setup({
        config = {
          scratch_repl = true,
          repl_definition = {
            python = {
              command = repl.current_python,
              format = common.bracketed_paste_python,
              block_dividers = { "# %%", "#%%" },
              env = { PYTHON_BASIC_REPL = "1" },
            },
            julia = {
              command = repl.current_julia,
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

      vim.keymap.set("n", "<leader>jr", function()
        iron.focus_on("julia")
      end, { desc = "Open/Focus Julia REPL", silent = true })

      vim.keymap.set("n", "<leader>jh", function()
        vim.cmd("IronHide julia")
      end, { desc = "Hide Julia REPL", silent = true })

      vim.keymap.set("n", "<leader>jR", function()
        iron.close_repl("julia")
        iron.repl_for("julia")
      end, { desc = "Restart Julia REPL", silent = true })

      vim.keymap.set("n", "<leader>pr", function()
        iron.focus_on("python")
      end, { desc = "Open/Focus Python REPL", silent = true })

      vim.keymap.set("n", "<leader>ph", function()
        vim.cmd("IronHide python")
      end, { desc = "Hide Python REPL", silent = true })

      vim.keymap.set("n", "<leader>pR", function()
        iron.close_repl("python")
        iron.repl_for("python")
      end, { desc = "Restart Python REPL", silent = true })

      vim.keymap.set("n", "<leader>qj", function()
        iron.repl_for("julia")
        require("quarto.runner").run_cell()

        vim.schedule(function()
          iron.repl_for("julia")
        end)
      end, { desc = "Quarto Run Cell in Julia REPL", silent = true })

      vim.keymap.set("n", "<leader>qp", function()
        iron.repl_for("python")
        require("quarto.runner").run_cell()
      end, { desc = "Quarto Run Cell in Python REPL", silent = true })

      vim.keymap.set("n", "<leader>rf", code_runner.run_current_file, {
        desc = "Run current Python/Julia file in terminal buffer",
        silent = true,
      })
    end,
  },
}
