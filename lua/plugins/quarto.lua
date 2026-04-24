return {
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "markdown" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
      "Vigemus/iron.nvim",
    },
    opts = {
      lspFeatures = {
        enabled = true,
        chunks = "curly",
        languages = { "python", "julia" },
        completion = {
          enabled = true,
        },
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
      },
      codeRunner = {
        enabled = true,
        default_method = "iron",
        never_run = { "yaml" },
      },
    },
    keys = {
      {
        "<leader>qv",
        function()
          require("quarto").quartoPreview()
        end,
        desc = "Quarto Preview",
      },
    },
  },
}
