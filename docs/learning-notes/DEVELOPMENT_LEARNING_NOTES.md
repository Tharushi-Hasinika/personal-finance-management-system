# Development Learning Notes

**Project:** Personal Finance Management System  
**Current module:** Account Service

This is a living learning journal covering concepts introduced during development. Update it as new concepts are implemented and verified.

## 1. Microservices and layered architecture

- Microservices divide a system into independently deployable services with defined responsibilities.
- Each service owns its data. Other services communicate through APIs or messages rather than accessing its database directly.
- A microservice can internally use layered architecture: controller, service, repository and persistence mappings.
- Cross-service identifiers can be stored as UUIDs without creating cross-database foreign keys.
- Microservices introduce additional complexity, including network failures and distributed consistency.

## 2. Docker and PostgreSQL

- An image is a packaged application template; a container is a running instance of an image.
- Docker Compose defines services, networking, volumes and configuration in YAML.
- A named volume preserves PostgreSQL data across container recreation.
- Port mapping uses host:container ports. Our mapping is `127.0.0.1:5433:5432` because the local PostgreSQL installation occupies port 5432.
- A health check helps determine whether PostgreSQL is accepting connections.
- `.env` stores local configuration secrets and must not be committed. `.env.example` documents required variables using placeholders.
- Changing the initialization password in Compose does not automatically change the password in an existing PostgreSQL database volume.

Useful commands (run Compose commands from `infrastructure/docker`):

```powershell
docker compose up -d
docker compose ps
docker compose logs postgres
docker compose down
docker exec -it pfms-postgres psql -U pfms_user -d account_service_db
```

Avoid `docker compose down -v` unless intentionally deleting stored database data.

## 3. Spring Boot and Maven

- Spring Initializr generates a project scaffold with selected dependencies.
- Maven manages dependencies and build tasks through `pom.xml`.
- Spring Boot auto-configuration configures components based on dependencies and application properties.
- Spring Web MVC supports REST endpoints; Spring Data JPA supports persistence; the PostgreSQL JDBC driver enables database connectivity.
- Actuator exposes operational endpoints such as `/actuator/health`.
- A health response of `UP` indicates configured health checks are passing; it does not prove every business operation works.
- Liveness concerns whether the application is alive; readiness concerns whether it is ready to receive traffic.

Our Account Service uses port 8081 and connects to `jdbc:postgresql://localhost:5433/account_service_db` when running locally. The password is supplied through the `DB_PASSWORD` environment variable, not hardcoded.

```powershell
mvn clean compile
mvn spring-boot:run
```

Stop the running application with Ctrl+C. Health endpoint: `http://localhost:8081/actuator/health`.

## 4. Flyway database migrations

- Flyway manages version-controlled database schema changes.
- Migration files live in `src/main/resources/db/migration/`.
- `V1__create_account_tables.sql` creates the initial Account Service schema. The double underscore separates the version from the description.
- Flyway records applied migrations and checksums in `flyway_schema_history`.
- Once a migration has been applied, use a new migration for subsequent schema changes rather than editing the applied file.
- Flyway owns schema creation; Hibernate uses `spring.jpa.hibernate.ddl-auto=validate` to check entity mappings against the schema.

Verification in psql:

```sql
\dt
SELECT version, description, success FROM flyway_schema_history;
\d account
\q
```

## 5. Relational database and financial data design

- Primary keys uniquely identify rows; foreign keys enforce relationships within the database.
- UNIQUE constraints prevent duplicate values or combinations. A unique account_id in account_balance enforces at most one balance row per account.
- NOT NULL and CHECK constraints enforce required fields and permitted values.
- Indexes can speed up queries but add storage and write overhead. Primary keys and unique constraints already create supporting indexes in PostgreSQL.
- DECIMAL(15,2) represents monetary values precisely; Java uses BigDecimal rather than float or double.
- TIMESTAMPTZ represents an instant in time; DATE represents a calendar date.
- Account deactivation preserves financial history.
- A ledger records balance changes; the current balance is a projection maintained consistently with those entries.
- Database transactions will be used to update the ledger and balance atomically.
- An operation identifier and unique constraint help prevent duplicate postings (idempotency).
- A version column will support optimistic locking to detect concurrent updates.

## 6. JPA, Hibernate and Java enums

**Status:** Introduced; entity implementation is next.

- JPA is a Java persistence specification; Hibernate is a JPA implementation.
- An entity is a Java class mapped to persistent database data.
- Spring Data JPA simplifies repository implementation.
- Java enums represent fixed sets of allowed values and provide compile-time type safety.
- Our enums are AccountType, AccountStatus, LedgerEntryType and LedgerEntryReason. Their values must match the database constraints.
- String-based enum mapping will keep stored values readable and avoid dependence on enum ordering.

Common mappings:

| PostgreSQL | Java |
| --- | --- |
| UUID | UUID |
| VARCHAR | String or enum |
| DECIMAL(15,2) | BigDecimal |
| TIMESTAMPTZ | Instant |
| DATE | LocalDate |
| BOOLEAN | boolean |
| BIGINT | Long |

Next topics: @Entity, @Table, @Id, @Column, @Enumerated, @OneToOne, @ManyToOne and @Version. Add examples after implementing and validating the entities.

## 7. Git and development practices

- Commit small, meaningful milestones after verification.
- Use `git status` and `git diff --cached` to review staged changes before committing.
- Do not commit passwords, real financial data, local environment files or Maven target directories.
- Keep migration files, configuration templates, source code and project documentation under version control.
- Separate formal design documentation from personal learning notes.
