#!/bin/bash

# 失敗したら即終了、未定義変数はエラー、パイプコマンドの途中のエラーも検知
set -ueo pipefail

# スクリプト自身のディレクトリを絶対パスで取得
DOTFILES_DIR=$(cd "$(dirname "$0")"; pwd)

#
# === 1. 基本ツールのインストール（apt） ===
#
echo "ℹ️ Starting dotfiles setup..."
sudo apt-get update
sudo apt-get install -y build-essential curl git software-properties-common unzip

#
# === 2. miseのインストール ===
#
if ! command -v mise &> /dev/null; then
  echo "ℹ️ Installing mise..."
  curl -fsSL https://mise.run | sh
  # 一時的にパスを通す（mise activateすれば自動でパスを通してくれるが、install.shの中では~/.local/bin/miseが見えないため）
  export PATH="$HOME/.local/bin:$PATH"
fi

#
# === 3. ツールのインストール ===
#
echo "ℹ️ Installing CLI tools via mise..."

# fishをインストールする（miseでインストールできない）
echo "ℹ️ Installing fish..."
sudo apt-add-repository -y ppa:fish-shell/release-4
sudo apt-get update
sudo apt-get install -y fish

# dockerでも必要なツールをインストールする
echo "ℹ️ Installing common tools..."
# $DOTFILES_DIR/config/mise/config.toml に列挙されているツールをインストールする
mise trust
mise install
# DOCKER_BUILD=trueならホスト専用ツールをスキップ
if [ "${DOCKER_BUILD:-false}" = "false" ]; then
  # hostの場合のみ必要なツールをインストールする
  echo "ℹ️ Installing host_only tools..."
  sudo apt-get install -y xclip             # クリップボード共有用
fi

# Rustのインストール
echo "ℹ️ Installing Rust..."
if ! command -v cargo &> /dev/null; then
  curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
  source "$HOME/.cargo/env"
fi
# LSP・フォーマッタ・リンタ
rustup component add rust-analyzer rustfmt clippy

# tldrのインストール
if ! command -v tldr &> /dev/null; then
  cargo install tealdeer
  tldr --update
fi

#
# === 4. 設定ファイルのリンク作成 ===
#

# 安全にリンクを貼るための関数
deploy_link() {
  local src=$1    # dotfiles側のパス
  local dst=$2    # ホームディレクトリ側のパス

  # すでに実体がある場合はバックアップ
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "⚠️  Backing up existing $dst to $dst.bak"
    mv "$dst" "$dst.bak"
  fi

  # 親ディレクトリを作成
  mkdir -p "$(dirname "$dst")"

  # シンボリックリンクを貼る
  ln -sfn "$src" "$dst"
}

# シンボリックリンクを貼る
echo "ℹ️ Creating symlinks..."

# ~/.config配下の処理
for path in "$DOTFILES_DIR/config/"*; do
  [ -e "$path" ] || continue # ファイルが存在しない場合のガード
  name=$(basename "$path")

  # 例外：gitディレクトリは~/.gitconfigとして貼る
  [ "$name" == "git" ] && continue

  deploy_link "$path" "$HOME/.config/$name"
done

# 例外的なファイル（ホーム直下）の処理
deploy_link "$DOTFILES_DIR/config/git/config" "$HOME/.gitconfig"

#
# === 5. Fishシェルのセットアップ ===
#
if [[ "$SHELL" != *"fish"* ]]; then
    echo "ℹ️ Switching default shell to fish..."
    if ! grep -q "$(which fish)" /etc/shells; then
        echo "$(which fish)" | sudo tee -a /etc/shells
    fi
    chsh -s "$(which fish)"
fi

# fisher本体のインストール
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
# fishプラグインのインストール
fish -c "fisher install PatrickF1/fzf.fish"
fish -c "fisher install jorgebucaran/autopair.fish"


echo "ℹ️ All done! Please restart your terminal."
