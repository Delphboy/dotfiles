@echo off

cd %HOMEPATH%

REM Install chocolatey
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

REM Install git and clone the dotfiles repo
choco install git
git clone https://github.com/Delphboy/dotfiles.git

REM Call the installation script
call "dotfiles/windows/installation/choco-install.bat"

echo Setup complete! Remember to remove the dotfiles folder at %HOMEPATH%\dotfiles

exit