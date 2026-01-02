---
title: Java 8 - Một bước tiến lớn trong lịch sử Java
published: 2025-01-18
description: "Tại sao Java 8 phổ biến đến vậy?"
image: https://hanam88.com/images/posts/091144-21122023-lambda-java8.jpg
tags: [Java, Java 8]
category: Công nghệ
draft: false
lang: ""
---

Java ra đời vào năm 1995, trải qua rất nhiều phiên bản, từ Java 1 (1996) đến Java 8 (2014). Mỗi phiên bản đều mang lại những cải tiến, những tính năng mới. Tuy nhiên, Java 8 là một bước tiến lớn trong lịch sử Java. Với Java 8, Java đã bắt kịp với các ngôn ngữ lập trình hiện đại hơn, giúp lập trình viên viết code ngắn gọn, dễ đọc hơn, với lambda expression, stream API, Optional, ...

```java
package com.lcaohoanq.java8;

import java.util.List;

public class Main {

    public static void main(String[] args) {
        System.out.println("Hello Java 8");

        List<String> list = List.of("Java", "Kotlin", "Scala", "Groovy", "C#", "Python", "Ruby", "JavaScript");

        for (String lang : list) {
            System.out.println(lang);
            //if want to filter
            if (lang.equals("Java")) {
                System.out.println("Java is the best");
            }
        }

        // Java 8
        list.forEach(lang -> System.out.println(lang));
        list.stream().filter(lang -> lang.equals("Java")).forEach(lang -> System.out.println("Java is the best"));

    }

}
```

- Bạn có thể thấy, với Java 8, việc sử dụng lambda expression, stream API giúp code ngắn gọn, dễ đọc hơn rất nhiều so với trước đây.

# Stream API

- Stream API giúp xử lý dữ liệu một cách linh hoạt, dễ dàng hơn. Với Stream API, bạn có thể thực hiện các thao tác như filter, map, reduce, collect, ...

```java
public class Main {

    public static void main(String[] args) {
        List<String> list = List.of("Java", "Kotlin", "Scala", "Groovy", "C#", "Python", "Ruby",
                                    "JavaScript");

        // Filter
        list.stream().filter(lang -> lang.equals("Java")).forEach(lang -> System.out.println(lang));

        // Map
        list.stream().map(lang -> lang.toUpperCase()).forEach(lang -> System.out.println(lang));

        // Reduce
        String result = list.stream().reduce("", (acc, lang) -> acc + lang);
        System.out.println(result);

        // Collect
        List<String> result = list.stream().filter(lang -> lang.startsWith("J"))
            .collect(Collectors.toList());
        System.out.println(result);

        List<String> words = Arrays.asList("hello", "world", "java", "is", "cool", "cool");
//words.add("not cool");

//Array.asList is immutable, cannot change size of the list

        words.stream().forEach(System.out::println);
        words.stream().filter(item -> item.length() > 3).forEach(System.out::println);
        words.stream().findAny().ifPresent(
            s -> System.out.println(s + "123")
        );
        words.stream().findFirst().ifPresent(
            s -> System.out.println(s + "123")
        );
        words.stream().distinct().forEach(System.out::println); //removed the duplicate
    }
}
```

# Functional Interface

- An interface that have only one "abstract method"
- Combine lambda using

```java

@FunctionalInterface
public interface MyFunctionalInterface {

    void myMethod();
}

class Main {

    public static void main(String[] args) {
        MyFunctionalInterface myFunctionalInterface = () -> System.out.println("Hello");
        myFunctionalInterface.myMethod();
    }

}
```

# Lambda Expression

# Method Reference

# Optional

- A container object which may or may not contain a non-null value. If a value is present, isPresent() will return true and get() will return the value.

```java
public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByEmail(String email);

}

class Main {

    public static void main(String[] args) {
        UserRepository userRepository = new UserRepositoryImpl();
        Optional<User> user = userRepository.findByEmail("example@gmail.com");
        if (user.isPresent()) {
            System.out.println(user.get());
        }
    }
}

```

# New Date Time API

# Default Method

- An interface can have default method, which is a method with implementation in interface, and can be override in class that implement this interface.

```java
public interface DefaultInterface {

    default void myDefaultMethod() {
        System.out.println("My default method");
    }

    void honk();
}

class DefaultInterfaceImpl implements DefaultInterface {

    @Override
    public void honk() {
        System.out.println("Honk honk");
    }
}

class Student implements DefaultInterface {

    @Override
    public void myDefaultMethod() {
        System.out.println("Student default method");
    }

    @Override
    public void honk() {
        System.out.println("Honk honk");
    }
}

class Main {
    public static void main(String[] args) {
        DefaultInterface defaultInterface = new DefaultInterfaceImpl();
        defaultInterface.myDefaultMethod(); // My default method
        defaultInterface.honk(); // Honk honk

        DefaultInterface student = new Student();
        student.myDefaultMethod(); // Student default method
    }
}

```

# Nashorn JavaScript Engine

# Parallel Stream

- Stream API can be used in parallel to increase the performance of the application.

```java
public class Main {

    public static void main(String[] args) {
        List<String> list = List.of("Java", "Kotlin", "Scala", "Groovy", "C#", "Python", "Ruby",
                                    "JavaScript");

        // Parallel Stream
        list.parallelStream().forEach(lang -> System.out.println(lang));
    }
}
```

# Collectors

- Collectors are used to combine the result of processing on the elements of a stream. Collectors can be used to return a list or a string.

```java
public class Main {

    public static void main(String[] args) {
        List<String> list = List.of("Java", "Kotlin", "Scala", "Groovy", "C#", "Python", "Ruby",
                                    "JavaScript");

        // Collect
        List<String> result = list.stream().filter(lang -> lang.startsWith("J"))
            .collect(Collectors.toList());
        System.out.println(result);

        String result = list.stream().collect(Collectors.joining(", "));
        System.out.println(result);
    }
}
```
