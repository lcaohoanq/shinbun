---
title: Hoàng ơi setup con Ubuntu Server mới cài này với ~~
published: 2025-12-26
description: Tập tành setup server cùng tui nha
image: "https://images.unsplash.com/photo-1683322499436-f4383dd59f5a?q=80&w=1171&auto=format&fit=crop"
tags: [Linux, Documentation, Server, Devops, Tinkering]
category: 'Công nghệ'
draft: false
lang: 'vi'
---

- Một ngày đẹp trời rãnh rỗi cài lại em máy cổ W520 của tui, chán ZimaOS rồi, nó đóng quá, siêu bí bách :0 chả cài gì, vọc vạch được. Tui lại tái hòa nhập với cộng đồng xD, Ubuntu Server (24 LTS) thẳng tiến. Cài siêu dễ luôn á, blog này chỉ để lưu lại khi tui cần cài gì tôi lên đây lấy về cho nhanh :) đỡ search. Nhớ đâu viết đến đấy (hoặc làm tới đâu nhớ thì viết) nên có thể mọi người vào mỗi thời gian thì sẽ thấy nội dung nó khác nhau.

![Alt text](https://www.zimaspace.com/_ipx/w_3072&f_png/image/zimaos/meet-zimaos.png)

- ZimaOS dùng làm NAS server thì đúng bài, đẹp, tiện nhẹ, có bán sẵn Server luôn, tên là ZimaCube, trông vuông vuông gọn gọn nhìn đẹp cực
- À tại sao tui lại cài Ubuntu Server á, dễ xài nhất rồi :) có gì fix cho khỏe. Hiện giờ daily tui dùng Debian, quen thuộc với package apt của nhà Debian rồi, tại daily tui dùng Debian

![](https://i.ytimg.com/vi/q5yM4ZYwB_s/maxresdefault.jpg)

# Check ip, SSH Config

![](https://miro.medium.com/0*tgrMTzwM0nO7DDjQ.png)

- Để SSH vào mà cài luôn

```zsh
ip a | grep 192.168
```

- Lười, list ip ra rồi pick thằng 192.168 luôn, của mình là **192.168.88.155**, quá ngon ta đã có địa chỉ của nhà người yêu rồi. Giờ ta sẽ nhắn tin, alo rủ ẻm đi chơi => SSH

```zsh
ssh hihi@192.168.88.155
```

- Nếu lười nhập pass mỗi lần SSH thì làm cách này, ở máy local, tạo một file **~/.ssh/config**

```zsh
nano ~/.ssh/config
```

- Với nội dung

```zsh
Host xyz
    HostName xxx.yyy.zz.aaa
    User root
    IdentityFile ~/.ssh/id_gitlab_lcaohoanq

Host w520
    HostName 192.168.88.155
    User lcaohoanq
    IdentityFile ~/.ssh/id_ed25519
```

- Chú ý ref tới các IdentityFile cho đúng nha, check lại xem có không

```zsh
❯ ls -al ~/.ssh
.rw-rw-r--  188 lcaohoanq 26 Dec 22:51  config
.r--------  411 lcaohoanq 14 Dec 15:33 󰌆 id_ed25519
.rw-rw-r--  100 lcaohoanq 14 Dec 15:33 󰷖 id_ed25519.pub
.r-------- 2.6k lcaohoanq 14 Dec 15:33  id_gitlab_lcaohoanq
.rw-rw-r--  569 lcaohoanq 14 Dec 15:33 󰷖 id_gitlab_lcaohoanq.pub
.rw------- 6.0k lcaohoanq 26 Dec 22:51 󰣀 known_hosts
.rw------- 5.2k lcaohoanq 26 Dec 22:51  known_hosts.old
```

- Cuối cùng copy public key (file .pub) đưa lên server là xong

```zsh
ssh-copy-id -i ~/.ssh/id_ed25519.pub lcaohoanq@192.168.88.155
```

- Test vào lại

```zsh
ssh -i /home/lcaohoanq/.ssh/id_ed25519 'lcaohoanq@192.168.88.155'
```

- Test phát cuối

```zsh
ssh w520
```

- Nếu vào được thì ngon lành cành đào

# VPN: Tailscale

![](https://blog.briancmoses.com/images/2021/tailscale/tailscale-logo-black-800.png)

- **WireGuard** xịn sò hơn mà config lằng nhằng quá, từ bỏ luôn, hiện dùng mỗi Tailscale ```nhanh```, ```tiện```, ```sướng```
- Ref doc đi: <https://tailscale.com/kb/1031/install-linux>
- Chạy lệnh này cài

```zsh
curl -fsSL https://tailscale.com/install.sh | sh
```

- Cài xong thì **sudo tailscale up**, Tailscale trả ra một url auth, copy vào browser rồi Login để nhận device là xong

# Tunnel: Cloudflare

![](https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Cloudflare_Logo.svg/1200px-Cloudflare_Logo.svg.png)

- Cài tá lả

```zsh
# Add cloudflare gpg key
sudo mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-public-v2.gpg | sudo tee /usr/share/keyrings/cloudflare-public-v2.gpg >/dev/null

# Add this repo to your apt repositories
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-public-v2.gpg] https://pkg.cloudflare.com/cloudflared any main' | sudo tee /etc/apt/sources.list.d/cloudflared.list

# install cloudflared
sudo apt-get update && sudo apt-get install cloudflared
```

- Sau khi cài xong rồi thì chạy tiếp lệnh này để nó nhận tunnel trên dashboard của mình, tự lắp **token** nhóe

```zsh
sudo cloudflared service install tokentokentokentokentokentoken....
```

# Docker

![](https://images.viblo.asia/fad7cf1a-772f-43e4-9042-e96d5d903b2b.png)

- Doc là chân ái, ráng vào Ctrl + C/V đi anh zai
- Cài xong run được cái container hello-world chưa chắc ngon đâu nha, check **docker ps** phát xem thử có bị bug permission không? Sửa ở đây (<https://stackoverflow.com/questions/48957195/how-to-fix-docker-permission-denied>), lỗi do user hiện tại chưa được thêm vào  group á mà, 99.9% cài mới docker đều bị :) gặp hoài luôn

# Netdata

- Giám sát server, container, app,... siêu ngon, nhẹ, đẹp, dễ xài
- Có 2 cách cài:

1. Cài bằng script: [Script install](https://learn.netdata.cloud/docs/netdata-agent/installation/linux)

`wget`

```zsh
wget -O /tmp/netdata-kickstart.sh https://get.netdata.cloud/kickstart.sh && sh /tmp/netdata-kickstart.sh
```

1. Cài bằng Docker (ưu tiên cách này): [Docker install](https://learn.netdata.cloud/docs/netdata-agent/installation/docker)

`docker run`

```zsh
docker run -d --name=netdata \
  --pid=host \
  --network=host \
  -v netdataconfig:/etc/netdata \
  -v netdatalib:/var/lib/netdata \
  -v netdatacache:/var/cache/netdata \
  -v /:/host/root:ro,rslave \
  -v /etc/passwd:/host/etc/passwd:ro \
  -v /etc/group:/host/etc/group:ro \
  -v /etc/localtime:/etc/localtime:ro \
  -v /proc:/host/proc:ro \
  -v /sys:/host/sys:ro \
  -v /etc/os-release:/host/etc/os-release:ro \
  -v /var/log:/host/var/log:ro \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v /run/dbus:/run/dbus:ro \
  --restart unless-stopped \
  --cap-add SYS_PTRACE \
  --cap-add SYS_ADMIN \
  --security-opt apparmor=unconfined \
  netdata/netdata
```

- Xong rồi truy cập **<http://server-ip:19999>** để xem dashboard thôi

> Trường hợp nếu xoay xoay mãi không vào được, hãy kiểm tra xem

- Port `19999` có đang listen không

```zsh
sudo ss -tulpn | grep 19999
```

```zsh
tcp   LISTEN 0      4096      0.0.0.0:19999      0.0.0.0:*    users:(("netdata",pid=136540,fd=6))       
tcp   LISTEN 0      4096         [::]:19999         [::]:*    users:(("netdata",pid=136540,fd=8)) 
```

- Firewall có chặn port 19999 không

```zsh
sudo ufw status
```

- Nếu có chặn thì mở port 19999 lên

```zsh
sudo ufw allow 19999/tcp
sudo ufw reload
```

# Dozzle

- Xem log container realtime trên web, nhanh, nhẹ
- Cài bằng Docker

```zsh
#Default: https://dozzle.dev/guide/getting-started

# I adjust port mapping to avoid conflict with Spring Boot app
docker run -d -v /var/run/docker.sock:/var/run/docker.sock -p 8888:8080 amir20/dozzle:latest
```

- Thường mình sẽ map ra port **8888:8080** để khỏi trùng container Spring Boot (8080)

# Set IP Tĩnh, Tắt DHCP

Thỉnh thoảng sẽ cần cho homelab server IP tĩnh, không đổi, để dễ quản lý, có 2 cách:
    - **Cấu hình trên Router** (nếu router có hỗ trợ)
    - **Cấu hình trực tiếp trên server** (cách này mình hay dùng), mình sẽ hướng dẫn cách này nha

- Kiểm tra cấu hình ở `/etc/netplan/`

```zsh
ls /etc/netplan/
```

Thường file sẽ có tên dạng 01-netcfg.yaml, 50-cloud-init.yaml hoặc 00-installer-config.yaml

- Sửa file với quyền sudo

Mình là `50-cloud-init.yaml`

```zsh
sudo vi /etc/netplan/50-cloud-init.yaml
```

- Nếu chưa chỉnh gì thì **dhcp4: true**, chú ý các khoảng trắng, indent đúng nha

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:  # Thay bằng tên card mạng của bạn, kiểm tra bằng ip a | grep 192.168
      dhcp4: no
      addresses:
        - 192.168.88.155/24 # Địa chỉ IP tĩnh bạn muốn đặt cho server, mình lấy luôn cái IP mà router cấp hiện tại
      routes:
        - to: default
          via: 192.168.88.1  # Địa chỉ IP của Router  (Gateway), mình xài router VNPT
      nameservers:
        addresses: [8.8.8.8, 1.1.1.1] # DNS của Google và Cloudflare
```

Lưu file lại, rồi chạy lệnh này để áp dụng cấu hình mới

```zsh
sudo netplan try # Thử cấu hình mới trước
```

> Nếu không có lỗi gì, **bấm Enter để áp dụng**, nếu có lỗi gì nó sẽ tự rollback lại cấu hình cũ sau 120s

Chắc chắn đúng thì hãy dùng

```zsh
sudo netplan apply
```

Kiểm tra lại IP thực tế

```zsh
hostname -I
```

- Nếu IP đúng như cấu hình thì okie, xong rồi đó :)

## Trường hợp oái ăm (mới gặp phải)

- Xong hết các bước trên nhưng ssh vào server không được, báo lỗi timeout, không kết nối được. Kì cục vãi

- Confirm rằng
  - Hostname đã đúng
  - `/etc/netplan/xxx.yaml` đã đúng syntax
  - Đúng tên card mạng
  - Firewall có chặn không
  - Check SSH đang listen không

```zsh
sudo ss -tulpn | grep ssh
# Hoặc grep port 22 luôn cũng được
```

- Nếu ra kết quả, oke vậy là đã listen port 1604 rồi, bước cuối check ssh service đang chạy không

```zsh
sudo systemctl status ssh
```

- Nếu không chạy thì start nó lên

```zsh
sudo systemctl enable ssh
sudo systemctl start ssh
```

- Oke xong rồi thử ssh lại xem được chưa nha :)
