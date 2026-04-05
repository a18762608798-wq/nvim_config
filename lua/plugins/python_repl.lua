return {
  {
    "Vigemus/iron.nvim",
    ft = { "python", "quarto", "markdown" },
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
          },
          repl_filetype = function(_, ft)
            if ft == "quarto" then
              return "python"
            end
            return ft
          end,
          repl_open_cmd = view.split.vertical.botright(50),
        },
        keymaps = {
          toggle_repl = "<leader>rr",
          restart_repl = "<leader>rR",
          send_code_block = "<leader>rc",
          send_code_block_and_move = "<leader>rn",
          visual_send = "<leader>rs",
          send_line = "<leader>rl",
          send_file = "<leader>rf",
          interrupt = "<leader>rq",
        },
        ignore_blank_lines = true,
      })

      vim.keymap.set("n", "<leader>ro", "<cmd>IronFocus<cr>", { desc = "Focus REPL" })
      vim.keymap.set("n", "<leader>rh", "<cmd>IronHide<cr>", { desc = "Hide REPL" })
    end,
  },
}
