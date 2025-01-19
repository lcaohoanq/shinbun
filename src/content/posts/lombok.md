---
title: Project Lombok
published: 2025-01-18
description: "Lombok - Best Java Library"
image: https://miro.medium.com/v2/resize:fit:1400/0*xei_MJc3VW4mUAKx.jpg
tags: [Java, Java Libary]
category: Tech
draft: false
lang: ""
---

- Let's learn about most popular Java library - Lombok, with most useful, popular annotations.

> ### Getter, SetterAnnotation
>
> - @Getter
> - @Setter

```java
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GetterSetter {

    private int id;
    private String name;

    @Setter(AccessLevel.PROTECTED)
    private int yob;

    /*
        Above annotation is specify the access level of the setter method.

        protected void setYob (int yob){
            this.yob = yob;
        }
    */

    public GetterSetter(int id, String name, int yob) {
        this.id = id;
        this.name = name;
        this.yob = yob;
    }

    public static void main(String[] args) {
        System.out.println(new GetterSetter(1, "Hoang", 1999).getYob());
    }

}
```

> ### ToString Annotation
>
> - @ToString

```java
import lombok.AllArgsConstructor;

//@lombok.ToString //ToString(id=1, name=Hoang, surname=Le)
//@lombok.ToString(includeFieldNames = false) //ToString(1, Hoang, Le)
//@lombok.ToString(exclude = "id") //ToString(name=Hoang, surname=Le)
@lombok.ToString(of = {"name", "surname"}) //ToString(name=Hoang, surname=Le)

@AllArgsConstructor
public class ToString {

    private int id;
    private String name;
    private String surname;

    public static void main(String[] args) {
        System.out.println(new ToString(1, "Hoang", "Le"));
    }

    /*
        @lombok.ToString: default with option (includeFieldNames = true), will return ToString(id=1, name=Hoang, surname=Le)
        @lombok.ToString(includeFieldNames = false) //ToString(1, Hoang, Le)

        All non-static, non-transient fields are printed. If you want to exclude some fields, you can use the exclude parameter.
        @lombok.ToString(exclude = "id") //ToString(name=Hoang, surname=Le)

        Otherwise, you can select each field you wish to be taken into account.
        @lombok.ToString(of = {"name", "surname"}) //ToString(name=Hoang, surname=Le)
     */

}
```

> ### Data Annotation
>
> - @Data

```java
@lombok.Data
public class Data {

    /* @lombok.Data will generate the following methods:
        - Getter for all fields
        - Setter for all non-final fields
        - equals, hashCode, and toString methods
        - Constructor with all final fields
    */

    private final int id;
    private final String birthPlace;
    private String name;
    private String surname;

    public static void main(String[] args) {
        Data data = new Data(1,"1"); //only the id is required to be initialized
        //Data data2 = new Data(1,"Hoang","Vietnam") //error
        System.out.println(data);
    }

}
```

> ### ...ArgsConstructor Annotation
>
> - @NoArgsConstructor
> - @AllArgsConstructor
> - @RequiredArgsConstructor

```java
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

@NoArgsConstructor(force = true)
@AllArgsConstructor
@RequiredArgsConstructor
public class ArgsConstructor {

    private int id;
    private String name;
    private String surname;
    private final String birthPlace; //the final field is required to be initialized in the constructor

    /*
    // @NoArgsConstructor
    public Author() {}

    // @AllArgsConstructor
    public Author(int id, String name, String surname, String birthPlace) {
      this.id = id
      this.name = name
      this.surname = surname
      this.birthPlace = birthPlace
    }

    // @RequiredArgsConstructor
    public Author(String birthPlace) {
      this.birthPlace = birthPlace
    }
    */

    public static void main(String[] args) {
        ArgsConstructor author = new ArgsConstructor(1, "Hoang", "Le", "Vietnam");
        System.out.println(author);
    }

}
```
