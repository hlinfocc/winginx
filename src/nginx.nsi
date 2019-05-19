; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Nginx"
!define PRODUCT_VERSION "1.6.0"
!define PRODUCT_PUBLISHER "InvGate S.R.L."
!define PRODUCT_WEB_SITE "http://www.invgate.com"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\nginx-service.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

Name "${PRODUCT_NAME}" ; ${PRODUCT_VERSION}"
OutFile "nginx-service.exe"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\English.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\Spanish.nlf"
InstallDir "$PROGRAMFILES\Nginx"
Icon "nginx.ico"
UninstallIcon "${NSISDIR}\Contrib\Graphics\Icons\nsis1-uninstall.ico"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
DirText "Setup will install $(^Name) in the following folder.$\r$\n$\r$\nTo install in a different folder, click Browse and select another folder."
ShowInstDetails show
ShowUnInstDetails show

Function .onInit
FunctionEnd

Section "Nginx" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite try
  File "nssm.exe"
  File "nginx.exe"
  File /r contrib
  File /r conf
;  File /r ssl
  File /r docs
  File /r html
  File /r "nginx.conf.d"
  CreateDirectory $INSTDIR\logs
  CreateDirectory $INSTDIR\temp
;  CreateDirectory $INSTDIR\sites-enabled
SectionEnd

Section -Post
  ExecWait '$INSTDIR\nssm.exe install Nginx "$INSTDIR\nginx.exe"'
  ExecWait '"sc.exe" start nginx'
  WriteRegStr HKLM "SYSTEM\CurrentControlSet\Services\nginx" \
                     "Description" "Nginx HTTP and reverse proxy server"
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\nssm.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\nginx.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  ExecWait '"sc.exe" stop nginx'
  ExecWait "$INSTDIR\nssm.exe remove nginx confirm"
  RMDir /r "$INSTDIR\conf"
  RMDir /r "$INSTDIR\contrib"
  RMDir /r "$INSTDIR\html"
  RMDir /r "$INSTDIR\docs"
  RMDir /r "$INSTDIR\temp"
  Delete $INSTDIR\nginx.exe
  Delete $INSTDIR\nssm.exe

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd
