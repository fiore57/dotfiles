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

gitのセットアップ

```bash
git remote set-url origin git@github.com:fiore57/dotfiles.git
ssh-keygen -t ed25519 -C "fiore57.cpp@gmail.com"
bat ~/.ssh/id_ed25519.pub
```

表示されたSSHキーをGithubのSettings→SSH and GPG keys→New SSH keyに貼り付け

```bash
ssh -T git@github.com
```

ユーザー名が表示されればOK

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
"padding": "10",
"scrollbarState": "hidden",
```

## Windows

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex (irm "https://raw.githubusercontent.com/fiore57/dotfiles/main/install-apps.ps1")
```

1. https://github.com/yuru7/HackGen/releases から `HackGen_NF_v*.zip` をダウンロードする
2. 展開し、 `HackGenConsoleNF-Regular.ttf` と `HackGenConsoleNF-Bold.ttf` を右クリック→インストールする
