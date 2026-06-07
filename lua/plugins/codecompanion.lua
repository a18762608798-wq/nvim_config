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
        "<leader>ap",
        "<cmd>CodeCompanionActions<cr>",
        mode = { "n", "v" },
        desc = "Prompt Actions (CodeCompanion)",
      },
      {
        "<leader>ai",
        "<cmd>CodeCompanion<cr>",
        mode = { "n", "v" },
        desc = "Inline (CodeCompanion)",
      },
    },

    opts = {
      adapters = {
        http = {
          opts = {
            show_model_choices = false,
          },

          deepseek = function()
            return require("codecompanion.adapters").extend("deepseek", {
              env = {
                api_key = "DEEPSEEK_API_KEY",
              },
              schema = {
                model = {
                  default = "deepseek-v4-flash",
                },
                max_tokens = {
                  default = 16384,
                },
              },
            })
          end,
        },
      },

      interactions = {
        chat = {
          adapter = "deepseek",
          opts = {
            system_prompt = function(ctx)
              return ctx.default_system_prompt
                .. [[

        Additional user preferences:
        - 你是一个资深中文AI助手。
        - 除非用户明确要求其他语言，否则所有解释、总结、提问都默认使用简体中文。
        - 代码、命令、文件名、API 名称保持原文。
        - 回答先给结论，再给必要说明。
        - 对于数学公式，采用$符号的markdown格式。
        ]]
            end,
          },
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
