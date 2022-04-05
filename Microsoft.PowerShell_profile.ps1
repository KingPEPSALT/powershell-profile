Set-ExecutionPolicy RemoteSigned -scope CurrentUser

<#
	
	OH-MY-POSH SETUP ---------------------------------------

#>
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

# import necessary modules
Import-Module posh-git
Import-Module oh-my-posh
Import-Module Terminal-Icons

$env:POSH_GIT_ENABLED=$true

Set-PoshPrompt -Theme ys # feel free to type: Get-PoshThemes and replace 'ys' here with your favourite theme


<#

	COMMANDS AND ALIASES -----------------------------------

	pastef: creates a file with the contents of the clipboard
	yankf:  copies whole file into clipboard
	rpf:    runs the profile
	cdp:    changes from C:/Users/Pepsalt to D:/Pepsalt
	v:      nvim
	touch:  makes a new file, linux touch
	grep:   matches strings, linux grep
#>

function pastef ($filepath) {
	Get-Clipboard | Out-String | Set-Content $filepath
}

function yankf ($filepath) {
	cat $filepath | clip
}

function rpf {
	&$PROFILE
}

function cdp {
	$user = [System.Environment]::UserName
	if ($(Convert-Path .) -like "C:*"){
		Set-Location "D:\$user" ; clear
	}else{
		Set-Location "C:\Users\$user" ; clear
	}
}

function touch ($filename) { 
	New-Item -ItemType "file" $filename 
}

New-Alias -Name v -Value nvim
New-Alias -Name grep -Value Select-String


<#

	POWERSHELL AUTOCOMPLETE --------------------------------

#>

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


<#

	TERMINAL STARTUP ---------------------------------------

#>

# use macchina for system information
clear
macchina;							# run macchina
if (-not $?) {							# 				macchina doesnt exist
	scoop install macchina;				# try to install macchina with scoop
	clear;								
	macchina;						# run macchina
	if (-not $?) {						# 				scoop doesnt exist
		iwr -useb get.scoop.sh | iex;	# install scoop
		refreshenv;						# refresh environment so scoop install is registered
		scoop install macchina; 		# install macchina
		clear; 						
		macchina					# run macchina
	}
}


<#

	GLOBAL VARIABLES ---------------------------------------

	$VIMConf: location of the vim config, usually $HOME/_vimrc
	$NVIMConf: location of the nvim config, usually $env:LOCALAPPDATA\nvim\init.vim
	$MACCHINA_THEMES: location of macchina themes directory

#>

$global:VIMConf="$HOME\_vimrc"
$global:NVIMConf="$env:LOCALAPPDATA\nvim\init.vim"
$global:MACCHINA_THEMES = $(macchina -l).split('`')[0].TrimEnd(":")
