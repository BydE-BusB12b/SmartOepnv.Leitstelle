@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Smart-OEPNV Leitstelle (Schnellstart)
echo.
echo === Smart-OEPNV Leitstelle starten (dotnet run) ===
echo Kein Installer noetig – ideal zum Testen.
echo.
dotnet run --project "src\SmartOepnv.Leitstelle\SmartOepnv.Leitstelle.csproj"
echo.
if errorlevel 1 (
    echo FEHLER – siehe Meldung oben.
    pause
)
