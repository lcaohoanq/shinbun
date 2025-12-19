---
title: Setup Debian 13 (Trixe) của mình
published: 2025-12-16
description: 'Mình cài đi cài lại, đổi os rất nhiều nên giữ các config lúc nào mình cũng xài ở đây'
image: "https://images.unsplash.com/photo-1640552435388-a54879e72b28?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0"
tags: [Linux, Config, Debian, KDE Plasma]
category: 'Công nghệ'
draft: false
lang: 'vi'
---

- Bài viết này được thực hiện trên Debian 13 Trixe KDE Plasma

# Đưa user hiện tại làm root
```zsh
sudo nano /etc/sudoesr
- Kéo tới dòng này, thêm vào ở dưới root tên user của bạn để cấp full quyền root
- Nếu không thì user `lcaohoanq` sẽ không thể cài, update package được

```zsh
# User privilege specification
root    ALL=(ALL:ALL) ALL
lcaohoanq ALL=(ALL:ALL) ALL
```

# Mount ổ cứng
- Hiện tại mình đang dùng **2 ổ cứng, 1 ổ SSD boot + 1 ổ NVME data**
- Check thông tin
```zsh
❯ sudo blkid

/dev/nvme0n1p1: LABEL="DATA" UUID="26a0de97-0abd-45e1-b610-129d3045f430" BLOCK_SIZE="4096" TYPE="ext4" PARTLABEL="Basic data partition" PARTUUID="3aec2ba0-c66e-01db-d015-761d37e3ed00"
/dev/sda5: UUID="9eacdd7d-3177-4e92-a812-63e0abaade65" TYPE="swap" PARTUUID="f6b8904f-05"
/dev/sda1: UUID="2c9bf3d9-8c80-4d4d-8632-4b10e65726d3" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="f6b8904f-01"
```
- Gọn hơn, xem dung lượng và **`UUID`** của ổ
```zsh
❯ lsblk -o NAME,SIZE,UUID
NAME          SIZE UUID
sda         223.6G
├─sda1      212.2G 2c9bf3d9-8c80-4d4d-8632-4b10e65726d3
├─sda2          1K
└─sda5       11.4G 9eacdd7d-3177-4e92-a812-63e0abaade65
nvme0n1     238.5G
└─nvme0n1p1 238.5G 26a0de97-0abd-45e1-b610-129d3045f430
```
- Mình muốn mount ổ **/dev/nvme0n1p1** -> /media/data, mình cần 4 thông tin
	-	UUID của ổ
	-	destination -> /media/data
	-	định dạng phân vùng -> ext4
	-	defaults 0 2 ->
		-	0: Liên quan tới tool **`dump`** (backup kiểu cổ)
			-   `0` = **không backup**
			-   `1` = có backup
			- `dump` gần như **không còn dùng**
		-  2:  fsck (file system check)
			- Nó quyết định **thứ tự kiểm tra filesystem khi boot**.
			- 0 -> không kiểm tra
			- 1 -> kiểm tra đầu tiên, chỉ dành cho root */*
			- 2 -> kiểm tra sau root -> Dùng cho disk phụ

- Gom lại ta được lệnh: `UUID=26a0de97-0abd-45e1-b610-129d3045f430 /media/data ext4 defaults 0 2`
- Bắt đầu mount, vào fstab
```zsh
sudo nano /etc/fstab
```
- Kiểm tra thông tin, và thêm vào dòng cuối cùng
```zsh
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# systemd generates mount units based on this file, see systemd.mount(5).
# Please run 'systemctl daemon-reload' after making changes here.
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/sda1 during installation
UUID=2c9bf3d9-8c80-4d4d-8632-4b10e65726d3 /               ext4    errors=remount-ro 0       1
# swap was on /dev/sda5 during installation
UUID=9eacdd7d-3177-4e92-a812-63e0abaade65 none            swap    sw              0       0

UUID=26a0de97-0abd-45e1-b610-129d3045f430 /media/data  ext4  defaults  0  2
```

- Lưu thay đổi, thường sau khi `sudo mount -a` thường bắt deamon reload, chú ý nhìn output của terminal và làm theo nhé
```zsh
# apply without rebooting
sudo mount -a
# If meet any error about no mount directory found, just need to reboot
```
- Check lại
```zsh
# verify mounting
df -h

# hoặc xài duf
duf
```

# Các phần mềm CLI mình hay cài
- Cài một lần luôn cho khỏe
- Mình đang xài Debian nên dùng apt nhé
- Đối với các package phổ biến
```zsh
sudo apt install \
  zsh \      # shell
  kitty \    # terminal
  bat \      # cat xịn hơn
  eza \			 # ls xịn hơn
  fzf \      # file & search
  zoxide \   # cd xịn hơn
  fastfetch \
  htop \
  btop \
  duf \  		# du df xịn hơn
  xclip     # copy paste với clipboard
  ranger    # thao tác file trong terminal
  byobu     # tmux xịn hơn
  fd-find
  ripgrep   # search recursive directories
  pipx
```

- Cho zoxide
```zsh
eval "$(zoxide init zsh)"
```
- Symlink cho fd
```
sudo ln -s $(which fdfind) /usr/local/bin/fd
# fdfind --version
fd --version
```

- Mình là dev với java nên cần thêm vài tool

```zsh
sudo apt install maven default-jdk
```
- Test lại đã cài được chưa
```zsh
mvn --version
```
```zsh
Apache Maven 3.9.9
Maven home: /usr/share/maven
Java version: 21.0.9, vendor: Debian, runtime: /usr/lib/jvm/java-21-openjdk-amd64
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "6.12.57+deb13-amd64", arch: "amd64", family: "unix"
```
```zsh
java --version
```
```zsh
openjdk 21.0.9 2025-10-21
OpenJDK Runtime Environment (build 21.0.9+10-Debian-1deb13u1)
OpenJDK 64-Bit Server VM (build 21.0.9+10-Debian-1deb13u1, mixed mode, sharing)
```

- Tham khảo thêm ở đây
> - https://dev.to/lissy93/cli-tools-you-cant-live-without-57f6

## Nodejs

- Ref: https://nodejs.org/en/download

```zsh
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install 22

# Verify the Node.js version:
node -v # Should print "v22.21.1".

# Verify npm version:
npm -v # Should print "10.9.4".
```

- Cài thêm pnpm, yarn, bun
```zsh
npm i -g pnpm yarn bun
```

## DevOps

- Doppler cho secret management: https://docs.doppler.com/docs/install-cli


# .secret.baseline

- Chặn commit .env (https://github.com/Yelp/detect-secrets/tree/master/docs)

```zsh
pipx install detect-secrets   # hoặc venv nếu bạn muốn
pre-commit install            # cài git hooks
```

- Cần có 3 file commit trên repo
	-   `.pre-commit-config.yaml`
	-   `.secrets.baseline`
	-   `.gitignore`

### **Team Setup**

```zsh
pipx install detect-secrets
pipx ensurepath
pre-commit install
```

**Commit bất kỳ có secrets → sẽ bị chặn.**
Nếu bị false positive:

```zsh
detect-secrets scan > .secrets.baseline
git add .secrets.baseline
git commit  -m "Update baseline"
```

# vim, neovim, lazyVim
- https://neovim.io/doc/install
```zsh
# Pre-built archives
# The Releases page provides pre-built binaries for Linux systems.

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
```
- Then add this to your shell config (~/.bashrc, ~/.zshrc, …):
```zsh
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
```

- Install Lazyvim (https://www.lazyvim.org/installation)
- LazyVim require v10 above to install

<img width="1134" height="713" alt="image" src="https://github.com/user-attachments/assets/b0959d01-e93c-4348-add1-a5af86f5405f" />

- Cài Thêm Trong LazyExtras để support nhiều ngôn ngữ + tools

# Docker
- Theo guide là được, chỉ cài Docker Engine https://docs.docker.com/engine/install/debian/
- Check cài thành công
```zsh
sudo docker run hello-world
```

- Nhưng xài lệnh `docker ps` thì không được
```yaml
docker: Got permission denied while trying to connect
to the Docker daemon socket at unix:///var/run/docker.sock:
Post http://%2Fvar%2Frun%2Fdocker.sock/v1.35/containers/create:
dial unix /var/run/docker.sock: connect: permission denied.
See 'docker run --help'.
```
- 100% mình cài mới là bị, do user hiện tại chưa được add vào group docker, cách fix [Docker: Permission denied](https://stackoverflow.com/questions/48957195/how-to-fix-docker-permission-denied)

- Mình chạy thêm vài container utility nữa [docker-compose](https://github.com/lcaohoanq/boilerplates/tree/lcaohoanq/config/docker-compose)
	- portainer: rất tiện, mình hay triển khai trên server thực tế
	- dozzle (8888): check log đẹp hơn, đỡ docker logs -f
	- postgres

# SSH
## GitHub

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

- Notice that if the .pub key have differ name need to specify the absolute path ssh-add /home/username/.ssh/id_xxxxx

```bash
ssh-add id_xxxxx

# If meet the key are too open
sudo chmod 400 /home/lcaohoanq/.ssh/id_xxxxx

# If meet permission denied when ssh-add
sudo chown lcaohoanq:lcaohoanq ~/.ssh/id_xxxxx

# Verify
ssh -T git@github.com
```

## GitLab
- Giống y chang ở trên, đổi lệnh cuối thành `gitlab`
```zsh
ssh -T git@gitlab.com
```


# Gõ tiếng Việt

## fcitx5
```zsh
sudo apt install fcitx5 libfcitx5-qt-data fcitx5-config-qt fcitx5-unikey fcitx5-material-color
```
- Add thêm `Unikey` vào nhé (dưới Keyboard - English US)
- Default chuyển ngôn ngữ `Ctrl + Space`, mình đổi qua `Ctrl + Left Shift`

## ibus-bamboo

- Dự án đã dừng phát triển ở repo gốc, hiện đang có những dev đang fork maintain
- https://github.com/BambooEngine/ibus-bamboo/issues/590

```zsh
sudo apt update
sudo apt install ibus ibus-unikey ibus-anthy

# start ibus-daemon
ibus-daemon -drx

# set ibus is default input method
im-config -n ibus
```

# Shortcut
-
- Kitty: Meta + Return = Super + Enter

# System Settings

## App & Windows - Window Management - Virtual Desktops

- Add desktop -> 3 Row 1,2,3
- Thêm xong thì mở rộng không gian ra 3 cửa sổ, có thể lăn chuột vào để đổi desktop (ở taskbar) hoặc Ctrl + Meta + Left/Right (Arrow)

# Grub
- Mình xài qua 2 bộ, mì ăn liền dễ xài là của [Chris Titus Tech](https://www.youtube.com/@ChrisTitusTech)
- Làm theo hướng dẫn là được, rất dễ: https://christitus.com/bootloader-themes/
<iframe width="560" height="315" src="https://www.youtube.com/embed/BAyzHP1Cqb0?si=bBD9WmEtvL7mQ8QJ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

- Hardcode hơn chút thì Minegrub https://github.com/Lxtharia/minegrub-theme'


![Alt text](https://github.com/Lxtharia/minegrub-theme/raw/dev/resources/preview_minegrub.png)

```zsh
cd Downloads &&
git clone https://github.com/Lxtharia/minegrub-theme.git &&
cd minegrub-theme &&

# Im just too lazy too config just apply the install, high risk high return boys <3
sudo ./install_theme.sh
```
-   Lưu thay đổi và reboot
```zsh
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

# zsh config

- Mình dùng [oh-my-zsh](https://ohmyz.sh/), nhớ cài zsh trước nhen
```zsh
sudo apt-get install zsh curl  && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- Sau khi cài xong thì mình có **`~/.zshrc`** để config, default thì đa số comment lại, mình sẽ overview các nhóm các bạn cần sửa
	- Theme: oh-my-zsh có built-in theme cũng đẹp rồi nhưng mình thích dùng [powerlevel10k] hơn (https://github.com/romkatv/powerlevel10k)
	- Plugins: rất nhiều plugin, tham khảo ở đây https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
	- Alias: shortcut lệnh

- Config của mình, các bạn tham khảo nhé https://github.com/lcaohoanq/dotfiles/blob/stow/.zshrc_debian13

> - Chú ý có các plugin này cần phải clone về nha
```zsh
# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# fzf-tab
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
```

# kitty config

- Ref: https://github.com/lcaohoanq/dotfiles/tree/stow/kitty

# Homebrew
- https://brew.sh/

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

- Set path

```zsh
echo >> /home/lcaohoanq/.zshrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/lcaohoanq/.zshrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

- Cài thêm GCC
```zsh
brew install gcc
```

# AWS CLI
```zsh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

```zsh
❯ aws --version
aws-cli/2.32.20 Python/3.13.11 Linux/6.12.57+deb13-amd64 exe/x86_64.debian.13
```

# spotifty

- Cài qua snapd, mạng mạnh nhưng lần nào tải đều rất lâu

# cloudflare warp client

- https://developers.cloudflare.com/warp-client/get-started/linux/

# zalo 

- Bản cài port từ .dmg trên macOS (https://github.com/ducseul/zalo-linux-unofficial)

```zsh
git clone https://github.com/ducseul/zalo-linux-unofficial.git && cd zalo-linux-unofficial && bash install.sh
```

- Không sync lần đầu đăng nhập được, còn mọi tính năng ngon lành 
