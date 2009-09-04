Name "Hacme Casino"
# Defines
!define REGKEY "SOFTWARE\Foundstone Free Tools\$(^Name)"
!define VERSION 1.0
!define COMPANY "Foundstone Professional Services"
!define URL http://www.foundstone.com
!define ALL_USERS

# Included files
!include Sections.nsh
!include WriteEnvStr.nsh

# Reserved Files
ReserveFile "${NSISDIR}\Plugins\AdvSplash.dll"

# Variables
Var StartMenuGroup

# Installer pages
Page license
Page custom SecurityWarning
Page directory
Page instfiles

# Installer attributes
OutFile HacmeCasinoSetup.exe
InstallDir "$PROGRAMFILES\Foundstone Free Tools\Hacme Casino v1.0"
CRCCheck on
XPStyle on
Icon images\fs_icon_32.ico
WindowIcon on
ShowInstDetails hide
AutoCloseWindow false
LicenseData license\license.txt
VIProductVersion 1.0.0.0
VIAddVersionKey ProductName "Hacme Casino"
VIAddVersionKey ProductVersion "${VERSION}"
VIAddVersionKey CompanyName "${COMPANY}"
VIAddVersionKey CompanyWebsite "${URL}"
VIAddVersionKey FileVersion ""
VIAddVersionKey FileDescription ""
VIAddVersionKey LegalCopyright ""
InstallDirRegKey HKLM "${REGKEY}" Path
ShowUninstDetails hide

# Installer sections

Section -Main SEC0000
    SetOutPath $INSTDIR
    File userguide\HacmeCasino_UserGuide.pdf
    SetOverwrite on
    File ..\HacmeCasino.exe
    WriteRegStr HKLM "${REGKEY}\Components" Main 1
    SetOutPath $INSTDIR\images
    File images\fs_icon_32.ico
    File images\PDF.ico
SectionEnd

Section -post SEC0001
    WriteRegStr HKLM "${REGKEY}" Path $INSTDIR
    WriteRegStr HKLM "${REGKEY}" StartMenuGroup $StartMenuGroup
    WriteUninstaller $INSTDIR\uninstall.exe
    SetOutPath $SMPROGRAMS\$StartMenuGroup
    CreateShortCut "$SMPROGRAMS\$StartMenuGroup\Hacme Casino User and Solution Guide v1.0.lnk" "$INSTDIR\HacmeCasino_UserGuide.pdf" "" "$INSTDIR\images\PDF.ico"
    CreateShortCut "$SMPROGRAMS\$StartMenuGroup\$(^Name) v1.0.lnk" "http://localhost:3000/" "" "$INSTDIR\images\fs_icon_32.ico"
    CreateShortCut "$SMPROGRAMS\$StartMenuGroup\Uninstall $(^Name).lnk" $INSTDIR\uninstall.exe
    CreateShortCut "$SMPROGRAMS\$StartMenuGroup\$(^Name) Server START.lnk" $INSTDIR\HacmeCasino.exe
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayName "$(^Name)"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayVersion "${VERSION}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" Publisher "${COMPANY}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" URLInfoAbout "${URL}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayIcon $INSTDIR\uninstall.exe
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" UninstallString $INSTDIR\uninstall.exe
    WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoModify 1
    WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoRepair 1
SectionEnd

# Macro for selecting uninstaller sections
!macro SELECT_UNSECTION SECTION_NAME UNSECTION_ID
    Push $R0
    ReadRegStr $R0 HKLM "${REGKEY}\Components" "${SECTION_NAME}"
    StrCmp $R0 1 0 next${UNSECTION_ID}
    !insertmacro SelectSection "${UNSECTION_ID}"
    Goto done${UNSECTION_ID}
next${UNSECTION_ID}:
    !insertmacro UnselectSection "${UNSECTION_ID}"
done${UNSECTION_ID}:
    Pop $R0
!macroend

# Uninstaller sections
Section /o un.Main UNSEC0000
    MessageBox MB_YESNO "Are you sure you want to uninstall $(^Name)?" IDYES Proceed IDNO CancelUninstall

    Proceed:
      Delete /REBOOTOK $INSTDIR\HacmeCasino.exe
      Delete /REBOOTOK $INSTDIR\HacmeCasino_UserGuide.pdf
      DeleteRegValue HKLM "${REGKEY}\Components" Main
      Goto Done

    CancelUninstall:
      Quit

    Done:
SectionEnd

Section un.post UNSEC0001
    DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\$(^Name) Server START.lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\$(^Name) v1.0.lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\Hacme Casino User and Solution Guide v1.0.lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\Uninstall $(^Name).lnk"
    Delete /REBOOTOK $INSTDIR\uninstall.exe
    Delete /REBOOTOK $INSTDIR\images\fs_icon_32.ico
    Delete /REBOOTOK $INSTDIR\images\PDF.ico    
    DeleteRegValue HKLM "${REGKEY}" StartMenuGroup
    DeleteRegValue HKLM "${REGKEY}" Path
    DeleteRegKey /ifempty HKLM "${REGKEY}\Components"
    DeleteRegKey /ifempty HKLM "${REGKEY}"
    RMDir /REBOOTOK $SMPROGRAMS\$StartMenuGroup
    RMDir /REBOOTOK $INSTDIR\images
    RMDir /REBOOTOK $INSTDIR
SectionEnd

# Installer functions
Function .onInit
    InitPluginsDir
    File /oname=$PLUGINSDIR\warning.ini .\warning.ini
    Push $R1
    File /oname=$PLUGINSDIR\spltmp.bmp images\FoundstoneLogo.bmp
    advsplash::show 1500 500 300 -1 $PLUGINSDIR\spltmp
    Pop $R1
    Pop $R1
    
    StrCpy $StartMenuGroup "Foundstone Free Tools\Hacme Casino 1.0"
FunctionEnd

# Uninstaller functions
Function un.onInit
    ReadRegStr $INSTDIR HKLM "${REGKEY}" Path
    ReadRegStr $StartMenuGroup HKLM "${REGKEY}" StartMenuGroup
    !insertmacro SELECT_UNSECTION Main ${UNSEC0000}
FunctionEnd

Function SecurityWarning
  ; Return value $R0 needs to be push/popped off the stack whether it is used or not
  ; this custom installer page is probably a little more complicated 
  ; than necessary because it needs to use a red font.  For no font, the code is simple:
  ;Push $R0
  ;InstallOptions::dialog $PLUGINSDIR\warning.ini
  ;Pop $R0

  Push $R0
  Push $R1
  Push $R2

    InstallOptions::initDialog /NOUNLOAD $PLUGINSDIR\warning.ini
    Pop $R0

    ReadINIStr $R1 $PLUGINSDIR\warning.ini "Field 1" "HWND"

    ;$R1 contains the HWND of the first field
    CreateFont $R2 "Tahoma" 10 700
    SetCtlColors $R1 CC0000 FFFFFF
    SendMessage $R1 ${WM_SETFONT} $R2 0

    InstallOptions::show
    Pop $R0

  Pop $R2
  Pop $R1
  Pop $R0
FunctionEnd
