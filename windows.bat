@echo off

REM Choco Installs
REM https://chocolatey.org/install
REM Allow global confirmation, so we don't need to confirm each item we're installing
choco feature enable -n=allowGlobalConfirmation

choco install vim
choco install git
choco install vscode
choco install cmder
choco install dotnet4.5
choco install dotnetcore-sdk

choco install firefox
choco install spotify
choco install telegram 

choco install adobereader
choco install flashplayerplugin 
choco install javaruntime
choco install paint.net
