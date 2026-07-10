# Banking Operations Simulation: Client Onboarding & Payment Processing

A personal learning project simulating a Banking Operations workflow — client onboarding, payment processing, and exception management — built to understand how retail/corporate banking operations teams work in practice.

This is a self-built simulation using dummy data. It does not represent any real bank, customer, or transaction.

## Project Objective

To demonstrate practical, entry-level understanding of:
- Client onboarding and documentation checks
- Payment processing and maker-checker controls
- Exception handling for failed/pending/reversed payments
- Operations MIS and dashboard reporting
- SQL for operational reporting

## Workflow

```
Client Onboarding  →  Approved customers can transact
        ↓
Payment Processing →  Success / Failed / Pending / Reversed
        ↓
Exception Management → Failed/Pending/Reversed payments are queued,
                        categorised, and resolved
        ↓
Operations Dashboard → KPIs and charts summarise all three stages
Audit Trail          → Logs key status changes for governance
```

## Technology Used

- **Excel** — data tables, COUNTIF/COUNTIFS, SUMIFS, AVERAGEIFS, INDEX-MATCH, conditional formatting, data validation, PivotChart-style dashboard
- **SQL** — 11 reporting queries covering lookups, summaries, and SLA compliance
- **Power BI** — dashboard build guide (see `PowerBI_Build_Guide.md`)

## Folder Structure

```
Banking_Operations_Simulation.xlsx   Core workbook (6 sheets)
SQL_Queries.sql                      11 SQL queries with comments
PowerBI_Build_Guide.md               Step-by-step guide to rebuild the dashboard in Power BI
Project_Report.docx                  Full write-up: scenario, assumptions, learnings
README.md                            This file
```

## Workbook Structure

| Sheet | Contents |
|---|---|
| Client Onboarding | 50 applications (Individual + Corporate), verification status, risk category, TAT, SLA tracking |
| Payment Processing | 120 transactions across UPI/IMPS/NEFT/RTGS/SWIFT with maker-checker |
| Exception Management | 20 exceptions linked to failed/pending/reversed payments, with root cause and resolution |
| Operations Dashboard | Live KPIs, 5 charts, a Customer Lookup tool, and a formula reference table |
| Audit Trail | 20 governance log entries across all three modules |
| Business Rules | 14 operational rules the data follows (SLA, maker-checker separation, exception routing, etc.) |

## How to Use

1. Open `Banking_Operations_Simulation.xlsx` in Excel.
2. Use the filter arrows on each register (Onboarding, Payments, Exceptions, Audit) to slice the data.
3. On the **Operations Dashboard** sheet, type any Customer ID into the lookup cell to pull that customer's record.
4. Run the queries in `SQL_Queries.sql` against a database loaded with the same three tables (or in any SQL practice environment) to reproduce the same reporting in SQL.

## Key Learnings

- How onboarding risk category and documentation completeness affect turnaround time and SLA compliance.
- Why maker-checker separation matters in payment processing controls.
- How failed/pending/reversed payments get triaged into an exception queue and resolved by category.
- How to build KPI dashboards using COUNTIFS/SUMIFS/AVERAGEIFS instead of manual calculation.
- Basic SQL reporting patterns used in banking operations MIS.

## Future Improvements

- Add a Power Query refresh layer to automate loading of new transaction batches.
- Extend the exception workflow with an SLA breach escalation timer.
- Add a second currency/region to simulate cross-border payment nuances.

## Disclaimer

All data in this project is fictional and generated for learning purposes. No real customer, transaction, or bank information is used.
