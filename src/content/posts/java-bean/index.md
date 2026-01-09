---
title: Java Bean
published: 2025-01-19
description: 'A bean named Java ^^'
image: "beans-blog.jpg"
tags: [Java]
category: 'Công nghệ'
draft: false
lang: ''
---

> ### A JavaBean is just a standard. It is a regular Java class, except it follows certain conventions
>
> - All properties are private
> - Public getters/setters
> - A public no-argument constructor (public all-argument constructor, optional)
> - Implements Serializable.

- Example code:

```java
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Student implements Serializable  {
  private int age;
  private String name;
}
```

# So why use JavaBeans?

The 'beans' of JavaBeans are classes that encapsulate one or more objects into a single standardized object (the bean). This standardization allows the beans to be handled in a more generic fashion, allowing easier code reuse and introspection
