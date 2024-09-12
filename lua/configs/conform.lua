local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    python = { "black" },
    cpp = { "clang-format" },
    cmake = { "gersemi" },
    tex = { "latexindent" },
    json = { "jq" },
    yaml = { "yamlfmt" },
    rust = { "rustfmt", lsp_format = "fallback" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
