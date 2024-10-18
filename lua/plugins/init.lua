return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },

  -- below is plugins added by myself

  -- 1. Surround selections, stylishly 😎
  -- some usage:
  --     Old text                    Command         New text
  --------------------------------------------------------------------------------
  --     surr*ound_words             ysiw)           (surround_words)
  --     *make strings               ys$"            "make strings"
  --     [delete ar*ound me!]        ds]             delete around me!
  --     remove <b>HTML t*ags</b>    dst             remove HTML tags
  --     'change quot*es'            cs'"            "change quotes"
  --     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
  --     delete(functi*on calls)     dsf             function calls
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  -- 2. Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
      views = {
        cmdline_popup = {
          position = {
            row = 15,
            col = "50%",
          },
          size = {
            width = 90,
            height = "auto",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          hover = {
            enabled = true,
          },
          signature = {
            enabled = false,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },

  -- {
  --   "gelguy/wilder.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     local wilder = require "wilder"
  --     wilder.setup {
  --       modes = { ":", "/", "?" },
  --     }
  --     wilder.set_option(
  --       "renderer",
  --       wilder.renderer_mux {
  --         [":"] = wilder.popupmenu_renderer {
  --           highlighter = wilder.basic_highlighter(),
  --         },
  --         ["/"] = wilder.wildmenu_renderer {
  --           highlighter = wilder.basic_highlighter(),
  --         },
  --       },
  --       wilder.popupmenu_renderer {
  --         pumblend = 20,
  --         highlighter = wilder.basic_highlighter(),
  --         left = { " ", wilder.popupmenu_devicons() },
  --         right = { " ", wilder.popupmenu_scrollbar() },
  --       }
  --     )
  --   end,
  -- },

  -- 3. Enable a better fzf plugin
  -- Fzf-lua aims to be as plug and play as possible with sane defaults, you can run any fzf-lua command like this:
  --    :lua require('fzf-lua').files()
  -- or using the `FzfLua` vim command:
  --    :FzfLua files
  -- or with arguments:
  --    :lua require('fzf-lua').files({ cwd = '~/.config' })
  -- or using the `FzfLua` vim command:
  --    :FzfLua files cwd=~/.config
  {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup {}
    end,
  },

  -- 4. A pretty list for showing diagnostics, references, telescope results, quickfix
  --    and location lists to help you solve all the trouble your code is causing.
  {
    "folke/trouble.nvim",
    event = "LspAttach",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>dx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>dX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>ds",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>dl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>dL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>dQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- 5. A git interface for Neovim, inspired by Magit.
  -- You can either open Neogit by using the Neogit command:
  --
  -- :Neogit             " Open the status buffer in a new tab
  -- :Neogit cwd=<cwd>   " Use a different repository path
  -- :Neogit cwd=%:p:h   " Uses the repository of the current file
  -- :Neogit kind=<kind> " Open specified popup directly
  -- :Neogit commit      " Open commit popup
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
      "echasnovski/mini.pick", -- optional
    },
    config = true,
  },

  -- 6. An calendar app for vim(neovim)
  -- Basic Usage:
  -- :Calendar
  -- :Calendar 2000 1 1
  -- :Calendar -view=year
  -- :Calendar -view=year -split=vertical -width=27
  -- :Calendar -view=year -split=horizontal -position=below -height=12
  -- :Calendar -first_day=monday
  -- :Calendar -view=clock
  -- You can switch between views with < and > keys.
  {
    "itchyny/calendar.vim",
    event = "VeryLazy",
  },

  -- 7. automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching
  -- You'll also get <a-n> and <a-p> as keymaps to move between references and <a-i> as a textobject for
  -- the reference illuminated under the cursor.
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    -- config = function()
    --   require("illuminate").configure()
    -- end,
  },

  -- 8. A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.
  -- Then open a directory with nvim .. Use <CR> to open a file/directory, and - to go up a directory.
  -- Otherwise, just treat it like a normal buffer and make changes as you like. Remember to :w when
  -- you're done to actually perform the actions.
  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup {
        columns = {
          "icon",
          "permissions",
          "size",
          "mtime",
        },
      }
    end,
  },

  -- 9. a code runner plugin for neovim written in Lua and Rust. It aims to provide
  --    stupidly fast partial code testing for interpreted and compiled languages.
  -- | Shorthand                   | Lua backend                              | <Plug> mapping            |
  -- |-----------------------------+------------------------------------------+---------------------------|
  -- | :SnipRun                    | lua require’sniprun’.run()               | <Plug>SnipRun             |
  -- | (normal node)               | lua require’sniprun’.run(‘n’)            | <Plug>SnipRunOperator     |
  -- | :’<,’>SnipRun (visual mode) | lua require’sniprun’.run(‘v’)            | <Plug>SnipRun             |
  -- | :SnipInfo                   | lua require’sniprun’.info()              | <Plug>SnipInfo            |
  -- | :SnipReset                  | lua require’sniprun’.reset()             | <Plug>SnipReset           |
  -- | :SnipReplMemoryClean        | lua require’sniprun’.clear_repl()        | <Plug>SnipReplMemoryClean |
  -- | :SnipClose                  | lua require’sniprun.display’.close_all() | <Plug>SnipClose           |
  -- | :SnipLive                   | lua require’sniprun.live_mode’.toggle()  | <Plug>SnipLive            |
  -- | ✖                           | lua require’sniprun.api’.run_range(..)   | ✖                         |
  -- | ✖                           | lua require’sniprun.api’.run_string(..)  | ✖                         |
  {
    "michaelb/sniprun",
    branch = "master",
    event = "VeryLazy",

    build = "sh install.sh 1",
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

    config = function()
      require("sniprun").setup {
        -- your options
      }
    end,
  },

  -- 10. properly configures LuaLS for editing your Neovim config by lazily updating your workspace libraries.
  --
  -- NOTE: Copy some config from github, hope this works.
  --
  -- TBH I have no idea how to use it.
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  -- { -- optional completion source for require statements and module annotations
  --   "hrsh7th/nvim-cmp",
  --   opts = function(_, opts)
  --     opts.sources = opts.sources or {}
  --     table.insert(opts.sources, {
  --       name = "lazydev",
  --       group_index = 0, -- set group index to 0 to skip loading LuaLS completions
  --     })
  --   end,
  -- },
  -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim

  -- nvim-cmp config from `https://github.com/gonstoll/dotfiles/blob/master/nvim/.config/nvim/lua/plugins/cmp.lua`
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "L3MON4D3/LuaSnip",
  --     "saadparwaiz1/cmp_luasnip",
  --     "hrsh7th/cmp-nvim-lsp",
  --     "rafamadriz/friendly-snippets",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     "hrsh7th/cmp-cmdline",
  --     "hrsh7th/cmp-calc",
  --     "hrsh7th/cmp-emoji",
  --     -- "onsails/lspkind.nvim",
  --   },
  --   event = "VeryLazy",
  --   config = function()
  --     local cmp = require "cmp"
  --     -- local lspkind = require "lspkind"
  --     local luasnip = require "luasnip"
  --     local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
  --
  --     -- local function formatForTailwindCSS(entry, vim_item)
  --     --   if vim_item.kind == "Color" and entry.completion_item.documentation then
  --     --     local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
  --     --     if r then
  --     --       local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
  --     --       local group = "Tw_" .. color
  --     --       if vim.fn.hlID(group) < 1 then
  --     --         vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
  --     --       end
  --     --       vim_item.kind = "●"
  --     --       vim_item.kind_hl_group = group
  --     --       return vim_item
  --     --     end
  --     --   end
  --     --   vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
  --     --   return vim_item
  --     -- end
  --
  --     cmp.setup {
  --       snippet = {
  --         expand = function(args)
  --           luasnip.lsp_expand(args.body)
  --         end,
  --       },
  --       preselect = cmp.PreselectMode.None,
  --       completion = {
  --         completeopt = "menu,menuone,noinsert,noselect",
  --       },
  --       mapping = {
  --         ["<CR>"] = cmp.mapping.confirm { select = false, behavior = cmp.ConfirmBehavior.Insert },
  --         ["<C-e>"] = cmp.mapping.abort(),
  --         ["<C-u>"] = cmp.mapping.scroll_docs(-4),
  --         ["<C-d>"] = cmp.mapping.scroll_docs(4),
  --         ["<Up>"] = cmp.mapping.select_prev_item(cmp_select_opts),
  --         ["<Down>"] = cmp.mapping.select_next_item(cmp_select_opts),
  --         ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select_opts),
  --         ["<C-n>"] = cmp.mapping.select_next_item(cmp_select_opts),
  --         ["<C-y>"] = cmp.mapping.complete(),
  --         ["<Tab>"] = cmp.mapping(function(fallback)
  --           if luasnip.expand_or_jumpable() then
  --             luasnip.expand_or_jump()
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --         ["<S-Tab>"] = cmp.mapping(function(fallback)
  --           if luasnip.jumpable(-1) then
  --             luasnip.jump(-1)
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --       },
  --       sources = cmp.config.sources({
  --         { name = "lazydev", group_index = 0 },
  --         { name = "nvim_lsp" },
  --         { name = "luasnip" },
  --         { name = "nvim_lua" },
  --       }, {
  --         { name = "buffer" },
  --         { name = "emoji" },
  --         { name = "calc" },
  --         { name = "path" },
  --       }),
  --       -- formatting = {
  --       --   expandable_indicator = true,
  --       --   fields = { "abbr", "menu", "kind" },
  --       --   format = lspkind.cmp_format {
  --       --     mode = "symbol",
  --       --     maxwidth = 200,
  --       --     ellipsis_char = "...",
  --       --     before = function(entry, item)
  --       --       local fallback_name = "[" .. entry.source.name .. "]"
  --       --       local menu_icon = {
  --       --         nvim_lsp = "[LSP]",
  --       --         luasnip = "[snip]",
  --       --         path = "[path]",
  --       --         emoji = "[🤌]",
  --       --         nvim_lua = "[api]",
  --       --         calc = "[calc]",
  --       --         buffer = "[buf]",
  --       --         cmdline = "[cmd]",
  --       --       }
  --       --
  --       --       item = formatForTailwindCSS(entry, item)
  --       --       item.menu = menu_icon[entry.source.name] or fallback_name
  --       --
  --       --       return item
  --       --     end,
  --       --   },
  --       -- },
  --
  --       -- disable completion in comments
  --       enabled = function()
  --         local context = require "cmp.config.context"
  --
  --         -- keep command mode completion enabled when cursor is in a comment
  --         if vim.api.nvim_get_mode().mode == "c" then
  --           return true
  --         else
  --           return not context.in_treesitter_capture "comment" and not context.in_syntax_group "Comment"
  --         end
  --       end,
  --     }
  --
  --     -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  --     cmp.setup.cmdline({ "/", "?" }, {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = {
  --         { name = "buffer" },
  --       },
  --     })
  --
  --     -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  --     cmp.setup.cmdline(":", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = cmp.config.sources({
  --         { name = "path" },
  --       }, {
  --         { name = "cmdline" },
  --       }),
  --     })
  --
  --     vim.api.nvim_create_autocmd("ModeChanged", {
  --       pattern = "*",
  --       callback = function()
  --         if
  --           ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
  --           and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
  --           and not require("luasnip").session.jump_active
  --         then
  --           require("luasnip").unlink_current()
  --         end
  --       end,
  --     })
  --   end,
  -- },

  -- another config copy from: https://github.com/desdic/neovim/blob/main/lua/plugins/nvim-cmp.lua
  {
    "hrsh7th/nvim-cmp",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      "lukas-reineke/cmp-under-comparator",
      "kdheepak/cmp-latex-symbols",
      "micangl/cmp-vimtex",
      "ray-x/cmp-treesitter",
      "DasGandlaf/nvim-autohotkey",
      -- "gbprod/yanky.nvim",
      -- "chrisgrieser/cmp_yanky",
    },
    config = function()
      local kind_icons = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
      }

      local cmp = require "cmp"
      local cmplsp = require "cmp_nvim_lsp"
      local compare = require "cmp.config.compare"
      local luasnip = require "luasnip"
      local MAX_ABBR_WIDTH = 30
      local MAX_MENU_WIDTH = 30

      cmplsp.setup()

      cmp.setup {
        -- preselect = false,
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        formatting = {
          expandable_indicator = true,
          fields = { "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            if vim.api.nvim_strwidth(vim_item.abbr) > MAX_ABBR_WIDTH then
              vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, MAX_ABBR_WIDTH) .. "…"
            end
            if vim.api.nvim_strwidth(vim_item.menu or "") > MAX_MENU_WIDTH then
              vim_item.menu = vim.fn.strcharpart(vim_item.menu, 0, MAX_MENU_WIDTH) .. "…"
            end
            local kind = vim_item.kind
            vim_item.kind = " " .. (kind_icons[kind] or "?") .. ""
            local source = entry.source.name
            vim_item.menu = "[" .. source .. "]"

            return vim_item
          end,
        },
        sorting = {
          priority_weight = 1.0,
          comparators = {
            compare.offset,
            compare.exact,
            compare.score,
            compare.recently_used,
            require("cmp-under-comparator").under,
            compare.kind,
          },
        },
        matching = {
          disallow_symbol_nonprefix_matching = true,
          disallow_fuzzy_matching = true,
          disallow_fullfuzzy_matching = true,
          disallow_partial_fuzzy_matching = true,
          disallow_partial_matching = false,
          disallow_prefix_unmatching = true,
        },
        min_length = 0, -- allow for `from package import _` in Python
        mapping = cmp.mapping.preset.insert {
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm { select = false }, -- no not select first item
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          { name = "lazydev", group_index = 0 },
          { name = "luasnip", max_item_count = 5 },
          { name = "nvim_lsp", max_item_count = 5 },
          { name = "nvim_lua", max_item_count = 5 },
          { name = "crates", max_item_count = 5 },
          { name = "emoji", max_item_count = 5 }, --  type :smile, accept the suggestion from the popular menu
          { name = "vimtex", max_item_count = 5 },
          { name = "treesitter", max_item_count = 5 },
          { name = "autohotkey", max_item_count = 5 },
          -- { name = "cmp_yanky", max_item_count = 3 },
          { name = "buffer", max_item_count = 5, keyword_length = 2 },
          { name = "nvim_lsp_signature_help", max_item_count = 5 },
          {
            name = "spell",
            max_item_count = 5,
            keyword_length = 3,
            option = {
              keep_all_entries = false,
              enable_in_context = function()
                return true
              end,
            },
          },
          {
            name = "latex_symbols", -- use \alpha to try it.
            option = {
              -- Type: number Default: 0 -- mixed Possible values:
              -- 0 -- mixed Show the command and insert the symbol
              -- 1 -- julia Show and insert the symbol
              -- 2 -- latex Show and insert the command
              strategy = 0, -- mixed
            },
          },
        },
        -- performance = {
        --   max_view_entries = 20,
        -- },
        window = {
          documentation = cmp.config.window.bordered(),
          completion = cmp.config.window.bordered(),
        },

        -- If you want insert `(` after select function or method item
        -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        -- local cmp = require('cmp')
        -- cmp.event:on(
        --   'confirm_done',
        --   cmp_autopairs.on_confirm_done()
        -- )
      }

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        -- matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },

  -- 11. improve lsp experences in neovim
  -- Three ways to lazy load lspsaga:
  --    1. Use event = 'LspAttach' (need latest lazy.nvim 2023-July-9)
  --    2. Use ft = {filetype} like ft = {'c','cpp', 'lua', 'rust', 'go'},
  --    3. As a depend on nvim-lspconfig
  -- Avaiable commands:
  --    :Lspsaga incoming_calls and :Lspsaga outgoing_calls.
  --    :Lspsaga code_action to invoke.
  --    :Lspsaga peek_definition and :Lspsaga peek_type_definition.
  --    :Lspsaga diagnostic_jump_next and :Lspsaga diagnostic_jump_prev to jump around diagnostics.
  --    :Lspsaga finder and you will see the finder window. By default it shows results for references and implementation.
  --    :Lspsaga term_toggle for Float Terminal.
  --    :Lspsaga hover_doc. If a hover window is opened, then the command would close it. Use :Lspsaga hover_doc ++keep if you want to keep the hover window.
  --    :Lspsaga finder imp to search and preview implementation of interfaces.
  --    Automatically show lightbulbs when the current line has available code actions.
  --    :Lspsaga outline for Outline
  --    :Lspsaga rename to rename
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup {}
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },

  -- 12. provides alternating syntax highlighting (“rainbow parentheses”) for Neovim, powered by Tree-sitter.
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      require("rainbow-delimiters.setup").setup {
        -- strategy = {
        --   [""] = rainbow_delimiters.strategy["global"],
        --   vim = rainbow_delimiters.strategy["local"],
        -- },
        -- query = {
        --   [""] = "rainbow-delimiters",
        --   lua = "rainbow-blocks",
        -- },
        -- priority = {
        --   [""] = 110,
        --   lua = 210,
        -- },
        -- highlight = {
        --   "RainbowDelimiterRed",
        --   "RainbowDelimiterYellow",
        --   "RainbowDelimiterBlue",
        --   "RainbowDelimiterOrange",
        --   "RainbowDelimiterGreen",
        --   "RainbowDelimiterViolet",
        --   "RainbowDelimiterCyan",
        -- },
      }
    end,
  },

  -- 13. Find Nerd Glyphs Easily 🤓 🔭
  -- nerdy.nvim adds a new command Nerdy.
  -- Nerdy also comes with a Telescope extension, to use it add the following to your telescope configs.
  --    require('telescope').load_extension('nerdy')
  -- And then call
  --    :Telescope nerdy
  -- or
  --    :lua require('telescope').extensions.nerdy.nerdy()
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
  },

  -- 14. some extensions for telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "jemag/telescope-diff.nvim",
      "tsakirist/telescope-lazy.nvim",
      "andrew-george/telescope-themes",
      "nvim-lua/popup.nvim",
      "lexay/telescope-zoxide.nvim",
    },
    config = function()
      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = require("telescope.actions").cycle_history_next,
              ["<C-k>"] = require("telescope.actions").cycle_history_prev,
              ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
            },
          },
        },
        extensions = {
          undo = {
            -- telescope-undo.nvim config, see below
          },
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt { postfix = " -g ''" },
                -- Use wildcat to match files/folders or pus !at beginning to exclude the file or folders
                -- or use -tfile_suffix to match files, or -Tfile_suffix to exclude files.
                ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt { postfix = " --iglob **" },
              },
            },
          },
          themes = {
            ignore = {},
          },
        },
      }
      require("telescope").load_extension "undo"
      require("telescope").load_extension "live_grep_args"
      require("telescope").load_extension "file_browser"
      require("telescope").load_extension "project"
      require("telescope").load_extension "frecency"
      require("telescope").load_extension "diff"
      require("telescope").load_extension "lazy"
      require("telescope").load_extension "zoxide"
      require("telescope").load_extension "nerdy"
      require("telescope").load_extension "aerial"
      require("telescope").load_extension "yank_history"
      -- require("telescope").load_extension "themes"
    end,
  },

  -- 15. Leap is a general-purpose motion plugin for Neovim
  -- NOTE: You can keep either `leap` or `flash`, I choose `flash` now.
  --
  -- Leap's default motions allow you to jump to any position in the visible editor
  -- area by entering a 2-character search pattern, and then potentially a label character
  -- to pick your target from multiple matches, similar to Sneak. The main novel idea in Leap
  -- is that you get a preview of the target labels - you can see which key you will need to
  -- press before you actually need to do that.
  -- Initiate the search in the forward (s) or backward (S) direction, or in the other windows (gs).
  -- (Note: you can use a single key for the current window or even the whole tab page, if you are okay with the trade-offs.)
  --    Start typing a 2-character pattern ({char1}{char2}).
  --    After typing the first character, you see "labels" appearing next to some of the {char1}{?} pairs.
  --    You cannot use the labels yet - they only get active after finishing the pattern.
  --        Enter {char2}. If the pair was not labeled, then voilà, you're already there.
  --        You can safely ignore the remaining labels, and continue editing - those are guaranteed
  --        non-conflicting letters, disappearing on the next keypress.
  --    Else: type the label character, that is now active. If there are more matches than available labels,
  --    you can switch between groups, using <space> and <backspace>.
  --    Character pairs give you full coverage of the screen:
  --      s{char}<space> jumps to the last character on a line.
  --      s<space><space> jumps to actual end-of-line characters, including empty lines.
  --    At any stage, <enter> consistently jumps to the next available target (<backspace> steps back):
  --      s<enter>... repeats the previous search.
  --      s{char}<enter>... can be used as a multiline substitute for fFtT motions.
  -- {
  --   "ggandor/leap.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("leap").add_default_mappings()
  --   end,
  -- },

  -- 16. Extensible UI for Neovim notifications and LSP progress messages.
  -- Fidget exposes some of its Lua API functions through :Fidget sub-commands (e.g., :Fidget clear), which support shell-like arguments and completion.
  --    :Fidget clear for Clear active notifications
  --    :Fidget clear_history for Clear notifications history
  --    :Fidget history to Show notifications history
  --    :Fidget lsp_suppress to Suppress LSP progress notifications
  --    :Fidget suppress to Suppress notification window
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      -- options
    },
  },

  -- 17. Better quickfix window in Neovim, polish old quickfix window.
  -- Buffer Commands
  --    BqfEnable: Enable nvim-bqf in quickfix window
  --    BqfDisable: Disable nvim-bqf in quickfix window
  --    BqfToggle: Toggle nvim-bqf in quickfix window
  -- Commands
  --    BqfAutoToggle: Toggle nvim-bqf enable automatically
  -- Function only works in the quickfix window, keys can be customized by lua require('bqf').setup({func_map = {}}).
  -- | Function    | Action                                                   | Def Key |
  -- |-------------+----------------------------------------------------------+---------|
  -- | open        | open the item under the cursor                           | <CR>    |
  -- | openc       | open the item, and close quickfix window                 | o       |
  -- | drop        | use drop to open the item, and close quickfix window     | O       |
  -- | tabdrop     | use tab drop to open the item, and close quickfix window |         |
  -- | tab         | open the item in a new tab                               | t       |
  -- | tabb        | open the item in a new tab, but stay in quickfix window  | T       |
  -- | tabc        | open the item in a new tab, and close quickfix window    | <C-t>   |
  -- | split       | open the item in horizontal split                        | <C-x>   |
  -- | vsplit      | open the item in vertical split                          | <C-v>   |
  -- | prevfile    | go to previous file under the cursor in quickfix window  | <C-p>   |
  -- | nextfile    | go to next file under the cursor in quickfix window      | <C-n>   |
  -- | prevhist    | cycle to previous quickfix list in quickfix window       | <       |
  -- | nexthist    | cycle to next quickfix list in quickfix window           | >       |
  -- | lastleave   | go to last selected item in quickfix window              | '"      |
  -- | stoggleup   | toggle sign and move cursor up                           | <S-Tab> |
  -- | stoggledown | toggle sign and move cursor down                         | <Tab>   |
  -- | stogglevm   | toggle multiple signs in visual mode                     | <Tab>   |
  -- | stogglebuf  | toggle signs for same buffers under the cursor           | '<Tab>  |
  -- | sclear      | clear the signs in current quickfix list                 | z<Tab>  |
  -- | pscrollup   | scroll up half-page in preview window                    | <C-b>   |
  -- | pscrolldown | scroll down half-page in preview window                  | <C-f>   |
  -- | pscrollorig | scroll back to original position in preview window       | zo      |
  -- | ptogglemode | toggle preview window between normal and max size        | zp      |
  -- | ptoggleitem | toggle preview for a quickfix list item                  | p       |
  -- | ptoggleauto | toggle auto-preview when cursor moves                    | P       |
  -- | filter      | create new list for signed items                         | zn      |
  -- | filterr     | create new list for non-signed items                     | zN      |
  -- | fzffilter   | enter fzf mode                                           | zf      |
  --
  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
    ft = "qf",
    dependencies = { "junegunn/fzf" },
    config = function()
      require("bqf").setup()
    end,
  },

  -- 18. A modern Vim and neovim filetype plugin for LaTeX files.
  -- Folding is explained in :help folds
  -- check this url: https://ejmastnak.com/tutorials/vim-latex/vimtex/#getting-started
  -- To check that VimTeX has loaded by opening a file with the .tex extension and issuing the command :VimtexInfo.
  -- All of the mappings (i.e. keyboard shortcuts for commands and actions) provided by VimTeX are nicely
  --    described in a three-column list you can find at :help vimtex-default-mappings.
  -- Change and delete stuffe
  --    Delete surrounding environments using dse
  --    Change surrounding environments using cse
  --    Delete surrounding commands using dsc
  --    Delete surrounding delimiters using dsd
  --    Change surrounding delimiters using csd
  --    Delete surrounding math using ds$
  --    Change surrounding math using cs$
  --    Change surrounding commands using csc
  -- Toggle-style mappings
  --    Toggle starred commands and environments using tsc and tse
  --    Toggle between inline and display math ts$
  --    Toggle surrounding delimiters using tsd
  --    Toggle surrounding fractions using tsf
  -- Motion mappings
  --    Navigate matching content using %
  --    Navigate sections using ]] and its variants
  --    Navigate environments using ]m and its variants
  --    Navigate math zones using ]n and its variants
  --    Navigate Beamer frames using ]r and its variants
  -- Table of VimTeX text objects
  --    | Mapping | Text object                                 |
  --    |---------+---------------------------------------------|
  --    | ac, ic  | LaTeX commands                              |
  --    | ad, id  | Paired delimiters                           |
  --    | ae, ie  | LaTeX environments                          |
  --    | a$, i$  | Inline math                                 |
  --    | aP, iP  | Sections                                    |
  --    | am, im  | Items in itemize and enumerate environments |
  {
    "lervag/vimtex",
    event = "VeryLazy",
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
    end,
    config = function()
      -- require("Vimtex").setup()
      vim.g.vimtex_fold_enabled = 1
      -- vim.g.vimtex_compiler_latexmk = {
      --   'options' : '-pdf -verbose -bibtex -file-line-error -synctex=1 --interaction=nonstopmode'
      -- }
    end,
  },

  -- 19. Lightweight alternative to context.vim
  -- Commands
  --    TSContextEnable, TSContextDisable and TSContextToggle.
  -- {
  --   "nvim-treesitter/nvim-treesitter-context",
  --   event = "BufReadPre",
  --   keys = {
  --     {
  --       "[c",
  --       function()
  --         require("treesitter-context").go_to_context()
  --       end,
  --       { desc = "goto context with treesitter support" },
  --     },
  --   },
  -- },

  -- 50. Syntax aware text-objects, select, move, swap, and peek support.
  -- select
  --    Define your own text objects mappings similar to ip (inner paragraph) and ap (a paragraph).
  -- swap
  --    Define your own mappings to swap the node under the cursor with the next or previous one, like function parameters or arguments.
  -- move
  --    Define your own mappings to jump to the next or previous text object.
  --    This is similar to ]m, [m, ]M, [M Neovim's mappings to jump to the next or previous function.
  --    You can make the movements repeatable like ; and ,.
  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   event = "BufReadPre",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  -- },

  -- 20. Highlight colors for neovim
  -- Ensure termguicolors is enabled if not already
  -- vim.opt.termguicolors = true
  -- | Command                 | Description         |
  -- |-------------------------+---------------------|
  -- | :HighlightColors On     | Turn highlights on  |
  -- | :HighlightColors Off    | Turn highlights off |
  -- | :HighlightColors Toggle | Toggle highlights   |
  {
    "brenoprata10/nvim-highlight-colors",
    event = "InsertEnter",
    config = function()
      require("nvim-highlight-colors").setup {
        enable_tailwind = true,
      }
    end,
  },
  -- TODO: No idea how to merge into cmp!!
  -- {
  --   "hrsh7th/nvim-cmp",
  --   config = function()
  --     require("cmp").setup {
  --       formatting = {
  --         format = require("nvim-highlight-colors").format,
  --       },
  --     }
  --   end,
  -- },

  -- 21. to display lsp hover documentation in a side panel.
  -- Commands
  --    :DocsViewToggle to open/close the docs view panel.
  --    :DocsViewUpdate to manually update the docs view panel (will open the docs view panel if necessary).
  -- NOTE: Disable until further understanding or request from me.
  -- {
  --   "amrbashir/nvim-docs-view",
  --   -- lazy = true,
  --   event = "LspAttach",
  --   cmd = "DocsViewToggle",
  --   opts = {
  --     position = "right",
  --     width = 60,
  --   },
  -- },

  -- 22. LSP signature hint as you type
  -- To toggle floating windows in Normal mode, you need either define a keymap to
  --    vim.lsp.buf.signature_help() or require('lsp_signature').toggle_float_win()
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },

  -- 23. Establish good command workflow and quit bad habit.
  -- NOTE: Disable for now.
  -- {
  --   "m4xshen/hardtime.nvim",
  --   event = "InsertEnter",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = {
  --     enabled = false,
  --   },
  -- },

  -- 24. A better annotation generator. Supports multiple languages and annotation conventions.
  -- `:Neogen` command will generate annotation for the function, class or other relevant type you're currently in
  -- or you can force a certain type of annotation with
  -- `:Neogen <TYPE>`
  --    It'll find the next upper node that matches the type `TYPE`
  --    E.g if you're on a method of a class and do `:Neogen class`, it'll find the class declaration and generate the annotation.
  -- If you like to use the lua API, I exposed a function to generate the annotations.
  --    `require('neogen').generate()`
  -- There is a list of supported languages and fields, with their annotation style
  -- | Languages       | Annotation Conventions                  | Supported annotation types |
  -- |-----------------+-----------------------------------------+----------------------------|
  -- | sh              | Google Style Guide ("google_bash")      | func, file                 |
  -- | c               | Doxygen ("doxygen")                     | func, file, type           |
  -- | cs              | Xmldoc ("xmldoc")                       | func, file, class          |
  -- |                 | Doxygen ("doxygen")                     |                            |
  -- | cpp             | Doxygen ("doxygen")                     | func, file, class          |
  -- | go              | GoDoc ("godoc")                         | func, type                 |
  -- | java            | Javadoc ("javadoc)                      | func, class                |
  -- | javascript      | JSDoc ("jsdoc")                         | func, class, type, file    |
  -- | javascriptreact | JSDoc ("jsdoc")                         | func, class, type, file    |
  -- | julia           | Julia ("julia")                         | func, class                |
  -- | kotlin          | KDoc ("kdoc")                           | func, class                |
  -- | lua             | Emmylua ("emmylua")                     | func, class, type, file    |
  -- |                 | Ldoc ("ldoc")                           |                            |
  -- | php             | Php-doc ("phpdoc")                      | func, type, class          |
  -- | python          | Google docstrings ("google_docstrings") | func, class, type, file    |
  -- |                 | Numpydoc ("numpydoc")                   |                            |
  -- |                 | reST ("reST")                           |                            |
  -- | ruby            | YARD ("yard")                           | func, type, class          |
  -- |                 | Rdoc ("rdoc")                           |                            |
  -- |                 | Tomdoc ("tomdoc")                       |                            |
  -- | rust            | RustDoc ("rustdoc")                     | func, file, class          |
  -- |                 | Alternative ("rust_alternative")        |                            |
  -- | typescript      | JSDoc ("jsdoc")                         | func, class, type, file    |
  -- |                 | TSDoc ("tsdoc")                         |                            |
  -- | typescriptreact | JSDoc ("jsdoc")                         | func, class, type, file    |
  -- |                 | TSDoc ("tsdoc")                         |                            |
  -- | vue             | JSDoc ("jsdoc")                         | func, class, type, file    |
  {
    "danymat/neogen",
    event = "VeryLazy",
    -- config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
    config = function()
      require("neogen").setup {
        -- languages = {
        --   ["cpp.doxygen"] = require "neogen.configurations.cpp",
        -- },
      }
    end,
  },

  -- 25. intelligently reopens files at your last edit position.
  {
    "farmergreg/vim-lastplace",
    event = "VeryLazy",
  },

  -- 26. Tabnine
  -- NOTE:: Disable for now until really need it. It cause a lot lag of Neovim.
  --
  -- Avaiable Commands
  --    :TabnineStatus - to print Tabnine status
  --    :TabnineDisable - to disable Tabnine
  --    :TabnineEnable - to enable Tabnine
  --    :TabnineToggle - to toggle enable/disable
  --    :TabnineChat - to launch Tabnine chat
  --    :TabnineLoginWithAuthToken - to log in using auth token (for headless environments, where no browser is available)
  -- Chat commands -> need pay
  --    :TabnineChat - to open Tabnine Chat
  --    :TabnineFix - to fix the function in scope
  --    :TabnineTest - to generate tests for function in scope
  --    :TabnineExplain - to explain the function in scope
  -- {
  --   "codota/tabnine-nvim",
  --   event = "LspAttach",
  --   build = "./dl_binaries.sh",
  --   config = function()
  --     require("tabnine").setup {
  --       disable_auto_comment = true,
  --       accept_keymap = "<C-a>",
  --       dismiss_keymap = "<C-]>",
  --       debounce_ms = 800,
  --       suggestion_color = { gui = "#90f080", cterm = 244 },
  --       exclude_filetypes = { "TelescopePrompt" },
  --       log_file_path = nil, -- absolute path to Tabnine log file
  --       ignore_certificate_errors = false,
  --     }
  --   end,
  -- },

  -- 27. codeium
  -- NOTE: Disable for now unless really need it.
  -- NOTE: Can't be used while setting proxy in terminal.
  --
  -- After installation and configuration, running :Codeium Auth, copying the token from your browser and pasting it into API token request.
  -- To use Codeium Chat, execute the :Codeium Chat command. The chat will be opened in your default browser using the xdg-open command.
  -- The plugin log is written to ~/.cache/nvim/codeium.log.
  -- {
  --   "Exafunction/codeium.nvim",
  --   event = "LspAttach",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     -- "hrsh7th/nvim-cmp",
  --     {
  --       "hrsh7th/nvim-cmp",
  --       opts = function(_, opts)
  --         opts.sources = opts.sources or {}
  --         table.insert(opts.sources, {
  --           name = "codeium",
  --           group_index = 0, -- set group index to 0 to skip loading LuaLS completions
  --         })
  --       end,
  --       -- opts = function()
  --       --   local cmp_conf = require "plugins.configs.cmp"
  --       --   table.insert(cmp_conf.sources, { name = "codeium" })
  --       --   return cmp_conf
  --       -- end,
  --     },
  --   },
  --   config = function()
  --     require("codeium").setup {
  --       enable_chat = false,
  --     }
  --   end,
  -- },

  -- 30. assists with discovering motions (Both vertical and horizontal) to navigate your current buffer
  -- Toggling: The hints can be toggled on and off with
  --    :Precognition toggle or require("precognition").toggle()
  -- The hints can be peeked, this means that the hint will be show until the next cursor movement.
  --    :Precognition peek or require("precognition").peek()
  {
    "tris203/precognition.nvim",
    event = "InsertEnter",
    opts = {
      -- startVisible = true,
      -- showBlankVirtLine = true,
      -- highlightColor = { link = "Comment" },
      -- hints = {
      --      Caret = { text = "^", prio = 2 },
      --      Dollar = { text = "$", prio = 1 },
      --      MatchingPair = { text = "%", prio = 5 },
      --      Zero = { text = "0", prio = 1 },
      --      w = { text = "w", prio = 10 },
      --      b = { text = "b", prio = 9 },
      --      e = { text = "e", prio = 8 },
      --      W = { text = "W", prio = 7 },
      --      B = { text = "B", prio = 6 },
      --      E = { text = "E", prio = 5 },
      -- },
      -- gutterHints = {
      --     G = { text = "G", prio = 10 },
      --     gg = { text = "gg", prio = 9 },
      --     PrevParagraph = { text = "{", prio = 8 },
      --     NextParagraph = { text = "}", prio = 8 },
      -- },
    },
  },

  -- 31. A treesitter supported autopairing plugin with extensions, and much more
  -- For new users, check out starter documentation (:help ultimate-autopair)
  -- For the default configuration, refer to the documentation (:help ultimate-autopair-default-config).
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    -- branch='v0.6', --recommended as each new version will have breaking changes
    opts = {
      --Config goes here
    },
  },

  -- 32. code outline window
  -- | Command            | Args             | Description                                                            |
  -- |--------------------+------------------+------------------------------------------------------------------------|
  -- | AerialToggle[!]    | left/right/float | Open or close the aerial window. With ! cursor stays in current window |
  -- | AerialOpen[!]      | left/right/float | Open the aerial window. With ! cursor stays in current window          |
  -- | AerialOpenAll      |                  | Open an aerial window for each visible window.                         |
  -- | AerialClose        |                  | Close the aerial window.                                               |
  -- | AerialCloseAll     |                  | Close all visible aerial windows.                                      |
  -- | [count]AerialNext  |                  | Jump forwards {count} symbols (default 1).                             |
  -- | [count]AerialPrev  |                  | Jump backwards [count] symbols (default 1).                            |
  -- | [count]AerialGo[!] |                  | Jump to the [count] symbol (default 1).                                |
  -- | AerialInfo         |                  | Print out debug info related to aerial.                                |
  -- | AerialNavToggle    |                  | Open or close the aerial nav window.                                   |
  -- | AerialNavOpen      |                  | Open the aerial nav window.                                            |
  -- | AerialNavClose     |                  | Close the aerial nav window.                                           |
  -- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
  -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
  -- Additionally, if it is a string that matches "actions.<name>",
  -- it will use the mapping at require("aerial.actions").<name>
  -- Set to `false` to remove a keymap
  -- keymaps = {
  --   ["?"] = "actions.show_help",
  --   ["g?"] = "actions.show_help",
  --   ["<CR>"] = "actions.jump",
  --   ["<2-LeftMouse>"] = "actions.jump",
  --   ["<C-v>"] = "actions.jump_vsplit",
  --   ["<C-s>"] = "actions.jump_split",
  --   ["p"] = "actions.scroll",
  --   ["<C-j>"] = "actions.down_and_scroll",
  --   ["<C-k>"] = "actions.up_and_scroll",
  --   ["{"] = "actions.prev",
  --   ["}"] = "actions.next",
  --   ["[["] = "actions.prev_up",
  --   ["]]"] = "actions.next_up",
  --   ["q"] = "actions.close",
  --   ["o"] = "actions.tree_toggle",
  --   ["za"] = "actions.tree_toggle",
  --   ["O"] = "actions.tree_toggle_recursive",
  --   ["zA"] = "actions.tree_toggle_recursive",
  --   ["l"] = "actions.tree_open",
  --   ["zo"] = "actions.tree_open",
  --   ["L"] = "actions.tree_open_recursive",
  --   ["zO"] = "actions.tree_open_recursive",
  --   ["h"] = "actions.tree_close",
  --   ["zc"] = "actions.tree_close",
  --   ["H"] = "actions.tree_close_recursive",
  --   ["zC"] = "actions.tree_close_recursive",
  --   ["zr"] = "actions.tree_increase_fold_level",
  --   ["zR"] = "actions.tree_open_all",
  --   ["zm"] = "actions.tree_decrease_fold_level",
  --   ["zM"] = "actions.tree_close_all",
  --   ["zx"] = "actions.tree_sync_folds",
  --   ["zX"] = "actions.tree_sync_folds",
  -- },
  {
    "stevearc/aerial.nvim",
    event = "LspAttach",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- 33. an ultra fold in Neovim.
  -- NOTE: Looks has error when use it, Disable it for now.
  --
  -- require('ufo').clos
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   event = "InsertEnter",
  --   dependencies = {
  --     "kevinhwang91/promise-async",
  --   },
  -- },

  -- 34. Navigate your code with search labels, enhanced character motions and Treesitter integration
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    -- @type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- 35. Debug Adapter Protocol client implementation for Neovim
  {
    "mfussenegger/nvim-dap-python",
    event = "LspAttach",
    dependencies = {
      -- "mfussenegger/nvim-dap",
      {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
          require("mason-nvim-dap").setup {
            ensure_installed = { "codelldb" },
            automatic_installation = false,
            handlers = {
              function(config)
                require("mason-nvim-dap").default_setup(config)
              end,
            },
          }
        end,
      },
      -- {
      --   "julianolf/nvim-dap-lldb",
      --   config = function()
      --     require("dap-lldb").setup {}
      --   end,
      -- },
      {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          require("nvim-dap-virtual-text").setup {}
        end,
      },
      {
        "rcarriga/nvim-dap-ui",
        event = "LspAttach",
        dependencies = {
          "mfussenegger/nvim-dap",
          "nvim-neotest/nvim-nio",
        },
        config = function()
          require("dapui").setup()
        end,
      },
    },
    config = function()
      require("dap-python").setup "~/myproj/python/venv/bin/python"
    end,
  },
  -- {
  --   "jay-babu/mason-nvim-dap.nvim",
  --   lazy = false,
  --   config = function()
  --     require("mason-nvim-dap").setup {
  --       ensure_installed = { "codelldb" },
  --       automatic_installation = false,
  --       handlers = {},
  --     }
  --   end,
  -- },

  -- 36. CMake integration in Neovim
  -- NOTE: Doens't work well or I don't know the best way to do this.
  --
  -- Basic usage:
  --    CMakeGenerate # Correspond to cmake ../Step1
  --    CMakeBuild    # Correspond to cmake --build .
  --    CMakeRun      # Correspond to ./Tutorial
  --    CMakeRunTest  # Correspond to ctest --test-dir <build-dir> -R xx
  -- {
  --   "Civitasv/cmake-tools.nvim",
  --   event = "InsertEnter",
  -- },

  -- 37. Perform search and replace operations in the current buffer using a modern user interface and contemporary regex syntax.
  -- " Substitute in entire file. Prefills the *escaped* word under the cursor.
  --      :RipSubstitute
  -- " Substitute in line range of the visual selection.
  --      :'<,'>RipSubstitute
  -- " Substitute in given range (in this case: current line to end of file).
  --      :.,$ RipSubstitute
  {
    "chrisgrieser/nvim-rip-substitute",
    cmd = "RipSubstitute",
    keys = {
      {
        "<leader>fs",
        function()
          require("rip-substitute").sub()
        end,
        mode = { "n", "x" },
        desc = " rip substitute",
      },
    },
  },

  -- 38. Plugin to improve viewing Markdown files in Neovim
  -- Commands
  --    :RenderMarkdown | :RenderMarkdown enable - Enable this plugin
  --        Can also be accessed directly through require('render-markdown').enable()
  --    :RenderMarkdown disable - Disable this plugin
  --        Can also be accessed directly through require('render-markdown').disable()
  --    :RenderMarkdown toggle - Switch between enabling & disabling this plugin
  --        Can also be accessed directly through require('render-markdown').toggle()
  --    :RenderMarkdown expand - Increase anti-conceal margin above and below by 1
  --        Can also be accessed directly through require('render-markdown').expand()
  --    :RenderMarkdown contract - Decrease anti-conceal margin above and below by 1
  --        Can also be accessed directly through require('render-markdown').contract()
  -- Also checl: https://github.com/OXY2DEV/markview.nvim -> An experimental markdown previewer for Neovim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    event = "InsertEnter",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    config = function()
      require("render-markdown").setup {}
    end,
  },

  -- 39. Display one line diagnostic messages where the cursor is, with icons and colors.
  -- API
  -- require("tiny-inline-diagnostic").change(blend, highlights):
  --    change the colors of the diagnostic. You need to refer to setup to see the structure of the blend and highlights options.
  -- require("tiny-inline-diagnostic").get_diagnostic_under_cursor(bufnr):
  --    get the diagnostic under the cursor, useful if you want to display the diagnostic in a statusline.
  -- require("tiny-inline-diagnostic").enable(): enable the diagnostic.
  -- require("tiny-inline-diagnostic").disable(): disable the diagnostic.
  -- require("tiny-inline-diagnostic").toggle(): toggle the diagnostic, on/off.
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    config = function()
      require("tiny-inline-diagnostic").setup()
    end,
  },

  -- 40. Display LSP inlay hints at the end of the line, rather than within the line.
  -- You can switch between displaying inlay hints at the end of the line (this plugin) and within the line (neovim default) by using the enable, disable and toggle functions:
  -- inlay hints will show at the end of the line (default)
  --    require("lsp-endhints").enable()
  -- inlay hints will show as if the plugin was not installed
  --    require("lsp-endhints").disable()
  -- toggle between the two
  --    require("lsp-endhints").toggle()
  {
    "chrisgrieser/nvim-lsp-endhints",
    event = "LspAttach",
    opts = {}, -- required, even if empty
  },

  -- 41. Neovim git GUI powered by libgit2
  -- NOTE: not installed with lua 5.4.7
  -- {
  --   "SuperBo/fugit2.nvim",
  --   opts = {
  --     width = 100,
  --   },
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --     "nvim-lua/plenary.nvim",
  --     {
  --       "chrisgrieser/nvim-tinygit", -- optional: for Github PR view
  --       dependencies = { "stevearc/dressing.nvim" },
  --     },
  --   },
  --   cmd = { "Fugit2", "Fugit2Diff", "Fugit2Graph" },
  --   keys = {
  --     { "<leader>F", mode = "n", "<cmd>Fugit2<cr>" },
  --   },
  -- },

  -- 42. Find And Replace plugin for Neovim
  -- You can open a new grug-far.nvim vertical split buffer with the :GrugFar command.
  -- If you would like to see the actual replacement in the results area, add --replace= to the flags.
  -- For more control, you can programmatically open a grug-far buffer like so: require('grug-far').open(opts)
  -- More examples:
  -- Launch with the current word under the cursor as the search string
  --    :lua require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })
  -- Launch with ast-grep engine
  --    :lua require('grug-far').open({ engine = 'astgrep' })
  -- Launch as a transient buffer which is both unlisted and fully deletes itself when not in use
  --    :lua require('grug-far').open({ transient = true })
  -- Launch, limiting search/replace to current file
  --    :lua require('grug-far').open({ prefills = { paths = vim.fn.expand("%") } })
  -- Launch with the current visual selection, searching only current file
  --    :<C-u>lua require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
  {
    "MagicDuck/grug-far.nvim",
    event = "InsertEnter",
    config = function()
      require("grug-far").setup {}
    end,
  },

  -- 43. The neovim tabline plugin.
  -- No default mappings are provided, here is an example:
  -- local map = vim.api.nvim_set_keymap
  -- local opts = { noremap = true, silent = true }
  --
  -- -- Move to previous/next
  -- map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
  -- map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
  -- -- Re-order to previous/next
  -- map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
  -- map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
  -- -- Goto buffer in position...
  -- map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
  -- map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
  -- map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
  -- map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
  -- map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
  -- map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
  -- map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
  -- map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
  -- map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
  -- map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
  -- -- Pin/unpin buffer
  -- map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
  -- -- Goto pinned/unpinned buffer
  -- --                 :BufferGotoPinned
  -- --                 :BufferGotoUnpinned
  -- -- Close buffer
  -- map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
  -- -- Wipeout buffer
  -- --                 :BufferWipeout
  -- -- Close commands
  -- --                 :BufferCloseAllButCurrent
  -- --                 :BufferCloseAllButPinned
  -- --                 :BufferCloseAllButCurrentOrPinned
  -- --                 :BufferCloseBuffersLeft
  -- --                 :BufferCloseBuffersRight
  -- -- Magic buffer-picking mode
  -- map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
  -- -- Sort automatically by...
  -- map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
  -- map('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', opts)
  -- map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
  -- map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
  -- map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
  --
  -- -- Other:
  -- -- :BarbarEnable - enables barbar (enabled by default)
  -- -- :BarbarDisable - very bad command, should never be used
  {
    "romgrk/barbar.nvim",
    event = "VeryLazy",
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    -- version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },

  -- 44. nvim-cmp setup
  -- TODO: Not works! Check later.
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = "InsertEnter",
  --   dependencies = {
  --     "hrsh7th/cmp-cmdline",
  --   },
  --   config = function()
  --     local cmp = require "cmp"
  --     cmp.setup.cmdline(":", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = cmp.config.sources({
  --         { name = "path" },
  --       }, {
  --         {
  --           name = "cmdline",
  --           option = {
  --             ignore_cmds = { "Man", "!" },
  --           },
  --         },
  --       }),
  --     })
  --     cmp.setup.cmdline("/", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = {
  --         { name = "buffer" },
  --       },
  --     })
  --   end,
  -- },

  -- 45. A cheatsheet plugin for neovim with bundled cheatsheets
  -- 1. Forget how to do X
  -- 2. Hit <leader>? to invoke cheatsheet telescope
  -- 3. Type in X and find forgotten mapping/command
  -- Your cheatsheet file is a simple text file with the name cheatsheet.txt found in
  -- ~/.config/nvim/ (~/AppData/Local/nvim/ if you're on Windows) alongside your init.nvim.
  -- Use the :CheatsheetEdit command to open it in a buffer to edit.
  -- | Telescope mappings | Description                               |
  -- |--------------------+-------------------------------------------|
  -- | <C-E>              | Edit user cheatsheet à la :CheatsheetEdit |
  -- | <C-Y>              | Yank the cheatcode                        |
  -- | Enter              | Fill in the command line; see below       |
  {
    "doctorfree/cheatsheet.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      local ctactions = require "cheatsheet.telescope.actions"
      require("cheatsheet").setup {
        bundled_cheetsheets = {
          enabled = { "default", "lua", "markdown", "regex", "netrw", "unicode" },
          disabled = { "nerd-fonts" },
        },
        bundled_plugin_cheatsheets = {
          enabled = {
            "auto-session",
            "goto-preview",
            "octo.nvim",
            "telescope.nvim",
            "vim-easy-align",
            "vim-sandwich",
          },
          disabled = { "gitsigns" },
        },
        include_only_installed_plugins = true,
        telescope_mappings = {
          ["<CR>"] = ctactions.select_or_fill_commandline,
          ["<A-CR>"] = ctactions.select_or_execute,
          ["<C-Y>"] = ctactions.copy_cheat_value,
          ["<C-E>"] = ctactions.edit_user_cheatsheet,
        },
      }
    end,
  },

  -- 46. Color picker and highlighter plugin for Neovim.
  -- NOTE: Disable it unless needed.
  --
  -- Avaiable Commands:
  -- :CccPick	-> Detects and replaces the color under the cursor.
  -- :CccConvert -> Convert color formats directly without opening the UI.
  -- :CccHighlighterEnable [{bufnr}] -> Highlight colors in the buffer {bufnr}. If {bufnr} is omitted, the target is the current buffer.
  -- :CccHighlighterDisable [{bufnr}] -> Disable highlight.
  -- :CccHighlighterToggle [{bufnr}] -> Toggle highlight.
  -- {
  --   "uga-rosa/ccc.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("ccc").setup {}
  --   end,
  -- },

  -- 47. Highlight, list and search todo comments in your projects
  -- Todo matches on any text that starts with one of your defined keywords (or alt) followed by a colon:
  -- TODO:
  -- FIX:
  -- HACK:
  -- NOTE:
  -- WARNING:
  -- PERF:
  --
  -- Avaiable Commands: start with Todo... or use: "Trouble todo" to list in *Trouble*.
  -- :TodoTelescope cwd=~/projects/foobar
  -- :TodoTelescope keywords=TODO,FIX
  {
    "folke/todo-comments.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  -- 48. Mini icons: to use it instead of "nvim-web-devicons"
  -- NOTE: Disable it unless wanto use mini.icons instead of nvim-web-devicons
  -- {
  --   "echasnovski/mini.icons",
  --   opts = {},
  --   lazy = true,
  --   specs = {
  --     { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
  --   },
  --   init = function()
  --     package.preload["nvim-web-devicons"] = function()
  --       require("mini.icons").mock_nvim_web_devicons()
  --       return package.loaded["nvim-web-devicons"]
  --     end
  --   end,
  -- },

  -- 49. provides a simple way to run and visualize code actions with Telescope.
  -- NOTE: Disable it unless need it.
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    event = "LspAttach",
    config = function()
      require("tiny-code-action").setup()
    end,
  },

  -- 51. Populate the quickfix with json entries
  -- nvim-jqx exposes two commands: JqxList and JqxQuery.
  -- Open a json file and issue JqxList: the json is prettified and the quickfix window is populated with the first level keys.
  -- Press X on a key to query its values and show the results in a floating window;
  -- alternatively <CR> takes you to its location in the file.
  {
    "gennaro-tedesco/nvim-jqx",
    event = { "BufReadPost" },
    ft = { "json", "yaml" },
  },

  -- 52. Decorations for vimdoc/help files in Neovim
  -- The plugin comes with the Helpview command. It has the following sub-commands,
  -- toggleAll -> Toggles the plugin itself.
  -- enableAll -> Enables the plugin.
  -- disableAll -> Disables the plugin
  -- toggle {buffer} -> Toggles the plugin on the specific buffer.
  -- enable {buffer} -> Enables the plugin on the specific buffer.
  -- disable {buffer} -> Disables the plugin on the specific buffer.
  -- Check out the help files(via :h helpview.nvim) to learn more!
  -- NOTE: It looks this will change colortheme a lot! Use Lazy load until invoke "help" command.
  {
    "OXY2DEV/helpview.nvim",
    -- lazy = false, -- Recommended

    -- In case you still want to lazy load
    ft = "help",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- 53. vim-doge: (Do)cumentation (Ge)nerator for nearly 20 languages 📚 Generate proper code documentation with a single keypress. ⚡️🔥
  -- Run :help doge to get the full help page.
  -- Commands
  --    :DogeGenerate {doc_standard}
  -- Command to generate documentation. The {doc_standard} accepts a count or a string as argument, and it can complete the available doc standards for the current buffer.
  -- TODO: Don't know how to use it. Will check back.
  -- {
  --   "kkoomen/vim-doge",
  --   event = "LspAttach",
  -- },

  -- 54. AI-powered coding, seamlessly in Neovim. Supports Anthropic, Copilot, Gemini, Ollama and OpenAI LLMs
  -- NOTE: Doesn't work with Gemini... not sure why. Disable it for now.
  -- {
  --   "olimorris/codecompanion.nvim",
  --   event = "InsertEnter",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
  --     "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
  --     { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves the default Neovim UI
  --   },
  --   -- config = true,
  --   config = function()
  --     require("codecompanion").setup {
  --       opts = {
  --         log_level = "DEBUG",
  --       },
  --       strategies = {
  --         chat = {
  --           adapter = "gemini",
  --         },
  --         inline = {
  --           adapter = "gemini",
  --         },
  --         agent = {
  --           adapter = "gemini",
  --         },
  --       },
  --       adapters = {
  --         opts = {
  --           allow_insecure = true, -- Use if required
  --           proxy = "socks5://192.168.1.6:10808",
  --         },
  --         gemini = function()
  --           return require("codecompanion.adapters").extend("gemini", {
  --             -- url = "https://generativelanguage.googleapis.com/v1beta/models/${model}-latest:generateContent?key=${api_key}",
  --             env = {
  --               api_key = "API-KEY",
  --             },
  --           })
  --         end,
  --       },
  --     }
  --   end,
  -- },

  -- 55. Gp.nvim (GPT prompt) Neovim AI plugin: ChatGPT sessions & Instructable text/code operations
  -- & Speech to text [OpenAI, Ollama, Anthropic, ..]
  -- NOTE: Just put it as a plugin which will be enabled if really needed, not configured yet!!
  -- {
  --   "robitx/gp.nvim",
  --   config = function()
  --     local conf = {
  --       -- For customization, refer to Install > Configuration in the Documentation/Readme
  --     }
  --     require("gp").setup(conf)
  --
  --     -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
  --   end,
  -- },

  -- 56. Generic log syntax highlighting and filetype management for Neovim
  -- Not specific doc need, it will automatically highlight log file (file extension as `.log`)
  -- A simple and lightweight Neovim plugin that brings syntax highlighting to generic log patterns
  -- and provides straight-forward configuration to manage the filetype detection rules over your preferred log files.
  {
    "fei6409/log-highlight.nvim",
    event = "InsertEnter",
    config = function()
      require("log-highlight").setup {}
    end,
  },

  -- 57. A neovim plugin that helps managing crates.io dependencies.
  -- Command
  --    :Crates <subcmd>
  -- Run a crates.nvim <subcmd>. All <subcmd>s are just wrappers around the corresponding functions.
  -- Possible key mappings as below:
  -- local crates = require("crates")
  -- local opts = { silent = true }
  --
  -- vim.keymap.set("n", "<leader>ct", crates.toggle, opts)
  -- vim.keymap.set("n", "<leader>cr", crates.reload, opts)
  --
  -- vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
  -- vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
  -- vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)
  --
  -- vim.keymap.set("n", "<leader>cu", crates.update_crate, opts)
  -- vim.keymap.set("v", "<leader>cu", crates.update_crates, opts)
  -- vim.keymap.set("n", "<leader>ca", crates.update_all_crates, opts)
  -- vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, opts)
  -- vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, opts)
  -- vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, opts)
  --
  -- vim.keymap.set("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, opts)
  -- vim.keymap.set("n", "<leader>cX", crates.extract_crate_into_table, opts)
  --
  -- vim.keymap.set("n", "<leader>cH", crates.open_homepage, opts)
  -- vim.keymap.set("n", "<leader>cR", crates.open_repository, opts)
  -- vim.keymap.set("n", "<leader>cD", crates.open_documentation, opts)
  -- vim.keymap.set("n", "<leader>cC", crates.open_crates_io, opts)
  -- vim.keymap.set("n", "<leader>cL", crates.open_lib_rs, opts)
  {
    "saecki/crates.nvim",
    event = "LspAttach",
    tag = "stable",
    config = function()
      local crates = require "crates"
      -- local opts = { silent = true }
      vim.keymap.set("n", "<leader>cp", crates.show_popup, { silent = true, desc = "Open Crates popup menu" })
      vim.keymap.set("n", "<leader>cd", crates.hide_popup, { silent = true, desc = "Close Crates popup menu" })
      vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, { silent = true, desc = "Crates show versions" })
      vim.keymap.set("n", "<leader>cf", crates.show_features_popup, { silent = true, desc = "Crates show features" })

      crates.setup {
        completion = {
          cmp = {
            enabled = true,
          },
        },
      }
    end,
  },

  -- 58. Improved Yank and Put functionalities for Neovim
  {
    "gbprod/yanky.nvim",
    dependencies = {
      { "kkharji/sqlite.lua" },
    },
    opts = {
      ring = { storage = "sqlite" },
    },
    keys = {
      {
        "<leader>pp",
        function()
          require("telescope").extensions.yank_history.yank_history {}
        end,
        desc = "Open Yank History",
      },
      -- { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
      -- { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
      -- { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
      -- { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
      -- { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
      -- { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
      -- { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
      -- { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      -- { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      -- { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      -- { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      -- { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
      -- { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
      -- { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
      -- { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
      -- { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
      -- { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
    },
  },

  -- 59. Multiple cursors in Neovim which work how you expect.
  -- Selecting Cursors
  --    You can add cursors above/below the current cursor with <up> and <down>.
  --    You can match the word under the cursor with <c-n> or <c-s> to skip. You can also use the mouse with <c-leftmouse>.
  -- Using the Cursors
  --    Once you have your cursors, you use vim normally as you would with a single cursor.
  -- Finished
  --    When you want to collapse your cursors back into one, press <esc>.
  {
    "jake-stewart/multicursor.nvim",
    -- event = "InsertEnter",
    branch = "1.0",
    config = function()
      local mc = require "multicursor-nvim"

      mc.setup()

      -- Add cursors above/below the main cursor.
      vim.keymap.set({ "n", "v" }, "<up>", function()
        mc.addCursor "k"
      end)
      vim.keymap.set({ "n", "v" }, "<down>", function()
        mc.addCursor "j"
      end)

      -- Add a cursor and jump to the next word under cursor.
      vim.keymap.set({ "n", "v" }, "<c-n>", function()
        mc.addCursor "*"
      end)

      -- Jump to the next word under cursor but do not add a cursor.
      vim.keymap.set({ "n", "v" }, "<c-s>", function()
        mc.skipCursor "*"
      end)

      -- Rotate the main cursor.
      vim.keymap.set({ "n", "v" }, "<left>", mc.nextCursor)
      vim.keymap.set({ "n", "v" }, "<right>", mc.prevCursor)

      -- Delete the main cursor.
      vim.keymap.set({ "n", "v" }, "<leader>x", mc.deleteCursor)

      -- Add and remove cursors with control + left click.
      vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)

      vim.keymap.set({ "n", "v" }, "<c-q>", function()
        if mc.cursorsEnabled() then
          -- Stop other cursors from moving.
          -- This allows you to reposition the main cursor.
          mc.disableCursors()
        else
          mc.addCursor()
        end
      end)

      vim.keymap.set("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          -- Default <esc> handler.
        end
      end)

      -- Align cursor columns.
      vim.keymap.set("n", "<leader>a", mc.alignCursors)

      -- Split visual selections by regex.
      vim.keymap.set("v", "S", mc.splitCursors)

      -- Append/insert for each line of visual selections.
      vim.keymap.set("v", "I", mc.insertVisual)
      vim.keymap.set("v", "A", mc.appendVisual)

      -- match new cursors within visual selections by regex.
      vim.keymap.set("v", "M", mc.matchCursors)

      -- Rotate visual selection contents.
      vim.keymap.set("v", "<leader>t", function()
        mc.transposeCursors(1)
      end)
      vim.keymap.set("v", "<leader>T", function()
        mc.transposeCursors(-1)
      end)

      -- Customize how cursors look.
      vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
      vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    end,
  },

  -- 60. plugin that brings stochastic parrots to Neovim.
  -- This is a gp.nvim-fork focused on simplicity.
  -- | Command                | Description                                                     |
  -- |------------------------+-----------------------------------------------------------------|
  -- | PrtChatNew <target>    | Open a new chat                                                 |
  -- | PrtChatToggle <target> | Toggle chat (open last chat or new one)                         |
  -- | PrtChatPaste <target>  | Paste visual selection into the latest chat                     |
  -- | PrtInfo                | Print plugin config                                             |
  -- | PrtContext <target>    | Edits the local context file                                    |
  -- | PrtChatFinder          | Fuzzy search chat files using fzf                               |
  -- | PrtChatDelete          | Delete the current chat file                                    |
  -- | PrtChatRespond         | Trigger chat respond (in chat file)                             |
  -- | PrtStop                | Interrupt ongoing respond                                       |
  -- | PrtProvider <provider> | Switch the provider (empty arg triggers fzf)                    |
  -- | PrtModel <model>       | Switch the model (empty arg triggers fzf)                       |
  -- | PrtStatus              | Prints current provider and model selection                     |
  -- | Interactive            |                                                                 |
  -- | PrtRewrite             | Rewrites the visual selection based on a provided prompt        |
  -- | PrtAppend              | Append text to the visual selection based on a provided prompt  |
  -- | PrtPrepend             | Prepend text to the visual selection based on a provided prompt |
  -- | PrtNew                 | Prompt the model to respond in a new window                     |
  -- | PrtEnew                | Prompt the model to respond in a new buffer                     |
  -- | PrtVnew                | Prompt the model to respond in a vsplit                         |
  -- | PrtTabnew              | Prompt the model to respond in a new tab                        |
  -- | PrtRetry               | Repeats the last rewrite/append/prepend                         |
  -- | Example Hooks          |                                                                 |
  -- | PrtImplement           | Takes the visual selection as prompt to generate code           |
  -- | PrtAsk                 | Ask the model a question                                        |
  --
  -- With <target>, we indicate the command to open the chat within one of the following target locations (defaults to toggle_target):
  --    popup: open a popup window which can be configured via the options provided below
  --    split: open the chat in a horizontal split
  --    vsplit: open the chat in a vertical split
  --    tabnew: open the chat in a new tab
  {
    "frankroeder/parrot.nvim",
    event = "InsertEnter",
    dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
    opts = {},
    config = function()
      require("parrot").setup {
        -- Providers must be explicitly added to make them available.
        providers = {
          anthropic = {
            api_key = os.getenv "ANTHROPIC_API_KEY",
            topic = {
              model = "claude-3-haiku-20240307",
              params = { max_tokens = 32 },
            },
          },
          gemini = {
            api_key = os.getenv "GEMINI_API_KEY",
          },
          -- groq = {
          --   api_key = os.getenv "GROQ_API_KEY",
          -- },
          -- mistral = {
          --   api_key = os.getenv "MISTRAL_API_KEY",
          -- },
          -- pplx = {
          --   api_key = os.getenv "PERPLEXITY_API_KEY",
          -- },
          -- -- provide an empty list to make provider available (no API key required)
          -- ollama = {},
          -- openai = {
          --   api_key = os.getenv "OPENAI_API_KEY",
          -- },
          -- github = {
          --   api_key = os.getenv "GITHUB_TOKEN",
          -- },
        },
      }
    end,
  },

  -- 61. Help you get in the flow with ripgrep in Neovim
  -- Steps:
  -- After restarting Neovim, press <leader>rg to open the RgFlow UI
  -- Type in a search pattern and press <ENTER>
  -- Note: <BS> (Backspace) or - will go up a dir
  -- A search will run and populate the QuickFix window
  -- Press dd to delete a QuickFix entry, or select a visual range and press d
  -- Press TAB to mark a line and <S-TAB> to unmark a line, a line can be marked more than once
  -- Press c/C to :Cfilter/:Cfilter then type a pattern to filter the quickfix results.
  -- Default mappings
  -- n = {
  --     ["<leader>rG"] = "open_blank",      -- Open UI - search pattern = blank
  --     ["<leader>rp"] = "open_paste",      -- Open UI - search pattern = First line of unnamed register as the search pattern
  --     ["<leader>rg"] = "open_cword",      -- Open UI - search pattern = <cword>
  --     ["<leader>rw"] = "open_cword_path", -- Open UI - search pattern = <cword> and path = current file's directory
  --     ["<leader>rs"] = "search",          -- Run a search with the current parameters
  --     ["<leader>ra"] = "open_again",      -- Open UI - search pattern = Previous search pattern
  --     ["<leader>rx"] = "abort",           -- Close UI / abort searching / abortadding results
  --     ["<leader>rc"] = "print_cmd",       -- Print a version of last run rip grep that can be pasted into a shell
  --     ["<leader>r?"] = "print_status",    -- Print info about the current state of rgflow (mostly useful for deving on rgflow)
  -- },
  {
    "mangelozzi/rgflow.nvim",
    event = "InsertEnter",
    opts = {},
    config = function()
      require("rgflow").setup {
        -- Set the default rip grep flags and options for when running a search via
        -- RgFlow. Once changed via the UI, the previous search flags are used for
        -- each subsequent search (until Neovim restarts).
        -- cmd_flags = "--smart-case --fixed-strings --ignore --max-columns 200",
        -- WARNING !!! Glob for '-g *{*}' will not use .gitignore file: https://github.com/BurntSushi/ripgrep/issues/2252
        cmd_flags = (
          "--smart-case -g *.{*,py} -g !*.{min.js,pyc} --fixed-strings --no-fixed-strings --no-ignore -M 500"
          -- Exclude globs
          .. " -g !**/.angular/"
          .. " -g !**/node_modules/"
          .. " -g !**/static/*/jsapp/"
          .. " -g !**/static/*/wcapp/"
        ),

        -- Mappings to trigger RgFlow functions
        default_trigger_mappings = true,
        -- These mappings are only active when the RgFlow UI (panel) is open
        default_ui_mappings = true,
        -- QuickFix window only mapping
        default_quickfix_mappings = true,
      }
    end,
  },

  --62. autopairs for neovim written in lua
  --
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    -- config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
    -- opts={},
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      local Rule = require "nvim-autopairs.rule"
      local npairs = require "nvim-autopairs"
      npairs.add_rule(Rule("$", "$", "tex"))
      npairs.add_rule(Rule("$$", "$$", "tex"))

      -- local cond = require "nvim-autopairs.conds"
      -- print(vim.inspect(cond))
      -- npairs.add_rules(
      --   {
      --     Rule("$", "$", { "tex", "latex" })
      --       -- don't add a pair if the next character is %
      --       :with_pair(cond.not_after_regex "%%")
      --       -- don't add a pair if  the previous character is xxx
      --       :with_pair(
      --         cond.not_before_regex("xxx", 3)
      --       )
      --       -- don't move right when repeat character
      --       :with_move(cond.none())
      --       -- don't delete if the next character is xx
      --       :with_del(cond.not_after_regex "xx")
      --       -- disable adding a newline when you press <cr>
      --       :with_cr(cond.none()),
      --   },
      --   -- disable for .vim files, but it work for another filetypes
      --   Rule("a", "a", "-vim")
      -- )

      -- npairs.add_rules {
      --   Rule("$$", "$$", "tex"):with_pair(function(opts)
      --     print(vim.inspect(opts))
      --     if opts.line == "aa $$" then
      --       -- don't add pair on that line
      --       return false
      --     end
      --   end),
      -- }
    end,
    -- config = function()
    --   local Rule = require "nvim-autopairs.rule"
    --   local npairs = require "nvim-autopairs"
    --   npairs.add_rule(Rule("$$", "$$", "tex"))
    -- end,
  },

  -- Backup plugins
  -- 1. lspkind: https://github.com/onsails/lspkind.nvim
  -- 2. mini.nvim: https://github.com/echasnovski/mini.nvim

  -- Thems collections --
  -- 1. midnight.nvim
  -- {
  --   "dasupradyumna/midnight.nvim",
  --   lazy = false,
  --   priority = 1000,
  -- },

  -- 2. https://github.com/scottmckendry/cyberdream.nvim
  -- {
  --   "scottmckendry/cyberdream.nvim",
  --   lazy = false,
  --   priority = 1000,
  -- },

  -- 3. tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    -- config = function()
    --   require("tokyonight").setup {
    --     style = "day",
    --   }
    -- end,
  },

  -- 4. catppuccin
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        flavour = "auto", -- latte, frappe, macchiato, mocha, gruvbox
      }
    end,
  },
}
