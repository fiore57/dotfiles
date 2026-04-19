# --- 全モード共通の設定（PATHなど） ---

# --- 対話モード専用の設定（見た目やエイリアスなど） ---
if status is-interactive
# Commands to run in interactive sessions can go here

fzf_configure_bindings --directory=ctrl-t

# miseのパスを通す
set -l mise_bin ~/.local/bin/mise
if test -x $mise_bin
  $mise_bin activate fish | source
end

if type -q zoxide
  zoxide init fish | source
end

# Starshipの初期化
starship init fish | source

# 設定の再読み込み
abbr -a reload 'source ~/.config/fish/config.fish'

# nvim
abbr -a nv nvim
# eza（モダンなls）
abbr -a l eza
abbr -a ls eza
abbr -a ll eza -l --no-user --git --time-style relative
abbr -a la eza -la --no-user --git --time-style relative
abbr -a tree eza --tree
# Git関連
abbr -a g git
abbr -a ga git add
abbr -a gap git add -p
abbr -a gb git branch
abbr -a gbd git branch -d
abbr -a gc git commit
abbr -a gcm git commit -m
abbr -a gd git diff
abbr -a gdc git diff --cached
abbr -a gl git l
abbr -a glo git lo
abbr -a glol git lol
abbr -a gs git status
abbr -a gss git status --short --branch
abbr -a gw git switch
abbr -a gwc git switch -c
abbr -a gwb git branch -
# tmux
abbr -a t tmux
abbr -a ta 'tmux attach || tmux new'
# docker
abbr -a docker-build-dev-base 'docker build -f Dockerfile.base -t dev-base .'
abbr -a docker-build-haskell-dev 'docker build -f Dockerfile.haskell -t haskell-dev .'
abbr -a haskell-dev 'docker run -it --rm -v "$HOME/dotfiles:/root/.dotfiles" -v "$HOME/workspace/haskell:/workspace" haskell-dev'

end

