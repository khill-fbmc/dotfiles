function New-LocalAdmin {
    param (
        [string]$UserName,
        [string]$Password,
        [string]$FullName,
        [string]$Description
    )

    New-LocalUserWrapper `
        -UserName $UserName `
        -Password $Password `
        -FullName $FullName `
        -Description $Description

    Add-LocalGroupMember `
        -Group "Administrators" `
        -Member $Username
}