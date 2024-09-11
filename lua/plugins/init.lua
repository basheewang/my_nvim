return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "mfussenegger/nvim-lint",
    event = "LspAttach",
    config = function()
      require("lint").linters_by_ft = {
        cmake = { "cmakelint" },
      }
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        -- A simple popup display that provides breadcrumbs feature using LSP server
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
      },
    },
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      pkgs = {
        "lua-language-server",
        "stylua",
        -- "html-lsp",
        -- "css-lsp",
        "prettier",
        "texlab",
        "pyright",
        "black",
        -- "clangd",
        -- "clang-format",
        "cmake-language-server",
        "gersemi",
        "latexindent",
        "jq",
        "taplo",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "regex",
        -- "html", "css"
      },
    },
  },

  -- Customized plugins

  -- {
  --   "max397574/better-escape.nvim",
  --   event = "InsertEnter",
  --   config = function()
  --     require("better_escape").setup()
  --   end,
  -- },

  -- 1. Surround selections, stylishly 😎
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
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    config = true,
  },

  -- 6. An calendar app for vim(neovim)
  {
    "itchyny/calendar.vim",
    event = "VeryLazy",
  },

  -- 7. automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    -- config = function()
    --   require("illuminate").configure()
    -- end,
  },

  -- 8. A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.
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
  {
    "michaelb/sniprun",
    event = "VeryLazy",
    build = "sh ./install.sh",
  },

  -- 10. properly configures LuaLS for editing your Neovim config by lazily updating your workspace libraries.
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    dependencies = {
      "Bilal2453/luvit-meta",
      { -- optional completion source for require statements and module annotations
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
          opts.sources = opts.sources or {}
          table.insert(opts.sources, {
            name = "lazydev",
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
          })
        end,
      },
    },
    opts = {
      library = {
        { plugins = { "nvim-dap-ui" }, types = true },
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  -- 11. improve lsp experences in neovim
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
  },

  -- 13. Find Nerd Glyphs Easily 🤓 🔭
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
      -- require("telescope").load_extension "themes"
    end,
  },

  -- 15. Leap is a general-purpose motion plugin for Neovim
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  -- 16. Extensible UI for Neovim notifications and LSP progress messages.
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      -- options
    },
  },

  -- 17. Better quickfix window in Neovim, polish old quickfix window.
  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
    ft = "qf",
    config = function()
      require("bqf").setup()
    end,
  },

  -- 18. A modern Vim and neovim filetype plugin for LaTeX files.
  {
    "lervag/vimtex",
    event = "VeryLazy",
    config = function()
      -- require("Vimtex").setup()
      vim.g.vimtex_fold_enabled = 1
      -- vim.g.vimtex_compiler_latexmk = {
      --   'options' : '-pdf -verbose -bibtex -file-line-error -synctex=1 --interaction=nonstopmode'
      -- }
    end,
  },

  -- 19. Lightweight alternative to context.vim
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    keys = {
      {
        "[c",
        function()
          require("treesitter-context").go_to_context()
        end,
      },
    },
  },

  -- 20. Highlight colors for neovim
  {
    "brenoprata10/nvim-highlight-colors",
    event = "InsertEnter",
    config = function()
      require("nvim-highlight-colors").setup {
        enable_tailwind = true,
      }
    end,
  },

  -- 21. to display lsp hover documentation in a side panel.
  {
    "amrbashir/nvim-docs-view",
    lazy = true,
    cmd = "DocsViewToggle",
    opts = {
      position = "right",
      width = 60,
    },
  },

  -- 22. LSP signature hint as you type
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },

  -- 23. Establish good command workflow and quit bad habit.
  {
    "m4xshen/hardtime.nvim",
    event = "InsertEnter",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      enabled = false,
    },
  },

  -- 24. A better annotation generator. Supports multiple languages and annotation conventions.
  {
    "danymat/neogen",
    event = "VeryLazy",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },

  -- 25. intelligently reopens files at your last edit position.
  {
    "farmergreg/vim-lastplace",
    event = "VeryLazy",
  },

  -- 26. Tabnine
  {
    "codota/tabnine-nvim",
    event = "LspAttach",
    build = "./dl_binaries.sh",
    config = function()
      require("tabnine").setup {
        disable_auto_comment = true,
        accept_keymap = "<C-a>",
        dismiss_keymap = "<C-]>",
        debounce_ms = 800,
        suggestion_color = { gui = "#90f080", cterm = 244 },
        exclude_filetypes = { "TelescopePrompt" },
        log_file_path = nil, -- absolute path to Tabnine log file
      }
    end,
  },

  -- 27. codeium
  {
    "Exafunction/codeium.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "hrsh7th/nvim-cmp",
      {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
          opts.sources = opts.sources or {}
          table.insert(opts.sources, {
            name = "codeium",
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
          })
        end,
        -- opts = function()
        --   local cmp_conf = require "plugins.configs.cmp"
        --   table.insert(cmp_conf.sources, { name = "codeium" })
        --   return cmp_conf
        -- end,
      },
    },
    config = function()
      require("codeium").setup {
        enable_chat = false,
      }
    end,
  },

  -- 29. A Neovim fuzzy finder that updates on every keystroke.
  {
    "linrongbin16/fzfx.nvim",
    event = "BufReadPre",
    dependencies = { "nvim-tree/nvim-web-devicons", "junegunn/fzf" },

    -- specify version to avoid break changes
    -- version = "v5.*",

    config = function()
      require("fzfx").setup()
    end,
  },

  -- 30. assists with discovering motions (Both vertical and horizontal) to navigate your current buffer
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
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    -- branch='v0.6', --recommended as each new version will have breaking changes
    opts = {
      --Config goes here
    },
  },

  -- 32. code outline window
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

  -- 33. an ultra fold in Neovim. - Looks has error when use it, Disable it for now.
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

  -- 36. Doens't work well or I don't know the best way to do this.
  -- {
  --   "Civitasv/cmake-tools.nvim",
  --   event = "InsertEnter",
  -- },

  -- 37. Perform search and replace operations in the current buffer using a modern user interface and contemporary regex syntax.
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
  {
    "MeanderingProgrammer/markdown.nvim",
    event = "InsertEnter",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    config = function()
      require("render-markdown").setup {}
    end,
  },

  -- 39. Display one line diagnostic messages where the cursor is, with icons and colors.
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
      require("tiny-inline-diagnostic").setup()
    end,
  },

  -- 40. Display LSP inlay hints at the end of the line, rather than within the line.
  {
    "chrisgrieser/nvim-lsp-endhints",
    event = "LspAttach",
    opts = {}, -- required, even if empty
  },

  -- 41. Neovim git GUI powered by libgit2 - not installed with lua 5.4.7
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
  {
    "MagicDuck/grug-far.nvim",
    event = "InsertEnter",
    config = function()
      require("grug-far").setup {}
    end,
  },

  -- 43. The neovim tabline plugin.
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

  --44. nvim-cmp setup
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require "cmp"
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
    end,
  },

  -- 45. A cheatsheet plugin for neovim with bundled cheatsheets
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
  {
    "uga-rosa/ccc.nvim",
    event = "VeryLazy",
    config = function()
      require("ccc").setup {}
    end,
  },

  -- 47. Highlight, list and search todo comments in your projects
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

  -- 48. Mini icons
  {
    "echasnovski/mini.icons",
    opts = {},
    lazy = true,
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- 49. provides a simple way to run and visualize code actions with Telescope.
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

  -- 50. Syntax aware text-objects, select, move, swap, and peek support.
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "BufReadPre",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
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
