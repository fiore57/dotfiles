Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# 管理者権限のチェック
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error 'このスクリプトを実行するには管理者権限が必要です。PowerShellを管理者として実行してください。'
}

$apps = @(
  "nathancorvussolis.corvusskk",
  "Vivaldi.Vivaldi",
  "Logitech.GHUB",
  "Notion.Notion",
  "Notion.NotionCalendar",
  "Microsoft.WindowsTerminal",
  "Microsoft.PowerToys",
  "DevToys-app.DevToys",
  "voidtools.Everything",
  "Amazon.Kindle",
  "Docker.DockerDesktop",
  "Microsoft.PowerShell"
)

foreach ($app in $apps) {

  # インストール済みならスキップ

  # コマンドが値を返すとそのまま標準出力（コンソール）に流れるため、`$null = ...`として破棄している
  # --id：idで結果をフィルター
  # -e（exact）：完全一致
  # -s（source）：指定されたリソースでパッケージ検索
  # 2>$null：標準エラー出力を破棄
  $null = winget list --id $app -e -s winget 2>$null
  if ($?) {
    Write-Host "$app is already installed. Skipping." -ForegroundColor Yellow
    continue
  }

  # インストール

  Write-Host "Installing $app..." -ForegroundColor Cyan
  winget install --id $app -e --source winget --silent --accept-package-agreements --accept-source-agreements


}
