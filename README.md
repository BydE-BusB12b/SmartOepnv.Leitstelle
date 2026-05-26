# Smart-ÖPNV Leitstelle

Eigenständiges Windows-Programm für Leitstelle (Routen, Versand, Dropbox).  
Gleiche Datenbasis wie der Planer; Live-Fahrzeugüberwachung folgt später.

**Gemeinsamer Code:** `..\SmartOepnv.Shared\`  
**Schwesterprodukt:** `..\SmartOepnv.Planer\`

## Schnell testen (ohne Setup.exe)

| Datei | Zweck |
|-------|--------|
| **`Run.bat`** | Programm direkt starten (empfohlen zum Testen) |
| **`Build-und-Starten.bat`** | Release bauen und EXE starten |
| **`Setup-bauen.bat`** | Installer `dist\Setup-....exe` erzeugen |

Zentral für beide Programme: `..\SmartOepnv-Test.bat` oder `SmartOepnv-Test.py`

## Starten

```powershell
cd C:\Users\hkx18\AndroidStudioProjects\SmartOepnv.Leitstelle
dotnet run --project src\SmartOepnv.Leitstelle\SmartOepnv.Leitstelle.csproj
```

EXE nach Build:  
`src\SmartOepnv.Leitstelle\bin\Release\net8.0-windows\Smart-OEPNV-Leitstelle.exe`

## Installer

```powershell
powershell -ExecutionPolicy Bypass -File installer\scripts\Build-Installer.ps1
```

Ergebnis: `dist\Setup-Smart-OEPNV-Leitstelle-x64.exe`
