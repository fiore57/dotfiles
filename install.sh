#!/bin/bash

# 失敗したら即終了、未定義変数はエラー、パイプコマンドの途中のエラーも検知
set -ueo pipefail

# スクリプト自身のディレクトリを絶対パスで取得
DOTFILES_DIR=$(cd "$(dirname "$0")"; pwd)

echo "ℹ️ Starting dotfiles setup..."

# === 1. 基本ツールのインストール（apt） ===
sudo apt update
sudo apt install -y build-essential curl git

# === 2. Homebrewのインストール & パス通し ===
if ! command -v brew &> /dev/null; then
  echo "ℹ️ Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
# このセッションで直ちにbrewを使えるようにする（再起動不要）
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# === 3. Brewツールの一括インストール ===
echo "ℹ️ Installing CLI tools via Brew..."
# インストールするツールのリスト
CORE_TOOLS=(
  fish        # シェル
  neovim      # エディタ
  gh          # GitHub CLI
  bat         # モダンなcat
  eza         # モダンなls
  fd          # モダンなfind
  git-delta   # モダンなgit diff
  ripgrep     # モダンなgrep
  fzf         # 曖昧検索
  zoxide      # 過去に訪れたディレクトリにzで移動
  xclip       # クリップボード共有用
)
# 既にインストール済みの場合はスキップされる
brew install "${CORE_TOOLS[@]}"

# === 4. GitHub認証 & SSH設定 ===
if ! gh auth status &> /dev/null; then
  echo "ℹ️ GitHub CLI login required"
  gh auth login -s admin:public_key -s repo
fi
# SSH鍵がなければ生成してGitHubに登録
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    echo "ℹ️ Generating SSH key..."
    ssh-keygen -t ed25519 -N "" -f "$HOME/.ssh/id_ed25519"
    gh ssh-key add "$HOME/.ssh/id_ed25519.pub" --title "WSL-Ubuntu-$(date +%Y%m%d)"
fi
# HTTPSのリモートURLをSSH形式に書き換える
cd "$DOTFILES_DIR"
current_url=$(git remote get-url origin)
if [[ $current_url == https://github.com/* ]]; then
    new_url=$(echo $current_url | sed 's|https://github.com/|git@github.com:|')
    git remote set-url origin "$new_url"
fi

# === 5. 設定ファイルのリンク作成 ===
echo "ℹ️ Creating symlinks..."
# configディレクトリ配下をまとめて ~/.config/ へ
mkdir -p "$HOME/.config"
for path in "$DOTFILES_DIR/config/"*; do
  name=$(basename "$path")
  target="$HOME/.config/$name"
  # 既存の実体ディレクトリがあればバックアップ
  if [ -d "$target" ] && [ ! -L "$target" ]; then
    echo "⚠️  Moving existing $name to $target.bak"
    mv "$target" "$target.bak"
  fi
  # シンボリックリンクを貼る
  ln -sfn "$path" "$target"
done

# === 6. Fishシェルのセットアップ ===
if [[ "$SHELL" != *"fish"* ]]; then
    echo "ℹ️ Switching default shell to fish..."
    if ! grep -q "$(which fish)" /etc/shells; then
        echo "$(which fish)" | sudo tee -a /etc/shells
    fi
    chsh -s "$(which fish)"
fi

echo "ℹ️ All done! Please restart your terminal."
