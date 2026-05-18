-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Use a custom filetype so no treesitter parser is attempted (cpp parser crashes on MQL5 syntax)
-- then apply cpp regex syntax for highlighting
vim.filetype.add({
  extension = {
    mq5 = "mql5",
    mq4 = "mql5",
    mqh = "mql5",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "mql5",
  callback = function()
    vim.bo.syntax = "cpp"
  end,
})
