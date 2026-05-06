# 📊 Banking Transaction Analytics — Dimensional Modeling Project

## 🧾 Project Overview

This project focuses on designing a **dimensional data model** for banking transaction analytics. The objective is to transform raw transactional data into a structured data warehouse that supports efficient reporting and business intelligence use cases.

The work simulates a real-world data workflow, covering data understanding, schema design, dimensional modeling, and performance considerations for analytical systems.

---

## 🎯 Objectives

The model is designed to support key analytical use cases:

* Customer behavior analysis (by tier, branch, and activity patterns)
* Product and channel performance tracking
* Branch-level operational reporting
* Detection of churn signals using transaction activity
* Time-based analysis (MoM, QoQ, YoY)

---

## 📁 Dataset Overview

The dataset consists of transactional banking records with the following components:

* `transactions` – transaction-level records (amount, timestamp, balance)
* `customers` – customer identifiers and segmentation (tier)
* `branches` – branch and location details
* `products` – product/service information
* `channels` – transaction channels (ATM, POS, etc.)

---

## 🛠️ Tools & Technologies  
- SQL (PostgreSQL)  
- dbdiagram.io (ERD design)  
- Power BI (dashboarding and reporting)

---

## 🧠 Data Modeling Approach

### Star Schema Design

The model follows a **star schema architecture**, consisting of:

* A central **fact table** capturing transactional events
* Multiple **dimension tables** providing descriptive context

All dimensions connect directly to the fact table using **surrogate keys**, ensuring consistency, scalability, and efficient query performance.

---

### Fact Table

**fact_transactions**

* Grain: *One row per transaction*
* Measures:

  * Transaction amount
  * Balance after transaction

The `txn_id` is retained as a **degenerate dimension** for traceability.

---

### Dimension Tables

* **dim_customer** → Customer attributes and tier classification (SCD Type 2)
* **dim_branch** → Branch and location details
* **dim_product** → Product/service information
* **dim_channel** → Transaction channels
* **dim_date** → Time attributes for analysis

---

## 🔄 Slowly Changing Dimensions (SCD)

* **SCD Type 2 (dim_customer)**
  Preserves historical changes in customer attributes such as tier

* **SCD Type 1 (other dimensions)**
  Overwrites updates where historical tracking is not required

---

## ⚙️ Data Pipeline Strategy

The pipeline follows an **ETL (Extract, Transform, Load)** approach:

* **Extract** → Source transactional data
* **Transform** → Clean, standardize, and structure into dimensional format
* **Load** → Populate dimension tables first, followed by the fact table

### Incremental Loads

* New records identified using transaction timestamps
* Prevents duplicate fact entries and ensures efficient updates

---

## ✅ Data Quality Considerations

* Duplicate transaction detection
* Null validation on key fields
* Referential integrity between fact and dimension tables
* Validation of transaction amounts and balances

---

## 🚀 Performance & Scalability

* Indexing on foreign keys for efficient joins
* Partitioning fact table by date for faster time-based queries
* Pre-aggregated tables (e.g., monthly totals by branch) for frequent reporting

---

## 📦 Deliverables

* Dimensional schema (`.sql`)
* ERD diagram (dbdiagram)
* Analytical report (`.pdf`)
* Power BI dashboard

---

## 📂 Repository Structure

```bash
banking-transaction-analytics/
├── data/
│   └── sample_dataset.sql
├── sql/
│   ├── schema_design.sql
│   └── transformations.sql
├── docs/
│   └── dimensional_model_report.pdf
├── erd/
│   └── schema_diagram.png
├── dashboard/
│   └── powerbi_dashboard.pbix
└── README.md
```

---

## 🚀 Key Takeaway

This project demonstrates how transactional data can be transformed into a scalable **analytical data model** using dimensional modeling techniques, enabling efficient reporting, historical tracking, and business decision support.

---

## 🔗 Acknowledgment

Completed as part of the HNG Data Analytics Internship Program.

---

## 👤 Author

**Emmanuel Achugo**
Data Analyst
SQL • Python • Power BI • Machine Learning
