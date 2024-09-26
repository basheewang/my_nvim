local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    -- python = { "black" },
    cpp = { "clang-format" },
    c = { "clang-format" },
    -- cmake = { "gersemi" },
    -- tex = { "latexindent" },
    -- json = { "jq" },
    yaml = { "yamlfmt" },
    zsh = { "beautysh" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
