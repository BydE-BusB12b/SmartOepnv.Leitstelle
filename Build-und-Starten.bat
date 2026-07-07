@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Smart-OEPNV Leitstelle - Build + Start
echo(
echo === Baue Release-Version ===
taskkill /F /IM Smart-OEPNV-Leitstelle.exe >nul 2>&1
dotnet build "src\SmartOepnv.Leitstelle\SmartOepnv.Leitstelle.csproj" -c Release
if errorlevel 1 (
    echo Build fehlgeschlagen.
    pause
    exit /b 1
)
echo(
echo === Starte EXE ===
start "" "%~dp0src\SmartOepnv.Leitstelle\bin\Release\net8.0-windows10.0.17763\Smart-OEPNV-Leitstelle.exe"
echo Leitstelle gestartet.
timeout /t 3 >nul
