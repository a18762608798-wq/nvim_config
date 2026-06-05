-- ~/.config/nvim/lua/plugins/codecompanion.lua

return {
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },

    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionActions",
      "CodeCompanionCmd",
    },

    keys = {
      {
        "<leader>ac",
        "<cmd>CodeCompanionChat Toggle<cr>",
        mode = { "n", "v" },
        desc = "Toogle (CodeCompanion)",
      },
      {
        "<leader>ad",
        "<cmd>CodeCompanionActions<cr>",
        mode = { "n", "v" },
        desc = "Prompt Actions (CodeCompanion)",
      },
    },

    opts = {
      adapters = {
        http = {
          opts = {
            -- 不每次都弹模型选择
            show_model_choices = false,
          },

          deepseek = function()
            return require("codecompanion.adapters").extend("deepseek", {
              env = {
                -- 这里填环境变量名，不是 sk-xxx 本体
                api_key = "DEEPSEEKAPI",
              },
              schema = {
                model = {
                  -- 便宜、快一点；需要更强再改 deepseek-v4-pro
                  default = "deepseek-v4-flash",
                },
              },
            })
          end,
        },
      },

      interactions = {
        chat = {
          adapter = "deepseek",
        },
        inline = {
          adapter = "deepseek",
        },
        cmd = {
          adapter = "deepseek",
        },
      },
    },
  },
}
