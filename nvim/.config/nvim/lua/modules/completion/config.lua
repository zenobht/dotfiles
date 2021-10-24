local config = {}

function config.lspconfig()
  local nvim_lsp = require('lspconfig')
  if packer_plugins['cmp_nvim_lsp'] and not packer_plugins['cmp_nvim_lsp'].loaded then
    vim.cmd [[packadd cmp_nvim_lsp]]
  end

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      -- delay update diagnostics
      update_in_insert = false,
    }
  )

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<Leader>cd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<Leader>ck', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', '<Leader>cj', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<Leader>cl', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
      buf_set_keymap("n", "<space>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
      buf_set_keymap("n", "<space>cf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end


    local function setupSign()
      local signs = {
        ["Error"] = "",
        ["Warning"] = "",
        ["Hint"] = "",
        ["Information"] = ""
      }

      for k, v in pairs(signs) do
        vim.api.nvim_call_function("sign_define", {
          "LspDiagnosticsSign"..k,
          { text = v, texthl = "LspDiagnosticsSign" .. k }
        })
      end
    end

    setupSign()
  end

  -- Use a loop to conveniently both setup defined servers
  -- and map buffer local keybindings when the language server attaches
  local servers = { "tsserver", "kotlin_language_server" }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end

  local home = os.getenv("HOME")

  require("lspconfig").java_language_server.setup{
    cmd = { home .. "/.local/bin/java-language-server/dist/lang_server_mac.sh" },
  }

  require("lspconfig").elixirls.setup {
    cmd = { home .. "/.local/bin/elixir-ls/language_server.sh" },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      dialyzerEnabled = true,
      dialyzerWarnOpts = {
        enum = {
          "error_handling",
          "no_behaviours",
          "no_contracts",
          "no_fail_call",
          "no_fun_app",
          "no_improper_lists",
          "no_match",
          "no_missing_calls",
          "no_opaque",
          "no_return",
          "no_undefined_callbacks",
          "no_unused",
          "underspecs",
          "unknown",
          "unmatched_returns",
          "overspecs",
          "specdiffs"
        },
        type = "string"
      }
    }
  }

  require("lspconfig").diagnosticls.setup {
    filetypes = {
      "javascript",
      "javascript.jsx",
      'typescript',
      'typescriptreact',
      'css',
      'scss',
      'markdown',
      'pandoc',
    },
    init_options = {
      filetypes = {
        javascript = "eslint",
        ["javascript.jsx"] = "eslint",
        javascriptreact = "eslint",
        typescriptreact = "eslint",
        markdown = 'markdownlint',
        pandoc = 'markdownlint'
      },
      linters = {
        eslint = {
          sourceName = "eslint",
          command = "./node_modules/.bin/eslint",
          rootPatterns = { ".git" },
          debounce = 100,
          args = {
            "--stdin",
            "--stdin-filename",
            "%filepath",
            "--format",
            "json",
          },
          parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "(eslint) ${message} [${ruleId}]",
            security = "severity",
          };
          securities = {
            [2] = "error",
            [1] = "warning"
          }
        },
        markdownlint = {
          command = 'markdownlint',
          rootPatterns = { '.git' },
          isStderr = true,
          debounce = 100,
          args = { '--stdin' },
          offsetLine = 0,
          offsetColumn = 0,
          sourceName = 'markdownlint',
          securities = {
            undefined = 'hint'
          },
          formatLines = 1,
          formatPattern = {
            '^.*:(\\d+)\\s+(.*)$',
            {
              line = 1,
              column = -1,
              message = 2,
            }
          }
        }
      }
    }
  }
end

function config.completion()
  local cmp = require'cmp'

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = {
      ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, { "i", "s" }),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      })
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })
end

function config.vsnip()
  vim.g.vsnip_snippet_dir = '~/.config/nvim/vsnip'
end

return config
