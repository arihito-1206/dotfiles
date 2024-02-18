require('jetpack.packer').startup(function(use)
  use { 'tani/vim-jetpack' } -- bootstrap
  use 'ntk148v/vim-horizon'
end)

-- termguicolorsを設定
vim.opt.termguicolors = true

-- カラースキームを設定
vim.cmd('colorscheme horizon')

-- lightlineの設定
vim.g.lightline = { colorscheme = 'horizon' }

