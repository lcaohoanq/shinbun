---
title: Abstract Class vs Interface in Java
published: 2025-01-21
description: '2 cái này sao mà dễ nhầm lẫn quá vậy ta?'
image: "hihi.png"
tags: [Java]
category: 'Công nghệ'
draft: false
lang: ''
---

## Difference between Abstract class and Interface

| **Points**        | **Abstract Class**                                                              | **Interface**                                                                                   |
|-------------------|---------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
| **Type of Methods**| Can have both abstract and concrete methods                                     | Can have only abstract methods (until Java 7), from Java 8 can have default and static methods, and from Java 9 can have private methods |
| **Variables**      | Can have final, non-final, static, and non-static variables                     | Only static and final variables                                                                  |
| **Inheritance**    | Can extend only one class (abstract or not)                                     | A class can implement multiple interfaces                                                        |
| **Constructors**   | Can have constructors                                                          | Cannot have constructors                                                                         |
| **Implementation** | Can provide the implementation of interface methods                            | Cannot provide the implementation of abstract class methods                                      |
