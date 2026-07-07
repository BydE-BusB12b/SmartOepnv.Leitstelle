@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Smart-OEPNV Leitstelle - Schnellstart
echo(
echo === Smart-OEPNV Leitstelle starten ===
echo Kein Installer noetig - ideal zum Testen.
echo(
taskkill /F /IM Smart-OEPNV-Leitstelle.exe >nul 2>&1
dotnet build "src\SmartOepnv.Leitstelle\SmartOepnv.Leitstelle.csproj" -c Debug -v q
if errorlevel 1 (
    echo Build fehlgeschlagen.
    pause
    exit /b 1
)
start "" "%~dp0src\SmartOepnv.Leitstelle\bin\Debug\net8.0-windows10.0.17763\Smart-OEPNV-Leitstelle.exe"
echo Leitstelle gestartet.
timeout /t 2 >nul
