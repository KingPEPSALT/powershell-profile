Set-ExecutionPolicy RemoteSigned -scope CurrentUser

# install modules if they don't exist
if (-Not(Get-Module -ListAvailable posh-git)){
	Install-Module -Name posh-git -Scope CurrentUser
}
if (-Not(Get-Module -ListAvailable oh-my-posh)){
	Install-Module -Name oh-my-posh -Scope CurrentUser
}
if (-Not(Get-Module -ListAvailable Terminal-Icons)){
	Install-Module -Name Terminal-Icons -Scope CurrentUser
}

$global:MYVIMRC="$HOME\_vimrc" # change to vimrc location
$env:POSH_GIT_ENABLED=$true

# oh-my-posh setup
Import-Module posh-git
Import-Module oh-my-posh
Import-Module Terminal-Icons

Set-PoshPrompt -Theme clean-detailed

# command that gets all of the aliases for another command
function Get-CmdletAlias ($cmdletname) {
	Get-Alias |
		Where-Object -FilterScript {$_.Definition -like "$cmdletname"} |
			Format-Table -Property Definition, Name -AutoSize
}

# paste from clipboard into file
function pastef ($filepath) {
	Get-Clipboard | Out-String | Set-Content $filepath
}

# copy from file into clipboard
function yankf ($filepath) {
	cat $filepath | clip
}

# linux-like commands
function touch ($filename) { 
	New-Item -ItemType "file" $filename 
}
New-Alias -Name grep -Value Select-String

# powershell autocomplete
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
        dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
           [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

clear
# macchina = neofetch but faster
function MACCHINA_CMD {
	macchina # change this to include a theme if you prefer or have one
}
MACCHINA_CMD; if (-not $?) {scoop install macchina;clear;MACCHINA_CMD; if (-not $?) { iwr -useb get.scoop.sh | iex;refreshenv;scoop install macchina;clear;MACCHINA_CMD}}
