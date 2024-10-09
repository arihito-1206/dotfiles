# dotfiles
## neovim のセットアップ
### 方針
- プラグイン管理は[vim-jetpack](https://github.com/tani/vim-jetpack)を使う

### 手順
#### neovimのインストール
`brew install neovim`

#### vim-jetpackのインストール
基本は本家のREADMEに従う。
`curl -fLo ~/.local/share/nvim/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim`

#### node.jsのインストール
coc.nvimのために入れる。けど、LSPはneovim built in LSPに乗り換えるかも。
`brew install nvm`
`nvm install node`

#### configファイルにシンボリックリンクリンクを貼る
```
mkdir -p ~/.config/nvim/
ln -s {git repo directory}/dotfiles/init.lua ~/.config/nvim/init.lua
ln -s {git repo directory}/dotfiles/lua ~/.config/nvim/lua
```

#### プラグインのインストール
neovimを起動して、以下のコマンドを実行
`:JetpackSync`
