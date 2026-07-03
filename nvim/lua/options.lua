require "nvchad.options"

local o = vim.o
o.number = true
o.relativenumber = true
o.foldmethod = 'expr'
o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
o.foldlevelstart = 99 -- Default to no folding

-- o.cursorlineopt ='both' -- to enable cursorline!
