# 手順

## Linux(WSL)

```bash
git clone https://github.com/fiore57/dotfiles.git
cd dotfiles
./install.sh
```

1. Windows Terminalの設定を開く
2. 左のメニューの一番下「JSONファイルを開く」からsettings.jsonを開く
3. 該当のプロファイルに以下を追記する

```json
"colorScheme": "One Half Dark",
"font":
{
    "face": "HackGen Console NF",
    "size": 11
},
"opacity": 85,
"padding": "10",
"scrollbarState": "hidden",
```

## Windows

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex (irm "https://raw.githubusercontent.com/fiore57/dotfiles/main/install-apps.ps1")
```
