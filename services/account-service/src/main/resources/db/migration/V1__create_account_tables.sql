-- =============================================
-- Table: account
-- =============================================

CREATE TABLE account (
    account_id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    account_name VARCHAR(100) NOT NULL,
    account_type VARCHAR(30) NOT NULL,
    institution_name VARCHAR(150),
    currency CHAR(3) NOT NULL DEFAULT 'LKR',
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    is_default BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_account_name
        CHECK (TRIM(account_name) <> ''),

    CONSTRAINT chk_account_type
        CHECK (account_type IN (
            'BANK', 'CASH', 'WALLET', 'OTHER'
        )),

    CONSTRAINT chk_account_currency
        CHECK (currency = 'LKR'),

    CONSTRAINT chk_account_status
        CHECK (status IN ('ACTIVE', 'INACTIVE'))
);

-- =============================================
-- Table: account_balance
-- =============================================

CREATE TABLE account_balance (
    balance_id UUID PRIMARY KEY,
    account_id UUID NOT NULL,
    current_balance DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    version BIGINT NOT NULL DEFAULT 0,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_balance_account
        FOREIGN KEY (account_id)
        REFERENCES account(account_id)
        ON DELETE RESTRICT,

    CONSTRAINT uq_balance_account
        UNIQUE (account_id),

    CONSTRAINT chk_current_balance
        CHECK (current_balance >= 0),

    CONSTRAINT chk_balance_version
        CHECK (version >= 0)
);

-- =============================================
-- Table: account_ledger_entry
-- =============================================

CREATE TABLE account_ledger_entry (
    entry_id UUID PRIMARY KEY,
    account_id UUID NOT NULL,
    transaction_id UUID,
    operation_id UUID NOT NULL,
    entry_type VARCHAR(10) NOT NULL,
    entry_reason VARCHAR(30) NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    balance_after DECIMAL(15, 2) NOT NULL,
    effective_date DATE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID,

    CONSTRAINT fk_ledger_account
        FOREIGN KEY (account_id)
        REFERENCES account(account_id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_ledger_entry_type
        CHECK (entry_type IN ('CREDIT', 'DEBIT')),

    CONSTRAINT chk_ledger_entry_reason
        CHECK (entry_reason IN (
            'OPENING_BALANCE',
            'INCOME',
            'EXPENSE',
            'TRANSFER',
            'LOAN',
            'REPAYMENT',
            'ADJUSTMENT'
        )),

    CONSTRAINT chk_ledger_amount
        CHECK (amount > 0),

    CONSTRAINT chk_ledger_balance_after
        CHECK (balance_after >= 0),

    CONSTRAINT uq_ledger_operation_account
        UNIQUE (operation_id, account_id)
);

-- =============================================
-- Indexes
-- =============================================

CREATE INDEX idx_account_user_id
    ON account(user_id);

CREATE INDEX idx_account_user_status
    ON account(user_id, status);

CREATE INDEX idx_ledger_account_effective_date
    ON account_ledger_entry(account_id, effective_date);

CREATE INDEX idx_ledger_transaction_id
    ON account_ledger_entry(transaction_id);