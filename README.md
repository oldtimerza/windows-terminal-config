The following needs to be installed first to get the posh git line syntactic sugar showing:

```PowerShell
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
```

Vim setup can be found here:
https://github.com/oldtimerza/vimrc

Don't forget to set execution roles:
```PowerShell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
