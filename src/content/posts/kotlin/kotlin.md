---
title: Kotlin 101
published: 2025-01-19
description: ''
image: https://images.prismic.io/qovery/c952e642-7c8c-4e2f-854e-b14a14868b3e_kotlin.png?ixlib=gatsbyFP&auto=compress%2Cformat&fit=max
tags: [Kotlin]
category: 'Công nghệ'
draft: false
lang: ''
---

> ### Documentation
> - https://github.com/lcaohoanq/kotlin
> - https://kotlinlang.org/docs/kotlin-reference.pdf

# Variables and data types

```kotlin
fun getDataType() {

    println("Hello world")
    var x = 5 //this is a variable
    var m: Int = 120
    println("x is : $x, a = $m")
    //you can change value of a variable
    x = 6
    println("x now is : $x")
    val y = 44 //val = cannot be assigned
    //y = 55
    //function = a block of code
    sayHello("Hoang")
    println("sum 2 and 3 is : ${sum(2.0, 3.0)}")
    //you can use labeled arguments
    println("sum 4 and 5 is : ${sum(x = 4.0, y = 5.0)}")

    // Data types
    val a: Int = 10000
    val d: Double = 100.00
    val f: Float = 100.00f
    val l: Long = 1000000004
    val s: Short = 10
    val b: Byte = 1
    val isExistingUser: Boolean = true
    val c: Char = 'a'
    println("Your Int Value is $a")
    println("Your Double  Value is $d")
    println("Your Float Value is $f")
    println("Your Long Value is $l")
    println("Your Short Value is $s")
    println("Your Byte Value is $b")
    println("Your Boolean Value is $isExistingUser")
    println("Your Char Value is $c")

    // Unsigned integer types: UByte(8), UShort(16), UInt(32), ULong(64)
    // Min value are 0
    // Utilizing the full bit range of an integer to represent positive values.

    val hoang: Any? = null //nullable type
    val hehe: Any = "Hello world!!!"
    if (hehe is Any)
        if (hehe is String) println("hehe is String") else println("hehe is not String")
    else println("hehe is null")

    /*
    Unit: A function that returns no meaningful value but still completes normally.
    Nothing: A function that never returns a value because it either throws an exception
    or doesn't terminate normally.
    */

}

// Can also omit the return type since `Unit` is implied
fun sayHelloV2(): Unit {
    println("Hello, World!")
}

// Used for functions that terminate abnormally
fun fail(message: String): Nothing {
    throw IllegalArgumentException(message)
}

fun process(value: Int?) {
    val nonNullValue = value ?: fail("Value cannot be null")
    println(nonNullValue)
}
```

## var and val
- `var` is used to declare a mutable variable (a variable that can be reassigned after it's been initialized).
- `val` is used to declare an immutable variable (a variable that cannot be reassigned after it's been initialized).

```kotlin
var name = "John"
name = "Doe" // OK

val age = 20
age = 21 // Error
```

# Condition

```kotlin
import enums.Quality

fun main() {
    ifConditions()
    whenConditions()
}

fun ifConditions() {

    val score = 80
    if (score > 50) {
        println("Passed")
    } else {
        println("Failed")
    }

    if (score > 50) println("Passed") else if (score == 50) println("Just Passed") else println("Failed")

    val isPassed = if (score > 50) true else false
    println(isPassed)

    val isPassed2 = if (score > 50) {
        println("Passed")
        "I love you very much" //last line is the return value
    } else {
        println("Failed")
        false
    }
    println(isPassed2)

}

fun whenConditions() {
    val quality: Quality = Quality.GOOD
    val qualityMessage: String = when (quality) {
        //when = switch-case
        Quality.BAD -> "This is bad"
        Quality.NORMAL -> "Quality is normal"
        Quality.GOOD -> "Yes, it is Good"
        Quality.EXCELLENT -> "Wooo, excellent"
    }
    println(qualityMessage)

    val score = 80
    when (score) {
        in 0..50 -> println("Failed")
        in 51..70 -> println("Normal")
        in 71..90 -> {
            println("Good")
            println("Keep it up")
        }

        in 91..100 -> println("Excellent")
        else -> println("Invalid score")
    }

    when (score) {
        1, 4, 5 -> println("One")
        in 2..10 -> println("From 2 to 10")
        !in 10..20 -> println("Not in 10 to 20")
        80 -> {
            println("Eighty")
            println("Keep it up")
        }

        else -> println("Invalid score")
    }

    //If your when expression doesn't have a subject, you must have an else branch or the compiler throws an error.
    // The else branch is evaluated when none of the other branch conditions are satisfied:
    when {
        score > 50 -> println("Passed")
        score == 50 -> println("Just Passed")
        else -> println("Failed")
    }

}
```

# OOP

# Enum

```kotlin
// Enum class without properties
enum class Quality {
    BAD, NORMAL, GOOD, EXCELLENT
}

// Enum class with properties
enum class RequestError(val message: String) {
  BAD_REQUEST("Invalid request"),
  INTERNAL_ERROR("Internal Server Error"),
  SUCCESS("Server processes request successfully");
  //you can define more methods here
  fun wordCount() = message.trim()
    .split("\\s+".toRegex()).size
}
```

# Static
```kotlin
class Calculation {
    //companion object = static in Java
    companion object {
        fun multiply(x: Int, y:Int):Int = x * y
        val PI = 3.1416
    }
}
```

# Deligate

```kotlin
import kotlin.properties.Delegates
import kotlin.reflect.KProperty
import storage.MyDBRepository
import storage.MySQLRepository

fun main(){

    //now we talk about delegate, interface
    //var repository = IStorageRepository() //cannot init an object from interface !
    val connectionString = "Server=myServerAddress;Database=myDataBase;Uid=myUsername;Pwd=myPassword;"
    var repository: MySQLRepository = MySQLRepository(connectionString)
    //println(repository)
    var myDBRepository = MyDBRepository(connectionString)
    myDBRepository.makeConnection(connectionString)
    //Delegated properties = make a separated class which override getter/setter
    val user5 = User(11, "Ted", "ted@gmail.com")
    user5.age = 30
    println(user5.age)
    //some standard delegates: lazy, observable
    println(user5.description)
    //create object from key-value map
    val productA = Product(
        mapOf(
            "name" to "iphone 4",
            "price" to 2000
        )
    )
    println(productA)
    //observable property => when property's value changes => a function is run
    productA.description = "hehe"
    productA.description = "haha"
    //property's type is Int
    productA.count = 2
    productA.count = 3
    productA.count = -1 //count still 3 because -1 < 0
    println(productA.count)

}


class Product(val map: Map<String, Any>) {
  val name: String by map
  val price: Int by map
  override fun toString(): String {
    return "name: $name, price: $price"
  }
  //observable property
  var description: String by Delegates.observable("Initial value"){
      property, oldValue, newValue ->
    println("${property.name}: $oldValue -> $newValue")
  }
  //observable with validation = Vetoable
  var count: Int by Delegates.vetoable(0) {
      property, oldValue, newValue ->
    println("${property.name}: $oldValue -> $newValue")
    newValue > 0//validation
  }
}

  data class User(val id:Int, var name:String, var email:String) {
  //you can also which properties determine "equal"
  override fun equals(other: Any?): Boolean {
    return other is User
      && this.id == other.id
      && this.email == email
  }
  //property
  var age:Int by UserDelegate()
  //you can also rewrite the hashCode method
  override fun hashCode(): Int {
    return id + name.hashCode() + email.hashCode()
  }
  //lazy delegates
  val description:String by lazy {
    "id:$id, name: $name, email: $email"
  }
}
class UserDelegate {
  private var value:Int = 0
  //getter
  operator fun getValue(user: User, property: KProperty<*>): Int {
    println("Call getValue of ${property.name}")
    return value
  }
  operator fun setValue(user: User, property: KProperty<*>, i: Int) {
    println("Call setValue of ${property.name}")
    value = i
  }
}

interface IStorageRepository {
  fun makeConnection(connectionString: String)
}

class MyDBRepository(connectionString: String):IStorageRepository
by MySQLRepository(connectionString) {
}

class MySQLRepository(val connectionString: String): IStorageRepository {
  override fun makeConnection(connectionString: String) {
    println("connect MySQL DB with $connectionString")
  }
}
```

# Exception

```kotlin
import com.sun.org.apache.xerces.internal.impl.dv.xs.IntegerDV

/*
    - Unchecked exceptions are exceptions that are not checked at compile-time
    - Checked exceptions are exceptions that are checked at compile-time

    try-catch-finally block
*/

/*
    In Java your functions are something like this

    void foo() throws IOException{
        throw new IOException();
    }
    In Kotlin, all exceptions are unchecked, meaning that the compiler does not force you to catch any of them
    But in Kotlin you can add annotation like below to force other Java classes to catch it.
    However, as other answers have pointed out, it doesn't have any meaning among Kotlin classes.

    @Throws(IOException::class)
    fun foo() {
        throw IOException()
    }
*/

open class DataAlreadyExistException(message: String?) : RuntimeException(message)

class RoleAlreadyExistException(message: String?) : DataAlreadyExistException(message)

fun main() {
    //multiple catch blocks
    try {
        throw RoleAlreadyExistException("Role already exists")
    } catch (e: RoleAlreadyExistException) {
        println("Caught RoleAlreadyExistException")
    } catch (e: DataAlreadyExistException) {
        println("Caught DataAlreadyExistException")
    } catch (e: RuntimeException) {
        println("Caught RuntimeException")
    } finally {
        println("Finally block")
    }

//    val str = getNumber("10") //Works fine
    val str = getNumber("10.5") //Must pass a Double or Float instead
    println(str)

}

fun getNumber(str: String): Int {
    return try {
        Integer.parseInt(str)
    } catch (e: NumberFormatException) {
        0
    }
}

//nested try-catch block
fun nestedTryCatch() {
    try {
        try {
            throw IllegalArgumentException("Illegal argument")
        } catch (e: IllegalArgumentException) {
            println("Caught IllegalArgumentException")
        }
    } catch (e: RuntimeException) {
        println("Caught RuntimeException")
    }
}
```

# Collections

```kotlin
/*Collections of only the same element
    - IntArray - Integer
    - DoubleArray - Double
    - LongArray - Long
    - ShortArray - Short
    - ByteArray - Byte
    - BooleanArray - Boolean

Collections of the same or different elements
    - arrayOf<String>
    - arrayOf<Int>
    - arrayOf<Fruit>
    - array(1,2,"Hoang", 3.0, Fruit())

Immutable Collections
    - listOf (List)
    - setOf (Set)
    - mapOf (Map)

Mutable Collections
    - arrayListOf, mutableListOf (MutableList) - ArrayList: java
    - hashSetOf, mutableSetOf (MutableSet) - HashSet: java
    - hashMapOf, mutableMapOf (MutableMap) - HashMap: java
*/

fun main() {

//    val numbers: IntArray = intArrayOf(1, 2, 3, 4, 5)
    val numbers: IntArray = intArrayOf(1, 2, 3, 4, 5)
    val numbers2 = IntArray(5) // [0, 0, 0, 0, 0]
    val numbers2_1: IntArray = IntArray(5) { 42 } // [42, 42, 42, 42, 42]
    val numbers2_2 = IntArray(5) { it * 2 } // [0, 2, 4, 6, 8]
    val numbers2_3 = IntArray(5) { (it + 1) * 2 } // [2, 4, 6, 8, 10]

    val numbers3: Array<Int> = arrayOf<Int>(1,2,4,6) //Integer[] in Java, boxed type, less memory efficient
    val numbers4 = arrayOf<Any>(1,"a", Student())

    println(numbers) // hashcode
    println(numbers.contentToString()) // [1, 2, 3, 4, 5]
    println(numbers[3]) // 4
    numbers[2] = 10
    //println(numbers[10]) // ArrayIndexOutOfBoundsException
    //numbers[10] = 10 // ArrayIndexOutOfBoundsException
    for(element in numbers) {
        println("element:  $element")
        println(" $element + 2") // 1 + 2 2 + 2 3 + 2 4 + 2 5 + 2
        println(" ${element + 2}") // 3 4 5 6 7
        //the value is changed only in the loop scope
    }
    numbers.forEach {
        print("$it ") // 1 2 3 4 5
    }

    numbers.forEachIndexed { index, value ->
        println("index: $index, value: $value")
    }

    /* indices: Returns an IntRange of the valid indices for this collection.

    indices returns IntRange(range of index from first to the last position) of collection, for example:
    val array= arrayOf(10,20,30,40,50,60,70)
    println("Indices: "+array.indices) // output: Indices: 0..6
    */
    for(index in numbers.indices) {
        println("index: $index, value: ${numbers[index]}")
    }


}
```

# List
```kotlin
package collections/*
    Immutable List: list of elements that cannot be modified
    - listOf: create an immutable list
    - Access elements using indexing
    - Iterate over the list using for loop, forEach, listIterator

    Mutable List: list of elements that can be modified
    - mutableListOf: create a mutable list
    - Manipulate elements using add, remove, and set
    - Iterate over the list using for loop, forEach, listIterator
*/

import models.Car

fun immutableList() {
    val fruits = listOf("Apple", "Banana", "Cherry")

    val anyTypes: List<Any> = listOf(1, 2, "hello", 3.0, Car("GLB 200 7G-DCT", 82020, 1.3f, 163), true)
    println(anyTypes.size)
    println(anyTypes)

    // Accessing elements
    println(fruits) //[Apple, Banana, Cherry]
    println("First fruit: ${fruits[0]}, Second fruit: ${fruits[1]}")  // Output: First fruit: Apple
//    fruits[2] = "Orange"  // Error: Cannot modify elements in an immutable list

    fruits.listIterator().forEach { fruit -> print("$fruit, ") } //write in lambda

    fruits.listIterator(0).forEach { fruit -> print("$fruit, ") } //write in lambda

    fruits.forEach { fruit -> print("$fruit, ") } //write in lambda

    // Iterating over the list
    for (fruit in fruits) {
        print(
            """
            $fruit,
        """.trimIndent()
        )
    }

    // Checking if the list contains a specific element
    if ("Banana" in fruits) {
        println("Banana is in the list!")
    }

    /*
    listIterator(): Creates a list iterator for the list, allowing bidirectional iteration. Using forEach with listIterator() isn’t much different from iterating over the list itself, unless you need advanced iterator features.
    One common use case of ListIterator is when you need to move in both directions (i.e., forward and backward) through a list and maybe modify the elements while iterating
    listIterator(0): Same as listIterator(), but explicitly starts at index 0. This is redundant if you just want to iterate from the start.
    forEach: Directly iterates over the list in a concise and functional style. This is the most idiomatic approach in Kotlin for simple iteration.
    Traditional for loop: Standard iteration syntax, useful when you want more control (like using break or continue).
    */

    val iterator = fruits.listIterator()
    // Traverse forward through the list
    println("Traversing forward:")
    while (iterator.hasNext()) {
        val fruit = iterator.next()
        println(fruit)
    }

    // Traverse backward through the list
    println("\nTraversing backward:")
    while (iterator.hasPrevious()) {
        val fruit = iterator.previous()
        println(fruit)
    }

    println("Demo listIterator with specific index")
    fruits.listIterator(2).forEach { fruit -> print("$fruit, ") } //Output: Cherry,
    //fruits.listIterator(8).forEach { fruit -> print("$fruit, ") }
    /*
        Exception in thread "main" java.lang.IndexOutOfBoundsException: Index: 8, Size: 3
        at java.base/java.util.AbstractList.rangeCheckForAdd(AbstractList.java:632)
        at java.base/java.util.AbstractList.listIterator(AbstractList.java:338)
        at ListsKt.immutableList(lists.kt:51)
        at MainKt.main(main.kt:160)
        at MainKt.main(main.kt)
	*/
}

fun mutableList() {
    // Mutable list: elements can be added, removed, or modified
    val vegetables = mutableListOf("Carrot", "Broccoli", "Spinach")

    // Adding elements
    vegetables.add("Potato")
    vegetables.add(1, "Tomato")  // Insert at a specific index
    vegetables.addAll(listOf("Cabbage", "Lettuce"))  // Add multiple elements

    // Modifying elements
    /*
        The val keyword ensures that vegetables will always point to the same list object,
        meaning you cannot reassign vegetables to a different list or object.However, since mutableListOf creates a mutable list,
        the contents of the list can be changed. You can add, remove, or modify elements within the list without changing the reference itself.
    */
    vegetables[0] = "Cucumber"
    vegetables.removeAt(2)  // Remove element at index 2
    //vegetables.removeAll(vegetables) //[]
    println("Demo shuffle")
    vegetables.shuffle()  // Shuffle the elements
    println(vegetables)

    // Removing elements
    vegetables.remove("Spinach")
    vegetables.removeAt(2)  // Remove element at index 2

    // Iterating over the mutable list
    for (vegetable in vegetables) {
        println(vegetable)
    }

    vegetables.forEach(::println)
//    vegetables.forEach { println(ed) }
    vegetables.forEach { it -> println(it) }
    vegetables.forEach { println(it) } //it is default name of lambda parameter

    var someNumbers = mutableListOf<Int>(1, 3, 4, -2, 5, -3, 7)
    someNumbers.forEach {
        print("$it ")
    }
    if (someNumbers.any { it < 0 }) {
        println("At least 1 item is negative")
    }
    if (someNumbers.all { it < 100 }) {
        println("All items are < 100")
    }
    if (someNumbers.none { it == 100 }) {
        println("No item has value = 100")
    }
    val someFloats = mutableListOf<Float>(3.5f, 2.3f, 4.6f, 1.8f)
    someFloats[0] = 22.2f
    println(someFloats)
    var cars = mutableListOf<Car>(
        Car("GLB 200 7G-DCT", 82020, 1.3f, 163),
        Car("GLB 200 d 8G-DCT", 2020, 119f, 150),
        Car("Lexus CT200H F SPORT", 2014, 109.7f, 136),
        Car("Lexus CT200H Hybrid", 2018, 119f, 150),
        Car(
            "Jetta Advance 1.6 TDI 105HP BlueMotion Technology DSG 7",
            2011, 97.5f, 105
        ),
        Car("Jetta Sport 1.4 TSI 160HP DSG 7 speed", 2011, 84.8f, 160),
        Car("Bentley Flying Spur W12", 2013, 243.7f, 528),
        Car("Bentley Brooklands 2008", 2007, 412.6f, 537),
        Car("Continental GTC 6.0 W12", 2019, 363.1f, 635),
        Car("Qashqai DIG-T 158 4WD Auto", 2021, 81.3f, 158),
        Car("Nissan Laurel JC32 2.8 D", 2020, 172.5f, 90),
    )
    println(cars)
    println("Add 1 car to the first item")
    cars.add(0, Car("Nissan Murano Z50 3.5 (234HP)", 2004, 213.5f, 234))
    println("Add to the last item")
    cars.add(Car("Bentley 8 Litre", 1930, 487.2f, 230))
    cars.forEach {
        println(it)
    }
    //filter cars which year is between 2013 and 2016
    var filteredCars = cars.filter { it.year in 2013..2016 }
    //find cars which name contains "lexus"
    filteredCars = cars.filter { it.name.contains("lexus", ignoreCase = true) }
    println("filtered cars:")
    for (item in filteredCars) {
        println(item)
    }
    println("sort the list, by horsePower")
    //var sortedCars = cars.sortedBy { it.horsePower }
    val sortedCars = cars.sortedByDescending { it.horsePower }
    sortedCars.forEach {
        println(it)
    }
    //get car's name and add to a separated list
    val carNames = cars.map { it.name }
    carNames.forEach { println(it) }
    println("There are ${carNames.count()} cars")
    println("First name: ${carNames.first()}, last name: ${carNames.last()}")
    //split/partition a list
    var (newerCars, olderCars) = cars.partition { it.year > 2019 }
    //minimum, maximum
    println(cars.minOf { it.horsePower })
    println(cars.maxOf { it.horsePower })
}

fun listMixed() {
    val mixedList: List<Any> = listOf("Apple", 123, true, 45.67)

    // Iterating over a mixed-type list
    for (element in mixedList) {
        println(element)
    }

}

fun manipulationList() {
    val numbers = listOf(1, 2, 3, 4, 5)

// map: transform each element
    val doubled = numbers.map { it * 2 }
    println(doubled)  // Output: [2, 4, 6, 8, 10]

// filter: filter elements based on a condition
    val evens = numbers.filter { it % 2 == 0 }
    println(evens)  // Output: [2, 4]

// find: find the first element matching a condition
    val firstEven = numbers.find { it % 2 == 0 }
    println(firstEven)  // Output: 2

// reduce: combine all elements
    val sum = numbers.reduce { acc, num -> acc + num }
    println(sum)  // Output: 15

// sorted: sort the list
    val sortedNumbers = numbers.sortedDescending()
    println(sortedNumbers)  // Output: [5, 4, 3, 2, 1]

}

fun createEmptyList() {
    // Immutable empty list
    val emptyList = emptyList<String>()

    // Mutable empty list
    val mutableEmptyList = mutableListOf<String>()

    // Add elements to the mutable list
    mutableEmptyList.add("New Item")
    println(mutableEmptyList)  // Output: [New Item]

}

fun nestedList() {
    val listOfLists = listOf(
        listOf(1, 2, 3),
        listOf(4, 5, 6),
        listOf(7, 8, 9)
    )

// Accessing elements in a nested list
    println(listOfLists[0][1])  // Output: 2

// Iterating over a nested list
    for (sublist in listOfLists) {
        for (element in sublist) {
            println(element)
        }
    }

}

fun convertListType() {
    // Immutable list
    val immutableList = listOf("A", "B", "C")

    // Convert to mutable list
    val mutableList = immutableList.toMutableList()
    mutableList.add("D")

    // Convert back to immutable list
    val newImmutableList = mutableList.toList()

    println(newImmutableList)  // Output: [A, B, C, D]

}
```

# Array List
```kotlin
import Student

fun main(){

    //what is the difference between ArrayList<T> and mutableListOf<T>?
    //ArrayList<T> is a class, mutableListOf<T> is a function that returns a MutableList<T>
    //result are the same

    val fruits = mutableListOf("guava", "strawberry", "kiwi", "pear", "kiwi")

    val student: ArrayList<Student> = arrayListOf(Student("1", "Brown"), Student("2", "Smith"))

    val newStudent = ArrayList<Student>()
    newStudent.add(Student("1", "Brown"))
    newStudent.add(Student("2", "Smith"))

}
```

# Map
```kotlin
package collections

import Student

fun main() {

    val daysOfTheWeek = mapOf(
        1 to "Monday",
        2 to "Tuesday",
        3 to "Wednesday",
        4 to "Thursday",
        5 to "Friday",
        6 to "Saturday",
        7 to "Sunday"
    )

    println(daysOfTheWeek)
    println(daysOfTheWeek[2])
    daysOfTheWeek.forEach(::println)
    println(daysOfTheWeek.toSortedMap())

    for(key in daysOfTheWeek.keys){
        println("key: $key, value: ${daysOfTheWeek[key]}")
    }

    for((key, value) in daysOfTheWeek) {
        println("key: $key, value: $value")
    }

    for(entry in daysOfTheWeek.entries) {
        println("key: ${entry.key}, value: ${entry.value}")
    }

    daysOfTheWeek.forEach { (i, s) ->
        println("key: $i, value: $s")
    }

    val studentList = mapOf(
        "1" to Student("1", "Brown"),
        "2" to Student("2", "Smith"),
        "3" to Student("3", "Johnson")
    )

    val newDaysOfTheWeek = daysOfTheWeek.toMutableMap()
    newDaysOfTheWeek[8] = "New Day"

}
```

# Set
```kotlin
package collections

fun main(){

    val fruits = setOf("guava", "strawberry", "kiwi", "pear", "kiwi")
    println(fruits)
    println(fruits.contains("kiwi"))
    println(fruits.elementAt(2))
    println(fruits.elementAtOrNull(5))
    println(fruits.first())
    println(fruits.last())
    println(fruits.size)
    println(fruits.toSortedSet())
    println(fruits.sorted())
    println(fruits.shuffled())
    println(fruits.reversed())
    println(fruits.isEmpty())
    println(fruits.isNotEmpty())

    val mutableFruits = mutableSetOf("guava", "strawberry", "kiwi", "pear", "kiwi")
    mutableFruits.add("apple")
    mutableFruits.remove("kiwi")
    println(mutableFruits)

    //immutable list
    val newFruits = fruits.toMutableList()
    newFruits.add("apple")
    newFruits.remove("kiwi")
    println(newFruits)

}
```

# Class Type

```kotlin
import com.sun.org.apache.bcel.internal.generic.NEW
import java.util.UUID

//can omit the public constructor keyword
class Song public constructor(id: String, name: String) {
    val id: String = id
    val name: String = name
}

class Film private constructor(id: String, name: String) {
    var id: String = id
    val name: String = name
}

// open class can be inherited
open class Book protected constructor(id: String, name: String) {
    val id: String = id
    val name: String = name
}

class Lamp internal constructor(id: String, name: String) {
    val id: String = id
    val name: String = name
}

/*
Class with primary constructor,
do not require initialize the properties with default values
*/
class User(
    val id: String = UUID.randomUUID().toString(),
    val name: String = "Unknown"
) {
    var hobby: String? = null
        //custom getter, setter
        get() {
            println("get() is called")
            return field?.uppercase()
        }
        set(value) {
            field = if (value.isNullOrBlank()) "unknown" else value
        }

    var age: Int? = null
        private set

    lateinit var email: String //lateinit property must be var and cannot be nullable

    //initialize block
    init {
        println("User is created with id: $id, name: $name")
//        email = "hoang@gmail.com"
    }

    override fun toString(): String {
        return "User(id=$id, name=$name)"
    }

    //member constructor
    constructor(id: String, name: String, hobby: String, age: Int) : this(id, name) {
        this.hobby = hobby
        this.age = age
    }

    //member function
    fun stateHobby() {
        println("$name's hobby is $hobby")
    }

    fun stateAge() {
        println("$name's age is $age")
    }

}

class User2() {
    var id: String? = null
    var name: String? = null

    override fun toString(): String {
        return "User2(id=$id, name=$name)"
    }
}

abstract class Person {
    abstract val id: String
    abstract val name: String
    abstract fun sayHello()
}

// nested class: in Kotlin, nested class is static by default,
// so its data member and member function can be accessed without creating an object of the class
// nested class cannot access the outer class's members
class School {
    data class Student(
        val id: String,
        val name: String
    )
}

// inner class: nested class which is marked as "inner" is called inner class
// the advantages is inner class can access the outer class's members even if it is private
class School2 {

    private val schoolName = "ABC School"

    inner class Student(
        val id: String,
        val name: String
    ){
        fun createStudent(){
            var student = Student("1", "John")
            println("""
                |Student: ${student.id}
                |Name: ${student.name}
                |School: $schoolName
            """.trimMargin())
        }
    }
}

data class Student(
    val id: String? = UUID.randomUUID().toString(),
    val name: String? = "John"
)

// enum class without properties
enum class Status { ACTIVE, INACTIVE }

// enum class with properties
enum class ActivityStatus(val status: String) {
    ACTIVE("active"),
    INACTIVE("inactive"),
}

fun main() {
    val user = User("1", "John")

    val mnhw = User(
        name = "mnhw.0612",
//        id = UUID.randomUUID().toString()

    ) //named arguments
    mnhw.hobby = "Learning English"
    //mnhw.age = 18 //Compile error, because age is private set
    //mnhw.email : kotlin.UninitializedPropertyAccessException: lateinit property email has not been initialized
    mnhw.stateHobby()

    val ybjoow = User("2", "ybjow", "Learning Chinese", 20)
    ybjoow.stateHobby()

    val hoang = User() //cannot use this, until we pass the default value to the constructor
    val student = Student("2", null)
    val student2 = student.copy(id = "new_clone", name = "Doe")

    var (_, name) = student // Destructuring declaration, omit first element is id
    //require exactly the same name and order of the properties within the class
    // var(name, _) = student //Compile error
    println("Destructuring name: $name")

    // In User2 class cannot init properties with the value pass in the constructor
    // So we have to use apply function to init properties
    // require var (have setter) properties
    val user2 = User2().apply {
        id = "3"
        name = "Doe"
    }

    println(user)
    println(mnhw)
    println(hoang)
    println(student)

    println(student2)
    println(student2.component1())
    println(student2.component2())
    //destructuring
    var (id, name2) = student2
    println("id= $id, name= $name2")

    println(user2)

    //Cannot access '<init>': it is private in 'Film'
    //val film: Film = Film("1", "The Avengers")
    var film: Film? = null
    film?.let {
        with(film) {
            id = "1"
            name = "The Avengers"
        }
    }

    //define an object from class
    val user1 = models.User(1, "hoang", "sunlight4d@gmail.com")
    val duong = models.User(1, "hoang", "sunlight4d@gmail.com")
    //2 data objects with the same values => the same hashcode
    println(user1.hashCode())
    println(duong.hashCode())
    if (user1.equals(duong)) {
        println("user1 and duong has the same content")
    }
    user1.name = "John"
    println(user1) //you can change property's value of a "val" object
    //but you cannot reference to another object / cannot be reassigned
    //user1 = User(2, "tony", "tony@gmail.com")
    val user3 = models.User(3, "mary", "mary@gmail.com")
    //clone this object
    //val user4 = user3.copy()
    //clones and changes properties
    val user4 = user3.copy(email = "mary123@gmail.com")
    println(user3)
    println(user4)

}
```

# Functions

```kotlin
import models.Bicycle
import models.Car
import models.Vehicle

fun main(){
  myFunction(5) //10

  // infix functions
  val z = 12 plus 5
  println("z = $z")
  println("5 + 3 is : ${5 plus 3}")
  println("6 times 5 = ${6 times 5}")
  var message: String = "John" loves "Mary" //non-null type String
  //message = null
  println(message)

  showColor(255, 0, 0, 0.5f) //double not need f suffix
  like("apple", "orange", "pineapple", "kiwi")

  /*
  doSomething(1, 2, completion = {result:Int -> run {
      println("result is : $result")
  }})
   */
  //more simpler way
  /*
  doSomething(1, 3) {result:Int ->
      run {
          println("result is : $result")
      }
  }
  */
  //simplest way
  doSomething(2, 3) {
    println("result is: $it") //item
  }
  println("operation = ${operation(x = 10.0f)(20.0f)}")
  println("Full name = ${getFullName("Nguyen", "Duc Hoang")}")
  println(url(1, 200))
  println(squaredNumber(30))
  url(1, 200).let { //the let function is used to execute a block of code on a non-null object
    println("It means that url is NOT NULL")
    println(it) //default name of the object is "it", this will take the value is the return value of the previous function
    println("Do more ...")
  }
}

//shadowing function
fun myFunction(a: Int){
  val a = 10
  println(a) //10
  // pass a value to this function, but it is not used
  // the variable is shadowed by the local variable
}

//Void Function: Can be omitted the Unit return type
fun sayHello(name: String):Unit {
  println("Hello "+name)
}

fun sayHello2(name: String) {
  println("Hello $name") //string concatenation
}

//functions which returns value
fun sum(x: Double, y: Double): Double {
  return x + y
}
fun showColor(red: Int, green: Int, blue: Int, alpha: Float) {
  println("color: $red - $green - $blue - $alpha")
}
//function with Variadic Arguments - vararg
fun like(vararg fruits: String) {
  for (fruit in fruits) {
    println("I like $fruit")
  }
}
//infix functions
//can be called without using the period and brackets
infix fun Int.plus(x: Int): Int {
  return this + x
}
infix fun Int.times(x: Int): Int = this * x //one-line function
infix fun String.loves(name: String) = "$this loves $name"
//Higher order function is:
//- function that takes another function as parameter
//OR - function returns a function
fun doSomething(x: Int, y: Int, completion: (Int) -> Unit) {
  println("do something")
  val result = x + y
  completion(result)
}
//function returns a function
fun operation(x: Float): (y:Float) -> Float {
  return fun(y: Float): Float {
    return y * y
  }
}
//lambda function
val getFullName:(String, String) -> String = {
    firstName: String, lastName:String -> run {
  println("This is a lambda function")
  "$firstName $lastName"
}
}
//another example
val url:(Int, Int)->String = {
    page:Int, limit:Int ->
  "https://yourServerName:port/products?page=$page&limit=$limit"
}
//another simpler example
val squaredNumber:(Int) -> Int = {x -> x * x}
fun describeVehicle(vehicle: Vehicle):String {
  return when(vehicle) {
    is Bicycle -> "This is a bicycle"
    is Car -> "This is a Car"
    else -> "I don't know"
  }
}
```

# Interface

```kotlin
fun main() {
    // Cannot create an instance of an interface
    //val studentRepository = JpaRepository<Student, Long> //Interface JpaRepository does not have constructors

    val studentList = mutableListOf(
        Student("1", "John"),
        Student("2", "Jane"),
        Student("3", "Alice")
    )

    val studentRepository = object : StudentRepository {
        override fun findAll(): List<Student> = studentList

        override fun save(entity: Student): Student {
            studentList.add(entity)
            return entity
        }

        override fun delete(entity: Student) {
            studentList.remove(entity)
        }

        override fun findById(id: String): Student =
            studentList.find { it.id == id } ?: throw IllegalArgumentException("Student not found")

        override fun findByName(name: String): Student? =
            studentList.find { it.name == name } ?: null

    }

}

class StudentController(
    private val studentRepository: StudentRepository
) {
    fun saveStudent(student: Student): Student {
        return studentRepository.save(student)
    }

    fun deleteStudent(student: Student) {
        studentRepository.delete(student)
    }

    fun findStudentById(id: String): Student {
        return studentRepository.findById(id)
    }

    fun findStudentByName(name: String): Student {
        return studentRepository.findByName(name) ?: throw IllegalArgumentException("Student not found")
    }
}

interface JpaRepository<T, ID> {
    fun save(entity: T): T
    fun delete(entity: T)
    fun findById(id: ID): T
    fun findAll(): List<T>
}

interface StudentRepository : JpaRepository<Student, String> {
    fun findByName(name: String): Student?
}
```

# Lambda

```kotlin
/*
lambda expression:
- Function which has no name
- Are function literals, i.e. functions that are not declared, but passed immediately as an expression
- Are defined with curly braces {} which takes variables as a parameter (if any) and a body of a function
- The body of a lambda is written after the variable (if any) followed by -> operator
- Syntax: { variable -> body_of_lambda }
*/

fun main(){
    val sum: (Int, Int) -> Int = { a: Int, b: Int -> a + b }
    print(sum(5, 6))

    //shorter
    val sum2 = { a: Int, b: Int -> println(a+b) }
    print(sum2(5, 6))
}

fun addNumber( a: Int, b: Int) {
    val sum = a + b
    print(sum)
}
```

# Loops

```kotlin
import collections.immutableList

fun main(){
    loops()

    //looping through a list
    immutableList()
}

fun loops(){

    for(num in 1..10){
        println(num)
    }

    for (i in 1 until 10) {
        println(i)
    }

    for (i in 10 downTo 1) {
        println(i)
    }

    for (i in 1..10 step 2) {
        println(i)
    }

    for (i in 10 downTo 1 step 2) {
        println(i)
    }

}
```

# Modifier

```kotlin
/*
    - public (default in Kotlin): if any class, interface are not specified with any modifier, it is public by default,
     if any member of class are not specified with any modifier, it is public by default
    - private
    - protected
    - internal: visible inside the same module

    - open: in kotlin all classes are final by default, so you can't be inherited,
    if you want to inherit from a class, you must use "open" keyword.
    It's the opposite of final in Java (when need to manually make class final explicitly)
*/
```

# Nullable
```kotlin
import com.sun.source.doctree.AttributeTree.ValueKind

fun main(){
    nullable()
}

fun nullable(){
    var name: String = "Denis" //non-nullable
    //name = null //Compile error

    var email: String? = "Hoang" //nullable, optional, default variable are not null
    email = "hoang@gmail.com"
//    email = null

    val student: Student? = null //nullable

    val student2: Student? = Student("1", "Hoang")
    //'student2' is always non-null type, IDE yield to remove '?' to make it non-null
    //student2 = null //Compile error, val cannot be reassigned

    var student3: Student? = Student("1", "Hoang")
    student3 = null //OK, var can be reassigned

    //if student3 is null, then let block will not be executed
    student3?.let {
        println("student3 is not null")
        for (i in 1..5) {
            println(i)
        }
        when(student3.name) {
            "Hoang" -> println("Hoang is here")
            else -> println("Someone else")
        }
    }

    //Elvis operator ?:
    //first operand ?: second operand
    //If first operand isn't null, then it will be returned.
    // If it is null, then the second operand will be returned.
    // This can be used to guarantee that an expression won't return a null value, as you'll provide a non-nullable value if the provided value is null.
    println("email's length is : ${email?.length ?: 0}")
    //if email is null then return 0, because failing back to the second operand
    //but if email is not null then email can use length property and then return the length of that email fail back to the first operand

    //if email is null, then return null, else return length, in-case the result are null then take the default value is 0
    println("email = ${email ?: "someone@gmail.com"}") //default value

    //Not null assertion operator !!
    //If you're sure that a nullable variable isn't null, you can use the not-null assertion operator (!!) to return a non-nullable value.
    //If the variable is null, a NullPointerException will be thrown.
    println("email's : ${email!!.uppercase()}") //NullPointerException
}
```

# String

```kotlin
fun stringManipulation() {

    val s = "Hello, world!\n"

    val text = """
    for (c in "foo")
        print(c)
    """

    val content = """
    |Tell me and I forget.
    |Teach me and I remember.
    |Involve me and I learn.
    |(Benjamin Franklin)
    """.trimMargin()

    val contentV2 = """
    ?   Tell me and I forget.
    ?   Teach me and I remember.
    ?   Involve me and I learn.
    ?   (Benjamin Franklin)
    """.trimMargin("?")

    //template string - string interpolation
    val letters = listOf("a", "b", "c", "d", "e")
    println("Letters: $letters")

    val hehehe = "abc"
    println("$hehehe.length is ${s.length}")

    println(s)
    println(text)
    println(content)
    println(contentV2)

}

fun stringFormat() {
    // Formats an integer, adding leading zeroes to reach a length of seven characters
    val integerNumber = String.format("%07d", 31416)
    println(integerNumber)
    // 0031416

    // Formats a floating-point number to display with a + sign and four decimal places
    val floatNumber = String.format("%+.4f", 3.141592)
    println(floatNumber)
    // +3.1416

    // Formats two strings to uppercase, each taking one placeholder
    val helloString = String.format("%S %S", "hello", "world")
    println(helloString)
    // HELLO WORLD

    // Formats a negative number to be enclosed in parentheses, then repeats the same number in a different format (without parentheses) using `argument_index$`.
    val negativeNumberInParentheses = String.format("%(d means %1\$d", -31416)
    println(negativeNumberInParentheses)
    //(31416) means -31416
}
```

# Casting

```kotlin
/*
    Unsafe cast operator: as
    - A nullable type can be cast to a non-nullable type using the unsafe cast operator as,
     but throw a ClassCastException if the nullable type is null. To avoid the exception, the source and target must be the same type.

    Safe cast operator: as?
    - Return null if the cast is not possible instead of throwing an exception.
*/
```
