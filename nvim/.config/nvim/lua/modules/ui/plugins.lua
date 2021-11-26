local plugins = {}
local conf = require('modules.ui.config')

plugins["mcchrish/nnn.vim"] = {
  cmd = 'NnnPicker',
}

plugins['nvim-telescope/telescope.nvim'] = {
  config = conf.telescope,
  requires = {
    {'nvim-lua/popup.nvim'},
    {'nvim-lua/plenary.nvim'},
    {'nvim-telescope/telescope-fzf-writer.nvim'},
  }
}

plugins['lewis6991/gitsigns.nvim'] = {
  event = {'BufRead','BufNewFile'},
  config = conf.gitsigns,
  requires = {'nvim-lua/plenary.nvim'}
}

plugins['kyazdani42/nvim-web-devicons'] = {}

plugins['folke/tokyonight.nvim'] = {
  event = 'VimEnter',
  config = conf.theme,
}

plugins["akinsho/nvim-bufferline.lua"] = {
  event = 'VimEnter',
  config = conf.bufferline,
}

plugins["hoob3rt/lualine.nvim"] = {
  event = 'VimEnter',
  config = conf.lualine,
}

plugins['kyazdani42/nvim-tree.lua'] = {
  cmd = {"NvimTreeToggle", "NvimTreeOpen"},
  config = conf.tree,
}

plugins['kyazdani42/nvim-tree.lua'] = {
  cmd = {"NvimTreeToggle", "NvimTreeOpen"},
  config = conf.tree,
}

plugins['goolord/alpha-nvim'] = {
  requires = { 'kyazdani42/nvim-web-devicons' },
  config = function ()
    require'alpha'.setup(require'alpha.themes.dashboard'.opts)
  end
}

return plugins
