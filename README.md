# 手順

## Linux(WSL)

```bash
git clone https://github.com/fiore57/dotfiles.git
cd dotfiles
./install.sh
```

`mise trust`しろと言われたら、以下を実行

```bash
cd config/mise
mise trust
mise install
```

ghのセットアップ

```bash
gh auth login
gh auth setup-git
git update-index --assume-unchanged config/git/config
```

これによってconfig/git/configを更新しても `git status` で表示されないため、戻したいときは `git update-index --no-assume-unchanged config/git/config` とする必要がある点に注意

### Windows Terminalの設定

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

1. https://github.com/yuru7/HackGen/releases から `HackGen_NF_v*.zip` をダウンロードする
2. 展開し、 `HackGenConsoleNF-Regular.ttf` と `HackGenConsoleNF-Bold.ttf` を右クリック→インストールする
