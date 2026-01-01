---
title: Linux 101
published: 2025-01-19
description: All stuffs about linux with a perspective of Debian KDE Plasma user
image: "https://github.com/lcaohoanq/Linux-Issues/assets/136492579/67567ea6-ef1c-4f92-8dd9-98979f1ba4e6"
tags: [Linux, Documentation]
category: 'Công nghệ'
draft: false
lang: 'en'
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

![](https://images.unsplash.com/photo-1685716851721-7e1419f2db18?q=80&w=1032&auto=format&fit=crop)

> Life seem more tough when learning, using Linux but after a long time, 2 years using, fail, break, reinstall many time...every moments worth it, i really love Linux and it became my daily driver now.

# OSS (Open Source Software)
- OSS is software with source code that anyone can inspect, modify, and enhance
- Many famous internet backbones tools:
	- [react](https://github.com/facebook/react)
	- [spring boot](https://github.com/spring-projects/spring-boot)
	- [fzf (fuzzy file finder)](https://github.com/junegunn/fzf)
	- [wireguard-easy](https://github.com/wg-easy/wg-easy)
	- [postgresql](https://wiki.postgresql.org/wiki/Submitting_a_Patch)

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

- Open source
- Community Support
- Support Wide Variaty of Hardware
- Customization
- Most Servers runs on Linux
- Automation
- Security (debatable topic, depend on you)

# Architecture of Linux ![](https://www.interviewbit.com/blog/wp-content/uploads/2022/06/Linux-Architecture-1024x728.png)

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

![](https://i.redd.it/9h04oradsds51.png)

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

![](https://i.redd.it/24b7ozlmfz3c1.png)

> This command `:(){ :|:& };:` is called "shell fork bomb", very dangerous when hacker can access then execute this command on our servers.
> [Read more about fork bomb here](https://www.cyberciti.biz/faq/understanding-bash-fork-bomb/)

  - **cd** : Change directory
    - `cd /home/user`
    - `cd ~`
    - `cd ..`
   > im using [zoxide](https://github.com/ajeetdsouza/zoxide): better cd

  - **ls** : List files and directories
    - `ls`
    - `ls -l` | `ls -al`
    - `ls -a`
    - ls -lt : sort time descending
    - ls -ltr: sort time ascending (r = reverse)
   >  im using [exa](https://github.com/ogham/exa): better ls

  - **pwd** : print **current** working directory

  - **cat**
    - `cat file.txt`
> im using [bat](https://github.com/sharkdp/bat),  notice that after install bat, it use the batcat (not bat) so need to remember or assign alias to .zshrc

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
>	- Because normal mkdir only support one directory, if pass parent/child/... it cause error -> using -p (parent) to fix

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
	- im currently using [atuin](https://github.com/atuinsh/atuin): better history, with built in sql lite, can search, navigate to the previous command

- Process:
  - `ps`: shows only **processes associated with your current terminal session and use**
  - `ps aux`:  display a **detailed snapshot of all running processes** on the system
    ```bash
    # show detailed all running processes and find obs 
    ps aux | grep "obs"
    ```

- Check CPU:
	- **nproc**
	- **lscpu**
	
- Check RAM
	- **free -h**
	- **cat /proc/meminfo**

- Process management
	- Mandatory: top
> im using [htop](https://github.com/htop-dev/htop), [btop](https://github.com/aristocratos/btop), better UI, more efficient to do process management

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

---

# File System

![](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFYxyZTyjPccvpZmE6pZuybHy_5FTVj_4rrw&s)

```zsh
/               # Root directory – gốc của mọi thứ
├── /boot       # File khởi động: kernel, initramfs, grub
├── /dev        # Device files (ổ cứng, USB, tty, null, random…)
├── /etc        # Config hệ thống (nghĩ: "editable text configs")
├── /home       # Thư mục người dùng (home của user)
│   └── hoang   # Ví dụ home của user hoang
│   └── duyen   # Ví dụ home của user duyen
├── /lib        # Thư viện cần cho /bin và /sbin
├── /lib64      # Thư viện 64-bit
├── /media      # Nơi auto-mount USB, ổ cứng rời
├── /mnt        # Mount tạm (mount thủ công)
├── /opt        # Optional software (app cài ngoài hệ thống)
├── /proc       # Virtual FS – info kernel & process (runtime)
├── /root       # Home của user root
├── /run        # Runtime data (PID, socket, lock file)
├── /sbin       # System binaries (lệnh cho admin/root)
├── /srv        # Data cho service (web, ftp…)
├── /sys        # Virtual FS – kernel, hardware
├── /tmp        # File tạm (có thể bị xoá khi reboot)
├── /usr        # Userland programs & libs
│   ├── /bin    # Binary cho user
│   ├── /sbin   # Binary cho admin
│   ├── /lib    # Thư viện
│   └── /share  # Data dùng chung (icons, fonts, docs)
└── /var        # Variable data
    ├── /log    # Log system
    ├── /cache  # Cache
    ├── /lib    # State data (db, package info)
    └── /www    # Web root (Apache/Nginx – tuỳ distro)

```

![Alt text](https://fireship.io/courses/linux/img/linux-file-system.png)
--- 

### Tips to remember

-   **/etc** → config
    
-   **/var** → always change (log, cache)
    
-   **/proc & /sys** → not a real file
    
-   **/usr** → app + lib
    
-   **/bin vs /sbin** → user vs admin
    
-   **/dev** → everything is file 😎 (i want fine also)

# File Permissions

- Every directory have permission for owner and group
	- Owner is who created the file or directory
	- Groups is the set of users who share the same permission

![](https://z5.kerneltalks.com/wp-content/uploads/2020/06/File-permissions-in-Linux-Unix.png)

> - : executable file
   r : read
   w: write
   x: execute
- `-rw-r--r--`: 
	- owner user: can read, write, not execute (for each file the owner is root, oracle9, user3)
	- group user: can read only
	- other user: can read only

-  rwx (**user**)    rwx  (**group**)   rwx (**other**)

## chmod

![](https://i.redd.it/u9zhxbl28pq21.jpg)

> change file permissions
 
 ```zsh
chmod [u/g/o][+/-/=][r/w/x][file]
```

- Syntax:
	- **u/g/o**: user/group/other
	- **+/-/=**: add, remove, set
	- **r/w/x**: read, write, execute

- Change file `data.txt` add groups permission writable

```zsh
chmod g+w data.txt
```

- Using octal notation
	- Easy to figure out what number: https://chmod-calculator.com/
```zsh
chmod 664 foo.txt
```
- Syntax:
	- **u/g/o**: 6 6 4
	- read and write: 6, read: 4
	 - 400 : read only

- Be careful with `chmod 777`, grant full access, convenience but it violate the principle of privilege

![](https://media.tenor.com/iP1Lga2PH3IAAAAe/pc-principal-check-privilege.png)   
 
---

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

---

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

- Copy all file content (rather than `32yy`, no this suck)
	- vim will popup that `32 lines yanked into "+`
```zsh
:%y+
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

- Home file (double g)
```zsh
gg
```

- Home line
```zsh
0
```

- End file (capital G)
```zsh
G
```

- End line
```zsh
Shift + 0
```

- Exit (Command mode -> **ESC**)
	- q stand for quit
	- w stand for write
```zsh
:q! #force exit without saving
:wq #save and exit
```

- **Advanced**
	- Combine nvim with **fzf**
		- In terminal type `nvim (space) then Ctrl + T`  => it will open file with nvim immediately
		-  Search file with `fzf`, preview with `batcat` then open in `nvim`: i use alias **fn** for this very long command `fn='/opt/nvim-linux-x86_64/bin $(fzf --preview="batcat --color=always {}")'`

- Ref the `alias` at my [dotfile](https://github.com/lcaohoanq/dotfiles)

### LazyVim

- Currently im using LazyVim (https://www.lazyvim.org/), it really easy to setup, and support a lot of LUA plugins there, but before going to something comfortable, make sure you have a basic or good foundation of vim, take time to practice :) 

![Alt text](https://user-images.githubusercontent.com/292349/213447056-92290767-ea16-430c-8727-ce994c93e9cc.png)

- In the current directory, type `nvim .`, it will open with nvim treesitter (same as sidebar in other IDE)

- Shortcut:
	- **Space + Space**: find file, like Ctrl + P (VSCode), Ctrl + Shift + N/Shift +  Shift (IntelliJ)
	- **Ctr + /**: Terminal (enter the Terminal using i mode)

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
---
# Symbolic links

- Like desktop shortcut in windows
```zsh
ln -s source destination

unlink destination
```
--- 
# Filter & IO redirection command

## Grep (Global Regular Expression Print)

- Find text patterns in files

- Syntax: `grep "search_term" [flags] [file_name]`
	- grep "mom" hello.txt
	- grep "mom" -n hello.txt (**-n**: line number)
	- grep "mom" -Rn . (**-R: recursive**, search multiple file all in current directory)
	- grep "^app" hello.txt (**RegEx**, search line start with `app`)
	- grep "error$" mvn_error.log (**RegEx**, search line end with `error`)
	- grep -c NullPointerException SomeErrorLogs.txt (**count how many time** NullPointerException **appear** in SomeErrorLogs.txt)

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

## Sed (non-interactive text editor)

- Mainly use RegEx, play with RegEx here: https://regex101.com/
- **s**: subtitution

```zsh
❯ sed 's/mom/dad' main.js
```

- Above command just print the file with replaced part, not a real change 

- We use redirection operator to take the output of command then input for sed

```zsh
❯ sed 's/mom/dad' main.js > hihi.js
```

- Using sed at 2nd half pipe, this mean replace all `q` with `vl`, g for global search  

```zsh
❯ echo "lcaohoanqqqq" | sed "s/q/vl/g"
lcaohoanvlvlvlvl
```

---

# Bash Scripting

![](https://miro.medium.com/1*6Oyig2ACF-unC3R-CXT8jw.jpeg)

- Instead of doing manually command in Linux enviroment, we use text file to automate day to day regular tasks, that text file tell system run each command we defined. 
- We have many cool tools outside: Ansible, Puppet, Chef, SaltStack, Terraform why to learn Bash script
> Many concept derived from bash script concepts

- Create new `firstscript.sh`:
```bash
#!/bin/bash

### This script prints system info ###

echo "Welcome to bash script"
echo

# Checking system uptime
echo "###############################"
echo "The uptime of the system is:"
uptime
echo

# Memory utilization
echo "###############################"
echo "Memory utilization"
free -m
echo

# Disk utilization
echo "###############################"
echo "Disk utilization"
df -h
```
- Now we execute `firstscript.sh`

```bash
❯ nvim firstscript.sh
❯ ./firstscript.sh
zsh: permission denied: ./firstscript.sh
❯ chmod +x ./firstscript.sh
❯ ./firstscript.sh
Welcome to bash script

###############################
The uptime of the system is:
 08:37:01 up 30 min,  1 user,  load average: 0.33, 0.44, 0.42

###############################
Memory utilization
               total        used        free      shared  buff/cache   available
Mem:           31963        5103       23971         837        4170       26859
Swap:          11628           0       11628

###############################
Disk utilization
Filesystem      Size  Used Avail Use% Mounted on
udev             16G     0   16G   0% /dev
tmpfs           3.2G  2.0M  3.2G   1% /run
/dev/sdb1       208G   82G  116G  42% /
tmpfs            16G   80M   16G   1% /dev/shm
tmpfs           5.0M  8.0K  5.0M   1% /run/lock
tmpfs           1.0M     0  1.0M   0% /run/credentials/systemd-journald.service
tmpfs            16G   20M   16G   1% /tmp
/dev/nvme0n1p1  234G  144G   79G  65% /media/data
tmpfs           3.2G  140K  3.2G   1% /run/user/1000
``` 

- `websetup.sh`: script for host a website
```bash
#!/bin/bash

# Install on CentOS
# sudo yum install wget unzip httpd -y
# -y continue to install the relate pakage if not install

# I don't want to see that much infomation about installing package
sudo yum install wget unzip httpd -y >/dev/null
# Redirection: error, generate some output, if not error put to /dev/null

sudo systemctl start httpd
sudo systemctl enable httpd

# Why use -p tag
# -p: mean parent, without -p, will throw error
# without -p will create only one level directory
mkdir -p /tmp/webfiles

cd /tmp/webfiles

# Download this zip using wget, can use curl,...
wget https://www.tooplate.com/zip-templates/2098_health.zip
unzip 2098_health.zip

# cp - r: recursive, copy all file, subfiles, folder
# source: all unzip file inside 2098_health to /var/www/html/
cp -r 2098_health/* /var/www/html/

systemctl restart httpd

# Clean up resources
rm -rf /tmp/webfiles
```

- More optimized, unzip to destination directory

```bash
unzip 2098_health.zip -d /var/www/html/
```

![](https://images.viblo.asia/9b6edd8b-83d6-499f-ab57-25502231bf23.png)

- There are too many shell nowadays: **bash**, **zsh**, **fish**,.. you can check your current shell using `echo $SHELL` command:
```zsh
❯ echo $SHELL
/usr/bin/zsh
```
My favorite shell is **zsh** (sound with z-shell, zsh is **default shell on MacOS**, in Linux need to install manually), im using with **oh-my-zsh**, it's powerful with lot of plugin and really pretty

## Variables

 - `websetup.sh`: refactored version

```bash
#!/bin/bash
set -e

### ====== VARIABLES ======
PKG_MANAGER="yum"
PACKAGES=("wget" "unzip" "httpd")

SERVICE_NAME="httpd"

TMP_DIR="/tmp/webfiles"
ZIP_URL="https://www.tooplate.com/zip-templates/2098_health.zip"
ZIP_FILE="2098_health.zip"
UNZIP_DIR="2098_health"

WEB_ROOT="/var/www/html"
### =======================

echo "▶ Installing packages..."
sudo $PKG_MANAGER install -y "${PACKAGES[@]}" >/dev/null

echo "▶ Starting & enabling service: $SERVICE_NAME"
sudo systemctl start $SERVICE_NAME
sudo systemctl enable $SERVICE_NAME

echo "▶ Preparing temp directory: $TMP_DIR"
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"

echo "▶ Downloading template..."
wget "$ZIP_URL"

echo "▶ Extracting..."
unzip "$ZIP_FILE"

echo "▶ Deploying to web root: $WEB_ROOT"
sudo cp -r "$UNZIP_DIR"/* "$WEB_ROOT"

echo "▶ Restarting service..."
sudo systemctl restart $SERVICE_NAME

echo "▶ Cleaning up..."
rm -rf "$TMP_DIR"

echo "✅ Done!"

```

- **Advantages**:
	- `set -e`: fail fast, any command error (exitcode != 0) script stop immediately.
	- Pass arguement : `ZIP_URL=$1 UNZIP_DIR=$2`, run: ```bash ./websetup.sh https://example.com/site.zip mysite```
	- Array of needed packages: can extend when runtime `PACKAGES+=("curl")`

- More enhance version

```bash
#!/bin/bash
set -euo pipefail

### ========= CONFIG =========
LOG_FILE="/var/log/web_deploy.log"

TMP_DIR="/tmp/webfiles"
ZIP_URL="https://www.tooplate.com/zip-templates/2098_health.zip"
ZIP_FILE="2098_health.zip"
UNZIP_DIR="2098_health"
WEB_ROOT="/var/www/html"
SERVICE_NAME="httpd"
### ==========================

### ========= LOGGING =========
exec > >(tee -a "$LOG_FILE") 2>&1
echo "===== START DEPLOY: $(date) ====="
### ===============================

### ========= CHECK OS =========
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "❌ Cannot detect OS"
    exit 1
fi

echo "▶ Detected OS: $OS"

### ========= DETECT PACKAGE MANAGER =========
if command -v dnf >/dev/null; then
    PKG_MANAGER="dnf"
elif command -v yum >/dev/null; then
    PKG_MANAGER="yum"
elif command -v apt >/dev/null; then
    PKG_MANAGER="apt"
else
    echo "❌ No supported package manager found"
    exit 1
fi

echo "▶ Using package manager: $PKG_MANAGER"

### ========= INSTALL PACKAGES =========
if [[ "$PKG_MANAGER" == "apt" ]]; then
    sudo apt update -y
    sudo apt install -y wget unzip apache2
    SERVICE_NAME="apache2"
else
    sudo $PKG_MANAGER install -y wget unzip httpd
fi

### ========= SERVICE =========
sudo systemctl enable "$SERVICE_NAME"
sudo systemctl start "$SERVICE_NAME"

### ========= DEPLOY =========
echo "▶ Preparing temp dir"
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"

echo "▶ Downloading template"
wget "$ZIP_URL"

echo "▶ Extracting"
unzip "$ZIP_FILE"

echo "▶ Copying files to web root"
sudo rm -rf "$WEB_ROOT"/*
sudo cp -r "$UNZIP_DIR"/* "$WEB_ROOT"

sudo systemctl restart "$SERVICE_NAME"

### ========= CLEAN =========
rm -rf "$TMP_DIR"

echo "✅ DEPLOY SUCCESS"
echo "===== END DEPLOY: $(date) ====="
```

- **Advantages**:
	- Check OS (CentOS / Rocky / Alma / Ubuntu / Debian)
		```zsh
		❯ cat /etc/os-release
		PRETTY_NAME="Debian GNU/Linux 13 (trixie)"
		NAME="Debian GNU/Linux"
		VERSION_ID="13"
		VERSION="13 (trixie)"
		VERSION_CODENAME=trixie
		DEBIAN_VERSION_FULL=13.2
		ID=debian
		HOME_URL="https://www.debian.org/"
		SUPPORT_URL="https://www.debian.org/support"
		BUG_REPORT_URL="https://bugs.debian.org/"
		```

	- Auto detect package manager (`yum | dnf | apt`)
		```zsh
		command -v dnf
		command -v yum
		command -v apt
		```
	
	- Log to file -> `/var/log/web_deploy.log`
		- `exec > >(tee -a "$LOG_FILE") 2>&1`
			- **stdout**
			- **stderr**
			- **console**
			
	- Fail fast pro vip
		- `set -euo pipefail`: 
			- **-e**: if error stop
			- **-u**: any variable not set -> fail
			- **pipefail**: pipe fail -> fail
