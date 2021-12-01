local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_lua= bind.map_lua
local map_args = bind.map_args
local map_wait = bind.map_wait
require('keymap.commands').setup()
require('keymap.config')

local plug_map = {
  -- normal
  -- nnn/scalpel/blame/nvimtree
  ["n|<Leader>fn"]            = map_lua("require('utils').nnnPicker()"):with_noremap():with_nowait(),
  ["n|<Leader>ft"]            = map_cr("NvimTreeToggle"):with_noremap():with_nowait(),
  ["n|<Leader>st"]            = map_cr("Scratch"):with_noremap():with_nowait(),
  ["n|<Leader>fr"]            = map_cmd("<Plug>(Scalpel)"):with_nowait(),
  ["n|<Leader>gl"]            = map_lua("require'gitsigns'.blame_line()"):with_noremap():with_nowait(),
  -- Neogit
  ["n|<Leader>gg"]            = map_cr("Neogit"):with_noremap():with_nowait(),
  -- telescope
  ["n|<Leader>ff"]            = map_lua("require('telescope.builtin').find_files({hidden=true})"):with_noremap():with_nowait(),
  ["n|<Leader>fs"]            = map_lua("require('telescope.builtin').live_grep()"):with_noremap():with_nowait(),
  ["n|<Leader>fw"]            = map_lua("require('telescope.builtin').grep_string()"):with_noremap():with_nowait(),
  ["x|<Leader>fw"]            = map_lua("require('telescope.builtin').grep_string({search = require('utils').getVisualSelection()})"):with_noremap():with_nowait(),
  ["n|<Leader>fc"]            = map_lua("require('telescope.builtin').current_buffer_fuzzy_find()"):with_noremap():with_nowait(),
  ["n|<Leader>b"]             = map_lua("require('telescope.builtin').buffers()"):with_noremap():with_nowait(),
  ["n|<Leader>gc"]            = map_lua("require('keymap.custom').git_conflicts({})"):with_noremap():with_nowait(),
  -- LSP
  ["n|<Leader>ls"]            = map_cr("LspStart"):with_noremap():with_nowait(),
  ["n|<Leader>le"]            = map_cr("LspStop"):with_noremap():with_nowait(),
  ["n|<Leader>lr"]            = map_cr("LspRestart"):with_noremap():with_nowait(),
  ["n|<Leader>li"]            = map_cr("LspInfo"):with_noremap():with_nowait(),
  -- asterisk
  ["n|*"]                     = map_cmd("<Plug>(asterisk-z*)"):with_nowait(),
  ["n|#"]                     = map_cmd("<Plug>(asterisk-z#)"):with_nowait(),
  ["n|g*"]                    = map_cmd("<Plug>(asterisk-gz*)"):with_nowait(),
  ["n|g#"]                    = map_cmd("<Plug>(asterisk-gz#)"):with_nowait(),
  ["n|<Leader>fa"]            = map_cr("write | edit | TSBufEnable highlight"):with_nowait():with_silent(),
  -- bufferline
  ["n|<C-h>"]                 = map_cr("BufferLineCyclePrev"):with_noremap():with_silent():with_nowait(),
  ["n|<C-l>"]                 = map_cr("BufferLineCycleNext"):with_noremap():with_silent():with_nowait(),
  -- Plugin acceleratedjk
  ["n|j"]                     = map_cmd('v:lua.enhance_jk_move("j")'):with_silent():with_expr(),
  ["n|k"]                     = map_cmd('v:lua.enhance_jk_move("k")'):with_silent():with_expr(),

  -- visual
  -- asterisk
  ["v|*"]                     = map_cmd("<Plug>(asterisk-z*)"):with_nowait(),
  ["v|#"]                     = map_cmd("<Plug>(asterisk-z#)"):with_nowait(),
  ["v|g*"]                    = map_cmd("<Plug>(asterisk-gz*)"):with_nowait(),
  ["v|g#"]                    = map_cmd("<Plug>(asterisk-gz#)"):with_nowait(),

  ["v|<Leader>fr"]            = map_cmd("<Plug>(ScalpelVisual)"):with_nowait(),
}

bind.nvim_load_mapping(plug_map)

vim.cmd([[
  imap <expr> <M-h>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<M-h>'
  smap <expr> <M-h>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<M-h>'
]])
