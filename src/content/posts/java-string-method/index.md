---
title: Java String Method
published: 2025-01-29
description: ""
image: "String-pool-1.png"
tags: [Java]
category: 'Công nghệ'
draft: false
lang: "en"
---

# Comprehensive Guide to Java String Methods (JDK 17)

## Introduction

String is one of the most fundamental and widely used classes in Java. This comprehensive guide covers all the important String methods available in JDK 17, complete with examples and practical use cases.

## Basic String Methods

### Length and Character Access

#### `length()`

Returns the length (number of characters) in the string.

```java
String text = "Hello World";
int length = text.length(); // Returns 11
```

#### `charAt(int index)`

Returns the character at the specified index (0-based).

```java
String text = "Hello";
char ch = text.charAt(0); // Returns 'H'
// Throws StringIndexOutOfBoundsException if index is negative or >= length()
```

#### `toCharArray()`

Converts the string to a character array.

```java
String text = "Hello";
char[] chars = text.toCharArray(); // Returns ['H', 'e', 'l', 'l', 'o']
```

### String Comparison Methods

#### `equals(Object anObject)`

Compares string content for exact equality.

```java
String str1 = "Hello";
String str2 = "Hello";
boolean isEqual = str1.equals(str2); // Returns true
```

#### `equalsIgnoreCase(String anotherString)`

Compares string content ignoring case differences.

```java
String str1 = "Hello";
String str2 = "hello";
boolean isEqual = str1.equalsIgnoreCase(str2); // Returns true
```

#### `compareTo(String anotherString)`

Compares two strings lexicographically.

```java
String str1 = "apple";
String str2 = "banana";
int result = str1.compareTo(str2); // Returns negative value
```

### Search and Position Methods

#### `indexOf(String str)`

Returns the index of the first occurrence of the specified substring.

```java
String text = "Hello World";
int index = text.indexOf("World"); // Returns 6
int notFound = text.indexOf("Java"); // Returns -1
```

#### `lastIndexOf(String str)`

Returns the index of the last occurrence of the specified substring.

```java
String text = "Hello Hello World";
int index = text.lastIndexOf("Hello"); // Returns 6
```

#### `contains(CharSequence sequence)`

Checks if the string contains the specified sequence.

```java
String text = "Hello World";
boolean contains = text.contains("World"); // Returns true
```

### Modification Methods

#### `substring(int beginIndex)`

Returns a substring from the specified index to the end.

```java
String text = "Hello World";
String sub = text.substring(6); // Returns "World"
```

#### `substring(int beginIndex, int endIndex)`

Returns a substring from beginIndex to endIndex-1.

```java
String text = "Hello World";
String sub = text.substring(0, 5); // Returns "Hello"
```

#### `replace(char oldChar, char newChar)`

Replaces all occurrences of a character with another.

```java
String text = "Hello";
String replaced = text.replace('l', 'w'); // Returns "Hewwo"
```

#### `replaceAll(String regex, String replacement)`

Replaces all substrings matching the regex pattern.

```java
String text = "Hello 123 World 456";
String replaced = text.replaceAll("\\d+", ""); // Returns "Hello  World "
```

### Trimming and Case Conversion

#### `trim()`

Removes leading and trailing whitespace.

```java
String text = "  Hello World  ";
String trimmed = text.trim(); // Returns "Hello World"
```

#### `strip()` (Added in JDK 11)

Similar to trim() but Unicode-aware.

```java
String text = "\u2000Hello World\u2000";
String stripped = text.strip(); // Returns "Hello World"
```

#### `toLowerCase()` and `toUpperCase()`

Converts string to lower or upper case.

```java
String text = "Hello World";
String lower = text.toLowerCase(); // Returns "hello world"
String upper = text.toUpperCase(); // Returns "HELLO WORLD"
```

### String Joining and Splitting

#### `join(CharSequence delimiter, CharSequence... elements)`

Joins multiple strings with a delimiter.

```java
String joined = String.join("-", "Java", "is", "awesome"); // Returns "Java-is-awesome"
```

#### `split(String regex)`

Splits string into array based on regex.

```java
String text = "Java,Python,JavaScript";
String[] languages = text.split(","); // Returns ["Java", "Python", "JavaScript"]
```

### Modern String Methods (JDK 11+)

#### `isBlank()`

Returns true if string is empty or contains only whitespace.

```java
String text = "   ";
boolean isBlank = text.isBlank(); // Returns true
```

#### `lines()`

Returns a stream of lines from the string.

```java
String text = "Line 1\nLine 2\nLine 3";
Stream<String> lines = text.lines(); // Returns stream of three lines
```

#### `repeat(int count)`

Repeats the string n times.

```java
String text = "Ha";
String repeated = text.repeat(3); // Returns "HaHaHa"
```

## Performance Considerations

When working with strings in Java, keep these performance tips in mind:

1. String objects are immutable - each modification creates a new string
2. Use StringBuilder for multiple string concatenations
3. Pool string literals using intern() when appropriate
4. Consider using StringBuffer in multi-threaded environments

## Common Use Cases and Best Practices

1. Input Validation

```java
public boolean isValidEmail(String email) {
    return email != null 
           && !email.isBlank() 
           && email.contains("@")
           && email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
}
```

1. String Formatting

```java
String formatted = String.format("Hello, %s! You are %d years old.", name, age);
```

1. Text Processing

```java
public String cleanupText(String text) {
    return text.strip()
               .toLowerCase()
               .replaceAll("\\s+", " ")
               .replaceAll("[^a-z0-9\\s]", "");
}
```

## Conclusion

Java's String class provides a rich set of methods for string manipulation. Understanding these methods and their proper usage is crucial for efficient string processing in Java applications. Remember to consider performance implications when working with strings, especially in performance-critical applications.
