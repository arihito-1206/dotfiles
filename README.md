# dotfiles
## WezTerm のセットアップ
### インストール
```
brew install --cask wezterm@nightly
```
※一部 nightly 限定機能を使っているため

### configファイルにシンボリックリンクリンクを貼る
```
mkdir -p ~/.config/wezterm
ln -s {git repo directory}/dotfiles/wezterm/* ~/.config/wezterm
```

## neovim のセットアップ
### 方針
- ~~プラグイン管理は[vim-jetpack](https://github.com/tani/vim-jetpack)を使う~~
- プラグイン管理は [lazy.nvim](https://lazy.folke.io/) に移管した。

### 手順
#### neovimのインストール
`brew install neovim`

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
