require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", "<leader>fw", "<cmd>lua require('fzf-lua').live_grep()<CR>", { desc = "fzf fuzzy grep" })
map("n", "<leader>fs", "<cmd>lua require('fzf-lua').lsp_live_workspace_symbols()<CR>", { desc = "fzf workspace symbols" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "fd", "<ESC>")

-- Nvim DAP
map("n", "<leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
	"n",
	"<leader>dd",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Debugger set conditional breakpoint" }
)
map("n", "<leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })
map("n", "<leader>ds", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger run" })


map("n", "gI", vim.lsp.buf.implementation, { desc = "LSP Go to implementation" })
map("n", "K", function()
  local line = vim.api.nvim_win_get_cursor(0)[1] - 1
  local diagnostics = vim.diagnostic.get(0, { lnum = line })

  if #diagnostics > 0 then
    vim.diagnostic.open_float(nil, {
      scope = "line",
      focus = false,
    })
  else
    vim.lsp.buf.hover()
  end
end, { desc = "Diagnostics if present, otherwise LSP hover" })

-- tabufline move buffers
nomap("n", "<leader>b")
map("n", "<leader>bl", "<cmd>lua require'nvchad.tabufline'.move_buf(1)<CR>", { desc = "Move tab to the right" })
map("n", "<leader>bh", "<cmd>lua require'nvchad.tabufline'.move_buf(-1)<CR>", { desc = "Move tab to the left" })

