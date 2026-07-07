@echo off
title Smart-OEPNV VoIP-Port freigeben
cd /d "%~dp0"

net session >nul 2>&1
if errorlevel 1 (
    echo Administratorrechte werden angefordert ...
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

echo VoIP-Port 8787 fuer Leitstelle einrichten ...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\Register-VoipPort.ps1"
echo.
echo Fertig. Bitte Smart-OEPNV Leitstelle neu starten.
pause
