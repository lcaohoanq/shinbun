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

# Docker ps

Ps (Process): liệt kê các container đang chạy

```zsh
docker ps
```

Kết quả

```zsh
CONTAINER ID   IMAGE                          COMMAND                  CREATED       STATUS                   PORTS                                                                                                                         NAMES
ed22890229b4   redpandadata/redpanda:latest   "/entrypoint.sh redp…"   13 days ago   Up 9 minutes (healthy)   0.0.0.0:9092-9093->9092-9093/tcp, [::]:9092-9093->9092-9093/tcp, 8081-8082/tcp, 0.0.0.0:9644->9644/tcp, [::]:9644->9644/tcp   redpanda
1b3f04a6ea11   postgres:17.4                  "docker-entrypoint.s…"   4 weeks ago   Up 9 minutes (healthy)   0.0.0.0:5432->5432/tcp, [::]:5432->5432/tcp                                                                                   postgres
98d8d145d49d   redis:7.2.3                    "docker-entrypoint.s…"   4 weeks ago   Up 9 minutes (healthy)   0.0.0.0:6379->6379/tcp, [::]:6379->6379/tcp                                                                                   redis-container
7ed17a84f912   dpage/pgadmin4                 "/entrypoint.sh"         4 weeks ago   Up 9 minutes             443/tcp, 0.0.0.0:5050->80/tcp, [::]:5050->80/tcp                                                                              pgadmin
```

- Thêm `-a` để liệt kê tất cả container (kể cả dừng)

```zsh
docker ps -a
```

Kết quả

```zsh
CONTAINER ID   IMAGE                          COMMAND                  CREATED        STATUS                     PORTS                                                                                                                         NAMES
dd51ff8cd1c7   proxmox_ui-app                 "/usr/local/bin/dock…"   16 hours ago   Exited (1) 9 hours ago                                                                                                                                   proxmox-lxc-app
ed22890229b4   redpandadata/redpanda:latest   "/entrypoint.sh redp…"   13 days ago    Up 9 minutes (healthy)     0.0.0.0:9092-9093->9092-9093/tcp, [::]:9092-9093->9092-9093/tcp, 8081-8082/tcp, 0.0.0.0:9644->9644/tcp, [::]:9644->9644/tcp   redpanda
dbe274fc116b   postgres:16-alpine             "docker-entrypoint.s…"   2 weeks ago    Exited (0) 2 weeks ago                                                                                                                                   crazy_brown
30f7215138cf   amir20/dozzle:latest           "/dozzle"                4 weeks ago    Exited (0) 4 weeks ago                                                                                                                                   nice_easley
00b2b3e5370c   job-hunter-api                 "java -jar app.jar"      4 weeks ago    Exited (143) 4 weeks ago                                                                                                                                 job_hunter_backend
2dc1af9953fa   phpmyadmin:5                   "/docker-entrypoint.…"   4 weeks ago    Exited (0) 3 weeks ago                                                                                                                                   phpmyadmin_ui
34ed0964f7d4   mysql:8.0                      "docker-entrypoint.s…"   4 weeks ago    Exited (0) 3 weeks ago                                                                                                                                   mysql
1b3f04a6ea11   postgres:17.4                  "docker-entrypoint.s…"   4 weeks ago    Up 9 minutes (healthy)     0.0.0.0:5432->5432/tcp, [::]:5432->5432/tcp                                                                                   postgres
98d8d145d49d   redis:7.2.3                    "docker-entrypoint.s…"   4 weeks ago    Up 9 minutes (healthy)     0.0.0.0:6379->6379/tcp, [::]:6379->6379/tcp                                                                                   redis-container
7ed17a84f912   dpage/pgadmin4                 "/entrypoint.sh"         4 weeks ago    Up 9 minutes               443/tcp, 0.0.0.0:5050->80/tcp, [::]:5050->80/tcp                                                                              pgadmin
350dc94561e0   getmeili/meilisearch:v1.29.0   "tini -- /bin/sh -c …"   4 weeks ago    Exited (143) 4 weeks ago                                                                                                                                 bit-learning-be-meilisearch-1
```

- Thêm `--format` để định dạng output theo ý muốn, thay vì loc cột bằng `awk`

  - ```zsh docker ps -a | awk '{print $1, $2, $NF}'``` : lấy cột CONTAINER, IMAGE, NAMES (nhưng CONTAINER ID có khoảng trắng)

  - ```zsh docker ps -a | awk 'NR==1 {print "CONTAINER_ID IMAGE NAME"} NR>1 {print $1, $2, $NF}```: in ra header cho đẹp

Cách đơn giản hơn với `--format`

```zsh
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"
```

Kết quả

```zsh
❯ docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Names}}"

CONTAINER ID   IMAGE                          NAMES
dd51ff8cd1c7   proxmox_ui-app                 proxmox-lxc-app
ed22890229b4   redpandadata/redpanda:latest   redpanda
dbe274fc116b   postgres:16-alpine             crazy_brown
30f7215138cf   amir20/dozzle:latest           nice_easley
00b2b3e5370c   job-hunter-api                 job_hunter_backend
2dc1af9953fa   phpmyadmin:5                   phpmyadmin_ui
34ed0964f7d4   mysql:8.0                      mysql
1b3f04a6ea11   postgres:17.4                  postgres
98d8d145d49d   redis:7.2.3                    redis-container
7ed17a84f912   dpage/pgadmin4                 pgadmin
350dc94561e0   getmeili/meilisearch:v1.29.0   bit-learning-be-meilisearch-1
```

- Thay vì thủ công lọc bằng `grep`, ta có thể dùng `--filter` để lọc kết quả, `status` nằm trong các options sau:
  - created
  - running
  - paused
  - restarting
  - removing
  - exited
  - dead

```zsh
docker ps --filter "status=exited"
```

Kết quả

```zsh
CONTAINER ID   IMAGE                          COMMAND                  CREATED        STATUS                     PORTS     NAMES
dd51ff8cd1c7   proxmox_ui-app                 "/usr/local/bin/dock…"   16 hours ago   Exited (1) 9 hours ago               proxmox-lxc-app
dbe274fc116b   postgres:16-alpine             "docker-entrypoint.s…"   2 weeks ago    Exited (0) 2 weeks ago               crazy_brown
30f7215138cf   amir20/dozzle:latest           "/dozzle"                4 weeks ago    Exited (0) 4 weeks ago               nice_easley
00b2b3e5370c   job-hunter-api                 "java -jar app.jar"      4 weeks ago    Exited (143) 4 weeks ago             job_hunter_backend
2dc1af9953fa   phpmyadmin:5                   "/docker-entrypoint.…"   4 weeks ago    Exited (0) 3 weeks ago               phpmyadmin_ui
34ed0964f7d4   mysql:8.0                      "docker-entrypoint.s…"   4 weeks ago    Exited (0) 3 weeks ago               mysql
350dc94561e0   getmeili/meilisearch:v1.29.0   "tini -- /bin/sh -c …"   4 weeks ago    Exited (143) 4 weeks ago             bit-learning-be-meilisearch-1
```

Dừng container theo điều kiện lọc

```zsh
docker ps --filter "status=running" --format "{{.ID}}" | xargs docker stop
```

- Giải thích:
  - Lấy ID của các container đang chạy
  - Dùng `xargs` để truyền từng ID vào lệnh **docker stop**

Dừng tất cả container đang chạy

```zsh
docker stop $(docker ps -a -q)
```

---

# Những ứng dụng hay dùng

- Đồ chơi sẽ để ở đây, rất cảm ơn bác **ChristianLempa** đã chia sẻ bộ đồ chơi khủng long này: <https://github.com/lcaohoanq/boilerplates>
- Đây là những app mình hay xài nhất

> 1. postgres: (<https://hub.docker.com/_/postgres>)
>
- Nhớ để ý password nhé, được mount ra file secret.postgres_password.txt và đọc ngược vào runtime container
- docker compose up -d bla bla bla, health check -> healthy -> ngon chạy
- giờ mình muốn tạo nhanh một db tên **bit_learning**, nếu gà: ê launch tiếp cái container dbgate nữa =)))) để tạo bằng ui, vì sao mình không chọn pgadmin mà dbgate vì một là nó nhẹ hơn, 2 là nó hỗ trợ được nhiều loại db thay vì chỉ mỗi postgres
- cánh nhanh nhất exec vào shell tạo luôn
  - docker exec -it <tìm id của postgres bằng docker ps> bash

  - ```zsh
      root@e620c11bfca0:/# ls
      bin   dev    etc lib    media  opt   root  sbin sys  usr
      boot  docker-entrypoint-initdb.d  home lib64  mnt    proc  run   srv tmp  var
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

  - `\l` (suyệt e lờ) để SHOW DATABASE nhóe
