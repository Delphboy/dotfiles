# Import posh git
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox

# My Alias'
Set-Alias -Name stat -Value get-gitstatus
Set-Alias -Name tp -Value Test-Path
Set-Alias -Name search -Value search-GitHub
Set-Alias -Name repo -Value search-Repos
Set-Alias -Name ddg -Value search-DuckDuckGo
Set-Alias -Name newt -Value new-Branch

# Linux alias
Set-Alias -Name grep -Value findstr
Set-Alias -Name touch -Value make

#Paths
$dev = $env:dev

# Create a new git branch based off master
function new-Branch {
    param (
        [string]$branchName
    )
    git checkout master
    git pull
    git checkout -b $branchName
}

function search-GitHub {
    foreach ($i in $args) {
        $searchParams += "+$i"
    }
    Start-Process firefox $("https://github.com/search?q=user:Delphboy" + "$searchParams")
}

function search-Repos {
    param (
        [string]$repo
    )
    Start-Process firefox $("https://github.com/Delphboy?tab=repositories&q=" + "$repo")
}

function search-DuckDuckGo {
    foreach ($i in $args) {
        $query += "+$i"
    }
    Start-Process firefox $("http://www.duckduckgo.com?q=" + "$query")
}

function get-gitstatus {
    git status
}


function edit-profile {
code $profile
}

function Open-GitHub {
    $repo = $(git rev-parse --show-toplevel).split('/')[-1]
    Start-Process firefox $("https://github.com/Delphboy/$repo")
}

function boot{
    start (get-childitem | where {$_.extension -eq ".sln"})
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
