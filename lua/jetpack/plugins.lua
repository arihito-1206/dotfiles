require('jetpack.packer').startup(function(use)
    use { 'tani/vim-jetpack' } -- bootstrap
    -- use 'ntk148v/vim-horizon'
    use 'preservim/nerdtree' -- ファイルエクスプローラ
    -- カラースキーム
    use 'EdenEast/nightfox.nvim'
    use 'cocopon/iceberg.vim' -- カラースキーム
    use 'junegunn/fzf.vim' -- 検索
    use {'junegunn/fzf', run = 'call fzf#install()' }
    use {
        "tpope/vim-fugitive", -- Git コマンド
        opt = true,
        cmd = {
            "G", "Git", "Gdiffsplit", "Gvdiffsplit", "Gedit", "Gsplit",
            "Gread", "Gwrite", "Ggrep", "Glgrep", "Gmove",
            "Gdelete", "Gremove", "Gbrowse",
        },
    }
    use 'airblade/vim-gitgutter' -- Git の差分を表示させる
    use 'tpope/vim-commentary' -- コメントアウトの操作性向上
    use 'cohama/lexima.vim' -- 括弧補完
    -- use {'neoclide/coc.nvim', branch = 'release'}
    -- use {'fatih/vim-go'}
    -- use 'sheerun/vim-polyglot' -- Syntax highlight
    -- ### nvim-lsp 関連 ###
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
end)

-- termguicolorsを設定
-- vim.opt.termguicolors = true

-- lightlineの設定
-- vim.g.lightline = { colorscheme = 'horizon' }
