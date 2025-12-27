---
title: Linux 101
published: 2025-01-19
description: All stuffs about linux with a perspective of Debian KDE Plasma user
image: "https://github.com/lcaohoanq/Linux-Issues/assets/136492579/67567ea6-ef1c-4f92-8dd9-98979f1ba4e6"
tags: [Linux, Documentation]
category: 'Công nghệ'
draft: false
lang: ''
---

> ### I have tried these three DEs
>  - Gnome
>  - KDE
>  - XFCE

- First time trying Gnome with Ubuntu (downloaded ISO from website and install~), it's so pretty and most compatible with my devices, smoothing experience aka Memory waster

- I had decided to move to Debian KDE Plasma (after watching the comparison video of some guys on Youtube), which was overwhelming with the ability to customize KDE features, and it's more lightweight than Gnome xD

- XFCE seems to fit with my X220 (4GB, 128GB 2.5inch SSD, i5 2th) but it lacks the functions that I need

**[Update: 20 June 24]**: Seem i have fall in love with the ricing process, i'm using bspwm and i3 now :) should i move to Arch with Hyperland xD

**[Update: 24 June 24]**: Back to using Gnome Debian (there some issue with my KDE + bspwm), but another session still bspwm xD

> https://github.com/lcaohoanq/dotfiles

**[Update 30 June 24]**: I have moved to Arch with Hyprland, my first time using Arch, and it's so fun to rice my system xD

> https://github.com/lcaohoanq/hypr-arch-dotfiles/

# OSS (Open Source Software)
- OSS is software with source code that anyone can inspect, modify, and enhance
- React: https://github.com/facebook/react
- fzf (fuzzy file finder): https://github.com/junegunn/fzf

Many many many tools are open source now :)

![Alt text](https://images.unsplash.com/photo-1549605659-32d82da3a059?q=80&w=1170&auto=format&fit=crop)


# Linux History

![Alt text](https://pbs.twimg.com/media/Dxs4O0DWsAE2MS7.jpg)

- 1984: The GNU Project and the Free Software Foundation
	- Create open source version of UNIX utilities
	- Create the General Public License (GPL): Software license enforcing open source principles
- 1991: Linus Tovarlds
	- Creates open source, UNIX-like kernel, released under the GPL
	- Ports some GNU utilities, solicits assistance online
- Today:
	- Linux kernel + GNU utilities = complete, open source, UNIX like operating system
		- Packaged for targeted audiences as distributions

- Linux Kernel Repository: https://github.com/torvalds/linux, i really want to have a chance to contribute to this repo

# Linux Principles
- Everything is a file (Include Hardware)
- Small Single purpose Programs
- Ability to chain programs together for complex operations
- Avoid Captive User Interface
- Configuration data stored in a text file

![Alt text](https://i.redd.it/hbms08i9y1i91.jpg)

# Why Linux?

- Opensource
- Community Support
- Support Wide Variaty of Hardware
- Customization
- Most Servers runs on Linux
- Automation
- Security (debatable topic, depend on you)

# Architecture of Linux ![Alt text](https://www.interviewbit.com/blog/wp-content/uploads/2022/06/Linux-Architecture-1024x728.png)

- Linux Kernel read, understand the hardware CPU, RAM, pass signal to Shell (Bash, Zsh, Fish,...) 

# Popular Linux Distributions (distros)

- List of Linux Distributions: https://en.wikipedia.org/wiki/List_of_Linux_distributions

![Alt text](https://i.ytimg.com/vi/QFzXQNZ6zvQ/maxresdefault.jpg)

- Desktop
	- Ubuntu
	- Mint
	- Arch
	- Fedora
	- Debian
	- OpenSUSE
- Server
	- RHEL (Red Hat Enterprise Linux): most stable, secured, not open source 
	- Ubuntu Server
	- CentOS
	- SUSE Enterprise Linux

- Most used Linux distros currently in IT industry
	- **RPM based or .rpm**: RHEL, Centos, Oracle Linux
		- Example: Google chrome software
		- Package name: google-chrome-stable-57.0.2987.133-1.x86_64.**rpm**
		- Installation: rpm -ivh google-chrome-stable_current_amd64.**rpm**
	- **Debian base or .deb**: Ubuntu server, Kali Linux
		- Example: Google chrome software
		- Package name: google-chrome-stable_current_amd64.**deb**
		- Installation: dpkg -i google-chrome-stable_current_amd64.**deb**

# Package manager
- A  **package manager** in Linux is a tool that automates the entire process of installing, updating, configuring, and removing software. You can think of it as an "app store" or a personal assistant for your operating system's software.

| Operating System | Default Package Manager | Additional Package Managers |
| ---------------- | ----------------------- | --------------------------- |
| Debian           | `apt`                   | `snapd`                     |
| Arch             | `pacman`                | `yay`, `snapd`              |
| Fedora           | `dnf`                   |                             |
| OpenSUSE         | `zypper`                |                             |
| Solus            | `eopkg`                 |                             |
| Gentoo           | `emerge`                |                             |
| Void             | `xbps`                  |                             |
| Alpine           | `apk`                   |                             |
| NixOS            | `nix`                   |                             |
| Slackware        | `slackpkg`              |                             |
| FreeBSD          | `pkg`                   |                             |
| OpenBSD          | `pkg_add`               |                             |
| NetBSD           | `pkgin`                 |                             |
| DragonFly BSD    | `pkg`                   |                             |
| Haiku            | `pkgman`                |                             |
| macOS            | `brew`                  |                             |
| Windows          | `choco`                 |                             |
| Android          | `f-droid`               |                             |
| iOS              | `cydia`                 |                             |
| Termux           | `pkg`                   |                             |
| Chrome OS        | `crostini`              |                             |
| Ubuntu           | `apt`                   |                             |
| CentOS           | `yum`                   |                             |
| RHEL             | `yum`                   |                             |
| Manjaro          | `pacman`                |                             |

![](https://cdn-media.sforum.vn/storage/app/media/quynh/apt-la-gi.jpg)

```zsh
sudo apt-get install ROSÉ
# when this package release guys?
```

# Commands

- Most used commands:

  - **cd** : Change directory
    - `cd /home/user`
    - `cd ~`
    - `cd ..`

  - **ls** : List files and directories
    - `ls`
    - `ls -l` | `ls -al`
    - `ls -a`
    - ls -lt : sort time descending
    - ls -ltr: sort time ascending (r = reverse)

  - **pwd** : Print working directory

  - **cat**
    - `cat file.txt`

  - **cp** : Copy files and directories
    - `cp file.txt file2.txt`
    - `cp -r dir1 dir2`
    - `cp * /usr/share/.fonts`

  - **mv** : Move files and directories
    - `mv file.txt /usr/share/.fonts`
    - `mv file.txt file2.txt`
    - `mv * /usr/share/.fonts`
    - we can perform the rename file or directory by mv command: if i want to rename the file demo.txt to test.txt
    ```bash
    mv demo.txt test.txt
    # same as directory
    ```

  - **rm** : Remove files and directories
    - `rm file.txt`
    - `rm -r dir1`
    - `rm -rf dir1`

  - **mkdir** : Make directories
	  - mkdir /hihi
	  - mkdir /hihi/hehe/huhu => No such file or directory => mkdir -p /hihi/hehe/huhu ok
- Because normal mkdir only support one directory, if pass parent/child/... it cause error -> using -p (parent) to fix

  - **echo** : Write text to file
    - `echo "Hello World" > file.txt`
    - echo "alias 'yt=ytfzf -t'" >> ~/.bashrc
    - echo "alias 'll=ls -al'" >> ~/.bashrc
    - echo "alias 'showdisk=cd /media/lcaohoanq/ ; ls -al'" >> ~/.bashrc

  - **touch** : Create file
    - `touch file.txt`

  - **nano** : Text editor
    - `nano file.txt`

  - **unzip** : Unzip files
    - `unzip file.zip`

  - **tree** : Show the current directory with the tree visualization
    ```bash
    # show everything
    tree

    # show directories only
    tree -D

    # show directories except the pattern
    tree -I "node_modules"

    # show except the pattern, directories only
    tree -I "node_modules" -D
    ```

- **history**: Show all previously executed command

- Check CPU:
	- **nproc**
	- **lscpu**
	
- Check RAM
	- **free -h**
	- **cat /proc/meminfo**

- Power Management

```bash
# reboot
sudo reboot

# shutdown after 1 min
sudo shutdown -h

# shutdown immediately
sudo shutdown -h now

# schedule shutdown after 10 mins
sudo shutdown -P +10
```

# [Advanced command]
  - chmod [arguement] : give a file specific permission
    - +x : can executable
    - 777 : give all permission (do not recommend to use)
    - 400 : read only

  - ps: show process id
    ```bash
    ps aux | grep "obs"
    ```

# File System
- /: root directory
- /boot
- /dev
- /usr
- 


![Alt text](https://fireship.io/courses/linux/img/linux-file-system.png)

# Text Editor

- nano and vim, let's go

## nano

<img width="645" height="339" alt="image" src="https://github.com/user-attachments/assets/2fd45886-f2a2-4d31-8414-ad779d75c683" />

- every linux have nano, if not install yet (very rare), usually in distroless docker image or lightweight linux distros

### Install

```zsh
sudo apt-get install nano
``` 

### Command

- Create new file without touch
```zsh
nano hehe.txt
```

-  Create a file name hihi.txt with some text
```zsh
echo "first line" > hihi.txt
```

- Append a text to end of file
```zsh
# Redirection operator
echo "first line" >> hihi.txt
```

- Cut/Delete a line 

```zsh
Ctrl + K
```

- Copy, paste selected line

```zsh
Ctrl + 6 #Mark set
Alt  + 6  #Copy selected
Ctrl + U #Paste
```

- Moving a line

```zsh
Ctrl + K
Ctrl + U
```

## vi, vim, nvim

![Alt text](https://images.viblo.asia/9fc1a38d-7f58-4abe-abaa-8deec07b9435.png)

- More at here (https://viblo.asia/p/co-ban-ve-vim-cho-nguoi-moi-bat-dau-GrLZDavnlk0)
- Vim has 3 mode
	- Normal: **default**, navigate, simple edit 
	- Insert: as the name, using as insert character
	- Command Line: saving, exiting,...

### Command

- Copy 1 line (yanking)
```zsh
yy
```

- Copy 3 line
```zsh
3yy
```

- Paste (as current cursor pointer)
	- Below: **p**
	- Above: **P**

- Undo
```zsh
u
```

- Delete 1 line (yanking): 
```zsh
dd
```

- Delete 3 line 
```zsh
3dd
```

- Jump to specific line (Normal mode), type line number with capital G -> Enter
```zsh
118796G
```

- Search word (Command mode -> **ESC**), / then type the keyword want to search -> Enter
```zsh
/Error
```

- Home of file(double g)
```zsh
gg
```

- End of file (capital G)
```zsh
G
```

- Start of line
```zsh
0
```

- End of line
```zsh
$
```

- Exit (Command mode -> **ESC**)
	- q stand for quit
	- w stand for write
```zsh
:q! #force exit without saving
:wq #save and exit
```

### LazyVim

- Currently im using LazyVim (https://www.lazyvim.org/), it really easy to setup, and support a lot of LUA plugins there, but before going to something comfortable, make sure you have a basic or good foundation of vim, take time to practice :) 

![Alt text](https://user-images.githubusercontent.com/292349/213447056-92290767-ea16-430c-8727-ce994c93e9cc.png)


- Linux with Nvim oh man, we nearly become arch user

![Alt text](https://i.ytimg.com/vi/Ul7JsYAZg5o/hqdefault.jpg)


# File Types

- Regular file
	- **-**: Normal files such as text, data, or executable files
- Directory
	- **d**: Files that are lists of others files
- Link
	- **l** : A shortcut that points to the location of the actual file
- Special file
	- **c**: Mechanism using for input and output, such as file in /dev
- Socket
	- **s**: A special file that provides inter-process networking protected by the file system's access control
- Pipe
	- **p**: A special file that allows processes to communicate with each other without using network socket semantics

# Symbolic links

- Like desktop shortcut in windows
```zsh
ln -s source destination

unlink destination
```

# Filter & IO redirection command

## Grep

- Find text from any text input

![Alt text](https://www.cyberciti.biz/media/new/faq/2007/08/grep-command-examples-for-Linux-and-Unix-users-1.png)


- Usecase 1: We have sample file **0_Run predefined test cases.txt** contain the log from Github Action CI pipeline. Search error logs find the error. Problem is the file are too long (10k ~ line), and we are in server, we not have any IDE to use.
- Find text contain "Exception"
```zsh
grep "Exception" 0_Run predefined test cases.txt
``` 

- Syntax:
	- grep "key_word" -param file_name 

- Param
	- R: search recursively
	- n: show line number

- Usecase 2: Find the export port of docker container name pgadmin. We can easily use **docker ps** then use eyes to look for the pgadmin container. But when the number of container become 50, 100 or even more. Using **docker ps** and search manually make you look silly :).

- Search with grep + pipe operator **|**
```zsh
❯ docker ps | grep pgadmin
7ed17a84f912   dpage/pgadmin4   "/entrypoint.sh"         12 days ago   Up 39 minutes             443/tcp, 0.0.0.0:5050->80/tcp, [::]:5050->80/tcp   pgadmin
```

## Sed
