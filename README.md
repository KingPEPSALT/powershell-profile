# powershell-profile
This profile makes Powershell look great.

![screenshot](https://media.discordapp.net/attachments/753198748871557151/959191980431278130/unknown.png)
---
Install a nerd font and set it as the font for your terminal. I'm using [windows terminal](https://github.com/Microsoft/Terminal) and the [Caskaydia Cove Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaCode).
If you don't use a nerd font, many of the terminal icons won't work.

You likely will have to edit a few things in my profile, for example you may have or want to remove the cdp function if you don't have a D: drive like me or may want to edit it to fit your environment better.

The profile will install: 
- [oh-my-posh](https://ohmyposh.dev/) for the prompt
- [posh-git](https://github.com/dahlbyk/posh-git) for git integration with the prompt
- [terminal-icons](https://github.com/devblackops/Terminal-Icons) for the icons in the prompt
- [scoop](https://scoop.sh/) to install macchina, though you will likely want this anyway
- [macchina](https://github.com/Macchina-CLI/macchina) for a neofetch replacement as neofetch is slow
If they aren't already installed.

### Create the profile
```powershell
notepad $PROFILE # use vim or code instead of notepad if you prefer
```
Copy and paste my profile into there.

### Alternatively:
Download the file and then in the same directory:
```powershell
mv Microsoft.PowerShell_profile.ps1 $PROFILE
```

---
### Start the profile
```powershell
&$PROFILE # this will start up the profile 
```
---
without [windows terminal](https://github.com/Microsoft/Terminal) acrylic
![image](https://user-images.githubusercontent.com/68469008/161149716-22e32ac2-2b15-4302-ad8a-cc114f314a6a.png)
