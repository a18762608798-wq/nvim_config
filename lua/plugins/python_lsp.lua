return {
  -- 覆写 Python LSP 的 pythonPath，让它使用 repl.lua 检测到的项目 Python
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              -- 这里设一个默认值，LspAttach 里会再动态更新
              pythonPath = require("utils.venv_choice").current_python()[1],
            },
          },
        },
      },
    },
  },

  -- 动态设置每个 buffer 的 Python 路径，确保项目切换时 LSP 用对 Python
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("PythonLspDynamicSettings", { clear = true }),
        desc = "Set pyright pythonPath to project Python from repl.lua",
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          -- 只对 pyright / basedpyright 生效
          if client.name ~= "pyright" and client.name ~= "basedpyright" then
            return
          end

          local python_path = require("utils.venv_choice").current_python()[1]
          if not python_path then
            return
          end

          -- 更新客户端配置
          client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, {
            python = {
              pythonPath = python_path,
            },
          })

          -- 通知服务端使用新配置
          vim.lsp.buf_notify(0, "workspace/didChangeConfiguration", {
            settings = client.config.settings,
          })
        end,
      })
    end,
  },
}
