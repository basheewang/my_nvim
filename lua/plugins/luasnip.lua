return {
  "L3MON4D3/LuaSnip",
  -- version = "v2.*",
  config = function()
    require "snippets.mysnips"
    -- local luasnip = require "luasnip"
    -- require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/snippets/" }

    -- luasnip.config.set_config {
    --   history = true,
    --   updateevents = "TextChanged,TextChangedI",
    --   ext_opts = {
    --     [require("luasnip.util.types").choiceNode] = {
    --       active = {
    --         virt_text = { { "●", "GruvboxPurple" } },
    --       },
    --     },
    --   },
    -- }
  end,
}
