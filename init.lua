-- basic
vim.opt.shell = "/bin/zsh"
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.textwidth = 0
vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.clipboard = "unnamed"
vim.cmd('syntax on')

vim.cmd('packadd vim-jetpack')
require('jetpack.plugins')

-- Key map
vim.keymap.set('n', '<C-n>', ':NERDTree<CR>')
vim.keymap.set('n', '[b', ':bprevious<CR>') -- バッファ切り替え
vim.keymap.set('n', ']b', ':bnext<CR>') -- バッファ切り替え

vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    io.write("\27[5 q")  -- ESC[5 q = 点滅縦棒（多くのターミナルでデフォルト）
    io.flush()
  end,
})

-- color scheme
-- vim.cmd('colorscheme nightfox')
vim.cmd('colorscheme iceberg')

-- 推奨: leader キー（未設定なら）
vim.g.mapleader = ' '

-- 補完の見た目を少し良く
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- LSPのcapabilities（cmp連携）
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSPが有効化されたバッファにだけキーマップ & 保存時フォーマット
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local map = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf })
    end
    -- 基本操作
    map('n', 'gd', vim.lsp.buf.definition)
    map('n', 'gD', vim.lsp.buf.declaration)
    map('n', 'gi', vim.lsp.buf.implementation)
    map('n', 'gr', vim.lsp.buf.references)
    map('n', 'K',  vim.lsp.buf.hover)
    map('n', '<leader>rn', vim.lsp.buf.rename)
    map('n', '<leader>ca', vim.lsp.buf.code_action)
    -- 診断
    map('n', 'gl', vim.diagnostic.open_float)
    map('n', '[d', vim.diagnostic.goto_prev)
    map('n', ']d', vim.diagnostic.goto_next)
    map('n', '<leader>q', vim.diagnostic.setloclist)

    -- 保存時フォーマット（同期）
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = ev.buf,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
})

-- gopls を“手動インストール前提”で設定
-- TODO: mason を使って管理する
local lspconfig = require('lspconfig')
lspconfig.gopls.setup({
  capabilities = capabilities,
  settings = {
    gopls = {
      gofumpt = true,            -- gofmt強化
      staticcheck = true,        -- 静的解析
      analyses = { unusedparams = true },
      -- organizeImports は gopls の format に含まれるため、基本はこれでOK
    },
  },
})

-- Setup nvim-cmp (自動補完の設定)
-- ref. https://zenn.dev/botamotch/articles/21073d78bc68bf
local cmp = require("cmp")
cmp.setup({
  -- TODO: スニペット機能を使いたくなったら、vsnip をインストールする
  -- snippet = {
  --   expand = function(args)
  --     vim.fn["vsnip#anonymous"](args.body)
  --   end,
  -- },
  sources = {
    { name = "nvim_lsp" },
    -- { name = "buffer" },
    -- { name = "path" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<S-TAB>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<TAB>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})
