# JPA and Hibernate

**Project:** Personal Finance Management System (PFMS)  
**Module:** Account Service  
**Status:** Living learning document — Account entity implementation

## 1. Object Relational Mapping (ORM)

ORM is a technique used to map object-oriented programming objects to relational database tables. It reduces the need to manually write SQL for common persistence operations.

For example, our `Account` Java class maps to the PostgreSQL `account` table. An entity instance represents an account record, and its persistent fields map to columns.

## 2. Jakarta Persistence API (JPA)

JPA is a specification that defines standard APIs and annotations for managing persistent Java objects. JPA is not itself an ORM implementation.

Examples include `@Entity`, `@Table`, `@Id` and `@Column`, imported from `jakarta.persistence`.

## 3. Hibernate

Hibernate is an ORM framework that implements JPA. Its responsibilities include:

- Mapping Java entities to database tables.
- Generating SQL statements.
- Managing entity lifecycle events.
- Tracking changes to managed entities (dirty checking).
- Validating database schema mappings.

Spring Data JPA simplifies repository development using JPA.

Communication flow:

```text
Java application / Spring Data JPA
             ↓
     JPA APIs / Hibernate
             ↓
    JDBC / PostgreSQL driver
             ↓
         PostgreSQL
```

## 4. Common JPA Annotations

| Annotation | Purpose |
|---|---|
| `@Entity` | Declares a persistent entity |
| `@Table` | Specifies the mapped database table |
| `@Id` | Identifies the primary key |
| `@GeneratedValue` | Configures identifier generation |
| `@Column` | Defines column mappings |
| `@Enumerated` | Configures enum persistence |
| `@PrePersist` | Callback before entity insertion |
| `@PreUpdate` | Callback before a JPA-managed entity update |

Example:

```java
@Entity
@Table(name = "account")
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "account_id", nullable = false, updatable = false)
    private UUID accountId;
}
```

### Column attributes

| Attribute | Purpose |
|---|---|
| `name` | Database column name |
| `nullable` | Describes whether null values are allowed |
| `length` | Expected string column length |
| `updatable` | Whether the column is included in provider-generated updates |
| `columnDefinition` | Explicit SQL column definition |

Column mapping annotations are not a replacement for request validation or database constraints.

## 5. UUID Generation

UUIDs are useful in distributed systems because identifiers can be generated independently without relying on a shared database sequence. They are designed for practical global uniqueness.

```java
@Id
@GeneratedValue(strategy = GenerationType.UUID)
private UUID accountId;
```

The persistence provider generates the identifier when the entity is persisted. UUIDs generally require more storage than integer identifiers.

## 6. Enum Mapping

JPA supports two common enum mapping strategies:

- `EnumType.ORDINAL`: stores the numeric position of an enum constant.
- `EnumType.STRING`: stores the enum constant name.

| AccountType | ORDINAL | STRING |
|---|---:|---|
| BANK | 0 | BANK |
| CASH | 1 | CASH |
| WALLET | 2 | WALLET |
| OTHER | 3 | OTHER |

PFMS uses string-based mapping for readability and to avoid problems caused by reordering enum constants.

```java
@Enumerated(EnumType.STRING)
@Column(name = "account_type", nullable = false, length = 30)
private AccountType accountType;
```

Renaming persisted enum constants still requires coordinated database changes. Enum values must match the database CHECK constraints.

## 7. Entity Constructors

JPA requires a public or protected no-argument constructor. Hibernate uses it when instantiating entities.

```java
protected Account() {
}
```

A parameterized constructor can initialize new entities with required business data.

```java
public Account(UUID userId, String accountName,
               AccountType accountType, String institutionName,
               boolean isDefault) {
    this.userId = userId;
    this.accountName = accountName;
    this.accountType = accountType;
    this.institutionName = institutionName;
    this.isDefault = isDefault;
}
```

Creating an object using `new Account(...)` does not automatically insert a database record. It must be persisted.

We write constructors, getters and setters manually for now rather than using Lombok, to understand the underlying Java concepts.

## 8. Encapsulation

Entity fields are private to control access and modification. Public setters are provided only for fields that application code should be able to modify.

| Field | Public setter? |
|---|---|
| accountId | No |
| userId | No |
| accountName | Yes |
| accountType | No |
| institutionName | Yes |
| currency | No |
| status | Yes |
| isDefault | No |
| createdAt | No |
| updatedAt | No |

When JPA annotations are placed on fields (including `@Id`), JPA uses field access by default. Public setters are not required for persistence.

Business rules and authorization must also be enforced in the service layer.

## 9. Lifecycle Callbacks

Lifecycle callbacks allow methods to execute automatically during entity persistence events.

```java
@PrePersist
protected void onCreate() {
    Instant now = Instant.now();
    this.createdAt = now;
    this.updatedAt = now;
}

@PreUpdate
protected void onUpdate() {
    this.updatedAt = Instant.now();
}
```

`@PrePersist` initializes creation and modification timestamps. `@PreUpdate` refreshes the modification timestamp before a managed entity update.

These callbacks do not automatically run for arbitrary SQL or bulk updates.

## 10. Date and Time Mapping

| Java type | Meaning |
|---|---|
| `LocalDate` | Calendar date |
| `LocalTime` | Time without date |
| `LocalDateTime` | Date and time without timezone information |
| `Instant` | Specific point on the UTC timeline |
| `ZonedDateTime` | Date and time with timezone information |

PFMS uses `Instant` for audit timestamps mapped to PostgreSQL `TIMESTAMPTZ` columns.

```java
@Column(name = "created_at", nullable = false, updatable = false)
private Instant createdAt;
```

## 11. Flyway vs Hibernate

Flyway manages database schema creation and versioned changes. Hibernate manages object-relational mapping and persistence operations.

PFMS uses:

```properties
spring.jpa.hibernate.ddl-auto=validate
```

This allows Hibernate to validate mappings without automatically modifying the database schema. Applied Flyway migrations should not be edited; intentional schema changes require new migrations.

## 12. Entity Verification

Entity implementation should be verified through:

1. Java compilation (`mvn clean compile`).
2. Spring Boot startup (`mvn spring-boot:run`).
3. Hibernate schema validation during startup.
4. Application health checks (`http://localhost:8081/actuator/health`).
5. Database integration tests (planned for later).

Run Maven commands from `services/account-service`, where the `pom.xml` is located. PostgreSQL must be running for application startup, and the database password must be supplied securely through the `DB_PASSWORD` environment variable.

Successful compilation does not guarantee compatible database mappings. Successful startup does not guarantee that every database operation or business rule works. Hibernate schema validation also does not verify every database constraint.

## 13. CHAR vs VARCHAR

| Feature | CHAR(n) | VARCHAR(n) |
|---|---|---|
| Length | Fixed | Variable, up to n characters |
| Padding | Pads shorter values with spaces | No automatic padding |
| PFMS example | Currency code | Account name |

The Account Service uses `CHAR(3)` for currency codes because codes such as LKR contain exactly three characters. Version 1 supports only LKR.

PostgreSQL's internal type name `bpchar` refers to blank-padded character data.

## 14. JDBC Type Mapping

Hibernate maps Java data types to JDBC and SQL data types. A Java `String` is generally mapped to `VARCHAR` by default.

The Hibernate-specific `@JdbcTypeCode` annotation explicitly configures the JDBC type mapping.

```java
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;
```

```java
@JdbcTypeCode(SqlTypes.CHAR)
@Column(name = "currency", nullable = false, length = 3,
        columnDefinition = "CHAR(3)")
private String currency = "LKR";
```

| Annotation | Responsibility |
|---|---|
| `@Column(columnDefinition = "CHAR(3)")` | Specifies the SQL column definition |
| `@JdbcTypeCode(SqlTypes.CHAR)` | Configures the JDBC type mapping |

`@Column` is a standard JPA annotation. `@JdbcTypeCode` is specific to Hibernate.

## 15. Hibernate SchemaManagementException

A `SchemaManagementException` can occur when Hibernate detects a mismatch between entity mappings and the existing database schema.

### Issue encountered in PFMS

Compilation succeeded, but application startup failed because the currency field's JDBC mapping was VARCHAR while PostgreSQL used CHAR(3).

```text
Schema validation: wrong column type encountered
in column [currency] in table [account];
found [bpchar (Types#CHAR)],
but expecting [char(3) (Types#VARCHAR)]
```

Docker, database connectivity and Flyway validation had already succeeded. The failure occurred during Hibernate initialization.

### Solution

Add `@JdbcTypeCode(SqlTypes.CHAR)` to the currency field, preserving the existing database schema. After the change, the subsequent terminal screenshot showed DispatcherServlet initialization, indicating that the application had started. Full persistence integration testing remains pending.

### Lessons learned

- Successful compilation does not guarantee successful application startup.
- SQL column definitions and JDBC type mappings serve different purposes.
- Schema validation detects mapping problems early.
- Do not disable validation or edit applied migrations simply to bypass a mapping error.
- Read the root cause in the logs rather than treating every warning as a failure.

## 16. Final Fields in JPA Entities

The Java `final` keyword prevents a variable from being reassigned after initialization.

VS Code displayed the following warning for the currency field:

```text
Field currency can be final
```

The IDE detected that the field is initialized to `LKR` and never explicitly reassigned by our Java code. However, persistent JPA entity fields must remain non-final for specification-compliant mappings. Hibernate needs to populate persistent fields when loading entities.

Keep the field non-final. The warning can safely remain.

### Controlling field modification

An optional improvement is to exclude currency from Hibernate-generated updates:

```java
@JdbcTypeCode(SqlTypes.CHAR)
@Column(name = "currency", nullable = false, length = 3,
        updatable = false, columnDefinition = "CHAR(3)")
private String currency = "LKR";
```

| Mechanism | Responsibility |
|---|---|
| `private` | Restricts direct field access |
| No public setter | Restricts ordinary external reassignment |
| `updatable = false` | Excludes the column from provider-generated updates |
| Database CHECK constraint | Ensures only LKR is accepted in Version 1 |
| Service-layer rules | Enforces application business requirements |

`updatable = false` does not make the Java field immutable or prevent direct SQL updates. It is an optional improvement, not a fix for the IDE warning.

### Lesson learned

IDE warnings and automatic code improvement suggestions must be evaluated in the context of the frameworks being used. Not every suggested fix is appropriate.

---

**Next learning topics:** `@OneToOne`, `BigDecimal`, optimistic locking with `@Version`, and `@ManyToOne`, to be added as the remaining Account Service entities are implemented.
