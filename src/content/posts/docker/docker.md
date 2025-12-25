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

# Tại sao lại sử dụng Container

- Khi phát triển một ứng dụng, thì ta cần phải triển khai trên nhiều môi trường khác nhau
  - Development
  - QA
  - Production
- Những môi trường ở những điều kiện hoàn toàn khác nhau nên nếu môi trường development chạy ổn thì chưa chắc những môi trường còn lại cũng vận hành trơn tru và ổn định.

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
