return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "InsertEnter",
    opts = {
      provider = "openai_fim_compatible",

      -- DeepSeek API 比本地/LSP 慢，别太激进
      request_timeout = 3,
      throttle = 1000,
      debounce = 400,
      n_completions = 1,

      provider_options = {
        openai_fim_compatible = {
          name = "deepseek",
          api_key = "DEEPSEEK_API_KEY", -- 注意：这里填环境变量名，不是 sk-xxx 本体
          end_point = "https://api.deepseek.com/beta/completions",
          model = "deepseek-v4-flash",
          stream = true,
          optional = {
            max_tokens = 128,
            top_p = 0.9,
            stop = { "\n\n" },
          },
        },
      },
    },
  },

  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      opts.keymap = opts.keymap or {}

      -- 手动触发 DeepSeek 补全：Alt-y
      opts.keymap["<A-y>"] = {
        function(cmp)
          cmp.show({ providers = { "minuet" } })
        end,
      }

      opts.sources = opts.sources or {}
      opts.sources.providers = opts.sources.providers or {}

      opts.sources.providers.minuet = {
        name = "minuet",
        module = "minuet.blink",
        async = true,
        timeout_ms = 3000,
        score_offset = 100,
      }

      -- 推荐先手动触发，不要一上来自动请求 API
      opts.completion = opts.completion or {}
      opts.completion.trigger = opts.completion.trigger or {}
      opts.completion.trigger.prefetch_on_insert = false
    end,
  },
}
