# Software Requirements Specification (SRS)
## Personal Finance Management System

**Document Version:** 1.0  
**Document Status:** Initial Draft  
**Project Name:** Personal Finance Management System

---

# 1. Introduction

## 1.1 Purpose

The purpose of this Software Requirements Specification (SRS) is to define the functional and non-functional requirements of the Personal Finance Management System.

This document describes the expected system behaviour, features, user interactions, external interfaces, constraints, and quality requirements. It will serve as a reference throughout the system design, development, testing, and deployment phases.

The intended audience includes the project developer, supervisors, testers, and other individuals involved in reviewing or evaluating the system.

## 1.2 Project Scope

The Personal Finance Management System is a web and mobile-based application designed to help individuals manage their personal financial activities through a centralized platform.

The system will provide facilities for:

- Managing multiple bank accounts and financial wallets.
- Recording income and expenses.
- Tracking daily budgets and food expenditure.
- Managing savings.
- Recording money lent to other individuals and repayments.
- Monitoring financial balances.
- Generating financial reports and summaries.
- Accessing synchronized financial information through web and mobile applications.

The application will use manually entered financial information rather than directly connecting to external bank accounts.

## 1.3 Intended Users

The system is intended for individuals who want to manage their personal finances using a centralized digital platform.

The initial system will support independent user accounts, where each user manages their own financial information.

## 1.4 Definitions and Abbreviations

| Term | Description |
|---|---|
| User | An individual registered with the application. |
| Account | A financial account, such as a bank account. |
| Wallet | A financial location used to maintain and track money, such as physical cash or food savings. |
| Transaction | A recorded financial activity that affects an account or wallet. |
| Income | Money received by the user. |
| Expense | Money spent by the user on goods or services. |
| Internal Transfer | Movement of money between financial accounts or wallets owned by the same user. |
| Lending | Money given to another individual with an expectation of repayment. |
| Repayment | Money received from an individual to settle an outstanding lending amount. |
| Daily Budget | A predefined amount allocated for daily food expenses. |
| Food Savings | Money accumulated from unspent daily food budgets. |
| SRS | Software Requirements Specification. |
| API | Application Programming Interface. |

---

# 2. Overall Description

## 2.1 Product Perspective

The proposed system will be developed as a centralized personal finance management platform consisting of a web application, a mobile application, and a backend system.

Both frontend applications will communicate with the backend through APIs. The backend will manage business operations, financial records, user authentication, and data synchronization.

The backend is planned to follow a microservices architecture, with individual services responsible for specific business functionalities.

PostgreSQL will be used for persistent data storage.

## 2.2 Product Functions

The major functions of the system include:

1. User registration and authentication.
2. Financial account and wallet management.
3. Income and expense recording.
4. Transaction categorization and history management.
5. Internal fund transfers.
6. Daily food budget management.
7. Savings management.
8. Lending and repayment tracking.
9. Financial reporting and analytics.
10. Synchronization between web and mobile applications.

## 2.3 User Characteristics

The application is intended for general users with basic knowledge of using computers or smartphones.

Users should be able to perform common financial management activities without requiring advanced technical or accounting knowledge.

The user interface should therefore be simple, understandable, and consistent across supported platforms.

## 2.4 Operating Environment

The system is expected to operate in the following environments:

| Component | Environment / Technology |
|---|---|
| Web Application | Modern web browsers |
| Mobile Application | Android and iOS |
| Web Frontend | Next.js and TypeScript |
| Mobile Frontend | React Native and Expo |
| Backend | Java and Spring Boot |
| Database | PostgreSQL |
| Communication | REST APIs |
| Containerization | Docker |
| Orchestration | Kubernetes |

## 2.5 Design and Implementation Constraints

- The backend will follow a microservices architecture.
- Each backend service will follow an appropriate layered design.
- The system will use PostgreSQL for relational data management.
- Communication between frontend applications and backend services will take place through APIs.
- Financial transactions will be entered manually by users.
- The system will not directly retrieve bank transactions through banking APIs.
- Access to financial information must be restricted to the authorized user.
- Financial records must be maintained consistently across supported devices.

## 2.6 Assumptions and Dependencies

The following assumptions are considered during the initial requirements definition:

- Users have access to an internet connection when using the synchronized application.
- Users are responsible for entering accurate financial information.
- Each user manages their own financial records.
- Users have at least one supported device.
- The backend and database services will be available for normal application operations.
- Financial amounts will initially be maintained in a single configured currency, with Sri Lankan Rupees (LKR) as the initial currency.
- The application will use a centralized backend to synchronize information between devices.

---

# 3. User Roles and Permissions

## 3.1 Registered User

A registered user is the primary user of the system.

The registered user should be able to:

- Register and log in.
- Manage personal financial accounts and wallets.
- Record and manage income and expenses.
- Manage daily budgets.
- Track savings.
- Record lending activities and repayments.
- View financial reports.
- Update personal account information.
- Access personal financial information through supported devices.

## 3.2 System Administrator

Administrative access may be required for technical system maintenance and operational management.

Administrative functions will be restricted and separated from ordinary personal financial management activities.

The detailed administrative permission model will be defined during system design.

---

# 4. Functional Requirements

Functional requirements describe the operations and services that the system must provide.

Each requirement is assigned a unique identifier for reference during development and testing.

## 4.1 User Authentication and Management

| ID | Requirement | Priority |
|---|---|---|
| FR-001 | The system shall allow new users to register using the required account information. | High |
| FR-002 | The system shall allow registered users to log in securely. | High |
| FR-003 | The system shall allow users to log out of the application. | High |
| FR-004 | The system shall provide mechanisms for users to recover access to their accounts. | Medium |
| FR-005 | The system shall allow users to manage their basic profile information. | Medium |
| FR-006 | The system shall restrict access to financial information based on user authorization. | High |

## 4.2 Account and Wallet Management

| ID | Requirement | Priority |
|---|---|---|
| FR-007 | The system shall allow users to create and manage multiple financial accounts and wallets. | High |
| FR-008 | The system shall support different financial account types, including bank accounts and cash wallets. | High |
| FR-009 | The system shall allow users to provide a name and relevant details for each account or wallet. | High |
| FR-010 | The system shall maintain the current balance of each account or wallet. | High |
| FR-011 | The system shall allow users to view the transaction history of individual accounts and wallets. | High |
| FR-012 | The system shall allow users to update or deactivate accounts and wallets while preserving historical financial records. | Medium |
| FR-013 | The system shall allow users to view the combined balance of their financial accounts and wallets. | High |

## 4.3 Income and Expense Management

| ID | Requirement | Priority |
|---|---|---|
| FR-014 | The system shall allow users to record income transactions manually. | High |
| FR-015 | The system shall allow users to record expense transactions manually. | High |
| FR-016 | The system shall allow users to provide transaction details, including amount, date, description, and category. | High |
| FR-017 | The system shall allow users to select the account or wallet associated with a transaction. | High |
| FR-018 | The system shall provide predefined transaction categories. | Medium |
| FR-019 | The system shall allow users to create and manage custom transaction categories. | Medium |
| FR-020 | The system shall allow users to view transaction histories. | High |
| FR-021 | The system shall allow users to search and filter transactions by date, category, transaction type, and account or wallet. | High |
| FR-022 | The system shall allow users to edit or delete eligible transaction records while maintaining financial consistency. | Medium |

## 4.4 Internal Fund Transfers

| ID | Requirement | Priority |
|---|---|---|
| FR-023 | The system shall allow users to transfer money between their own financial accounts and wallets. | High |
| FR-024 | The system shall require users to specify the source account, destination account, transfer amount, and date. | High |
| FR-025 | The system shall decrease the source balance and increase the destination balance when a transfer is successfully recorded. | High |
| FR-026 | The system shall maintain a record of each internal transfer. | High |
| FR-027 | The system shall prevent a transfer from being completed when the source account does not have sufficient available funds, subject to the configured account rules. | High |
| FR-028 | The system shall exclude internal transfers from ordinary income and expense totals. | High |

## 4.5 Daily Food Budget Management

| ID | Requirement | Priority |
|---|---|---|
| FR-029 | The system shall allow users to configure a daily food budget. | High |
| FR-030 | The system shall allow users to record breakfast expenses separately. | High |
| FR-031 | The system shall allow users to record lunch expenses separately. | High |
| FR-032 | The system shall allow users to record dinner expenses separately. | High |
| FR-033 | The system shall calculate the total food expenditure for each day. | High |
| FR-034 | The system shall calculate the remaining daily food budget. | High |
| FR-035 | The system shall record unspent daily food budget amounts as food savings. | High |
| FR-036 | The system shall maintain a separate food savings balance. | High |
| FR-037 | The system shall provide a mechanism to manage days when food expenditure exceeds the allocated daily budget. | High |
| FR-038 | The system shall allow users to view historical daily food budgets, meal expenses, and savings. | High |

## 4.6 Savings Management

| ID | Requirement | Priority |
|---|---|---|
| FR-039 | The system shall allow users to maintain separate savings records. | High |
| FR-040 | The system shall allow users to record additions to and withdrawals from savings. | High |
| FR-041 | The system shall maintain the current balance of each savings wallet or account. | High |
| FR-042 | The system shall allow users to view historical savings activities. | Medium |
| FR-043 | The system shall display accumulated savings over a selected period. | Medium |

## 4.7 Lending Management

| ID | Requirement | Priority |
|---|---|---|
| FR-044 | The system shall allow users to record money lent to other individuals. | High |
| FR-045 | The system shall allow users to record the borrower's name, lending amount, date, and description. | High |
| FR-046 | The system shall associate a lending transaction with the financial account or wallet from which the money was provided. | High |
| FR-047 | The system shall maintain the outstanding amount for each lending record. | High |
| FR-048 | The system shall allow users to record full or partial repayments. | High |
| FR-049 | The system shall update the outstanding lending amount when a repayment is recorded. | High |
| FR-050 | The system shall maintain repayment histories for individual lending records. | High |
| FR-051 | The system shall display the total outstanding lending amount. | High |
| FR-052 | The system shall distinguish lending activities from ordinary expenses in financial reports. | High |

## 4.8 Financial Reports and Analytics

| ID | Requirement | Priority |
|---|---|---|
| FR-053 | The system shall generate monthly financial summaries. | High |
| FR-054 | The system shall display total income and expenses for a selected period. | High |
| FR-055 | The system shall display current balances of individual accounts and wallets. | High |
| FR-056 | The system shall provide expense breakdowns by category. | High |
| FR-057 | The system shall provide daily food expenditure and savings summaries. | High |
| FR-058 | The system shall display total accumulated savings. | Medium |
| FR-059 | The system shall display outstanding lending amounts and repayment information. | High |
| FR-060 | The system shall provide graphical representations of relevant financial information. | Medium |
| FR-061 | The system shall allow users to filter reports by selected dates or periods. | High |

## 4.9 Multi-Device Synchronization

| ID | Requirement | Priority |
|---|---|---|
| FR-062 | The system shall provide access through web and mobile applications. | High |
| FR-063 | The system shall use a centralized backend to maintain financial information. | High |
| FR-064 | The system shall synchronize financial records across supported devices. | High |
| FR-065 | The system shall reflect successfully saved changes when the user accesses the application from another supported device. | High |
| FR-066 | The system shall prevent unauthorized users from accessing synchronized financial information. | High |

## 4.10 Data Management

| ID | Requirement | Priority |
|---|---|---|
| FR-067 | The system shall store user and financial information persistently. | High |
| FR-068 | The system shall validate financial information before saving records. | High |
| FR-069 | The system shall prevent invalid transaction amounts and incomplete mandatory information from being saved. | High |
| FR-070 | The system shall maintain historical financial records when accounts or wallets are deactivated. | High |
| FR-071 | The system shall provide appropriate mechanisms for backing up and recovering financial information. | High |

---

# 5. Non-Functional Requirements

Non-functional requirements define the quality attributes and operational expectations of the system.

## 5.1 Security

| ID | Requirement |
|---|---|
| NFR-001 | The system shall authenticate users before granting access to protected functionality. |
| NFR-002 | The system shall ensure that users can access only their own financial records. |
| NFR-003 | Sensitive information shall be protected during communication between clients and backend services. |
| NFR-004 | Passwords shall be stored using secure password-hashing mechanisms rather than plain text. |
| NFR-005 | Authentication tokens and sensitive configuration information shall be handled securely. |
| NFR-006 | The system shall validate and authorize requests before performing financial operations. |

## 5.2 Performance

| ID | Requirement |
|---|---|
| NFR-007 | Common application operations should respond within an acceptable time under normal operating conditions. |
| NFR-008 | The system should efficiently retrieve transaction histories and financial summaries. |
| NFR-009 | The system should support multiple registered users without significant degradation in normal usage. |
| NFR-010 | Financial calculations should be performed accurately and consistently. |

## 5.3 Reliability and Data Integrity

| ID | Requirement |
|---|---|
| NFR-011 | The system shall maintain accurate financial balances. |
| NFR-012 | Financial operations shall be protected against incomplete or duplicate processing. |
| NFR-013 | The system shall preserve financial records during normal application operations. |
| NFR-014 | Failed financial operations shall not leave partially updated account balances. |
| NFR-015 | The system shall maintain consistency between financial transactions and their corresponding balance changes. |

## 5.4 Usability

| ID | Requirement |
|---|---|
| NFR-016 | The application shall provide a simple and understandable user interface. |
| NFR-017 | Common financial activities should be accessible with minimal navigation. |
| NFR-018 | The web and mobile applications should provide consistent functionality and terminology. |
| NFR-019 | The application shall display clear validation messages and operation feedback. |

## 5.5 Scalability

| ID | Requirement |
|---|---|
| NFR-020 | The backend architecture should support the independent development and scaling of individual services. |
| NFR-021 | The database design should support increasing amounts of financial records. |
| NFR-022 | The system should support the future introduction of additional financial management features. |

## 5.6 Maintainability

| ID | Requirement |
|---|---|
| NFR-023 | The backend services shall follow a structured and maintainable code organization. |
| NFR-024 | The system shall maintain appropriate technical documentation. |
| NFR-025 | The system shall support automated testing of important business functionalities. |
| NFR-026 | The system shall use version control to manage source code changes. |

## 5.7 Portability and Compatibility

| ID | Requirement |
|---|---|
| NFR-027 | The web application shall support commonly used modern web browsers. |
| NFR-028 | The mobile application shall target supported Android and iOS devices. |
| NFR-029 | The system should support deployment in containerized environments. |

---

# 6. External Interface Requirements

## 6.1 User Interface Requirements

The system shall provide separate web and mobile interfaces.

The interfaces should include:

- User registration and login screens.
- Dashboard displaying financial summaries.
- Account and wallet management screens.
- Income and expense entry screens.
- Transaction history screens.
- Daily food budget screens.
- Savings management screens.
- Lending and repayment screens.
- Reports and analytics screens.
- User profile and settings screens.

The interfaces should be responsive and provide a consistent user experience.

## 6.2 Software Interface Requirements

The system is expected to interact with the following software components:

| Component | Purpose |
|---|---|
| Next.js Web Application | Provides the web-based user interface. |
| React Native Mobile Application | Provides the mobile user interface. |
| Spring Boot Backend Services | Implements application business logic. |
| PostgreSQL | Stores application data. |
| Spring Cloud Gateway | Provides a centralized API entry point. |
| Spring Security | Handles authentication and authorization. |
| REST APIs | Support communication between frontend and backend services. |

## 6.3 Communication Interface Requirements

- The web and mobile applications shall communicate with backend services through HTTP-based APIs.
- Secure HTTPS communication shall be used in deployed environments.
- Backend services shall exchange information through defined service interfaces.
- Appropriate error responses shall be returned when requests cannot be completed.

---

# 7. Data Requirements

## 7.1 User Data

The system shall maintain information required to identify and manage registered users.

## 7.2 Account and Wallet Data

The system shall maintain:

- Account or wallet name.
- Account or wallet type.
- Opening balance, where applicable.
- Current balance.
- Creation and modification information.
- Associated user information.

## 7.3 Transaction Data

The system shall maintain:

- Transaction identifier.
- Transaction type.
- Amount.
- Date and time.
- Description.
- Category.
- Associated account or wallet.
- Associated user.

## 7.4 Budget Data

The system shall maintain:

- Daily budget amount.
- Budget date.
- Breakfast expenditure.
- Lunch expenditure.
- Dinner expenditure.
- Total food expenditure.
- Remaining budget or deficit.
- Associated food savings information.

## 7.5 Lending Data

The system shall maintain:

- Lending record identifier.
- Borrower information.
- Original lending amount.
- Lending date.
- Outstanding amount.
- Repayment records.
- Lending status.

## 7.6 Financial Data Accuracy

The system shall use appropriate numeric data types for monetary values and avoid floating-point calculations that could introduce financial rounding errors.

Financial transactions, balance changes, transfers, and repayments must be recorded consistently.

---

# 8. System Constraints

The following constraints apply to the proposed system:

1. Financial transactions will be entered manually by users.
2. Direct bank account integration is outside the initial project scope.
3. The initial application will use Sri Lankan Rupees (LKR) as its configured currency.
4. The application requires backend connectivity for synchronized operations.
5. Financial records must be isolated between different users.
6. The backend will be developed using Java and Spring Boot.
7. PostgreSQL will be used as the primary relational database.
8. The system will be developed and deployed using containerization technologies as part of the project.

---

# 9. Out of Scope

The following functionalities are not included in the initial version of the system:

- Direct integration with banking systems.
- Automatic retrieval of bank transactions.
- Automatic processing of bank payments.
- Investment portfolio management.
- Stock market and cryptocurrency tracking.
- Loan application and loan approval management.
- Tax calculation and tax filing.
- Business accounting and organizational financial management.

These functionalities may be considered for future enhancements if required.

---

# 10. Future Enhancements

The following features may be considered for future versions:

- Importing financial transactions from Excel or CSV files.
- Support for multiple currencies.
- Recurring income and expense management.
- Financial goals and savings targets.
- Budget notifications and reminders.
- Advanced spending analysis.
- Exporting financial reports to PDF or Excel.
- Offline transaction entry with synchronization when connectivity is restored.

---

# 11. Acceptance Criteria

The initial system will be considered functionally acceptable when the following conditions are satisfied:

1. Users can register, log in, and access their own financial information.
2. Users can create and manage multiple accounts and wallets.
3. Users can record income and expenses and view their transaction histories.
4. Internal transfers correctly update the source and destination balances without being counted as expenses.
5. Users can maintain daily food budgets and record individual meal expenses.
6. The system correctly calculates daily food expenditure and remaining budget amounts.
7. Users can maintain separate savings records.
8. Users can record lending activities and repayments and view outstanding amounts.
9. Financial reports accurately represent income, expenses, savings, transfers, and lending activities.
10. Financial information is synchronized between the web and mobile applications.
11. Unauthorized users cannot access another user's financial information.
12. Financial operations maintain consistent balances and transaction records.

---

# 12. Document Status

This SRS represents the initial requirements specification for the Personal Finance Management System.

Requirements may be refined during subsequent system analysis and design activities. Detailed financial calculation rules, service responsibilities, database structures, and API contracts will be documented separately.

