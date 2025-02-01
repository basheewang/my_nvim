require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- To set maps you don't like.
nomap("i", "<C-k>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- telescope related keymap settings
map("n", "<leader>tz", ":Telescope zoxide <CR>", { desc = "Open zoxide list panel" })
map(
  "n",
  "<leader>fg",
  ":lua require('telescope').extensions.live_grep_args.live_grep_args() <CR>",
  { desc = "Grep by telescope rg extension." }
)
map("n", "<leader>te", ":Telescope <CR>", { desc = "Open Telescope" })
map("n", "<leader>fl", ":FzfLua <CR>", { desc = "Open fzf-lua commands list" })
map("n", "<leader>fd", ":FzfLua files <CR>", { desc = "Open fzf-lua to find files" })
map("n", "<leader>fv", ":FzfLua live_grep_native <CR>", { desc = "Grep by fzf-lua live grep native" })
map("n", "<leader>fe", ":Telescope egrepify <CR>", { desc = "Grep by telescope egrepify extension" })
map(
  "n",
  "<leader>fc",
  ":lua require('fzf-lua').oldfiles({cwd_only=true})<CR>",
  { desc = "search old files under current folder" }
)
map("n", "<leader>tf", ":Telescope frecency <CR>", { desc = "Use frecency to find files" })
map(
  "n",
  "<leader>td",
  ":lua require('telescope').extensions.diff.diff_files({hidden=true}) <CR>",
  { desc = "Diff files" }
)
map(
  "n",
  "<leader>tg",
  ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { desc = "use rg extension for live grep" }
)
map(
  "n",
  "<leader>tc",
  ":lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<CR>",
  { desc = "Use rg extension for strings under cursor" }
)
map(
  "n",
  "<leader>tb",
  ":lua require('telescope.builtin').live_grep{ search_dirs={'%:p'} } <CR>",
  { desc = "search current buffer only" }
)
map(
  "n",
  "<leader>tp",
  ":lua require('telescope.builtin').live_grep{ search_dirs={'%:p:h'} } <CR>",
  { desc = "search folders of current buffer only" }
)

-- Some keymaps for better experience
-- map("n", "<leader>cl", ":Calendar -view=year -position=left <CR>", { desc = "Display Calendar" })
map("n", "<leader>cy", ":Calendar -view=year -week_number <CR>", { desc = "Display Yearly Calendar" })
map("n", "<leader>tn", ":Telescope nerdy <CR>", { desc = "Insert icons from Nerd fonts" })
map("n", "<leader>ty", ":Telescope yank_history <CR>", { desc = "open yank history with Telescope" })
map("n", "<leader>bb", "<cmd>enew<CR>", { desc = "buffer new" })

-- map("n", "z>", ":lua require('ufo').openAllFolds<CR>", { desc = "use ufo to open all folds" })
map("n", "<leader>to", function()
  vim.opt.scrolloff = 999 - vim.o.scrolloff
end, { desc = "Always in center of screen" })
map("n", "]g", ":lua vim.diagnostic.goto_next()<CR>", { desc = "Go to next message" })
map("n", "[g", ":lua vim.diagnostic.goto_prev()<CR>", { desc = "Go to previous message" })
map("n", "<leader>gg", ":GrugFar<CR>", { desc = "use grug-far to search and replace" })
map("n", "<C-p>", "<Cmd>BufferPick<CR>", { desc = "switch to buffer" })
map("n", "<leader>?", ":Cheatsheet<CR>", { desc = "open cheatsheet for reference" })

-- DAP keymap settings
map("n", "<leader>dd", ":lua require('dapui').toggle()<CR>", { desc = "Toggle Dap UI" })
map("n", "<F5>", ":lua require('dap').continue()<CR>", { desc = "Continue Dap" })
map("n", "<leader>B", ":lua require('dap').toggle_breakpoint()<CR>", { desc = "Toggle Breakpoint" })
map("n", "<Leader>dr", function()
  require("dap").repl.open()
end)
map("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "Dap step over" })
map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "Dap step into" })
map("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "Dap step out" })
map("n", "<F4>", function()
  require("dap").close()
end, { desc = "Dap close and out" })

-- Lint settings
map("n", "<leader>fn", ":lua require('lint').try_lint()<CR>", { desc = "Lint current buffer" })

-- LSPSage settings
map("n", "<leader>sf", ":Lspsaga finder<CR>", { desc = "Use LSPSaga to find word under cursor" })
map("n", "<leader>sd", ":Lspsaga hover_doc<CR>", { desc = "Use LSPSaga to check documentation under cursor" })
map("n", "<leader>sc", ":Lspsaga code_action<CR>", { desc = "Use LSPSaga for available code actions" })
map("n", "<leader>sn", ":Lspsaga rename<CR>", { desc = "Use LSPSaga to rename a vairiable/function, etc." })
map("n", "<leader>sl", ":Lspsaga outline<CR>", { desc = "Use LSPSaga to show outline of current buffer" })

-- LSP related
map("n", "<leader>ct", function()
  ---@diagnostic disable-next-line: missing-parameter
  require("tiny-code-action").code_action()
end, { desc = "Code Action" })

-- SnipRun
map("n", "<leader>sr", ":SnipRun<CR>", { desc = "Use SnipRun to run the code", silent = true })

-- LSP signature
map("n", "<leader>sk", function()
  require("lsp_signature").toggle_float_win()
end, { silent = true, noremap = true, desc = "toggle signature" })

-- crates key mappings
-- map("n", "<leader>cs", ":Crates toggle<CR>", { desc = "Toggle Crates features" })

map("n", "<leader>ll", ":Legendary<CR>", { desc = "Show avaiable keymaps by Legendary", silent = true })

-- Github copilot
map("n", "<leader>co", ":Copilot<CR>", { desc = "Use Github Copilot" })
map("n", "<leader>cl", ":CopilotChat<CR>", { desc = "Open Github CopilotChat" })

-- Snacks
map("n", "<leader>Sp", ":lua Snacks.picker() <CR>", { desc = "Open Snacks Picker" })
map("n", "<leader>Sf", ":lua Snacks.picker.files() <CR>", { desc = "Open Snacks to find file" })
