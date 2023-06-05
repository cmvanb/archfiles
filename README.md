# Arch Linux dotfiles

## YADM installation

Clone dotfiles.  
```
yadm clone git@git.sr.ht:~casper/dotfiles
```

Set the class name (used for alternates and templates). For now this is just the hostname.
```
yadm config local.class $HOSTNAME
```

Initialize alternates and templates.
```
yadm alt
```

