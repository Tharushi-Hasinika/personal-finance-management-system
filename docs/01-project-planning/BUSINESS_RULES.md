# Business Rules
## Personal Finance Management System

**Document Version:** 1.0  
**Document Status:** Initial Draft

---

# 1. Introduction

This document defines the business rules governing financial operations within the Personal Finance Management System.

It establishes how accounts, wallets, transactions, budgets, savings, lending activities, and financial reports should behave.

These rules are intended to ensure that all financial calculations are accurate, consistent, and predictable throughout the application.

# 2. Financial Account and Wallet Management

## BR-001: Financial Account Classification

The system shall support different types of financial accounts and wallets.

The initial financial structure shall include:

| Account / Wallet | Description |
|---|---|
| Bank Savings | A bank account primarily used to maintain savings. |
| Bank Daily | A bank account used for regular financial activities. |
| On-Hand | A wallet representing physical cash available for daily expenses. |
| Food Savings | A separate wallet used to accumulate unspent daily food budget amounts. |

Users may create additional accounts and wallets when required.

## BR-002: Independent Balance Management

Each account or wallet shall maintain its own balance.

A transaction affecting one account shall not directly change another account unless the operation is an internal transfer or an explicitly defined financial operation.

## BR-003: Opening Balance

When creating an account or wallet, the user shall be able to specify its opening balance.

The opening balance shall represent the amount available in that account at the time it is introduced into the system.

The opening balance shall be recorded as the initial financial position rather than as ordinary income.

## BR-004: Balance Calculation

The balance of an account or wallet shall be calculated using its opening balance and subsequent financial activities.

**General formula:**

Current Balance = Opening Balance + Total Inflows - Total Outflows

Only financial activities that affect the relevant account or wallet shall be included.

# 3. Income and Expense Management

## BR-005: Income Recording

Income shall represent money received by the user from an external source.

Examples include:

- Salary or internship allowance.
- Gifts received.
- Other personal income.

When income is recorded, the selected account or wallet balance shall increase by the recorded amount.

## BR-006: Expense Recording

An expense shall represent money spent on goods, services, or other personal consumption.

Examples include:

- Food purchases.
- Transportation.
- Stationery.
- Personal purchases.

When an expense is recorded, the selected account or wallet balance shall decrease by the recorded amount.

## BR-007: Transaction Validation

Every transaction shall:

- Have a valid positive amount.
- Be associated with a valid account or wallet.
- Have a transaction date.
- Have a valid transaction type.
- Include mandatory information required by its transaction category.

## BR-008: Transaction Editing and Deletion

When a transaction is edited or deleted, the system shall ensure that the corresponding account or wallet balances are recalculated or adjusted correctly.

Historical financial information shall not become inconsistent as a result of modifying a transaction.

# 4. Internal Fund Transfers

## BR-009: Definition of Internal Transfers

An internal transfer represents the movement of money between two financial accounts or wallets owned by the same user.

Examples include:

- Bank Daily to On-Hand.
- Bank Savings to Bank Daily.
- On-Hand to Food Savings, where applicable.

## BR-010: Transfer Balance Calculation

When an internal transfer is successfully completed:

- The transfer amount shall be deducted from the source account.
- The same amount shall be added to the destination account.

**Example:**

A user transfers Rs. 5,000 from Bank Daily to On-Hand.

| Account | Before Transfer | After Transfer |
|---|---:|---:|
| Bank Daily | Rs. 20,000 | Rs. 15,000 |
| On-Hand | Rs. 2,000 | Rs. 7,000 |

The total money owned by the user remains unchanged.

## BR-011: Transfer Classification

Internal transfers shall not be classified as income or expenses.

They shall be recorded separately and excluded from ordinary income and expense calculations.

## BR-012: Transfer Validation

The system shall validate that:

- The source and destination accounts are different.
- Both accounts belong to the same user.
- The transfer amount is valid.
- The source account has sufficient available funds, subject to its configured balance rules.

A transfer shall be completed as one logical operation. If either balance update fails, the system shall not leave only one side of the transfer applied.

# 5. Daily Food Budget Management

## BR-013: Daily Food Budget Allocation

The user shall define a daily food budget.

The system shall use the configured amount when calculating daily food expenditure and remaining balances.

The daily budget may be updated by the user when required.

## BR-014: Meal Expense Recording

The system shall support separate expense records for:

- Breakfast.
- Lunch.
- Dinner.

Each meal expense shall be associated with a specific date.

Additional meal entries may be supported if required.

## BR-015: Daily Food Expenditure Calculation

The total daily food expenditure shall be calculated as:

**Total Food Expenditure = Breakfast + Lunch + Dinner**

Example:

| Meal | Amount |
|---|---:|
| Breakfast | Rs. 170 |
| Lunch | Rs. 75 |
| Dinner | Rs. 180 |
| **Total** | **Rs. 425** |

## BR-016: Daily Budget Surplus

When total food expenditure is less than the allocated daily budget, the remaining amount shall be treated as food savings.

**Formula:**

Food Savings = Daily Budget - Total Food Expenditure

Example:

| Description | Amount |
|---|---:|
| Daily Budget | Rs. 550 |
| Total Food Expenditure | Rs. 425 |
| Food Savings | Rs. 125 |

The surplus amount of Rs. 125 shall be transferred from the On-Hand wallet to the Food Savings wallet.

## BR-017: Daily Budget Deficit

When total food expenditure exceeds the allocated daily budget, the difference shall be treated as a food budget deficit.

**Formula:**

Food Budget Deficit = Total Food Expenditure - Daily Budget

Example:

| Description | Amount |
|---|---:|
| Daily Budget | Rs. 550 |
| Total Food Expenditure | Rs. 650 |
| Food Budget Deficit | Rs. 100 |

According to the intended financial workflow, the deficit shall be covered using the Food Savings wallet.

The system shall transfer the required amount from Food Savings to On-Hand to cover the additional food expenditure.

If the available Food Savings balance is insufficient, the system shall identify the uncovered amount and request an appropriate resolution rather than silently creating money or an invalid balance.

## BR-018: Food Savings Balance

The Food Savings wallet shall maintain the accumulated amount from unspent daily food budgets.

Its balance shall be updated based on:

- Daily food budget surpluses.
- Transfers used to cover food budget deficits.
- Other explicitly recorded adjustments or withdrawals.

**General formula:**

Food Savings Balance = Opening Balance + Total Surplus Transfers - Total Deficit Transfers + Other Inflows - Other Outflows

## BR-019: Daily Food Budget Independence

Each day's food budget shall be calculated independently.

An unused budget from one day shall not automatically increase the following day's allocated food budget.

Instead, the unspent amount shall be recorded in Food Savings.

# 6. Savings Management

## BR-020: Savings Classification

Savings shall represent money intentionally retained for future use rather than ordinary spending.

The system shall distinguish savings movements from income and expenses.

## BR-021: Savings Additions

When money is added to a savings wallet, the corresponding balance shall increase.

If the money is transferred from another owned account or wallet, the operation shall be classified as an internal transfer rather than new income.

## BR-022: Savings Withdrawals

When money is withdrawn from savings and moved to another owned account or wallet, the operation shall be recorded as an internal transfer.

When savings are used for an actual purchase, the purchase shall be recorded as an expense associated with the account or wallet from which the money is spent.

# 7. Lending Management

## BR-023: Lending Classification

Money lent to another individual shall be treated as a receivable rather than an ordinary expense.

The amount represents money expected to be returned.

## BR-024: Lending Transaction Recording

When recording a lending transaction, the system shall maintain:

- Borrower's name.
- Lending amount.
- Lending date.
- Source account or wallet.
- Description or additional notes.
- Outstanding amount.

## BR-025: Lending Balance Calculation

When money is lent, the selected source account or wallet balance shall decrease by the lending amount.

The outstanding lending amount shall increase by the same amount.

**Example:**

A user lends Rs. 2,000 from On-Hand.

| Description | Amount |
|---|---:|
| On-Hand Before Lending | Rs. 5,000 |
| Amount Lent | Rs. 2,000 |
| On-Hand After Lending | Rs. 3,000 |
| Outstanding Lending | Rs. 2,000 |

The lending amount shall not be included in ordinary expense totals.

## BR-026: Repayment Recording

When a borrower repays money:

- The repayment amount shall be added to the selected receiving account or wallet.
- The outstanding lending amount shall decrease by the repayment amount.
- A repayment record shall be maintained.

## BR-027: Partial Repayments

The system shall support multiple repayments against a single lending record.

The outstanding amount shall be calculated as:

Outstanding Amount = Original Lending Amount - Total Repayments

Example:

| Description | Amount |
|---|---:|
| Original Lending | Rs. 5,000 |
| First Repayment | Rs. 2,000 |
| Second Repayment | Rs. 1,000 |
| **Outstanding Amount** | **Rs. 2,000** |

## BR-028: Lending Completion

A lending record shall be considered settled when its outstanding amount becomes zero.

The system shall not allow repayments exceeding the outstanding amount.

# 8. Financial Reporting Rules

## BR-029: Income Calculation

Total income for a selected period shall include valid income transactions recorded during that period.

Internal transfers and loan repayments shall not be included as ordinary income.

## BR-030: Expense Calculation

Total expenses for a selected period shall include valid expense transactions recorded during that period.

The following shall not be classified as ordinary expenses:

- Internal transfers.
- Money lent to others.
- Transfers into savings.
- Transfers between financial wallets.

## BR-031: Lending Reporting

Lending reports shall display:

- Total amount lent.
- Total amount repaid.
- Current outstanding amount.

These values shall be presented separately from ordinary expenses.

## BR-032: Savings Reporting

Savings reports shall display accumulated savings and movements over the selected period.

Transfers between owned accounts shall not be treated as new income or expenses.

## BR-033: Monthly Financial Summary

The monthly summary shall provide information about:

- Total income.
- Total expenses.
- Account and wallet balances.
- Food expenditure.
- Food budget savings and deficits.
- Savings movements.
- Lending activities and repayments.
- Outstanding lending amounts.

The report shall distinguish actual spending from transfers and lending activities to avoid misleading financial totals.

# 9. Data Integrity and Financial Accuracy

## BR-034: Positive Transaction Amounts

All financial transaction amounts shall be greater than zero.

Transaction direction shall be determined by the transaction type rather than by entering negative amounts.

## BR-035: Financial Precision

The system shall use appropriate decimal-based numeric types for monetary calculations.

Floating-point arithmetic shall not be used for financial balance calculations.

## BR-036: Balance Consistency

Every completed financial operation shall maintain consistency between transaction records and corresponding account or wallet balances.

## BR-037: Duplicate Operation Prevention

The system shall prevent the same financial operation from being unintentionally processed multiple times.

## BR-038: Historical Record Preservation

Changes to financial records shall not silently remove or distort previously recorded financial activities.

The system shall maintain sufficient transaction history to support accurate financial reporting and auditing.

## BR-039: User Data Isolation

Financial records belonging to one user shall not be accessible to another user without appropriate authorization.

# 10. General Business Principles

The system shall follow these general principles:

1. Every financial movement must have a clearly identified source and destination where applicable.
2. Money moving between accounts owned by the same user shall not create additional income or expenses.
3. Lending shall be treated as an amount receivable rather than ordinary spending.
4. Repayments shall reduce outstanding lending balances.
5. Daily food budget surpluses shall contribute to Food Savings.
6. Daily food budget deficits shall be handled using available Food Savings according to the defined workflow.
7. Financial balances must accurately reflect all completed financial activities.
8. Financial reports must distinguish income, expenses, transfers, savings movements, and lending activities.

# 11. Document Status

This document represents the initial business rules for the Personal Finance Management System.

The rules may be refined during system analysis and implementation. Detailed transaction workflows, edge cases, validation rules, and accounting decisions will be further specified during database design and backend development.

