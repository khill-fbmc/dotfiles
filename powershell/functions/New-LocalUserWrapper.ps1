Import-Module microsoft.powershell.localaccounts -UseWindowsPowerShell

function New-LocalUserWrapper {
    param (
        [string]$UserName,
        [string]$Password,
        [string]$FullName,
        [string]$Description
    )

    # Convert plain text password to a secure string
    $SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force

    # Define parameters for New-LocalUser
    $Params = @{
        Name        = $UserName
        Password    = $SecurePassword
        FullName    = $FullName
        Description = $Description
    }

    # Create the new local user
    New-LocalUser @Params
}