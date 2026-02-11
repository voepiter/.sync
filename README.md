## .SYNC

>Linux work enviroment sync with
>essential apt packages,configs, etc.

>Helps when you work on multiple hosts 
>including WSL, vps servers, termux ...  

### Features

- ssh keys agent for passwordless work  
- Bash optimal profile
- Zsh with cool Powerlevel10k theme and autocomlete highlight plugins
- Tmux optimal config with save plugin
- Midnight Commander and Far manager with Dark theme and optimal syntax
- WSL optimisation
- Fail2Ban 
 
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
