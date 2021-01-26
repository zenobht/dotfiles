
function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup '..group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

local autocmds = {
  MY_AUTOCMDS = {
    {"FocusGained,BufEnter,CursorHold,CursorHoldI", "*", "if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif"},
    {"FileChangedShellPost", "*", "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None"},
    {"BufRead,BufNewFile", "*", "setlocal formatoptions-=cro"},
    {"FileType", "gitcommit,gitrebase,gitconfig", "set bufhidden=delete"},
    {"FileType", "fzf", "tunmap <buffer> <Esc>"},
    {"TermOpen", "*", "call custom#OnTermOpen()"},
    {"InsertEnter", "*", "hi link EndOfLineSpace Normal"},
    {"InsertLeave", "*", "hi link EndOfLineSpace ErrorMsg"},
    {"TextYankPost", "*", "silent! lua vim.highlight.on_yank {higroup='IncSearch', timeout=250, on_visual=false}"},
  }
}

nvim_create_augroups(autocmds)
