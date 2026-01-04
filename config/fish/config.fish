# --- 全モード共通の設定（PATHなど） ---
if test -d /home/linuxbrew/.linuxbrew/bin
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

if type -q zoxide
  zoxide init fish | source
end

# --- 対話モード専用の設定（見た目やエイリアスなど） ---
if status is-interactive
# Commands to run in interactive sessions can go here

# Starshipの初期化
starship init fish | source

# 設定の再読み込み
abbr -a reload 'source ~/.config/fish/config.fish'

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

end

