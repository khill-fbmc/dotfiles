function Connect-FortunaExchange {
    [CmdletBinding()]
    param(
        [string]$CertificatePassword
    )

    if (-not $CertificatePassword) {
        # Prompt the user for input
        $CertificatePassword = Read-Host "Please input the ExO.pfx password: "
    }

    $X509Certificate2 = [System.Security.Cryptography.X509Certificates.X509Certificate2]
    $Cert = $X509Certificate2::New($env:EXO_PFX_PATH, $CertificatePassword)
    Connect-ExchangeOnline -Organization $env:TENANT_DOMAIN -Certificate $Cert -AppId $env:EXO_APP_ID
}