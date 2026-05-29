-- Gold layer: average review score KPI
-- Calculates the true weighted average review score across all delivered orders
--A single AVG over every review row is used instead of averaging the five per-score values, so each review counts equally and the KPI is not skewed by uneven counts per score.
--review_score is CAST to DOUBLE so the result is a true decimal average rather than an integer-truncated one.

CREATE OR REPLACE TABLE gold_avg_review AS
SELECT AVG(CAST(review_score AS DOUBLE)) AS avg_review_score
FROM silver_reviews