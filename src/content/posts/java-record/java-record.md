---
title: Java Record Class
published: 2025-01-18
description: "A new feature in Java 14"
image: https://getlearntech.com/wp-content/uploads/2024/06/Java-Record-Big-1024x535.png
tags: [Java]
category: Công nghệ
draft: false
lang: ""
---

# Java Record Class

Introduced in **Java 14** as a preview feature, and officially released in **Java 16**, the `record` keyword allows for a simplified, concise way to create **immutable data classes**. A record class in Java implicitly defines:

- **Final fields** for the record components.
- A **constructor** that initializes the fields.
- **Getters** (accessor methods) for each field.
- `equals()`, `hashCode()`, and `toString()` methods.

## Why Use Records?

Before records, developers had to manually define getters, constructors, and often override methods like `toString()` and `equals()` for simple data holder classes. Records reduce this boilerplate code, focusing on data immutability and reducing the potential for errors.

## Syntax

A simple record declaration looks like this:

```java
public record Person(String name, int age) {}

This is equivalent to:

public class Person {
    private final String name;
    private final int age;

    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String name() {
        return name;
    }

    public int age() {
        return age;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Person person = (Person) o;
        return age == person.age && Objects.equals(name, person.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, age);
    }

    @Override
    public String toString() {
        return "Person[name=" + name + ", age=" + age + "]";
    }
}

Features of Records

1. Immutability

Fields in a record are final by default, making record instances immutable. This means once an object is created, its state cannot be modified.

2. Compact Syntax

Records eliminate the need for manually writing constructors, getters, and overriding methods. Everything is automatically generated.

3. Custom Constructors

You can still define custom constructors for validation or data transformation:

public record Person(String name, int age) {
    public Person {
        if (age < 0) {
            throw new IllegalArgumentException("Age cannot be negative");
        }
    }
}

4. Custom Methods

Although records are concise, you can add custom methods to enrich their functionality:

public record Person(String name, int age) {
    public String greeting() {
        return "Hello, my name is " + name;
    }
}

5. Compatibility with Serialization

Records are inherently compatible with Java’s serialization mechanisms, and they implement the Serializable interface by default.

Limitations
	•	No inheritance: Records cannot extend other classes, though they can implement interfaces.
	•	No setters: Records are designed to be immutable, so fields are final and cannot be modified once set.
	•	Cannot be abstract: Records are concrete data types and cannot be marked as abstract.

Example of Record with Interface

Records can implement interfaces, allowing more complex behavior:

public record Rectangle(double length, double width) implements Shape {
    @Override
    public double area() {
        return length * width;
    }
}

Conclusion

Java records simplify the creation of immutable data classes by reducing boilerplate code. They provide built-in support for immutability, concise syntax, and automatically generated methods, making them ideal for situations where classes are used primarily for storing data.

