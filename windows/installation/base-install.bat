@echo off

cd %HOMEPATH%

REM Configure Git (it is installed by choco-install.bat)
git config --global user.name "Henry Senior"
set /p email="Enter git email: "
git config --global user.email %email%

REM Configure dev variable
set /p DevPath="Enter path to be used for dev"
IF EXIST %DevPath% (
setx dev %DevPath%
) ELSE (
mkdir %DevPath%
setx dev %DevPath%
choco install microsoft-windows-terminal
)

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
choco install visualstudio2019community

REM Enable WSL
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
wsl --set-default-version 2

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile Ubuntu.appx -UseBasicParsing"

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Add-AppxPackage .\Ubuntu.appx"

del Ubuntu.appx

REM Setup PowerShell
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Install-Module posh-git -Scope CurrentUser"

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Install-Module oh-my-posh -Scope CurrentUser"

del "%HOMEPATH%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
copy "%HOMEPATH%\dotfiles\windows\config\Microsoft.PowerShell_profile.ps1" "%HOMEPATH%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

REM Setup Windows Terminal
del "%HOMEPATH%\AppData\Local\Packages\Microsoft.WindowsTerminal*\LocalState\settings.json"
copy "%HOMEPATH%\dotfiles\windows\config\settings.json" "%HOMEPATH%\AppData\Local\Packages\Microsoft.WindowsTerminal*\LocalState\settings.json"

REM Setup Emacs Doom
cd %HOMEPATH%
git clone --depth 1 https://github.com/hlissner/doom-emacs .emacs.d
cd .emacs.d
git checkout develop
cd %HOMEPATH%
copy dotfiles\.emacs.d\* .emacs.d\
copy dotfiles\.doom.d\* .doom.d\

echo The scipt will now start WSL so you can set up your user account. Please see the README file for instructions on running the automated WSL setup once your
pause
WSL
