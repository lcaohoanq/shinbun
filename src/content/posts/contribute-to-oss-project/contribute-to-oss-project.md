---
title: Chuyện đóng góp vào dự án nào đó trên Github
published: 2025-12-29
description: 'Source này có bug nè'
image: "https://images.unsplash.com/photo-1586372291391-4a70098d643e?q=80&w=1170&auto=format&fit=crop"
tags: [Github, OSS, Contribution, Docker, Microservices, Containerized Application]
category: 'Công nghệ'
draft: true
lang: 'vi'
---

> Chuyện là mình có clone một source về chạy (source microservices docker compose) như hướng dẫn

- emart-docker-compose.txt

```zsh
# Clone source code of Emart App
git clone https://github.com/devopshydclub/emartapp.git
ls
cd emartapp/
ls

# Bring up  containers from docker-compose file
vim docker-compose.yaml
docker compose up -d
docker compose ps
docker ps -a
ip addr show

# Go to browser enter http://VMIp:80

# Clean up
docker compose down
docker system prune -a
exit
exit
vagrant halt
```

- Oke làm tới **docker compose up -d** thì lỗi image notfound, thằng openjdk-8 không pull được

```Dockerfile
FROM openjdk:8 AS BUILD_IMAGE    # Lỗi ở đây
WORKDIR /usr/src/app/
RUN apt update && apt install maven -y
COPY ./ /usr/src/app/
RUN mvn install -DskipTests

FROM openjdk:8

WORKDIR /usr/src/app/
COPY --from=BUILD_IMAGE /usr/src/app/target/book-work-0.0.1-SNAPSHOT.jar ./book-work-0.0.1.jar

EXPOSE 9000
ENTRYPOINT ["java","-jar","book-work-0.0.1.jar"]
# Test
```

- Vậy là mình lên google search thử "openjdk 8 docker image not found" thì ra kết quả là thằng openjdk 8 đã bị deprecate rồi, thay vào đó dùng thằng **eclipse-temurin:8-jdk** debian-base (temurin là tên mới của adoptopenjdk) và tinh chỉnh cho gọn lại

```Dockerfile
FROM eclipse-temurin:8-jdk AS build
WORKDIR /app

COPY . .
RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests

FROM eclipse-temurin:8-jdk
WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 9000
ENTRYPOINT ["java","-jar","app.jar"]
```

> Á chết mình quên fork source về từ đầu rồi sửa, giờ mình muốn tạo PR thì làm sao nhỉ?

# 1. Fork về (lười vãi không skip bước này về được)

- Fork về github cá nhân

# 2. Set add fork remote

```zsh
git remote -v

# origin	https://github.com/devopshydclub/emartapp.git (fetch)
# origin	https://github.com/devopshydclub/emartapp.git (push)

git remote add fork git@github.com:lcaohoanq/emartapp.git

git remote -v

# fork	git@github.com:lcaohoanq/emartapp.git (fetch)
# fork	git@github.com:lcaohoanq/emartapp.git (push)
# origin	https://github.com/devopshydclub/emartapp.git (fetch)
# origin	https://github.com/devopshydclub/emartapp.git (push)
```

# 3. Tạo branch mới và Push lên fork remote

- Nên tạo một branch mới theo convention branch

```zsh
git checkout -b fix-dockerfile-openjdk-image
```

- Push thay đổi

```zsh
git commit -am "Fix Dockerfile openjdk image not found issue"
git push fork fix-dockerfile-openjdk-image
```

- Cuối cùng thì vào github cá nhân tạo PR từ branch **fix-dockerfile-openjdk-image** lên repo gốc là xong

> Chú ý là set-url dùng ssh thay vì https để khỏi bị hỏi password liên tục nhé, nếu nhầm thì có thể sửa lại set-url với ssh nha:

```zsh
git remote set-url fork git@github.com:lcaohoanq/emartapp.git
```
