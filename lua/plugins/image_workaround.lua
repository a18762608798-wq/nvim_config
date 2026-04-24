return {
  {
    "folke/snacks.nvim",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "image",
        callback = function(ev)
          vim.bo[ev.buf].bufhidden = "wipe"
          vim.bo[ev.buf].swapfile = false
        end,
      })
    end,
  },
}
