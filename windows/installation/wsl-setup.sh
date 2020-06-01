#!/bin/bash

cd ~

# Update stuff
sudo apt-get update -y && sudo apt-get upgrade -y

# Download powerline-go
sudo apt install golang-go
go get -u github.com/justjanne/powerline-go

# Add GOTPATH to .bachrc
echo "GOPATH=$HOME/go
function _update_ps1() {
    PS1="$($GOPATH/bin/powerline-go -error $?)"
}
if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi" >> .bashrc

exit
