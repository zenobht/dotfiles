local config = {}

function config.treesitter()
  require('nvim-treesitter.configs').setup {
    ensure_installed = "maintained",
    highlight = {
      enable = true
    },
    indent = {
      enable = false,
    },
    disable = { "elixir" },
    context_commentstring = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<Leader>ti",
        node_incremental = "<Leader>tj",
        scope_incremental = "<Leader>ta",
        node_decremental = "<Leader>tk",
      },
    },
  }
end

return config
