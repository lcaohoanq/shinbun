---
title: Hoàng ơi" setup con Ubuntu Server mới cài này với ~~
published: 2025-12-26
description: Tập tành setup server cùng tui nha
image: "https://images.unsplash.com/photo-1683322499436-f4383dd59f5a?q=80&w=1171&auto=format&fit=crop"
tags: [Linux, Documentation, Server, Devops, Tinkering]
category: 'Công nghệ'
draft: false
lang: 'vi'
---

- Một ngày đẹp trời rãnh rỗi cài lại em máy cổ W520 của tui, chán ZimaOS rồi, nó đóng quá, siêu bí bách :0 chả cài gì, vọc vạch được. Tui lại tái hòa nhập với cộng đồng xD, Ubuntu Server thẳng tiến. Cài siêu dễ luôn á, blog này chỉ để lưu lại khi tui cần cài gì tôi lên đây lấy về cho nhanh :) đỡ search. Nhớ đâu viết đến đấy (hoặc làm tới đâu nhớ thì viết) nên có thể mọi người vào mỗi thời gian thì sẽ thấy nội dung nó khác nhau.

![Alt text](https://www.zimaspace.com/_ipx/w_3072&f_png/image/zimaos/meet-zimaos.png)

- ZimaOS dùng làm NAS server thì đúng bài, đẹp, tiện nhẹ, có bán sẵn Server luôn, tên là ZimaCube, trông vuông vuông gọn gọn nhìn đẹp cực
- À tại sao tui lại cài Ubuntu Server á, dễ xài nhất rồi :) có gì fix cho khỏe. Hiện giờ daily tui dùng Debian, rất quen với package apt của nhà Debian rồi.
# Check ip

- Để SSH vào mà cài luôn
```zsh
ip a | grep 192.168
```
- Lười, list ip ra rồi pick thằng 192.168 luôn, của mình là **192.168.88.155**, quá ngon ta đã có địa chỉ của nhà người yêu rồi. Giờ ta sẽ nhắn tin, alo rủ ẻm đi chơi => SSH

```zsh
ssh hihi@192.168.88.155
```

-  Nếu lười nhập pass mỗi lần SSH thì làm cách này, ở máy local, tạo một file **~/.ssh/config**
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

- WireGuard xịn sò hơn mà config lằng nhằng quá, từ bỏ luôn, hiện dùng mỗi Tailscale nhanh, tiện, sướng
- Ref doc đi: https://tailscale.com/kb/1031/install-linux
- Nói chung là chạy lệnh này cài
```zsh
curl -fsSL https://tailscale.com/install.sh | sh
```
- Cài xong thì **sudo tailscale up** Login vào để nhận device là xong

# Tunnel: Cloudflare

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
- Doc là chân ái, ráng vào Ctrl + C/V đi anh zai
- Cài xong run được cái container hello-world chưa chắc ngon đâu nha, check **docker ps** phát xem thử có bị bug permission không? Sửa ở đây (https://stackoverflow.com/questions/48957195/how-to-fix-docker-permission-denied), lỗi do user hiện tại chưa được thêm vào  group á mà, 99.9% cài mới docker đều bị :) gặp hoài luôn 

