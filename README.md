# dotfiles
I move between operating systems quite a lot (mainly linux and windows). These are the scripts and config files I use to make the computers I'm using a little bit more homely. 

## Windows
The Windows installation process is automated through the use of chocolatey. To start the automated setup on a fresh Windows installation, copy and paste the following commands into an Administrator elevated CMD prompt:

```
cd %HOMEPATH%
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Invoke-WebRequest -OutFile choco-install.bat https://raw.githubusercontent.com/Delphboy/dotfiles/master/windows/installation/choco-install.bat"
call choco-install.bat
```

The script will complete by entering into WSL so you can configure your linux user. Once you have configured the user, run the following:
```
cd ~
wget  https://raw.githubusercontent.com/Delphboy/dotfiles/master/windows/installation/wsl-setup.sh
sudo bash wsl-setup.sh
exit
```
