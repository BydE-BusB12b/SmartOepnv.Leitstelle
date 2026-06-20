# Erstellt Setup-Smart-OEPNV-Leitstelle-x64.exe

$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path))
$Project = Join-Path $Root "src\SmartOepnv.Leitstelle\SmartOepnv.Leitstelle.csproj"
$PublishDir = Join-Path $Root "publish\win-x64"
$IssFile = Join-Path $Root "installer\SmartOepnv.Leitstelle.iss"
$DistDir = Join-Path $Root "dist"
$LeitstelleIcon = Join-Path $Root "installer\assets\leitstelle.ico"

Write-Host "=== Smart-OEPNV Leitstelle: Installer-Build ===" -ForegroundColor Cyan

if (-not (Test-Path $LeitstelleIcon)) {
    $png = Join-Path $Root "installer\assets\leitstelle-512.png"
    if (-not (Test-Path $png)) { throw "Leitstelle-Icon fehlt: installer\assets\leitstelle-512.png" }
    & (Join-Path $Root "installer\scripts\Convert-PngToIco.ps1") -PngPath $png -IcoPath $LeitstelleIcon
}

Write-Host "1/3 dotnet publish..." -ForegroundColor Yellow
if (Test-Path $PublishDir) { Remove-Item $PublishDir -Recurse -Force }
dotnet publish $Project -c Release -r win-x64 --self-contained true -p:PublishReadyToRun=true -p:PublishTrimmed=false -o $PublishDir
if ($LASTEXITCODE -ne 0) { throw "dotnet publish fehlgeschlagen" }

$IsccCandidates = @(
    "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe",
    "$env:ProgramFiles\Inno Setup 6\ISCC.exe",
    (Join-Path (Split-Path -Parent $Root) "SmartOepnv.Planer\tools\InnoSetup6\ISCC.exe")
)
$Iscc = $IsccCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $Iscc) { throw "Inno Setup 6 nicht gefunden." }

if (-not (Test-Path $DistDir)) { New-Item -ItemType Directory -Path $DistDir | Out-Null }
Write-Host "2/3 Inno Setup..." -ForegroundColor Yellow
& $Iscc $IssFile
if ($LASTEXITCODE -ne 0) { throw "Inno Setup Build fehlgeschlagen" }

$SetupExe = Get-ChildItem $DistDir -Filter "Setup-Smart-OEPNV-Leitstelle-x64*.exe" | Sort-Object LastWriteTime -Descending | Select-Object -First 1

function Get-ProjectVersion {
    param([string]$CsprojPath)
    [xml]$doc = Get-Content -LiteralPath $CsprojPath -Encoding UTF8
    foreach ($group in $doc.Project.PropertyGroup) {
        if ($group.Version) {
            return "$($group.Version)".Trim()
        }
    }
    throw "Keine Version in $CsprojPath gefunden."
}

if ($SetupExe) {
    $version = Get-ProjectVersion -CsprojPath $Project
    $uploadScript = Join-Path (Split-Path -Parent $Root) "SmartOepnv.Shared\scripts\Upload-DistSetupToDropbox.ps1"
    if (-not (Test-Path $uploadScript)) {
        throw "Upload-Skript fehlt: $uploadScript"
    }
    & $uploadScript -SetupExePath $SetupExe.FullName -Product Leitstelle -Version $version
}

Write-Host "=== FERTIG ===" -ForegroundColor Green
if ($SetupExe) { Write-Host "Setup: $($SetupExe.FullName)" -ForegroundColor White }
