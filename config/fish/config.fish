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
end
