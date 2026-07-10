# Power BI Dashboard — Build Guide

A `.pbix` file can't be generated directly in this environment (it needs the Power BI Desktop application to compile). This guide lets you rebuild the same dashboard yourself in under 30 minutes — and being able to build it live is also better for an interview than just showing a static file.

## Step 1 — Load the data
1. Open Power BI Desktop → **Get Data → Excel Workbook**.
2. Select `Banking_Operations_Simulation.xlsx`.
3. Load these three tables (not the Dashboard/Audit/Business Rules sheets): **Client Onboarding**, **Payment Processing**, **Exception Management**.

## Step 2 — Set relationships
Go to **Model view** and create:
- `Client Onboarding[Customer ID]` → `Payment Processing[Customer ID]` (one-to-many)
- `Payment Processing[Transaction ID]` → `Exception Management[Linked Transaction ID]` (one-to-many)

## Step 3 — Add measures (DAX)
Create a new table or use the fields pane to add these measures — all beginner-level:

```dax
Total Applications = COUNTROWS('Client Onboarding')

Approval Rate =
DIVIDE(
    CALCULATE(COUNTROWS('Client Onboarding'), 'Client Onboarding'[Final Status] = "Approved"),
    [Total Applications]
)

Avg Onboarding TAT = AVERAGE('Client Onboarding'[Turnaround Time])

Payment Success Rate =
DIVIDE(
    CALCULATE(COUNTROWS('Payment Processing'), 'Payment Processing'[Payment Status] = "Success"),
    COUNTROWS('Payment Processing')
)

Total Exceptions = COUNTROWS('Exception Management')

Avg Resolution TAT =
CALCULATE(
    AVERAGE('Exception Management'[Resolution TAT]),
    'Exception Management'[Current Status] = "Resolved"
)
```

## Step 4 — Build the report page
Layout (single page, "Banking Operations Overview"):

- **Top row — Cards**: Total Applications, Approval Rate, Payment Success Rate, Total Exceptions
- **Left — Bar chart**: Applications by Final Status (Approved/Rejected/Pending)
- **Middle — Pie chart**: Payment Status breakdown (Success/Failed/Pending/Reversed)
- **Right — Bar chart**: Exception Category breakdown
- **Bottom — Line chart**: Payments processed by Payment Date (trend over time)

## Step 5 — Add slicers
Add slicers for:
- **Customer Type** (Individual/Corporate)
- **Payment Type** (UPI/IMPS/NEFT/RTGS/SWIFT)
- **Risk Category** (Low/Medium/High)

These let a reviewer filter the whole dashboard live during a walkthrough — this is the interactive piece Excel alone can't fully replicate.

## Step 6 — Formatting
- Use a neutral palette — one accent colour (navy/teal) plus grey, no more than 3 colours total.
- Keep card labels short: "Approval Rate", not "Client Onboarding Approval Rate Percentage".
- Turn off gridlines on charts for a cleaner look.

## Step 7 — Publish/export
- **File → Export → PDF** for a portfolio-ready static version.
- If you have a Power BI account, **Publish** to Power BI Service and share the link on LinkedIn/GitHub instead of a screenshot.

## What to say about this in an interview
"I used Power BI to add cross-filtering — clicking a payment type slicer updates the exception breakdown live, which isn't possible in a static Excel dashboard. It's the same underlying data as my Excel workbook, just with an interactive layer on top."
