---
title: DTO (Data Transfer Object) - What is it?
published: 2025-01-19
description: ''
image: "https://github.com/user-attachments/assets/daa8e1b5-e08c-4ca5-b67c-2679c0c79391"
tags: [Java]
category: 'Tech'
draft: false
lang: ''
---

# DTO (Data Transfer Object)

![image](https://github.com/user-attachments/assets/daa8e1b5-e08c-4ca5-b67c-2679c0c79391)

- I prefer using record (java 16+) for visualize the DTO

```java
public record SubcategoryDTO(
    @NotNull(message = "Category id is required") @JsonProperty("category_id") Long categoryId,
    @NotEmpty(message = "Sub Category name is required") Set<String> name
) {}
```

```java
@JsonPropertyOrder({
    "id",
    "name",
    "created_at",
    "updated_at"
})
public record CategoryResponse(
    Long id,
    String name,
    TreeSet<Subcategory> subcategories,
    @JsonIgnore @JsonProperty("created_at") @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss.SSSSSS") LocalDateTime createdAt,
    @JsonIgnore @JsonProperty("updated_at") @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss.SSSSSS") LocalDateTime updatedAt
) {}
```

```java
@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "categories")
public class Category extends BaseEntity {

    @Id
    @SequenceGenerator(name = "categories_seq", sequenceName = "categories_id_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "categories_seq")
    @Column(name="id", unique=true, nullable=false)
    @JsonProperty("id")
    private Long id;
    private String name;

    @OneToMany(mappedBy = "category")
    private Set<Subcategory> subcategories;

}
```

```java
    @PostMapping("/sub")
    @PreAuthorize("hasRole('ROLE_MANAGER')")
    public ResponseEntity<ApiResponse<CreateNewSubcategoryResponse>> createSubCategory(
        @Valid @RequestBody SubcategoryDTO subcategoryDTO,
        BindingResult result
    ) {
        if (result.hasErrors()) {
            throw new MethodArgumentNotValidException(result);
        }
        return ResponseEntity.status(HttpStatus.CREATED).body(
            ApiResponse.<CreateNewSubcategoryResponse>builder()
                .message("Create sub category successfully")
                .statusCode(HttpStatus.CREATED.value())
                .isSuccess(true)
                .data(categoryService.createSubCategory(subcategoryDTO))
                .build()
        );
    }
```

```java
    @Override
    public CreateNewSubcategoryResponse createSubCategory(SubcategoryDTO subcategoryDTO)
        throws DataNotFoundException, DataAlreadyExistException {

        Category category = categoryRepository.findById(subcategoryDTO.categoryId())
            .orElseThrow(() -> new CategoryNotFoundException("Category not found"));

        if (subcategoryRepository.existsByCategoryIdAndNameIn(category.getId(), subcategoryDTO.name())) {
            throw new DataAlreadyExistException("Subcategory already exist in category: " + category.getId());
        }

        subcategoryDTO.name().forEach(name -> {
            subcategoryRepository.save(
                Subcategory.builder()
                    .name(name)
                    .category(category)
                    .build());
        });

        return new CreateNewSubcategoryResponse(categoryMapper.toCategoryResponse(category));
    }
```