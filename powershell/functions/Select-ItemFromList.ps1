function Select-ItemFromList {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [PSObject[]]$Items
    )

    begin {
        $allItems = @()
    }

    process {
        $allItems += $_
    }

    end {
        $selectedItem = Get-SelectionByNumber -MenuItems $allItems -Title "Select an item from the list:"
        return $selectedItem
    }
}