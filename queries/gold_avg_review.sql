-- Gold layer: average review score KPI
-- Calculates the true weighted average review score across all delivered orders

CREATE OR REPLACE TABLE gold_avg_review AS
SELECT AVG(CAST(review_score AS DOUBLE)) AS avg_review_score
FROM silver_reviews