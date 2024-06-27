Write-Host " _   __              _        _      ______  _    _  _____  _   _ "
Write-Host "| | / /             (_)      ( )     | ___ \| |  | |/  ___|| | | |"
Write-Host "| |/ /   ___ __   __ _  _ __ |/ ___  | |_/ /| |  | |\ ``--. | |_| |"
Write-Host "|    \  / _ \\ \ / /| || '_ \  / __| |  __/ | |/\| | ``--. \|  _  |"
Write-Host "| |\  \|  __/ \ V / | || | | | \__ \ | |    \  /\  //\__/ /| | | |"
Write-Host "\_| \_/ \___|  \_/  |_||_| |_| |___/ \_|     \/  \/ \____/ \_| |_/"
Write-Host ""

$BinPath = Resolve-Path "$PSScriptRoot/bin"
$ScriptsToLoad = "$BinPath/*.ps1"


Write-Host -NoNewline "---"
Write-Host -NoNewline " START " -ForegroundColor Cyan
Write-Host "---------------------------------------------------------"
Write-Host "> BinPath: $BinPath" -ForegroundColor White

$Scripts = Get-ChildItem  $ScriptsToLoad
Write-Host "> Discovered: $($Scripts.Length) Scripts" -ForegroundColor White

$Scripts | ForEach-Object {
    . $_
    Write-Host -NoNewline "> Loaded: " -ForegroundColor White
    Write-Host $_.Name -ForegroundColor Magenta
}

Write-Host -NoNewline "---"
Write-Host -NoNewline " READY " -ForegroundColor Green
Write-Host "---------------------------------------------------------"