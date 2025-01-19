---
title: Linux 101
published: 2025-01-19
description: All stuffs about linux with a perspective of Debian KDE Plasma user
image: "https://github.com/lcaohoanq/Linux-Issues/assets/136492579/67567ea6-ef1c-4f92-8dd9-98979f1ba4e6"
tags: [Linux, Documentation]
category: 'Tech'
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

# [Basic Commands]

- Most used commands:

  - **cd** : Change directory
    - `cd /home/user`
    - `cd ~`
    - `cd ..`

  - **ls** : List files and directories
    - `ls`
    - `ls -l` | `ls -al`
    - `ls -a`

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

## [Cool CLI tools]
- Ref: https://dev.to/lissy93/cli-tools-you-cant-live-without-57f6

> My favorite:
- neofetch
- `htop` : System monitor
![image](https://github.com/lcaohoanq/Linux-Issues/assets/136492579/6e0d930b-4923-40c7-a77c-139ccf462c0a)
- `btop` : Same as htop but look prettier
![image](https://github.com/lcaohoanq/Linux-Issues/assets/136492579/b6792e97-f792-412b-9459-757921ba3805)
- `ranger` : GUI terminal file navigation
![image](https://github.com/lcaohoanq/Linux-Issues/assets/136492579/55fcb569-c56c-458b-9587-3b85b6f653f7)
  - config ranger can preview text, image, video
  ```bash
  # Debian

  ```

  ```bash
  # Arch
  sudo pacman -S w3m mpv ueberzug

  # this command will generate the ranger configuration ~/.config/ranger
  ranger --copy-config=all

  # edit file rc.conf
  nano ~/.config/ranger/rc.conf
  ```
  ```bash
  set preview_images_method kitty
  set preview_images true
  set show_hidden true
  ```
- `duf` : better `du`
![image](https://github.com/lcaohoanq/Linux-Issues/assets/136492579/b016e577-4caf-4249-ad8d-c19d5b0fc227)
- `byobu` : more enhancements of tmux
- `zoxide` : better `cd`
- `fzf`: cool find file tools
  ```bash
    # install
    sudo apt install fzf

    fzf
    __________________
    > index.js

    # preview the file content
    fzf --preview='cat {}'
    __________________
    > index.js

    # preview and open in neovim
    nvim $(fzf --preview='cat {}')
  ```
- `ytfzf`: playing youtube video with terminal
  - ref: https://www.makeuseof.com/watch-youtube-videos-in-linux-terminal/
 ### Arch
```bash
yay -S ytfzf yt-dlp
```

 ### Debian
  ```bash
  # Installation
  sudo apt install jq curl mpv fzf

  # re-install mpv if at the end you can not stream the video
  sudo apt install snapd
  sudo snap install mpv

  sudo apt install ueberzug

  # clone the repo
  git clone git@github.com:pystardust/ytfzf.git

  cd ytfzf

  sudo apt install make

  sudo make install
  sudo make install doc
  sudo make addons
  ```

  - config
  ```bash
  sudo mkdir ~/.config/ytfzf
  cd ~/.config/ytfzf
  sudo nano conf.sh
  ```
  - the content in file

  ```bash
  video_pref="bestvideo[height<=?720][fps<=?30]"
  audio_pref='bestaudio/audio'
  is_detach=yes
  thumbnail_viewer='kitty'
  skip_thumb_download=no
  enable_back_button=yes
  enable_hist=no
  enable_submenus=yes
  ```

  ```bash
  # choose the first video and stream it
  ytfzf -a slay! phonk

  # show the list of options to choose
  ytfzf -t
  > Linux
  ```

  - remap the key
  ```bash
  echo "alias yt='ytfzf - t'" >> ~/.bashrc
  source ~/.bashrc
  ```

## [Useful configuration]

- Mapping mouse with `xbindkeys`
   - Install `kwin`
   - https://www.google.com/url?q=https://github.com/Bismuth-Forge/bismuth&sa=D&source=docs&ust=1718093947630257&usg=AOvVaw3K2LQnDy3hmpsLycFWVMUU
  ```bash
  sudo apt install kwin-bismuth
  ```
  - Enable the below options and do a little adjust from default **Meta + F8** to **Meta + Tab** at Shhow Desktop Grid

![image](https://github.com/lcaohoanq/Linux-Issues/assets/136492579/c19c2d7f-fa1d-43f4-91f5-57590386c3bd)

  - Install `xbindkeys`
  ```bash
  sudo apt-get install xbindkeys xautomation

  # identify which number of button / keycode when click into the small square
  xev

  # create xbindkeysrc file
  nano ~/.xbindkeysrc
  ```

  - After detect i know the `forward` and `backward` of my mouse **(VXE R1 SE+)** is `113` and `114`
  - So i want to map it to the **same as the kwin script above** to iterate the virtual desktop

  ```bash
  "xte 'keydown Alt_L' 'key Left' 'keyup Alt_L'"
  c:113

  "xte 'keydown Alt_L' 'key Right' 'keyup Alt_L'"
  c:114  # Replace with actual keycode for the forward button

  # Middle click
  # Supper + Tab (Windows + Tab)
  "xte 'keydown Alt_L' 'key Tab' 'keyup Alt_L'"
  c:133
  ```

![image](https://github.com/lcaohoanq/Linux-Issues/assets/136492579/9d219525-1f1e-4f5c-b623-02f3742ea3ef)


  ```bash
  # Save and Close
  # Start the xbindkeys
  xbindkeys
  ```

- Change trackpoint sensitivity
```bash
# replace your sensitivity at 150

echo 150 | sudo tee /sys/devices/platform/i8042/serio1/serio2/sensitivity
```

# [Input method]

- I'm using Ibus with 2 additional language is Vietnamese and Japanese (English is always have there)

## 1. Gnome
- https://minhng.info/tips/unikey-ubuntu-2204.html
- https://askubuntu.com/questions/1407560/switching-language-by-alt-shift-after-update-from-ubuntu-22-04-beta-to-release: switch to next input source -> CTRL + Alt + A (my favorite shortcut)

```bash
sudo apt install ibus-unikey
```

```bash
sudo apt install ibus-mozc mozc-utils-gui # Japanese
```

- Logout to takes effect

## 2. KDE Plasma

```bash
sudo apt update
sudo apt install ibus ibus-unikey ibus-anthy

# start ibus-daemon
ibus-daemon -drx

# set ibus is default input method
im-config -n ibus
```

- Reboot your system to apply changes

- After that we will enter to Ibus GUI configuration by command

```bash
ibus-setup
```

- In the Input Method tab:

  - Click on the Add button.
  - Search for and add Vietnamese (Unikey).
  - Search for and add Japanese (Anthy or Mocz), i`m using Mocz now
  - Add shortcut for change the input method:
    > Default is `<Super>space`, I change to `<Control><Alt>A`, it's up to you

- Adjust the Ibus-Preferences auto-start

![image](https://github.com/lcaohoanq/My-Linux-Experience/assets/136492579/c05e7ec4-f37f-4c7d-b525-2962b33001a2)

## 3. Arch

- Fcitx5 work with Japanese, but not Vietnamese
- Ibus still not work with Arch (continue to find the solution)

# [Mount drive]

## 1. Install G-Parted

- Debian

```bash
sudo apt install gparted
```

- Arch

```zsh
sudo pacman -S gparted
```

## 2. Get the drive's UUID

```bash
lsblk -o NAME,SIZE,UUID
```

![alt text](https://github.com/lcaohoanq/linux/blob/master/05-MountDrive/image.png?raw=true)

- Or more details

```bash
sudo blkid
```

- Each UUID corresponding for each partion of each driver

## 3. Check your drive's type (NTFS,ext4,...)

- Install `ntfs-3g `, as it is required for mounting `NTFS` partitions with read and write access

```bash
sudo apt update
sudo apt install ntfs-3g
```

- If ext4, skip to the next step

## 4. Edit /etc/fstab

```bash
sudo nano /etc/fstab
```

![image](https://github.com/lcaohoanq/Linux-Issues/assets/136492579/6dc573f5-a10a-4e00-b97a-22de486ab82a)

- This is my current disk

  > /dev/sdc1: UUID="022D-A728" BLOCK_SIZE="512" TYPE="vfat" PARTUUID="10eb9e0a-d35b-4a06-add6-5af9648660de"

  > /dev/sdc2: UUID="61d23e9c-361e-4c0f-9813-ba446759b712" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="40ff6c17-e76d-4925-8dc8-4730a8ff2996"

  > /dev/sdc3: UUID="0734bbed-9e19-4d56-bd5a-5ed1e81bbaf3" TYPE="swap" PARTUUID="cf63ed80-df79-47fa-bfda-9602602118b5"

- I want to mount as ntfs with read and write partition
- Replace the UUIDs with those of your NTFS partitions and the mount points with the ones you created

```bash
# NTFS partition 1
UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx /mnt/ntfs1 ntfs-3g defaults,rw 0 2

# NTFS partition 2
UUID=yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy /mnt/ntfs2 ntfs-3g defaults,rw 0 2
```

- /mnt/ntfs1, /mnt/ntfs2: mount point (can be create manually or auto with
- ntfs-3g: type partition

The defaults option is a shorthand that refers to a set of default mount options:

    rw (read-write)
    suid (allow set-user-identifier or set-group-identifier bits to take effect)
    dev (interpret character or block special devices on the filesystem)
    exec (allow execution of binaries)
    auto (can be mounted automatically with the mount -a command)
    nouser (only root can mount)
    async (all I/O to the filesystem should be done asynchronously)

rw

The rw option explicitly specifies that the filesystem should be mounted with read and write permissions.
0

This is the dump frequency. It is used by the dump command to determine which filesystems need to be dumped (i.e., backed up). A value of 0 means that the filesystem will not be dumped.
2

This is the fsck order. It specifies the order in which filesystem checks are done at boot time by the fsck utility:

    0 means the filesystem is not checked.
    1 is used for the root filesystem.
    2 means the filesystem will be checked after the root filesystem, with multiple filesystems having the same number being checked in parallel.

![image](https://github.com/lcaohoanq/Linux-Issues/assets/136492579/969fb8db-5ef8-4acf-b2d4-0042d2d77dbb)

## 5. Apply change

```bash
# apply without rebooting
sudo mount -a
# If meet any error about no mount directory found, just need to reboot

# verify mounting
df -h
```

```bash
# or (sudo apt install duf) for more colorful ^^
duf
```

![image](https://github.com/lcaohoanq/Linux-Issues/assets/136492579/71e2488b-0f99-49db-9884-723c93bcd221)

# [Nvidia Graphics Card]

```bash
sudo add-apt-repository contrib
sudo add-apt-repository non-free
sudo apt update
sudo apt install nvidia-detect
nvidia-detect
sudo apt install nvidia-driver
```

- I will buy AMD GPU next time, Nvidia is not friendly with Linux

# [Terminal Customization]

- Make sure you have install the Nerd Fonts
- Apply the "randomly" bashshell customize of other guys

- https://www.linuxfordevices.com/tutorials/linux/beautify-bash-shell

```bash
git clone --recursive https://github.com/andresgongora/synth-shell.git

cd synth-shell

sudo chmod +x setup.sh

./setup.sh

# Yes for all~

# Any edit
nano ~/.bashrc
```

> Finnaly, we have such a pretty terminal

# [Github-SSH key]

- https://docs.github.com/fr/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

```bash
mkdir ~/.ssh

# or i have my own .ssh key, i have created before
cp .ssh/ /home/lcaohoanq/.ssh/ -r
```
```bash
# Ensure ssh-agent is enabled
sudo pacman -S openssh
```

```bash
# The command starts the ssh-agent in the background
eval "$(ssh-agent -s)"
```

```bash
ssh-add id_xxxxx

# If meet the key are too open
sudo chmod 400 /home/lcaohoanq/.ssh/id_xxxxx

# If meet permission denied when ssh-add
sudo chown lcaohoanq:lcaohoanq ~/.ssh/id_xxxxx

# Verify
ssh -T git@github.com
```
