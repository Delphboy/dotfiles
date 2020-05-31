@echo off

cd %HOMEPATH%

REM Allow global confirmation, so we don't need to confirm each item we're installing
choco feature enable -n=allowGlobalConfirmation

REM Core Programs
choco install firefox
choco install telegram 
choco install spotify
choco install javaruntime
choco install paint.net
choco install bitwarden
choco install miktex
choco install texstudio
choco install notion
choco install steam

REM Make Firefox default
"c:\program files\Mozilla Firefox\firefox.exe" -silent -nosplash -setDefaultBrowser

REM Fonts
choco install firacodenf
choco install cascadiacodepl

REM Development Tools
choco install emacs
choco install vim
choco install vscode
choco install notepadplusplus.install
choco install dotnet4.5
choco install dotnetcore-sdk
choco install microsoft-windows-terminal

REM Configure Git
git config --global user.name "Henry Senior"

REM Setup PowerShell
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Install-Module posh-git -Scope CurrentUser"

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Install-Module oh-my-posh -Scope CurrentUser"

del "%HOMEPATH%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
copy "%HOMEPATH%\dotfiles\windows\config\Microsoft.PowerShell_profile.ps1" "%HOMEPATH%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

REM Setup terminal
del "%HOMEPATH%\AppData\Local\Packages\Microsoft.WindowsTerminal*\LocalState\settings.json"
copy "%HOMEPATH%\dotfiles\windows\config\settings.json" "%HOMEPATH%\AppData\Local\Packages\Microsoft.WindowsTerminal*\LocalState\settings.json"

REM Setup spacemacs
cd %HOMEPATH%
git clone https://github.com/syl20bnr/spacemacs .emacs.d
cd .emacs.d
git checkout b develop
git pull -s recursive -X theirs origin develop


REM Link to installation pages of thing not in chocolatey
start https://visualstudio.microsoft.com/

REM Exit message
echo All done!
echo
echo You need to:
echo     - Install visual studio (Not in chocolatey)
echo     - Configure menu and taskbar
echo     - Configure install visual studio
echo     - Set "dev" environment variable
pause

