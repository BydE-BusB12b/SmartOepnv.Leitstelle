# Einmalige Windows-Freigabe für VoIP-Signaling (Leitstelle-Installer, Admin).
$ErrorActionPreference = "SilentlyContinue"

$urls = @(
    "http://+:8787/",
    "http://+:8787/voip/ws/"
)
$users = @("Jeder", "Everyone", "NT AUTHORITY\Authenticated Users")

foreach ($url in $urls) {
    foreach ($user in $users) {
        netsh http add urlacl url=$url user=$user 2>$null | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "URL-Reservierung OK: $url ($user)"
            break
        }
    }
}

netsh advfirewall firewall add rule name="Smart-OEPNV VoIP" dir=in action=allow protocol=TCP localport=8787 2>$null | Out-Null
Write-Host "Firewall-Regel VoIP (8787/TCP) gesetzt oder bereits vorhanden."

exit 0
