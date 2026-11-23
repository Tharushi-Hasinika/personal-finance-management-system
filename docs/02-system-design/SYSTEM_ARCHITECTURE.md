# System Architecture

## 1. Introduction

This document describes the proposed architecture of the Personal Finance Management System. It explains the major components, their responsibilities, communication mechanisms, and the technologies used to develop and deploy the system.

The system will follow a microservices architecture. Each backend service will be developed independently and will follow a layered architecture internally.

The architecture is designed to support web and mobile applications, maintain financial data consistency, and allow future improvements.

## 2. Architectural Style

### 2.1 Microservices Architecture

The backend will be divided into several independent services. Each service will handle a specific business responsibility.

The main advantages of this approach include:

- Independent development and testing of services.
- Easier maintenance by separating business responsibilities.
- Ability to scale individual services when required.
- Better separation of data and business logic.
- Opportunity to learn distributed system concepts.

### 2.2 Layered Architecture

Each backend microservice will follow a layered architecture.

The main layers will be:

1. **Controller Layer:** Handles incoming HTTP requests and returns responses.
2. **Service Layer:** Contains business logic and application rules.
3. **Repository Layer:** Handles database operations.
4. **Entity Layer:** Represents the database entities.
5. **DTO Layer:** Defines the data structures exchanged through APIs.

This separation will improve code organization, maintainability, and testability.

## 3. High-Level System Components

The system consists of the following major components:

### 3.1 Web Application

The web application will provide access through desktop and mobile browsers.

Responsibilities:

- User registration and login.
- Managing accounts and wallets.
- Recording income and expenses.
- Managing daily food budgets.
- Tracking savings and lending.
- Viewing financial reports.

**Technology:** Next.js and TypeScript.

### 3.2 Mobile Application

The mobile application will provide similar core functionality through mobile devices.

Responsibilities:

- Accessing personal financial information.
- Recording daily transactions.
- Managing budgets and wallets.
- Viewing balances and reports.
- Synchronizing information with the web application.

**Technology:** React Native and Expo.

### 3.3 API Gateway

The API Gateway will act as the central entry point for requests from the web and mobile applications.

Responsibilities:

- Routing requests to appropriate backend services.
- Handling common request processing.
- Integrating authentication checks.
- Providing a consistent API entry point.

**Technology:** Spring Cloud Gateway.

### 3.4 Authentication Service

This service will manage user authentication and identity-related operations.

Responsibilities:

- User registration.
- User login and logout.
- Password management.
- JWT token generation and validation.
- Managing authenticated user identity.

**Technology:** Java, Spring Boot, and Spring Security.

### 3.5 Account Service

This service will manage the user's financial accounts and wallets.

Responsibilities:

- Creating and managing financial accounts.
- Managing account and wallet details.
- Maintaining account balances.
- Recording opening balances.
- Providing account information to other services through APIs.

Examples of supported accounts include:

- Bank Savings Account.
- Bank Daily Account.
- On-Hand Cash Wallet.
- Food Savings Wallet.

### 3.6 Transaction Service

This service will manage financial transactions.

Responsibilities:

- Recording income.
- Recording expenses.
- Managing internal transfers.
- Maintaining transaction history.
- Validating transaction information.

### 3.7 Budget Service

This service will manage daily food budgets and related savings calculations.

Responsibilities:

- Setting daily food budgets.
- Recording breakfast, lunch, and dinner expenses.
- Calculating daily spending totals.
- Calculating daily surplus and deficit amounts.
- Managing the financial adjustments associated with the food budget.

### 3.8 Lending Service

This service will manage money lent to other people and repayments.

Responsibilities:

- Recording lending transactions.
- Tracking outstanding amounts.
- Recording full and partial repayments.
- Maintaining lending history.

### 3.9 Reporting Service

This service will generate financial summaries and reports.

Responsibilities:

- Generating monthly financial reports.
- Summarizing income and expenses.
- Displaying account balances.
- Summarizing food budget performance.
- Showing savings and lending information.

## 4. Database Architecture

PostgreSQL will be used as the primary relational database management system.

Each microservice will own and manage its own data. Other services must access that data through the owning service's API or an agreed messaging mechanism.

The services must not directly modify another service's database tables.

During local development, the services may use one PostgreSQL server with separate databases. This will preserve service-level data ownership without requiring multiple database server installations.

Database migrations will be managed using Flyway.

## 5. Communication Between Components

### 5.1 Client-to-Backend Communication

The web and mobile applications will communicate with the backend through REST APIs exposed by the API Gateway.

### 5.2 Inter-Service Communication

Backend services will initially communicate using synchronous REST APIs.

Message-based communication using RabbitMQ may be introduced when asynchronous processing becomes necessary.

### 5.3 Authentication Communication

The authentication mechanism will use JWT-based authentication.

Authenticated requests will include the relevant access token. The backend will validate the user's identity and ensure that users can only access their own financial information.

## 6. Financial Data Consistency

Maintaining accurate financial information is a major architectural requirement.

The system must distinguish between:

- Income.
- Expenses.
- Internal transfers.
- Savings transfers.
- Lending.
- Loan repayments.

Internal transfers and lending operations must not be incorrectly counted as expenses.

Financial operations that update multiple related records must be designed with appropriate consistency and failure-handling mechanisms. Since separate microservices cannot share a normal database transaction, distributed operations must be handled carefully.

The system should also prevent duplicate transaction processing through appropriate validation and idempotency mechanisms.

## 7. Technology Stack

| Component | Technology |
|---|---|
| Web Frontend | Next.js, TypeScript |
| Mobile Frontend | React Native, Expo |
| Backend | Java, Spring Boot |
| API Gateway | Spring Cloud Gateway |
| Database | PostgreSQL |
| ORM | Spring Data JPA, Hibernate |
| Authentication | Spring Security, JWT |
| Database Migration | Flyway |
| API Documentation | Swagger / OpenAPI |
| Inter-Service Communication | REST, RabbitMQ (when required) |
| Containerization | Docker |
| Container Orchestration | Kubernetes |
| Version Control | Git, GitHub |

## 8. Deployment Architecture

Docker will be used to containerize the backend services and supporting infrastructure.

Docker Compose will be used initially to run the application components in a local development environment.

Kubernetes will be introduced later to learn container orchestration and manage the deployment of multiple services.

The deployment architecture will support the web application, mobile application, API Gateway, backend services, and databases.

## 9. Security Considerations

The system will implement the following security measures:

- Secure user authentication.
- Password hashing.
- JWT-based authorization.
- HTTPS for communication.
- User-level data isolation.
- Input validation.
- Secure management of environment variables and credentials.
- Protection against unauthorized access to financial information.

The system will not directly connect to users' bank accounts. Bank transactions and account information will be entered manually.

## 10. Future Scalability

The architecture should allow future improvements such as:

- Adding new financial account types.
- Supporting additional budgeting methods.
- Introducing notifications.
- Improving reporting and analytics.
- Supporting additional users.
- Adding new client applications.

The architecture will be implemented incrementally. Technologies such as RabbitMQ and Kubernetes will be introduced when they are relevant to the development stage rather than adding unnecessary complexity at the beginning.

## 11. Conclusion

The proposed architecture provides a modular foundation for developing the Personal Finance Management System.

By combining microservices, layered architecture, REST APIs, PostgreSQL, and modern frontend technologies, the system aims to provide a maintainable and extensible solution for personal financial management.