---
title: My Linux Ricing
published: 2025-01-19
description: 'I used arch btw'
image: "https://preview.redd.it/hyprland-minimalism-v0-hw4jaul4fh8d1.jpg?width=1080&crop=smart&auto=webp&s=537b4a02ce45c681191c599831e507be7199019f"
tags: [Linux, Ricing, Customization]
category: 'Công nghệ'
draft: false
lang: ''
---

> ### dotfiles:
> - https://github.com/lcaohoanq/dotfiles

# zsh auto suggesstion

```bash
# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# zsh-256color
cd $ZSH_CUSTOM/plugins && git clone https://github.com/chrissicool/zsh-256color
```
- In the plugins

```
plugins=(
  git
  zsh-256color
  zsh-syntax-highlighting
  zsh-autosuggestions
)
```
- Config shortcut to accept the suggestion

```bash
nano .zshrc

# auto suggest
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#B0EBB4,bg=#000000,bold"

#
bindkey "^[[Z" magic-space            # shift-tab to bypass completion
bindkey "^I^I" autosuggest-accept     # tab + tab for accept the suggestion
```

# xclip

- https://linuxconfig.org/how-to-use-xclip-on-linux

```bash
# xclip
alias xc='xclip'
alias xcsc='xclip -selection clipboard'
```bash

