. (Resolve-Path "$PSScriptRoot/envVars.ps1")

Clear-Host
Write-Host "----------------------------------------------------------------------"
Write-Host "   _   __              _        _      ______  _    _  _____  _   _ "
Write-Host "  | | / /             (_)      ( )     | ___ \| |  | |/  ___|| | | |"
Write-Host "  | |/ /   ___ __   __ _  _ __ |/ ___  | |_/ /| |  | |\ ``--. | |_| |"
Write-Host "  |    \  / _ \\ \ / /| || '_ \  / __| |  __/ | |/\| | ``--. \|  _  |"
Write-Host "  | |\  \|  __/ \ V / | || | | | \__ \ | |    \  /\  //\__/ /| | | |"
Write-Host "  \_| \_/ \___|  \_/  |_||_| |_| |___/ \_|     \/  \/ \____/ \_| |_/"
Write-Host ""
Write-Host -NoNewline "----------------------------------------------------------"
Write-Host -NoNewline " LOADING " -ForegroundColor Yellow
Write-Host "---"
# Write-Host "> FnsPath: $FnsPath" -ForegroundColor White

# Autoload Functions
Get-ChildItem "$PSScriptRoot/functions/*.ps1" | ForEach-Object {
    . $_
    Write-Host -NoNewline "[FUNC] " -ForegroundColor Cyan
    Write-Host $_.Name -ForegroundColor White
}

# Autoload Modules
Get-ChildItem "$PSScriptRoot/modules/*.psm1" | ForEach-Object {
    Import-Module $_ -Force
    $ImportedFunctions = Get-Command -Module $_.BaseName -CommandType Function | ForEach-Object { $_.Name }
    Write-Host -NoNewline "[MOD ] " -ForegroundColor Magenta
    Write-Host $_.Name -ForegroundColor White
    Write-Host -NoNewline "[>>>>] " -ForegroundColor Magenta
    Write-Host (Join-String -Separator ", " -InputObject $ImportedFunctions) -ForegroundColor Cyan
}

Write-Host -NoNewline "-----------------------------------------------------------"
Write-Host -NoNewline " READY! " -ForegroundColor Green
Write-Host "---"