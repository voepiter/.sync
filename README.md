## .SYNC

>simple syncronisation system for Linux
>machines - packages,configs, etc

### Features
*ssh keys agent  
*Bash optimal profile
*Zsh with autocomlete highlight plugins and powerlevel10k theme
*Tmux optimal config
*Midnight Commander and Far manager with colorizers
*WSL optimisation
*Fail2Ban 
 
### Installation

copy repo to new host
```bash
git clone git@github.com:voepiter/.sync.git
```

install apt packages
```bash
.sync/install
```

first time repo initialisation
```bash
.sync/init
```
save setting to repo
```bash
.sync/save
```

load setting to host
```bash
.sync/load
```
