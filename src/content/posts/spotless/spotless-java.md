---
title: Cách mà mình áp dụng Spotless để code clean hơn
published: 2025-12-19
description: 'Format code sớm đi, code sạch thì mát, conflict tránh xa'
image: "https://www.jetbrains.com/resharper/features/screenshots/20171/configure_format.png"
tags: [Java, Spotless, SpringBoot, Code Format]
category: 'Công nghệ'
draft: false
lang: 'vi'
---

> Anh em làm việc với hệ sinh thái Nodejs thì sẽ nghe tới Prettier, Eslint là combo Formatter, Linter phổ biến nhất hầu như dự án nào mình cũng thấy xài
>  **Formatter** là tool giúp anh em xóa khoảng trắng thừa, sắp xếp lại thứ tự import, tab 2 cách hay 4 cách... về format của code
>  **Linter** là tool đánh giá chất lượng code theo chuẩn nào đó, hoặc tự define, ví dụ function không trả gì thì không ghi gì hay ghi void? Cho phép, cảnh báo, hoặc cấm dùng type any trong Typescript

- Vấn đề mình hay gặp khi code chung với team là, mỗi người một kiểu setup IDE, format code, khi xảy ra conflict rất "nhảm" giữa việc một thằng tab 2 dấu cách và tab 4 dấu cách. Ít file còn đỡ, nhiều file conflict, mà toàn bị lỗi format thì ối dồi ôi lắm. Không chỉ code mỗi Intelliji vì nó không có tính năng Ctrl+Save (visual), có người sẽ mở code trong vscode -> Hỏi AI, AI Response -> Ctrl + Save -> Là xong luôn ăn hết format của VScode, tiến thoái lưỡng nan, giờ mình thêm có vài dòng mà Save file lại ăn hết changes của mình? Rồi push đống này lên, teammate pull về lại xào xáo ủa sao code nhìn lạ vậy :) Đó là lí do code lộn xộn, cần phải xử lí. 
- Có 2 hướng để giải quyết, một là từ đầu họp, setup convention code rõ ràng, Setup IDE chuẩn. Anh em chỉ code theo thôi. Trường hợp 1 mình hiếm thấy quá, vì mình chỉ trong dự án học tập, sinh viên nên mọi người không quan trọng lắm vấn đề này, khi mình đặt vấn đề thì sẽ có ý kiến "mệt thế, rườm rà thế". Trường hợp 2 thì sẽ không ép, bắt team align từ đầu nhưng dần dần code sẽ đẹp hơn *hehehe, đối với những codebase đã có sẵn rồi, ta cần từ từ dọn dẹp nó. Có thể kiểm tra liên tục nhờ gắn CI flow với format check, lint check nhằm phát hiện sớm hơn các lỗi, nhằm viết code đẹp hơn.
> Hôm nay mình ở bên hệ sinh thái Java, có 1 tool siêu ngon là **Spotless**
- Anh em tham khảo ở đây: https://github.com/diffplug/spotless

- Cái hay của spotless là nó gộp lại Formatter và Linter, rất dễ sử dụng, config. Khi bên Prettier, Eslint setup tối thiểu cần 5 file, 
	- .prettierrc.json
	- .prettierignore
	- eslintrc.json
	- .eslintignore
	- .editorconfig
- Thì bên spotless chỉ cần bỏ thêm plugin vào **pom.xml** nếu làm dự án bạn làm với Maven hoặc **build.gradle.kts** nếu làm với Gradle, sau đây mình sẽ chia sẻ đoạn code copy plug-play luôn nhé.

## pom.xml
- Trong phần <build></build> thêm giúp mình  **spotless-maven-plugin** 
```xml
<groupId>com.diffplug.spotless</groupId>  
<artifactId>spotless-maven-plugin</artifactId>
<version>2.46.1</version>
```

- pom.xml đầy đủ

```xml
<build>  
    <plugins>  
        <!--  Spotless for code formatting-->
        <plugin>
            <artifactId>spotless-maven-plugin</artifactId>
            <configuration>
                <!-- Java files formatting (if any) -->
                <formats>
                    <format>
                        <endWithNewline/>
                        <includes>
                            <include>src/**/*.xml</include>
                            <include>pom.xml</include>
                        </includes>
                        <trimTrailingWhitespace/>
                    </format>

                    <!-- Properties files -->
                    <format>
                        <endWithNewline/>
                        <includes>
                            <include>src/**/*.properties</include>
                        </includes>
                        <trimTrailingWhitespace/>
                    </format>

                    <!-- YAML files -->
                    <format>
                        <endWithNewline/>
                        <includes>
                            <include>src/**/*.yml</include>
                            <include>src/**/*.yaml</include>
                        </includes>
                        <trimTrailingWhitespace/>
                    </format>

                    <!-- JSON files -->
                    <format>
                        <includes>
                            <include>src/**/*.json</include>
                        </includes>
                        <prettier>
                            <config>
                                <tabWidth>4</tabWidth>
                                <useTabs>false</useTabs>
                            </config>
                            <devDependencyProperties>
                                <property>
                                    <name>prettier</name>
                                    <value>3.0.3</value>
                                </property>
                            </devDependencyProperties>
                        </prettier>
                    </format>
                </formats>

                <!-- XML files formatting -->
                <java>
                    <endWithNewline/>
                    <excludes>
                        <exclude>src/main/java/**/package-info.kt</exclude>
                        <exclude>src/test/java/**/package-info.kt</exclude>
                    </excludes>
                    <!-- Use Google Java format: https://github.com/google/google-java-format -->
                    <formatAnnotations/>
                    <googleJavaFormat>
                        <formatJavadoc>false</formatJavadoc>                      <!-- optional, 1.8 is the minimum supported version for Java 11 -->
                        <reflowLongStrings>true</reflowLongStrings>                       <!-- or GOOGLE (optional) -->
                        <style>AOSP</style> <!-- optional -->
                        <version>1.28.0
                        </version>        <!-- optional -->
                    </googleJavaFormat>
                    <includes>
                        <include>src/main/java/**/*.java</include>
                        <include>src/test/java/**/*.java</include>
                    </includes>
                    <licenseHeader>
                        <file>${project.basedir}/src/main/resources/license-header.txt</file>
                    </licenseHeader>
                    <removeUnusedImports/>
                    <trimTrailingWhitespace/>
                </java>
            </configuration>
            <executions>
                <execution>
                    <goals>
                        <goal>check</goal>
                        <goal>apply</goal>
                    </goals>
                    <phase>compile</phase>
                </execution>
            </executions>
            <groupId>com.diffplug.spotless</groupId>
            <version>2.46.1</version>
        </plugin>
    </plugins>  
</build>
```

- Chạy bằng terminal
	- **mvn spotless:apply** (format hết tất cả các file bị sai định dạng, cẩn thận chạy lệnh này vì nó sẽ sửa tất cả những file, trường hợp mình chạy lệnh này nó sẽ ảnh hưởng đến code của các thành viên khác, nếu không align format từ đầu, sẽ gây conflict rất nặng. Best practice nên checkout nhánh khác và merge vào, đồng thời bảo mọi người pull về và resolve conflict sớm nhất có thể nha. Lỗi format sửa conflict rất chán)
	- **mvn spotless:check** (check file nào bị sai format)

- Các option khác mọi người tham khảo thêm ở doc chính thức nhé
	- https://github.com/diffplug/spotless/tree/main/plugin-maven#java

## build.gradle.kts

- Thêm: id("com.diffplug.spotless") version "8.1.0"
- subprojects {} liên quan đến config sâu hơn của gradle, khi build tự động chạy format hoàn toàn source code
- Chú ý giúp mình scope của **spotless {}**, tại sao mình có thể viết được như vậy, đọc doc đê
	- https://github.com/diffplug/spotless/tree/main/plugin-gradle#java

```kts
plugins {
  java
  id("org.springframework.boot") version "3.3.2"
  id("io.spring.dependency-management") version "1.1.6"
  id("com.diffplug.spotless") version "8.1.0"
}

group = "com.lcaohoanq"

version = "0.0.1"

java { toolchain { languageVersion = JavaLanguageVersion.of(17) } }

configurations { compileOnly { extendsFrom(configurations.annotationProcessor.get()) } }

repositories { mavenCentral() }

dependencies {
  implementation("org.springframework.boot:spring-boot-starter-actuator")
  implementation("org.springframework.boot:spring-boot-starter-data-jpa")
  implementation("org.springframework.boot:spring-boot-starter-security")
  implementation("org.springframework.boot:spring-boot-starter-thymeleaf")
  implementation("org.springdoc:springdoc-openapi-starter-webmvc-ui:2.5.0")
  implementation("org.springframework.boot:spring-boot-starter-validation")
  implementation("org.springframework.boot:spring-boot-starter-web")
  implementation("org.springframework.boot:spring-boot-starter-mail")
  implementation("org.springframework.boot:spring-boot-starter-oauth2-resource-server")
  implementation("org.thymeleaf.extras:thymeleaf-extras-springsecurity6")
  implementation("com.turkraft.springfilter:jpa:3.1.7")
  compileOnly("org.projectlombok:lombok")
  annotationProcessor("org.projectlombok:lombok")
  developmentOnly("org.springframework.boot:spring-boot-devtools")
  runtimeOnly("com.mysql:mysql-connector-j")
  testImplementation("org.springframework.boot:spring-boot-starter-test")
  testImplementation("org.springframework.security:spring-security-test")
  testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

subprojects {
  apply(plugin = "com.diffplug.spotless")
  configure<com.diffplug.gradle.spotless.SpotlessExtension> {
    kotlin {
      target("**/*.kt")
      targetExclude("${rootProject.layout.buildDirectory}/**/*.kt")

      ktlint()
        .editorConfigOverride(
          mapOf(
            "ktlint_standard_filename" to "disabled", // cho phép tên file tự do hơn
            "ij_kotlin_imports_layout" to "*", // optimize imports
            "ij_kotlin_allow_trailing_comma" to "true",
            "ktlint_standard_no-wildcard-imports" to "disabled", // cho phép wildcard imports
            "ktlint_function_naming_ignore_when_annotated_with" to "Composable",
          )
        )
      licenseHeaderFile(rootProject.file("license-header.kt"))
    }

    kotlinGradle {
      target("*.gradle.kts")
      ktlint()
    }
  }

  // Tự động chạy spotlessApply trước khi build
  afterEvaluate { tasks.named("preBuild") { dependsOn("spotlessApply") } }
}

spotless {
  kotlinGradle {
    target("*.gradle.kts") // chỉ root gradle scripts
  }
  yaml {
    target("*.yml", ".github/**/*.yml", "src/**/*.yml")
    jackson()
    trimTrailingWhitespace()
    lineEndings
  }

  java {
    target("src/**/*.java")

    removeUnusedImports()
    forbidWildcardImports()
    formatAnnotations()

    eclipse()
    licenseHeaderFile(rootProject.file("license-header.kt"), "package|import|public|class|@")
  }
}

tasks.withType<Test> { useJUnitPlatform() }
```

## license-header
- Với pom.xml mình có dùng license-header.txt và build.gradle.kts mình dùng license-header.kt, file gì cũng được nha, text là được, mình ngựa á.
- File này dùng để nối thêm bản quyền vào đầu tất cả các file trong source code, có thể custom include exclude được

- license-header.txt
```txt
/**
 * Copyright (c) 2025 lcaohoanq. All rights reserved.
 * This software is the confidential and proprietary information of lcaohoanq.
 * You shall not disclose such confidential information and shall use it only in
 * accordance with the terms of the license agreement you entered into with hcmurs.
 */
```  

- license-header.kt
```kt
/**
 * Copyright (c) 2025 lcaohoanq. All rights reserved.
 * This software is the confidential and proprietary information of lcaohoanq.
 * You shall not disclose such confidential information and shall use it only in
 * accordance with the terms of the license agreement you entered into with hcmurs.
 */
```
- Bản chất file này định dạng nào cũng chỉ là text chứa comment thôi
