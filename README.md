# powershell-profile
### Make Powershell look great.

(Screenshots using [**windows_terminal**](https://github.com/Microsoft/Terminal) and the **clean_detailed** oh-my-posh theme.
![image](https://media.discordapp.net/attachments/753198748871557151/959191980431278130/unknown.png)
![image](https://user-images.githubusercontent.com/68469008/161149716-22e32ac2-2b15-4302-ad8a-cc114f314a6a.png)
![image](https://user-images.githubusercontent.com/68469008/161399995-76431e83-fc19-405f-adcf-823ef57a95e5.png)

---
Install a nerd font and set it as the font for your terminal. I'm using [windows terminal](https://github.com/Microsoft/Terminal) and the [Caskaydia Cove Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaCode).
If you don't use a nerd font, many of the terminal icons won't work.

You likely will have to edit a few things in my profile:
- cdp command, you may not have a D: drive with a user directory so you may want to remove or edit it appropriately
- rpf command, you may not want this command if you don't plan on editing your profile often
- MACCHINA_CMD command, you will want to remove `-t Hardair` as it won't exist for you
 
The profile will install: 
- [**oh-my-posh**](https://ohmyposh.dev/) for the prompt
- [**posh-git**](https://github.com/dahlbyk/posh-git) for git integration with the prompt
- [**terminal-icons**](https://github.com/devblackops/Terminal-Icons) for the icons in the prompt
- [**scoop**](https://scoop.sh/) to install macchina, though you will likely want this anyway
- [**macchina**](https://github.com/Macchina-CLI/macchina) for a neofetch replacement as neofetch is slow
if they aren't already installed.

The profile will make use of if available but will not install:
- [**pygments cli**](https://github.com/pygments/pygments)
- **[neovim](https://neovim.io/)/[vim](https://www.vim.org/)** pssst... [(my vim config)](https://github.com/kingpepsalt/vimrc)

Install
---
### Easy install

```powershell
iwr -useb https://raw.githubusercontent.com/KingPEPSALT/powershell-profile/main/Microsoft.PowerShell_profile.ps1 |`
  ni $PROFILE -Force
```
---
### Create the profile
```powershell
notepad $PROFILE # use vim or code instead of notepad if you prefer
```
Copy and paste my profile into there.

---
### Alternatively:
Download the file and then in the same directory:
```powershell
mv Microsoft.PowerShell_profile.ps1 $PROFILE
```

---
## Restart Powershell to run the profile
---

### Aliases:
alias  | description 
---|---
pastef | creates a file with the contents of the clipboard 
yankf  | copies whole file into clipboard 
ykp    | yankf on the profile, copies profile onto clipboard 
rpf    | runs the profile 
cdp    | changes from C:/Users/Pepsalt to D:/Pepsalt 
v      | nvim/vim if you have them 
touch  | makes a new file, linux touch 
grep   | matches strings, linux grep 
ccat   | syntax highlighted cat, to activate this: https://github.com/pygments/pygments 
vp     | opens profile in the first editor it can find out of nvim->vim->code->notepad 

Themes
---
If you want my custom themes: go [here](https://github.com/KingPEPSALT/powershell-profile/blob/main/themes/oh-my-posh/emodipt_edit.json)
