---
title: Cách cài Cloudflare Family Filter trên Windows, Linux và Mobile
published: 2026-10-06
description: "Hướng dẫn cài đặt Cloudflare Family Filter trên Windows, Linux, iOS và Android để chặn nội dung người lớn và các tên miền độc hại."
image: "image.png"
tags: ["Cloudflare", "Family Filter", "Windows", "Linux", "Mobile", "Parental Control"]
category: "Công nghệ"
draft: false
lang: "vi"
---

# Cloudflare Family Filter là gì?

Cloudflare Family Filter là dịch vụ DNS của Cloudflare dành cho gia đình, giúp **chặn các tên miền chứa nội dung người lớn và malware**.

Cloudflare cung cấp hai địa chỉ DNS cho Family Filter:

### IPv4
```text
1.1.1.3
1.0.0.3
```

### IPv6
```text
2606:4700:4700::1113
2606:4700:4700::1003
```

Trong bài viết này, mình sẽ hướng dẫn cách cấu hình Cloudflare Family Filter trên Windows, Linux, iOS và Android.

> **Lưu ý:** DNS filtering chỉ hoạt động ở mức tên miền. Nếu thiết bị sử dụng VPN, DNS-over-HTTPS (DoH), DNS-over-TLS (DoT) hoặc một DNS resolver khác thì DNS Filter có thể bị bypass.

---

## Windows

### 1. Sử dụng PowerShell

Mở PowerShell với quyền **Administrator**.

* **IPv4** (Nếu bạn đang sử dụng IPv4):
  ```powershell
  netsh interface ipv4 set dnsservers name="Wi-Fi" static 1.1.1.3 primary
  netsh interface ipv4 add dnsservers name="Wi-Fi" 1.0.0.3 index=2
  ipconfig /flushdns
  ```

* **IPv6** (Để cấu hình IPv6):
  ```powershell
  netsh interface ipv6 set dnsservers name="Wi-Fi" static 2606:4700:4700::1113 primary
  netsh interface ipv6 add dnsservers name="Wi-Fi" 2606:4700:4700::1003 index=2
  ipconfig /flushdns
  ```

> *Mẹo:* Nếu tên adapter mạng của bạn không phải `Wi-Fi`, hãy thay thế bằng tên adapter tương ứng (ví dụ: `Ethernet`). Bạn có thể kiểm tra tên adapter bằng lệnh:
> ```powershell
> netsh interface show interface
> ```

---

### 2. Cấu hình bằng giao diện Windows

Nếu không muốn sử dụng command line, bạn có thể làm theo các bước sau:

1. Mở **Control Panel**.
2. Chọn **Network and Internet** → **Network and Sharing Center**.
3. Chọn **Change adapter settings**.
4. Nhấp chuột phải vào kết nối mạng đang sử dụng và chọn **Properties**.
5. Chọn một trong hai giao thức:
   * *Internet Protocol Version 4 (TCP/IPv4)*
   * *Internet Protocol Version 6 (TCP/IPv6)*
6. Chọn **Properties**.
7. Chọn **Use the following DNS server addresses** và nhập thông tin tương ứng:

* **IPv4:**
  * *Preferred DNS server:* `1.1.1.3`
  * *Alternate DNS server:* `1.0.0.3`

* **IPv6:**
  * *Preferred DNS server:* `2606:4700:4700::1113`
  * *Alternate DNS server:* `2606:4700:4700::1003`

---

## Linux

Trên Linux, cách cấu hình DNS phụ thuộc vào network stack mà phân phối (distro) của bạn đang sử dụng. Hai trường hợp phổ biến nhất là **NetworkManager** và **systemd-resolved**.

### Trường hợp 1: NetworkManager

Kiểm tra trạng thái NetworkManager:
```bash
systemctl is-active NetworkManager
```
Nếu kết quả là `active`, bạn có thể sử dụng công cụ `nmcli`.

1. Xem danh sách connection:
   ```bash
   nmcli connection show
   ```
   *(Ví dụ connection có tên là "Wi-Fi")*.

2. Cấu hình DNS:
   * **IPv4:**
     ```bash
     nmcli connection modify "Wi-Fi" \
       ipv4.dns "1.1.1.3 1.0.0.3" \
       ipv4.ignore-auto-dns yes
     ```
   * **IPv6:**
     ```bash
     nmcli connection modify "Wi-Fi" \
       ipv6.dns "2606:4700:4700::1113 2606:4700:4700::1003" \
       ipv6.ignore-auto-dns yes
     ```

3. Reconnect lại kết nối để áp dụng:
   ```bash
   nmcli connection down "Wi-Fi"
   nmcli connection up "Wi-Fi"
   ```

4. Kiểm tra lại:
   ```bash
   nmcli device show | grep -E 'IP4.DNS|IP6.DNS'
   ```

---

### Trường hợp 2: systemd-resolved

Nếu distro của bạn sử dụng `systemd-resolved`:

1. Kiểm tra trạng thái:
   ```bash
   systemctl is-active systemd-resolved
   ```
   Nếu kết quả là `active`, bạn có thể sử dụng `resolvectl`.

2. Xác định tên interface mạng bằng lệnh:
   ```bash
   ip -br addr
   ```
   *Ví dụ output:*
   ```text
   lo        UNKNOWN
   enp2s0    UP
   wlan0     UP
   tailscale0 UNKNOWN
   ```
   *(Trong trường hợp này, interface Wi-Fi là `wlan0`).*

3. Cấu hình DNS cho interface (ví dụ `wlan0`):
   ```bash
   sudo resolvectl dns wlan0 \
     1.1.1.3 \
     1.0.0.3 \
     2606:4700:4700::1113 \
     2606:4700:4700::1003
   ```

4. Kiểm tra trạng thái:
   ```bash
   resolvectl status
   ```

> **Lưu ý:** Lệnh `resolvectl dns` có thể chỉ áp dụng cho runtime hiện tại. Tùy thuộc vào Network Manager hoặc distro, DNS có thể bị ghi đè sau khi khởi động lại. Để cấu hình lâu dài (persistent), bạn nên cấu hình trực tiếp thông qua network manager của hệ thống.

---

## Kiểm tra DNS

Sau khi hoàn tất cấu hình, bạn có thể kiểm tra xem DNS đã hoạt động chính xác chưa:

* **Sử dụng resolvectl (trên Linux):**
  ```bash
  resolvectl status
  ```

* **Sử dụng dig:**
  ```bash
  dig example.com
  ```
  Hoặc kiểm tra trực tiếp qua Cloudflare Family DNS:
  ```bash
  dig @1.1.1.3 example.com
  ```

* **Kiểm tra thông qua cURL:**
  ```bash
  curl https://1.1.1.1/cdn-cgi/trace
  ```
  Tìm dòng bắt đầu bằng `ip=` và kiểm tra các thông tin resolver tương ứng hiển thị.

---

## Mobile

Trên điện thoại di động, cách cấu hình DNS sẽ phụ thuộc vào hệ điều hành.

### 1. iOS (iPhone / iPad)

1. Mở **Settings** → **Wi-Fi** → Nhấn vào biểu tượng **ⓘ** bên cạnh mạng Wi-Fi đang kết nối.
2. Cuộn xuống chọn **Configure DNS** và chuyển sang chế độ **Manual**.
3. Xóa các DNS server cũ (nếu có) và thêm các địa chỉ mới:
   * `1.1.1.3`
   * `1.0.0.3`
   * (Tùy chọn IPv6): `2606:4700:4700::1113` và `2606:4700:4700::1003`
4. Nhấn **Save** ở góc trên bên phải.

---

### 2. Android

Cách đơn giản và hiện đại nhất trên Android là sử dụng **Private DNS** (nếu phiên bản Android của bạn hỗ trợ):

1. Vào **Settings** → **Network & Internet** *(hoặc Connections tùy dòng máy)* → **Private DNS**.
2. Chọn tùy chọn **Private DNS provider hostname**.
3. Nhập vào ô hostname giá trị sau:
   ```text
   family.cloudflare-dns.com
   ```
4. Nhấn **Save**.

> *Mẹo:* Cách này sử dụng giao thức bảo mật DNS-over-TLS (DoT) và tự động áp dụng cả IPv4/IPv6 mà không cần thiết lập thủ công từng dòng. Tên menu có thể thay đổi nhẹ tùy theo nhà sản xuất (Samsung, Xiaomi, OPPO, Google Pixel, v.v.).