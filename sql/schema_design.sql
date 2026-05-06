-- =====================================================
-- PART B: DIMENSIONAL MODEL - PALLADIUM BANK
-- STAR SCHEMA IMPLEMENTATION
-- =====================================================

-- Stores customer master data and supports segmentation + SCD Type 2 tracking
CREATE TABLE dim_customer (
    customer_sk INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    tier VARCHAR(20) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    is_current BOOLEAN NOT NULL
);

-- Stores branch details for regional performance and location analysis
CREATE TABLE dim_branch (
    branch_sk INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    branch_id VARCHAR(10) NOT NULL,
    branch_name VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL,
	city VARCHAR(50)
);

-- Stores product details for revenue and product performance analysis
CREATE TABLE dim_product (
    product_sk INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id VARCHAR(10) NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    product_type VARCHAR(50) NOT NULL
);

-- Stores transaction channel such as ATM, POS, Mobile, Internet Banking
CREATE TABLE dim_channel (
    channel_sk INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    channel_name VARCHAR(50) NOT NULL
);

-- Date dimension enabling time-based analytics (MoM, QoQ, YoY comparisons)
CREATE TABLE dim_date (
    date_sk INT PRIMARY KEY,
    full_date DATE NOT NULL,
    year INT NOT NULL,
    quarter INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL,
	week_number INT NOT NULL,
	day_of_week VARCHAR(10) NOT NULL,
	is_weekend BOOLEAN NOT NULL
);

-- Central fact table storing banking transactions at grain: one row per transaction
-- Stores measurable metrics (amount, balance) and links to all dimensions
CREATE TABLE fact_transactions (
    txn_id VARCHAR(20) PRIMARY KEY,
    txn_timestamp TIMESTAMP NOT NULL,
    customer_sk INT NOT NULL,
    branch_sk INT NOT NULL,
    product_sk INT NOT NULL,
    channel_sk INT NOT NULL,
    date_sk INT NOT NULL,
    txn_type VARCHAR(50),
    amount NUMERIC(18,2) NOT NULL,
    balance_after NUMERIC(18,2) NOT NULL,

    FOREIGN KEY (customer_sk) REFERENCES dim_customer(customer_sk),
    FOREIGN KEY (branch_sk) REFERENCES dim_branch(branch_sk),
    FOREIGN KEY (product_sk) REFERENCES dim_product(product_sk),
    FOREIGN KEY (channel_sk) REFERENCES dim_channel(channel_sk),
    FOREIGN KEY (date_sk) REFERENCES dim_date(date_sk)
);