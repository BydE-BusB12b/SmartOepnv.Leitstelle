@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Smart-OEPNV Leitstelle – Installer bauen
echo.
echo === Erstellt Setup-Smart-OEPNV-Leitstelle-x64.exe in dist\ und laedt nach Dropbox ===
echo Dauert einige Minuten...
echo.
powershell -ExecutionPolicy Bypass -File "%~dp0installer\scripts\Build-Installer.ps1"
echo.
pause
