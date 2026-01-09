---
title: Java Pojo
published: 2025-01-19
description: 'Plain Old Java Object - What is it?'
image: "https://www.boardinfinity.com/blog/content/images/2023/05/Pojo-class-in-java.png"
tags: [Java]
category: 'Công nghệ'
draft: false
lang: ''
---

# POJO

> ### What is POJO?
>
> - Can't Extend anything
> - Can't Implement anything
> - No outside annotaion

```java
public class Cat {

  int age;
  String name;

}
```

- Not a POJO!

```java
public class Cat implements Animals {

  int age;
  String name;

  @Override
  public void run(){
    System.out.println(String.format("%s can be run", this.name));
  }

}
```
