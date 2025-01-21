---
title: OOP in Java
published: 2025-01-21
description: ''
image: "https://media2.dev.to/dynamic/image/width=1600,height=900,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fjnjgfl10cn4tm9qlztv1.png"
tags: [Java]
category: 'Tech'
draft: false
lang: 'vi'
---

# OOP là gì?

> - OOP (Object-Oriented Programming) là một phương pháp lập trình dựa trên các đối tượng, hướng về đối tượng.

### Khoan đã, vậy đối tượng gì?
> - Đối tượng là một thực thể, một thứ gì đó có thể nhìn thấy, chạm vào, cảm nhận được. Ví dụ: một con mèo, một chiếc xe, một người, Đối tượng có 2 đặc điểm chính là thuộc tính (property|attribute) và hành vi, phương thức (behaviour| method | function).

- Ví dụ: Một đối tượng `User` có các thuộc tính như `userID`, `fullName`, `roleID`, `password`. Các hành vi như `login()`.

```java
public class UserDTO {
    private String userID;
    private String fullName;
    private String roleID;
    private String password;

    public UserDTO() {
    }

    public UserDTO(String userID, String fullName, String roleID, String password) {
        this.userID = userID;
        this.fullName = fullName;
        this.roleID = roleID;
        this.password = password;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean authenticate(String fullName, String password) {
        return this.fullName.equals(fullName) && this.password.equals(password);
    }

}
```

- Tối ưu hơn với Lombok

```java
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserDTO {
    private String userID;
    private String fullName;
    private String roleID;
    private String password;
    public Boolean authenticate(String fullName, String password) {
        return this.fullName.equals(fullName) && this.password.equals(password);
    }

}
```

- Với Java 16+ sử dụng `record`

```java
public record UserDTO(
  String userID,
  String fullName,
  String roleID,
  String password
){
    public Boolean authenticate(String fullName, String password) {
        return this.fullName.equals(fullName) && this.password.equals(password);
}
```

# 4 tính chất của OOP
- **Tính kế thừa (Inheritance)**: Là khả năng một lớp con kế thừa tất cả các thuộc tính và phương thức từ lớp cha.
- **Tính đóng gói (Encapsulation)**: Là khả năng che giấu thông tin, chỉ cho phép truy cập thông qua các phương thức.
- **Tính đa hình (Polymorphism)**: Là khả năng một phương thức có thể thực thi nhiều hành vi khác nhau.
- **Tính trừu tượng (Abstraction)**: Là khả năng tạo ra các lớp trừu tượng, không thể khởi tạo đối tượng từ lớp trừu tượng.

## 1. Tính kế thừa (Inheritance)

- Kế thừa là một tính chất cho phép một lớp mới được tạo ra dựa trên một lớp đã tồn tại. Lớp mới được gọi là lớp con, lớp đã tồn tại được gọi là lớp cha.

- Đặc biệt trong Java, một lớp chỉ có thể kế thừa từ một lớp cha duy nhất.

- Dưới đây là một ví dụ đơn giản, tính kế thừa sẽ phức tạp hơn khi ta kết hợp với các access modifier cho properties và method (từ khóa **super**)

```java
public class Animal {
    public void eat() {
        System.out.println("Eating...");
    }
}

public class Dog extends Animal {
    public void bark() {
        System.out.println("Barking...");
    }
}

public class Cat extends Animal {
    public void meow() {
        System.out.println("Meowing...");
    }
}

public class Main{
    public static void main(String[] args) {
        Dog dog = new Dog();
        dog.eat(); // Eating...
        dog.bark(); // Barking...

        Cat cat = new Cat();
        cat.eat(); // Eating...
        cat.meow(); // Meowing...
    }
}
```

## 2. Tính đóng gói (Encapsulation)

- Đóng gói là một tính chất cho phép che giấu thông tin, chỉ cho phép truy cập thông qua các phương thức.

- Trong Java, chúng ta sử dụng access modifier để quy định quyền truy cập của properties và method.

- Best practice: Sử dụng **private** cho properties và **public** cho getter và setter.

```java
public class User {
    private String username;
    private String password;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
```

## 3. Tính đa hình (Polymorphism)

- Đa hình là một tính chất cho phép một phương thức có thể thực thi nhiều hành vi khác nhau.

- Đa hình có 2 loại: **Compile-time Polymorphism** (Overloading) và **Runtime Polymorphism** (Overriding).

### 3.1. Compile-time Polymorphism (Overloading)

- Overloading là việc tạo nhiều phương thức cùng tên nhưng khác nhau về số lượng tham số hoặc kiểu dữ liệu của tham số.

```java
public class Calculator {
    public int add(int a, int b) {
        return a + b;
    }

    public int add(int a, int b, int c) {
        return a + b + c;
    }
}
```

### 3.2. Runtime Polymorphism (Overriding)

- Overriding là việc một lớp con thay đổi cách thức hoạt động của một phương thức đã được định nghĩa trong lớp cha nhưng **không thay đổi**:
> - access modifier
> - tên phương thức
> - kiểu trả về
> - tham số.

```java
public class Animal {
    public void sound() {
        System.out.println("Animal makes sound");
    }
}

public class Dog extends Animal {
    @Override
    public void sound() {
        System.out.println("Dog barks");
    }
}

public class Cat extends Animal {
    @Override
    public void sound() {
        System.out.println("Cat meows");
    }
}

public class Main {
    public static void main(String[] args) {
        Animal animal = new Dog();
        animal.sound(); // Dog barks

        animal = new Cat();
        animal.sound(); // Cat meows
    }
}
```

## 4. Tính trừu tượng (Abstraction)

- Trừu tượng là một tính chất cho phép tạo ra các lớp trừu tượng, không thể khởi tạo đối tượng từ lớp trừu tượng.

- Trong Java, chúng ta sử dụng từ khóa **abstract** để tạo ra lớp trừu tượng và phương thức trừu tượng. Hàm abstract sẽ chưa được implement ở lớp cha, mà sẽ được implement ở lớp con, tăng tính linh hoạt và tái sử dụng code.

- Chú ý
  - một class abstract thì không thể khởi tạo đối tượng từ nó nhưng có thể khởi tạo đối tượng từ lớp con của nó.
  - một phương thức abstract không có body, chỉ có declaration.
  - một class abstract có thể có hoặc không có phương thức là abstract, nhưng nếu một class có ít nhất một phương thức abstract thì class đó phải là abstract.

```java
public abstract class Animal {
    public abstract void sound();
}

public class Dog extends Animal {
    @Override
    public void sound() {
        System.out.println("Dog barks");
    }
}

public class Cat extends Animal {
    @Override
    public void sound() {
        System.out.println("Cat meows");
    }
}

public class Main {
    public static void main(String[] args) {
        //Animal animal = new Animal();
        // Error: Cannot instantiate the type Animal

        Animal animal = new Dog();
        animal.sound(); // Dog barks

        animal = new Cat();
        animal.sound(); // Cat meows
    }
}
```
