
---
title: User CRUD với Java Spring Boot 3
published: 2025-01-22
description: ''
image: "https://cdn.hashnode.com/res/hashnode/image/upload/v1636832404785/mTXlsmro-.png?w=1600&h=840&fit=crop&crop=entropy&auto=compress,format&format=webp"
tags: [Java, Spring Boot, CRUD]
category: 'Công nghệ'
draft: false
lang: 'vi'
---

# Tạo Project

- Có 2 cách tạo project Spring Boot:
  - Sử dụng [Spring Initializr](https://start.spring.io/)
  - Sử dụng Spring Tool Suite (STS) hoặc IntelliJ IDEA

- Mình sẽ tạo trên Spring Initializr, vì nó đơn giản và nhanh chóng.

![alt text](image.png)

- Project: Maven
- Language: Java 17
- Spring Boot: 3.4.1
- Dependencies:
  - Lombok
  - H2 Database
  - Spring Data JPA

- Cần thêm gì thì vô pom.xml add sau, 3 cái trên là cơ bản.

# Coding

- **User.java**
	- @Table(name =  "users"): một bảng trong DB với tên users
	- Điều kiện để trở thành một Entity là xài 2 annotation: @Entity, @Table
	- Sử dụng những annotation của Lombok để giảm Boilerplate Code

```java
package com.lcaohoanq.demo.domain.user;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) //GenerationType.AUTO, GenerationType.SEQUENCE
    @Column(name = "id", nullable = false, updatable = false) //if not provide name="id", JPA will automatically using the field name is userId
    private Long userId;
    private String username;
    private String password;

}
```

- **UserDTO.java**
	-  DTO (Data Transfer Object): record **java 16+**, giống với data class của kotlin, mình có một bài viết về record tại đây [Java Record](https://shinbun.vercel.app/posts/java-record),

```java
package com.lcaohoanq.demo.domain.user;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;

public record UserDTO(
    @JsonProperty("username")
    @NotEmpty(message = "Username is required")
    @Size(min = 6, max = 20)
    String username,

    @JsonProperty("password")
    @NotEmpty(message = "Password is required")
    @Size(min = 6, max = 20)
    String password
) {}
```
- **UserRepository.java**
	- Sử dụng **Repository Pattern** [DAO vs Repository](https://www.baeldung.com/java-dao-vs-repository) thay vì dùng DAO (Data Access Object)
	- Có thể dùng @Repository hoặc không vì JpaRepository đã dùng @Repository
	- JpaRepository nhận 2 type là Entity và Data Type của PK của Entity đó (ở đây PK của User là Long userId) nên sẽ dùng Long

```java
package com.lcaohoanq.demo.domain.user;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

public interface UserRepository extends JpaRepository<User, Long> {}
```

- **UserService.java**
	- Bussiness Logic

```java
package com.lcaohoanq.demo.domain.user;

import com.lcaohoanq.demo.ResourceNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    @Override
    @Transactional
    public User create(UserDTO userDTO) {
        User user = User.builder()
            .username(userDTO.username())
            .password(userDTO.password())
            .build();
        return userRepository.save(user);
    }

    @Override
    @Transactional
    public User update(Long id, UserDTO userDTO) {
        User existingUser = findById(id);
        existingUser.setUsername(userDTO.username());
        existingUser.setPassword(userDTO.password());
        return userRepository.save(existingUser);
    }

    @Override
    @Transactional
    public void delete(Long id) {
        User user = findById(id);
        userRepository.delete(user);
    }

    @Override
    public User findById(Long id) {
        return userRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("User not found with id: " + id));
    }
}
```

- **UserController.java**:
  - @RestController: định nghĩa một REST API Endpoint
  - @RequestMapping: áp dụng prefix cho tất cả endpoint trong class
  - @GetMapping, @PostMapping, @PutMapping, @DeleteMapping, @PatchMapping,... cho những HTTP request tương ứng 
  - Không khuyến khích sử dụng @Autowired -> Field Injection (tham khảo ở đây, [Why using Autowired is not recommend](https://www.baeldung.com/java-spring-field-injection-cons), nên dùng @RequiredArgsContructor + private final -> Constructor Base Injection)
  - @Valid sẽ kích hoạt validation trong DTO, chỉ hoạt động với @RequestBody là một Object  
```java
package com.lcaohoanq.demo.domain.user;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.*;

@RestController
@RequestMapping("${API_PREFIX}/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final UserRepository userRepository;
    
    @GetMapping("")
    public ResponseEntity<?> findAll(
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int size)
    {
        return ResponseEntity.ok(userRepository.findAll(PageRequest.of(page, size)));
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<User> getUser(@PathVariable Long id) {
        User user = userService.findById(id);
        return ResponseEntity.ok(user);
    }
    
    @PostMapping("/register")
    public ResponseEntity<User> create(
        @Valid @RequestBody UserDTO userDTO
    ) {
        User createdUser = userService.create(userDTO);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<User> update(
        @PathVariable Long id,
        @Valid @RequestBody UserDTO userDTO
    ) {
        User updatedUser = userService.update(id, userDTO);
        return ResponseEntity.ok(updatedUser);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        userService.delete(id);
        return ResponseEntity.noContent().build();
    }
}
```

# Swagger UI

- Add thêm dependency vào **pom.xml**
```xml
<dependencies>
	<dependency>  
	  <groupId>org.springdoc</groupId>  
	  <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>  
	  <version>2.6.0</version>  
	</dependency>
<dependencies>
```

# Config

- **application.properties**

```properties
spring.application.name=demo-crud-springboot-application  
  
spring.output.ansi.enabled=ALWAYS  
  
server.port=8080   
  
# API  
API_PREFIX=/api/v1  
  
# MySQL database configuration  
spring.datasource.url=${SPRING_DATASOURCE_URL:jdbc:mysql://localhost:3311/mysql_starter?useSSL=false&serverTimezone=UTC}  
spring.datasource.username=${DB_USERNAME:root}  
spring.datasource.password=${MYSQL_ROOT_PASSWORD:Luucaohoang1604^^}  
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver  
  
# JPA / Hibernate configuration  
spring.jpa.database-platform=org.hibernate.dialect.MySQLDialect  
spring.jpa.hibernate.ddl-auto=create  
spring.jpa.show-sql=true  
  
springdoc.swagger-ui.operations-sorter=method  
springdoc.swagger-ui.tags-sorter=alpha  
springdoc.api-docs.path=/v3/api-docs  
springdoc.swagger-ui.path=/swagger-ui.html
```

# Test
- Truy cập: http://localhost:8080/swagger-ui/index.html