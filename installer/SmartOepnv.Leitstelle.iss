; Smart-ÖPNV Leitstelle – Windows-Setup (Inno Setup)

#define MyAppName "Smart-ÖPNV Leitstelle"
#define MyAppExeName "Smart-OEPNV-Leitstelle.exe"
#define MyAppPublisher "Smart-ÖPNV"
#define MyAppURL "https://github.com/BydE-BusB12b/GPSAnsagen"
#define MyAppVersion "0.3.0"

[Setup]
AppId={{C5F9A3B2-4D0E-5F8A-9B2C-3E6F7A0D1B4C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
DefaultDirName={autopf}\Smart-OEPNV\Leitstelle
DefaultGroupName=Smart-ÖPNV
DisableProgramGroupPage=no
LicenseFile=assets\LICENSE.txt
InfoBeforeFile=assets\INFO.txt
OutputDir=..\dist
OutputBaseFilename=Setup-Smart-OEPNV-Leitstelle-x64
SetupIconFile=assets\leitstelle.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
MinVersion=10.0
UninstallDisplayName={#MyAppName}

[Languages]
Name: "german"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "desktopicon"; Description: "Desktopsymbol erstellen"; GroupDescription: "Zusätzliche Symbole:"; Flags: checkedonce
Name: "launchapp"; Description: "Smart-ÖPNV Leitstelle nach der Installation starten"; GroupDescription: "Abschluss:"; Flags: checkedonce

[Files]
Source: "..\publish\win-x64\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"
Name: "{group}\{#MyAppName} deinstallieren"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; WorkingDir: "{app}"

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent; Tasks: launchapp

[UninstallDelete]
Type: filesandordirs; Name: "{userappdata}\Smart-OEPNV\Leitstelle"
