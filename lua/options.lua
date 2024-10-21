require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

o.relativenumber = true

-- Fold related.
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldcolumn = "1"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true

vim.cmd.colorscheme "tokyonight"
-- vim.cmd.colorscheme "catppuccin"

---@diagnostic disable-next-line: assign-type-mismatch
require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/lua/snippets" }
-- vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/snippets"
