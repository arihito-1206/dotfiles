# dotfiles

macOS 用の Neovim / WezTerm 設定です。`setup.sh` が必要なツールのインストールと、`~/.config` へのシンボリックリンク作成を行います。

## Requirements

- macOS
- [Homebrew](https://brew.sh/)
- Git

## Setup

```bash
git clone https://github.com/arihito-1206/dotfiles.git
cd dotfiles
bash setup.sh
```

引数を省略すると Neovim と WezTerm の両方をセットアップし、最後に検証を実行します。

個別にセットアップする場合:

```bash
bash setup.sh nvim
bash setup.sh wezterm
```

利用できるコマンドは `bash setup.sh --help` で確認できます。

## Verify

```bash
bash setup.sh verify
```

次の項目を確認し、導入済みのバージョンとシンボリックリンクの参照先を表示します。

- `nvim`、`gopls`、`wezterm` が `PATH` 上にあること
- Neovim / WezTerm の設定がこのリポジトリへリンクされていること

成功すると `Verification passed.` と表示されます。

## Configuration

### Neovim

`setup.sh nvim` は Homebrew で Neovim と `gopls` をインストールし、次の設定をリンクします。

```text
~/.config/nvim/init.lua -> <repository>/init.lua
~/.config/nvim/lua      -> <repository>/lua
```

プラグイン管理には [lazy.nvim](https://lazy.folke.io/) を使用し、初回起動時に自動で取得します。Go の補完・定義ジャンプ・診断・保存時フォーマットには Neovim の built-in LSP と `gopls` を使用します。

### WezTerm

`setup.sh wezterm` は Homebrew で WezTerm nightly と MesloLGS NF をインストールし、次の設定をリンクします。

```text
~/.config/wezterm/wezterm.lua  -> <repository>/wezterm/wezterm.lua
~/.config/wezterm/keybinds.lua -> <repository>/wezterm/keybinds.lua
```

一部の設定が nightly 版を前提としているため、stable 版の WezTerm が導入済みの場合は、先に次のコマンドでアンインストールしてください。

```bash
brew uninstall --cask wezterm
```

## Existing configuration and reruns

リンク先に既存のファイルやディレクトリがある場合は、同じ場所へ `.backup-YYYYMMDD-HHMMSS` を付けて退避してからリンクを作成します。

`setup.sh` は再実行できます。必要な Homebrew パッケージが導入済みで、正しいシンボリックリンクが存在する場合は、その項目を変更せずに処理を続けます。別のシンボリックリンクがある場合は、このリポジトリへのリンクに置き換えます。
