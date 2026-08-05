require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local disable_auto_comment = augroup("disable_auto_comment", { clear = true })

autocmd("FileType", {
  group = disable_auto_comment,
  pattern = "*",
  desc = "Disable automatic comment continuation",
  callback = function()
    vim.opt_local.formatoptions:remove { "c", "r", "o" }
  end,
})
