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

Set-PoshPrompt -Theme zash # feel free to type: Get-PoshThemes and replace 'zash' here with your favourite theme


<#

	COMMANDS AND ALIASES

	+--------+--------------------------------------------------------------------------------+
	| alias  | description                                                                    |
	+--------+--------------------------------------------------------------------------------+
	| pastef | creates a file with the contents of the clipboard                              |
	| yankf  | copies whole file into clipboard                                               |
	| ykp    | yankf on the profile, copies profile onto clipboard                            |
	| rpf    | runs the profile                                                               |
	| cdp    | changes from C:/Users/Pepsalt to D:/Pepsalt                                    |
	| v      | nvim/vim if you have them													  |
	| touch  | makes a new file, linux touch											      |
	| grep   | matches strings, linux grep  												  |
	| ccat   | syntax highlighted cat, to activate this: https://github.com/pygments/pygments |
	| vp     | opens profile in the first editor it can find out of nvim->vim->code->notepad  |
	+--------+--------------------------------------------------------------------------------+

#>

function pastef ($filepath) {
	Get-Clipboard | Out-String | Set-Content $filepath
}

function yankf ($filepath) {
	cat $filepath | clip
	if ($?){
		$opth = $filepath
		if ($filepath -eq $PROFILE){
			$opth = "`$PROFILE"
		}
		$e = $([char]0x1b) # ansi escape character
		echo "Successfully yanked $e[0;32m$opth$e[0m into clipboard..."
	}
}

function ykp {
	yankf $PROFILE
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

if (Get-Command nvim){
	New-Alias -Name v -Value nvim
}elseif (Get-Command vim){
	New-Alias -Name v -Value vim
}
function vp { 
	if (alias v){
		v $PROFILE
	}elseif(Get-Command code){
		code $PROFILE
	}else{
		Notepad.exe $PROFILE
	}
}
New-Alias -Name grep -Value Select-String

# https://github.com/pygments/pygments
if (Get-Command pygmentize){
	New-Alias -Name ccat -Value pygmentize
}


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
macchina -t hardair;				# run macchina
if (-not $?) {							# 				macchina doesnt exist
	scoop install macchina;				# try to install macchina with scoop
	clear;								
	macchina -t hardair;			# run macchina
	if (-not $?) {						# 				scoop doesnt exist
		iwr -useb get.scoop.sh | iex;	# install scoop
		refreshenv;						# refresh environment so scoop install is registered
		scoop install macchina; 		# install macchina
		clear; 						
		macchina -t hardair 		# run macchina
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
