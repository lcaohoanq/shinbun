---
title: Java Record Class
published: 2025-02-06
description: "A new feature in Java 14"
image: https://getlearntech.com/wp-content/uploads/2024/06/Java-Record-Big-1024x535.png
tags: [Java]
category: Công nghệ
draft: false
lang: ""
---

Introduced as a **preview feature** in **Java 14** and officially released in **Java 16**, the `record` keyword provides a simplified, concise way to create **immutable data classes**. Records remove much of the boilerplate code required for traditional Java classes by automatically generating several methods, focusing on immutability and data representation.

## Why Use Records?

Before records, developers had to manually define fields, constructors, getters, and often override methods like `equals()`, `hashCode()`, and `toString()` for simple data classes. This was time-consuming and error-prone, especially for data-centric classes where the main concern is holding and manipulating data.

### Key Features of Records:
- **Immutability**: Record fields are `final` by default.
- **Concise Syntax**: Automatic generation of constructors, getters, and core methods.
- **No inheritance**: Records cannot extend other classes but can implement interfaces.
- **Serialization**: Records implement `Serializable` by default.

## Syntax

Here's a simple `record` declaration:

```java
public record Person(String name, int age) {}
```

This is equivalent to the following traditional Java class:

```java
public class Person {
    private final String name;
    private final int age;

    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Person person = (Person) o;
        return age == person.age && name.equals(person.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, age);
    }

    @Override
    public String toString() {
        return "Person{name='" + name + "', age=" + age + "}";
    }
}
```

As you can see, the `record` class dramatically reduces boilerplate code, automatically generating:
- A constructor,
- Getter methods (e.g., `name()` and `age()`),
- `equals()`, `hashCode()`, and `toString()`.

## Example with Lombok

Before the introduction of `record`, Lombok was a popular way to avoid boilerplate. Lombok provides annotations like `@Data` and `@AllArgsConstructor` to generate similar code automatically.

Here's an example using Lombok:

```java
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Person {
    private final String name;
    private final int age;
}
```

While Lombok reduces boilerplate, it requires adding external dependencies and annotations to achieve similar results. With `record`, Java natively supports immutability and concise syntax, making it a more natural fit for modern Java applications.

## Advantages of Records over Lombok and Other Approaches

- **Native Support**: Records are built into Java, requiring no external dependencies.
- **Concise Syntax**: Records are more succinct, reducing code to just the essentials.
- **Immutability**: Records enforce immutability by default, enhancing data safety.
- **Cleaner Code**: No need for annotations or external libraries like Lombok for basic data structures.

## Custom Constructors and Methods

While records provide a default constructor and methods, you can define custom behavior when necessary.

### Custom Constructor:

```java
public record Person(String name, int age) {
    public Person {
        if (age < 0) {
            throw new IllegalArgumentException("Age cannot be negative");
        }
    }
}
```

### Custom Method:

```java
public record Person(String name, int age) {
    public String greeting() {
        return "Hello, my name is " + name;
    }
}
```

## Example of Record with Interface

Records can implement interfaces, which allows for more flexible data classes:

```java
public record Rectangle(double length, double width) implements Shape {
    @Override
    public double area() {
        return length * width;
    }
}
```

## Limitations of Records
- **No Inheritance**: Records cannot extend other classes.
- **No Setters**: Fields in records are `final`, enforcing immutability.
- **Concrete Class**: Records cannot be abstract.

## Conclusion

Java `record` classes provide a clean, concise, and efficient way to define immutable data classes with minimal boilerplate code. For simple data holders, records offer a better alternative to traditional classes and even tools like Lombok by leveraging native Java features. They simplify the development process, ensuring immutability, providing automatic method generation, and helping developers focus on functionality rather than repetitive code.

Records are the future of immutable data structures in Java, offering a more efficient and readable way to work with data-centric objects.

> Ref:
> - [Baeldung java-record-keyword](https://www.baeldung.com/java-record-keyword)