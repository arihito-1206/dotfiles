-- basic
vim.opt.shell = "/bin/zsh"
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.textwidth = 0
vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.clipboard = "unnamedplus"
vim.cmd('syntax on')


-- Key map
vim.keymap.set('n', '[b', ':bprevious<CR>') -- バッファ切り替え
vim.keymap.set('n', ']b', ':bnext<CR>') -- バッファ切り替え

vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    io.write("\27[5 q")  -- ESC[5 q = 点滅縦棒（多くのターミナルでデフォルト）
    io.flush()
  end,
})

-- 推奨: leader キー（未設定なら）
vim.g.mapleader = ' '

-- 補完の見た目を少し良く
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- vim.cmd('packadd vim-jetpack')
-- require('jetpack.plugins')
-- Plugin manager
require('config.lazy')

-- LSP Setting
require('config.lsp')
