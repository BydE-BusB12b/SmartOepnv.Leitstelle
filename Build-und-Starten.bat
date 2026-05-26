@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Smart-OEPNV Leitstelle – Build + Start
echo.
echo === Baue Release-Version ===
dotnet build "src\SmartOepnv.Leitstelle\SmartOepnv.Leitstelle.csproj" -c Release
if errorlevel 1 (
    echo Build fehlgeschlagen.
    pause
    exit /b 1
)
echo.
echo === Starte EXE ===
start "" "%~dp0src\SmartOepnv.Leitstelle\bin\Release\net8.0-windows\Smart-OEPNV-Leitstelle.exe"
echo Leitstelle gestartet.
timeout /t 3 >nul
