# Banking Operations Workflow Simulation

**Client Onboarding · Payment Processing · Exception Management**

![Status](https://img.shields.io/badge/status-completed-brightgreen)
![Type](https://img.shields.io/badge/type-self--learning%20portfolio%20project-blue)
![Excel](https://img.shields.io/badge/tool-Excel-217346)
![SQL](https://img.shields.io/badge/tool-SQL-4479A1)
![Power BI](https://img.shields.io/badge/tool-Power%20BI%20(guide)-F2C811)

> A self-directed, self-learning simulation of a bank's Operations function — built to practically understand how client onboarding, payment processing, and exception handling work together. All data is fictional.

---

## 1. Project Overview

This project simulates the day-to-day operational workflow of a bank's Operations team: onboarding a new customer, processing their payment instructions, and handling the exceptions that come up along the way (failed payments, incomplete documents, duplicate transactions). It was built entirely as a **personal learning exercise** — not for or with any company, and not based on any real institution's data or process.

## 2. Business Scenario

A bank's Operations division has two connected responsibilities: bringing new customers onto the platform (onboarding) and executing their payment instructions once they're active. This project simulates both stages for 50 fictional customers and 120 fictional payment transactions — including realistic operational friction like missing documents, failed payments, and reversals — and tracks how each issue gets resolved.

## 3. Objectives

- Build a realistic, end-to-end view of client onboarding through to payment execution
- Practice operational controls: maker-checker separation, SLA tracking, risk categorization
- Learn to categorize and resolve payment exceptions by root cause, not just outcome
- Build a formula-driven Excel MIS dashboard instead of manually computing KPIs
- Practice SQL for the same reporting use cases a real Ops analyst would need

## 4. Project Workflow

```
Client Onboarding
      │  (Approved customers only)
      ▼
Payment Processing  ──────────────►  Success (no further action)
      │
      ▼ (Failed / Pending / Reversed)
Exception Management
      │  (categorized, owned, resolved)
      ▼
Operations Dashboard  ◄── pulls live KPIs from all three stages
Audit Trail            ◄── logs key status changes across all three
```

## 5. Folder Structure

```
Banking-Operations-Workflow-Simulation/
├── README.md
├── Banking_Operations_Simulation.xlsx     # Core workbook — 6 sheets
├── SQL_Queries.sql                        # 11 commented reporting queries
├── PowerBI_Build_Guide.md                 # Step-by-step guide (no live .pbix — see note below)
├── Project_Report.docx                    # Scenario, assumptions, terminology, learnings
├── SOP_Banking_Operations.docx            # Standard Operating Procedure document
└── screenshots/
    ├── 01-onboarding-sheet.png
    ├── 02-payment-processing-sheet.png
    ├── 03-exception-management-sheet.png
    ├── 04-operations-dashboard.png
    └── 05-audit-trail.png
```

## 6. Tools Used

| Tool | Purpose |
|---|---|
| Microsoft Excel | Core data, formulas, dashboard, charts |
| SQL | Operational reporting queries |
| Power BI | Dashboard build guide (self-buildable; see Section 10) |
| Microsoft Word | Project Report & SOP documentation |

## 7. Dataset Overview

All data is **100% fictional**, generated for this simulation only.

| Sheet | Records | Description |
|---|---|---|
| Client Onboarding | 50 | Individual + Corporate applications with document status, risk category, SLA tracking |
| Payment Processing | 120 | Transactions across UPI, IMPS, NEFT, RTGS, SWIFT with maker-checker fields |
| Exception Management | 20 | Failed/Pending/Reversed payments, linked by Transaction ID, categorized by root cause |
| Audit Trail | 20 | Status-change log entries across all three modules |

## 8. Excel Features

- Structured Excel Tables with filter/sort dropdowns on every register
- Formulas used: `IF`, `COUNTIF`/`COUNTIFS`, `SUMIFS`, `AVERAGE`/`AVERAGEIFS`, `INDEX`/`MATCH`
- Live Customer Lookup tool (enter a Customer ID, pull their full record)
- Conditional formatting on all status columns (Approved/Rejected, Success/Failed, etc.)
- Data validation on Risk Category field
- A dedicated "Formulas Used in this Workbook" reference table — every formula is traceable to where it's applied

## 9. SQL Features

11 queries covering:
`Customer Lookup` · `Customer Summary` · `Payment Summary` · `Daily Payments` · `Failed Payments` · `Pending Payments` · `Payment Status Report` · `Exception Report (joined)` · `Average TAT` · `Top Exception Categories` · `SLA Compliance Report`

Each query is commented with what it does and where an Ops team would actually use it (e.g., daily follow-up list, monthly governance review).

## 10. Power BI Dashboard — Guide, Not a Packaged File

**Honest note:** a `.pbix` file requires Power BI Desktop to compile and can't be generated as a static artifact — so this repo includes a **step-by-step build guide** (`PowerBI_Build_Guide.md`) instead of a pre-built file. It covers data load, relationships, DAX measures, visual layout, and slicers, so the dashboard is fully reproducible in under 30 minutes. If you'd rather see it live than read the guide, ask and I can walk through building it.

## 11. Business Rules

14 operational rules the dataset follows, e.g.:
- RTGS permitted only above ₹2,00,000
- Maker and Checker must always be two different individuals
- Any Failed/Pending/Reversed payment is automatically queued as an exception
- High-risk customers require manual document verification
- Sanctions Hold exceptions are always routed to Compliance, not Operations

(Full list in the workbook's **Business Rules** sheet.)

## 12. Audit Trail

A 20-entry governance log recording who changed what, when, and why — across onboarding decisions, payment status changes, and exception resolutions. Modeled on the idea that in real banking Ops, the *history* of a decision matters as much as the decision itself.

## 13. Exception Management

Every payment that isn't a clean Success (Failed / Pending / Reversed) is logged into an exception queue, categorized by root cause (Invalid Account Number, Wrong IFSC, Insufficient Funds, Duplicate Payment, Sanctions Hold, etc.), assigned an owner (Operations or Compliance), and tracked through to resolution with a Resolution TAT.

## 14. Key Learnings

- Document completeness and risk category directly drive onboarding turnaround time and SLA outcomes
- Maker-checker separation is a control, not a formality — it changes how the data itself is structured
- Categorizing exceptions by root cause (not just "failed") is what makes an exception queue actually useful for a manager
- A trustworthy dashboard is one where every number is formula-driven and traceable — not hardcoded

## 15. Skills Demonstrated

Banking Operations · Client Onboarding · Payment Processing · Exception Management · Operational Controls (Maker-Checker) · SLA & TAT Tracking · Excel (COUNTIFS/SUMIFS/AVERAGEIFS/INDEX-MATCH) · SQL Reporting · MIS/Dashboard Design · Process Documentation (SOP)

## 16. Screenshots

*(Add screenshots to the `/screenshots` folder and they'll render below)*

| Screenshot | Description |
|---|---|
| `01-onboarding-sheet.png` | Client Onboarding register with filters and SLA tracking |
| `02-payment-processing-sheet.png` | Payment Processing register with maker-checker fields |
| `03-exception-management-sheet.png` | Exception queue linked to failed/pending/reversed payments |
| `04-operations-dashboard.png` | Live KPI dashboard with charts and Customer Lookup tool |
| `05-audit-trail.png` | Governance log of status changes |

## 17. Future Improvements

- Automate data refresh using Power Query so new transaction batches load without manual formula updates
- Add an SLA breach escalation timer to the exception workflow
- Extend the simulation to a second currency to capture cross-border payment nuances
- Build out the Power BI dashboard live and publish a shareable link

## 18. Disclaimer

This is a **self-learning portfolio project**. All customer names, transaction values, and identifiers are fictional and randomly generated. This project does not represent, was not built for, and is not affiliated with any real bank, financial institution, or employer. No confidential, proprietary, or real operational data is used anywhere in this repository.

---

### Recruiter-Friendly Summary

*A fresher-built simulation of banking Ops onboarding-to-payment-to-exception workflow, with a formula-driven Excel dashboard and 11 SQL reporting queries — built to demonstrate practical understanding of maker-checker controls, SLA tracking, and exception root-cause analysis before any live BFSI experience.*
