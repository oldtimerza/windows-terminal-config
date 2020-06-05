1) The following needs to be installed first to get the posh git line syntactic sugar showing:

```PowerShell
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
```


2) Don't forget to set execution roles:
```PowerShell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

3a) Set up terminal settings with the settings from the settings.json file
3b) copy contents of PowerShell profile into the profile file create by ```PowerShell notepad $PROFILE``` in PowerShell.
3c) Install the font files from ttf.

4) Vim setup can be found here, pull it into ~/.vim_runtime:
https://github.com/oldtimerza/vimrc

