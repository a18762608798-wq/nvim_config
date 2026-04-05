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
        languages = { "python", "bash", "html", "r", "julia" },
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
        "<leader>qp",
        function()
          require("quarto").quartoPreview()
        end,
        desc = "Quarto Preview",
      },
      {
        "<leader>qc",
        function()
          require("quarto.runner").run_cell()
        end,
        desc = "Quarto Run Cell",
      },
      {
        "<leader>qa",
        function()
          require("quarto.runner").run_all()
        end,
        desc = "Quarto Run All",
      },
      {
        "<leader>ql",
        function()
          require("quarto.runner").run_line()
        end,
        desc = "Quarto Run Line",
      },
      {
        mode = "v",
        "<leader>qv",
        function()
          require("quarto.runner").run_range()
        end,
        desc = "Quarto Run Range",
      },
    },
  },
}
