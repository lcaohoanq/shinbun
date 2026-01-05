---
title: Tất tần tật về Docker
published: 2025-12-15
description: ''
image: "https://images.viblo.asia/fad7cf1a-772f-43e4-9042-e96d5d903b2b.png"
tags: [Docker, Containerization, DevOps]
category: 'Công nghệ'
draft: true
lang: 'vi'
---

# Docker là gì?

> Triết lí: Build one run anywhere

1. Docker là nền tảng dùng để đóng gói, phân phối và triển khai application
2. Container là môi trường ảo hóa `độc lập, hoàn chỉnh, dễ thay thế`: chứa chương trình và các gói bổ sung cho chương trình chính

- Độc lập: chương trìn bên trong container không thể biết và truy cập đến các chương trình bên ngoài
- Hoàn chỉnh: container chứa đầy đủ những gì application cần
- Dễ thay thế: Container thường nhẹ nên dễ xóa cũ, tạo mới. Không mất thời gian. Khả năng scaling cao
---
# Tại sao lại sử dụng Container

- Khi phát triển một ứng dụng, thì ta cần phải triển khai trên nhiều môi trường khác nhau
  - Development
  - QA
  - Production
- Những môi trường ở những điều kiện hoàn toàn khác nhau nên nếu môi trường development chạy ổn thì chưa chắc những môi trường còn lại cũng vận hành trơn tru và ổn định.
---
# Docker context

- Chuyện là mình có 1 server vps, mình remote vào docker ps, docker images,.. docker logs -f nhiều quá mình lười, mà máy local mình setup sẵn đủ đồ chơi (như `lazydocker`), xài tiện hơn, nên mình muốn chạy mấy lệnh docker trên local nhưng thao tác trên con vps kia thì phải làm sao? **Docker context** sẽ giúp mình làm việc này

- Tạo ```context``` mới tên **vps**, kết nối qua ssh tới con remote server với
  - **username**: user
  - **ip**: remote-server-ip
  - *nhập pass ssh khi được hỏi*

```zsh
docker context create vps --docker "host=ssh://user@remote-server-ip"
```

- Chuyển qua lại giữa các context
  - Chuyển sang context vps
  ```zsh
  docker context use vps
  ```
  - Chuyển về context mặc định (local)
  ```zsh
  docker context use default
  ```

- Liệt kê các context

```zsh
❯ docker context ls
NAME         DESCRIPTION                               DOCKER ENDPOINT               ERROR
default      Current DOCKER_HOST based configuration   unix:///var/run/docker.sock
fpt *                                                  ssh://fpt
fpt-server                                             ssh://hoang@123.456.789.000
```

- Ở đây mình có 3 context
  - **default**: context mặc định, thao tác trên máy local
  - **fpt**: context kết nối tới con server fpt (alias là fpt, này config trong ```~/.ssh/config``` rồi)
  - **fpt-server**: context kết nối tới con server (username: hoang, ip: 123.456.789.000)


- Đây là alias trong file ```~/.ssh/config``` của mình, bạn có thể tham khảo để cấu hình ssh cho tiện nhé

```zsh
❯ cat ~/.ssh/config
Host *
    ControlMaster auto
    ControlPath ~/.ssh/sockets/%r@%h-%p
    ControlPersist 600

Host fpt
    HostName 123.456.789.000
    User root
    IdentityFile ~/.ssh/id_gitlab_lcaohoanq

Host w520
    HostName 192.168.88.155
    User lcaohoanq
    Port 1604
    IdentityFile ~/.ssh/id_ed25519
    ServerAliveInterval 30
    ServerAliveCountMax 3
```

- Xóa context

```zsh
docker context rm vps
```

- Xem chi tiết context hiện tại

```zsh
docker context inspect
```

- Xem help của docker context

```zsh
❯ docker context --help
Usage:  docker context COMMAND

Manage contexts

Commands:
  create      Create a context
  export      Export a context to a tar archive FILE or a tar stream on STDOUT.
  import      Import a context from a tar or zip file
  inspect     Display detailed information on one or more contexts
  ls          List contexts
  rm          Remove one or more contexts
  show        Print the name of the current context
  update      Update a context
  use         Set the current docker context

Run 'docker context COMMAND --help' for more information on a command.
```
---
# Những ứng dụng hay dùng
- Đồ chơi sẽ để ở đây, rất cảm ơn bác **ChristianLempa** đã chia sẻ bộ đồ chơi khủng long này: https://github.com/lcaohoanq/boilerplates
- Đây là những app mình hay xài nhất

> 1. postgres: (https://hub.docker.com/_/postgres)
  - Nhớ để ý password nhé, được mount ra file secret.postgres_password.txt và đọc ngược vào runtime container
  - docker compose up -d bla bla bla, health check -> healthy -> ngon chạy
  - giờ mình muốn tạo nhanh một db tên **bit_learning**, nếu gà: ê launch tiếp cái container dbgate nữa =)))) để tạo bằng ui, vì sao mình không chọn pgadmin mà dbgate vì một là nó nhẹ hơn, 2 là nó hỗ trợ được nhiều loại db thay vì chỉ mỗi postgres
  - cánh nhanh nhất exec vào shell tạo luôn
    - docker exec -it <tìm id của postgres bằng docker ps> bash
    - ```zsh
      root@e620c11bfca0:/# ls
      bin   dev			 etc	lib    media  opt   root  sbin	sys  usr
      boot  docker-entrypoint-initdb.d  home	lib64  mnt    proc  run   srv	tmp  var
      root@e620c11bfca0:/# psql -U postgres
      psql (17.4 (Debian 17.4-1.pgdg120+2))
      Type "help" for help.

      postgres=# SHOW DATABASES;
      postgres=# CREATE DATABASE bit_learning;
      CREATE DATABASE
      postgres=# \l
                                                            List of databases
           Name     |  Owner   | Encoding | Locale Provider |  Collate   |   Ctype    | Locale | ICU Rules |   Access privileges
      --------------+----------+----------+-----------------+------------+------------+--------+-----------+-----------------------
       bit_learning | postgres | UTF8     | libc            | en_US.utf8 | en_US.utf8 |        |           |
       postgres     | postgres | UTF8     | libc            | en_US.utf8 | en_US.utf8 |        |           |
       template0    | postgres | UTF8     | libc            | en_US.utf8 | en_US.utf8 |        |           | =c/postgres          +
                    |          |          |                 |            |            |        |           | postgres=CTc/postgres
       template1    | postgres | UTF8     | libc            | en_US.utf8 | en_US.utf8 |        |           | =c/postgres          +
                    |          |          |                 |            |            |        |           | postgres=CTc/postgres
      (4 rows)

      ```
     - \l (suyệt e lờ) để SHOW DATABASE nhóe
