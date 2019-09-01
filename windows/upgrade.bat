@echo off
choco feature enable -n=allowGlobalConfirmation

choco upgrade vim
choco upgrade git
choco upgrade vscode
choco upgrade cmder
choco upgrade dotnet4.5
choco upgrade dotnetcore-sdk

choco upgrade firefox
choco upgrade spotify
choco upgrade telegram 

choco upgrade adobereader
choco upgrade flashplayerplugin 
choco upgrade javaruntime
choco upgrade paint.net