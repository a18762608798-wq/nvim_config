-- This lua file is to cancel the close the MD013, which is use to lint the line length of markdown files.
return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          prepend_args = {
            "--config",
            vim.fn.stdpath("config") .. "/.markdownlint.yaml",
            "--",
          },
        },
      },
    },
  },
}
