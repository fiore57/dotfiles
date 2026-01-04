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
# コマンドが存在しないならインストールする関数
install_if_missing() {
  local command_name=$1
  local package_name=${2:-$1} # 2番目の引数がなければ1番目と同じとみなす

  if ! command -v "$command_name" &> /dev/null; then
    echo "ℹ️ Installing $package_name..."
    brew install $package_name
  fi
}

echo "ℹ️ Installing CLI tools via Brew..."
install_if_missing "fish"               # シェル
install_if_missing "nvim" "neovim"      # エディタ
install_if_missing "gh"                 # GitHub CLI
install_if_missing "bat"                # モダンなcat
install_if_missing "eza"                # モダンなls
install_if_missing "fd"                 # モダンなfind
install_if_missing "delta" "git-delta"  # モダンなgit diff
install_if_missing "rg" "ripgrep"       # モダンなgrep
install_if_missing "fzf"                # 曖昧検索
install_if_missing "zoxide"             # 過去に訪れたディレクトリにzで移動
install_if_missing "xclip"              # クリップボード共有用
install_if_missing "starship"           # fishのカスタマイズ

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
# 安全にリンクを貼るための関数
deploy_link() {
  local src=$1    # dotfiles側のパス
  local dst=$2    # ホームディレクトリ側のパス

  # 1. すでに実体がある場合はバックアップ
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "⚠️  Backing up existing $dst to $dst.bak"
    mv "$dst" "$dst.bak"
  fi

  # 2. 親ディレクトリを作成
  mkdir -p "$(dirname "$dst")"

  # 3. シンボリックリンクを貼る
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


# === 6. Fishシェルのセットアップ ===
if [[ "$SHELL" != *"fish"* ]]; then
    echo "ℹ️ Switching default shell to fish..."
    if ! grep -q "$(which fish)" /etc/shells; then
        echo "$(which fish)" | sudo tee -a /etc/shells
    fi
    chsh -s "$(which fish)"
fi

echo "ℹ️ All done! Please restart your terminal."
