/* ============================================================
   BANKING OPERATIONS SIMULATION - SQL QUERIES
   Client Onboarding, Payment Processing & Exception Management
   ============================================================
   These queries assume three tables loaded from the Excel workbook:

   client_onboarding (application_id, customer_id, customer_name,
       customer_type, verification_status, risk_category,
       application_date, decision_date, turnaround_time,
       sla_target, sla_met, final_status, rejection_reason)

   payment_processing (transaction_id, customer_id, payment_type,
       amount, maker, checker, approval_status, payment_status,
       processing_tat, payment_date)

   exception_management (exception_id, transaction_id, exception_category,
       root_cause, resolution_action, owner, resolution_tat, current_status)

   Beginner-friendly SQL only. No stored procedures, no window functions.
   ============================================================ */


-- 1. CUSTOMER LOOKUP
-- Used when an operations analyst needs full customer detail for a single
-- Customer ID during a query or audit check.
SELECT customer_id, customer_name, customer_type, risk_category, final_status
FROM client_onboarding
WHERE customer_id = 'CUST0007';


-- 2. CUSTOMER SUMMARY
-- Gives a one-line snapshot per customer type: how many applications,
-- how many approved, and the average turnaround time. Useful for a
-- weekly onboarding review meeting.
SELECT
    customer_type,
    COUNT(*) AS total_applications,
    SUM(CASE WHEN final_status = 'Approved' THEN 1 ELSE 0 END) AS approved_count,
    ROUND(AVG(turnaround_time), 1) AS avg_turnaround_days
FROM client_onboarding
GROUP BY customer_type;


-- 3. PAYMENT SUMMARY
-- Total transaction count and total amount processed by payment type.
-- Used by Ops leads to see where transaction volume is concentrated.
SELECT
    payment_type,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM payment_processing
GROUP BY payment_type
ORDER BY total_amount DESC;


-- 4. DAILY PAYMENTS
-- Shows how many payments were processed each day and the total value.
-- Used to spot unusually high or low volume days.
SELECT
    payment_date,
    COUNT(*) AS payments_count,
    SUM(amount) AS total_amount
FROM payment_processing
GROUP BY payment_date
ORDER BY payment_date;


-- 5. FAILED PAYMENTS
-- Lists every failed transaction so the Ops team can review them
-- before they are picked up into the Exception Queue.
SELECT transaction_id, customer_id, payment_type, amount, payment_date
FROM payment_processing
WHERE payment_status = 'Failed'
ORDER BY payment_date DESC;


-- 6. PENDING PAYMENTS
-- Lists payments still awaiting approval or processing, used for the
-- daily pending-items follow-up list.
SELECT transaction_id, customer_id, payment_type, amount, approval_status
FROM payment_processing
WHERE payment_status = 'Pending';


-- 7. PAYMENT STATUS REPORT
-- A simple count-and-percentage view of Success / Failed / Pending / Reversed.
-- Used as the source data behind the Payment Status pie chart in the dashboard.
SELECT
    payment_status,
    COUNT(*) AS total,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM payment_processing), 1) AS percentage
FROM payment_processing
GROUP BY payment_status;


-- 8. EXCEPTION REPORT
-- Full exception detail joined back to the original transaction, so an
-- analyst can see the payment amount and type alongside the exception.
SELECT
    e.exception_id,
    e.transaction_id,
    p.customer_id,
    p.payment_type,
    p.amount,
    e.exception_category,
    e.root_cause,
    e.resolution_action,
    e.owner,
    e.current_status
FROM exception_management e
JOIN payment_processing p ON e.transaction_id = p.transaction_id
ORDER BY e.exception_id;


-- 9. AVERAGE TAT
-- Average turnaround time for onboarding and average resolution time for
-- exceptions, in one combined view for the MIS report.
SELECT
    (SELECT ROUND(AVG(turnaround_time), 1) FROM client_onboarding) AS avg_onboarding_tat_days,
    (SELECT ROUND(AVG(resolution_tat), 1) FROM exception_management
        WHERE current_status = 'Resolved') AS avg_exception_resolution_tat_days;


-- 10. TOP EXCEPTION CATEGORIES
-- Ranks exception categories by frequency, so the Ops manager knows which
-- root cause to prioritise fixing (e.g. training, process, or system issue).
SELECT
    exception_category,
    COUNT(*) AS occurrences
FROM exception_management
GROUP BY exception_category
ORDER BY occurrences DESC;


-- 11. SLA COMPLIANCE REPORT
-- Percentage of onboarding applications that met their SLA target,
-- broken down by risk category. Used in the monthly Ops governance review.
SELECT
    risk_category,
    COUNT(*) AS total_applications,
    SUM(CASE WHEN sla_met = 'Yes' THEN 1 ELSE 0 END) AS sla_met_count,
    ROUND(100.0 * SUM(CASE WHEN sla_met = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS sla_compliance_pct
FROM client_onboarding
WHERE sla_met IN ('Yes', 'No')
GROUP BY risk_category
ORDER BY risk_category;
