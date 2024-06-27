function Get-SelectionByNumber {
    param (
        [array]$MenuItems,
        [string]$Title
    )

    $selectedIndex = -1

    while ($selectedIndex -lt 0 -or $selectedIndex -ge $MenuItems.Length) {
        Display-MenuInline -MenuItems $MenuItems -Title $Title

        $choice = Read-Host "Enter the number of your selection"
        if ($choice -match '^\d+$') {
            $selectedIndex = [int]$choice
            if ($selectedIndex -lt 0 -or $selectedIndex -ge $MenuItems.Length) {
                Write-Host "Invalid selection. Please enter a number between 0 and $($MenuItems.Length - 1)." -ForegroundColor Red
            }
        }
        else {
            Write-Host "Invalid choice. Please enter a number." -ForegroundColor Red
        }
    }

    return $MenuItems[$selectedIndex]
}