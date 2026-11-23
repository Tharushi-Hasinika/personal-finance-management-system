# Personal Finance Management System
## Project Overview

### 1. Introduction

The Personal Finance Management System is a web and mobile-based application designed to help individuals manage and monitor their personal financial activities through a centralized platform.

The system aims to replace manual financial tracking methods, such as spreadsheets and separate records, with an organized and accessible digital solution. It provides functionalities for managing bank accounts, cash balances, income, expenses, savings, daily budgets, and lending activities.

The application will support access through both web and mobile platforms, with financial information synchronized across devices through a centralized backend system.

### 2. Project Background

Personal financial management involves several activities, including recording daily expenses, monitoring account balances, managing savings, allocating budgets, and tracking money lent to others.

Managing these activities manually can become time-consuming and may lead to difficulties in maintaining accurate and up-to-date financial records. Information stored across multiple spreadsheets or separate records can also make it difficult to obtain a complete overview of an individual's financial situation.

This project is motivated by the need for a centralized system that simplifies personal financial management while providing better visibility into financial activities.

The proposed system is based on practical personal financial management requirements, including multiple bank accounts, physical cash management, daily food budgeting, separate savings tracking, and lending management.

### 3. Project Vision

To develop a reliable and user-friendly personal finance management platform that enables individuals to organize their financial activities, monitor their spending patterns, manage savings, and make informed financial decisions.

### 4. Project Objectives

The main objectives of the project are:

- To provide a centralized platform for managing personal financial information.
- To simplify the recording and monitoring of income and expenses.
- To support the management of multiple bank accounts and cash wallets.
- To provide daily budget management and expense tracking facilities.
- To maintain separate records of savings and financial allocations.
- To support the recording and monitoring of money lent to others and repayments.
- To generate meaningful financial summaries and reports.
- To provide synchronized access through web and mobile applications.
- To apply modern software engineering practices and technologies in developing a scalable and maintainable application.

### 5. Main System Features

#### 5.1 User Authentication and Management
- Allow users to register and securely log in.
- Manage individual user accounts.
- Protect personal financial information through appropriate authentication and authorization mechanisms.

#### 5.2 Account and Wallet Management
- Create and manage multiple financial accounts and wallets.
- Maintain separate records for bank accounts and physical cash.
- Monitor the current balance of each account or wallet.
- Record transfers between personal financial accounts and wallets.
- Maintain transaction histories for individual accounts.

#### 5.3 Income and Expense Management
- Record income and expenses manually.
- Categorize transactions for better organization.
- Associate transactions with relevant accounts or wallets.
- View transaction histories using dates and categories.
- Monitor changes in available balances.

#### 5.4 Daily Food Budget Management
- Maintain a predefined daily food budget.
- Record breakfast, lunch, and dinner expenses separately.
- Calculate the remaining amount from the allocated daily budget.
- Transfer unspent food budget amounts into a separate food savings balance.
- Manage situations where daily food expenses exceed the allocated budget.

#### 5.5 Savings Management
- Maintain separate savings records.
- Track accumulated savings over time.
- Monitor additions to and withdrawals from savings.
- View historical savings information.

#### 5.6 Lending Management
- Record money lent to other individuals.
- Maintain information about lending transactions.
- Track outstanding amounts for each person.
- Record full or partial repayments.
- Monitor repayment history and outstanding balances.

#### 5.7 Financial Reports and Analytics
- Generate monthly financial summaries.
- View income and expense breakdowns.
- Monitor account and wallet balances.
- Analyze daily food expenditure and savings.
- Track lending activities and outstanding amounts.
- Present financial information through suitable charts and visual summaries.

#### 5.8 Multi-Device Access and Synchronization
- Provide access through a web application and a mobile application.
- Synchronize financial information across supported devices.
- Allow users to access updated financial records from different devices.
- Maintain consistent financial information through a centralized backend.

### 6. Target Users

The primary target users are individuals who want to manage their personal finances in a structured and organized manner.

The system is particularly suitable for individuals who:

- Manage money across multiple bank accounts and cash wallets.
- Regularly track daily expenses and personal budgets.
- Maintain separate savings records.
- Need to monitor money lent to other individuals.
- Prefer accessing their financial information through multiple devices.

The system will initially be designed around an individual personal finance management workflow while supporting the possibility of use by multiple independent users.

### 7. Proposed Technology Stack

The following technologies are proposed for the development of the system.

| Component | Technology |
|---|---|
| Web Frontend | Next.js, TypeScript |
| Mobile Application | React Native, Expo |
| Backend | Java, Spring Boot |
| Software Architecture | Microservices Architecture |
| Database | PostgreSQL |
| ORM | Spring Data JPA, Hibernate |
| API Gateway | Spring Cloud Gateway |
| Authentication | Spring Security, JWT |
| Inter-Service Communication | REST APIs, RabbitMQ where required |
| Database Migration | Flyway |
| API Documentation | Swagger / OpenAPI |
| Containerization | Docker |
| Container Orchestration | Kubernetes |
| Version Control | Git, GitHub |

### 8. Project Scope

The project focuses on developing a personal finance management platform that supports the following activities:

- Manual recording and management of financial transactions.
- Management of multiple personal bank accounts and cash wallets.
- Income and expense categorization.
- Daily food budget allocation and tracking.
- Separate savings management.
- Recording and monitoring of lending activities.
- Generation of financial summaries and reports.
- Secure access through web and mobile applications.
- Synchronization of financial information across devices.

The application will not directly connect to users' bank accounts. Financial transactions and account information will be entered manually by users. This approach provides users with control over the financial information stored in the application.

### 9. Expected Outcome

The expected outcome is a functional personal finance management system that provides a centralized platform for recording, organizing, and monitoring personal financial activities.

The application is expected to reduce the effort required for manual financial tracking, improve the visibility of personal financial information, and help users understand their spending and savings patterns.

From a technical perspective, the project will demonstrate the practical application of modern software engineering concepts, including microservices architecture, layered backend development, RESTful API design, relational database management, authentication and authorization, containerization, and application deployment.

