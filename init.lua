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

