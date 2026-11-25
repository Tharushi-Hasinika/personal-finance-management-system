# Maven and Java Compilation

## 1. Java Compilation

Java source files (`.java`) are converted into bytecode files (`.class`) by the Java compiler (`javac`). The JVM executes the compiled bytecode at runtime.

Compilation flow:

Java Source Code → Java Compiler → Bytecode → JVM

## 2. Maven

Maven is a build automation and dependency management tool for Java projects.

Its responsibilities include:

- Managing project dependencies.
- Compiling source code.
- Executing automated tests.
- Packaging applications.
- Managing the build lifecycle.

Maven uses the `pom.xml` file to define project configuration, dependencies, and build plugins.

## 3. Clean Compilation

Command: `mvn clean compile`

- `mvn`: Invokes Maven.
- `clean`: Removes previously generated build files.
- `compile`: Compiles the main Java source code.

Compiled classes are normally stored in the `target/classes/` directory.

The `target/` directory should be excluded from version control because its contents can be regenerated.

## 4. Maven Build Lifecycle

Selected phases of the default build lifecycle:

1. validate
2. compile
3. test
4. package
5. verify
6. install
7. deploy

Executing a phase also executes the preceding phases in the same lifecycle.

The clean lifecycle is separate from the default build lifecycle.

## 5. Useful Maven Commands

| Command | Purpose |
|---|---|
| `mvn clean` | Remove generated build files |
| `mvn compile` | Compile source code |
| `mvn clean compile` | Perform a fresh compilation |
| `mvn test` | Run tests |
| `mvn package` | Package the application |
| `mvn clean install` | Build and install the artifact locally |
| `mvn spring-boot:run` | Run the Spring Boot application |
| `mvn dependency:tree` | Inspect project dependencies |

## 6. Compilation vs Application Execution

Successful compilation does not mean the application is fully functional.

Compilation verifies source code correctness at compile time. Runtime execution is required to verify application startup, database connectivity, Flyway migrations, and Hibernate schema validation.

## 7. Incremental Development

Compile and verify the project after completing logical implementation milestones.

Benefits:

- Early error detection.
- Easier debugging.
- Reduced accumulation of errors.
- Increased confidence before implementing dependent components.

## 8. Application in the PFMS Project

After implementing the Account Service enums, the project was compiled using `mvn clean compile`.

The following compiled classes are generated:

- AccountType.class
- AccountStatus.class
- LedgerEntryType.class
- LedgerEntryReason.class

This verification is performed before implementing the JPA entities that depend on these enums.

## 9. Maven Execution Directory and MissingProjectException

Maven normally searches for the `pom.xml` file in the current working directory.

If Maven is executed from a directory without a POM file, it can produce a `MissingProjectException`.

### Solutions

- Navigate to the directory containing the `pom.xml` file before executing Maven commands.
- Alternatively, use the `-f` option to explicitly specify the POM file location.

Example: `mvn -f services/account-service/pom.xml clean compile`

### Application in Microservices

In a microservices architecture, individual services can have independent Maven projects with their own POM files. Each service can be compiled, tested, packaged and deployed independently.

### Warnings vs Errors

Warnings indicate potential issues but do not necessarily prevent a build from completing.

Errors indicate problems that prevent successful execution.

When troubleshooting a build failure, identify the actual error message rather than assuming that every warning is responsible for the failure.