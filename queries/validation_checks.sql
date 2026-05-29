-- Data validation checks
-- Run these to verify gold layer integrity
--These checks exist so the gold tables are confirmed before the dashboard is published, rather than trusting the transformations blindly.
--Revenue is summed across three independent gold tables so any mismatch points to a join or filter error in one of them.
--Expected values are written inline next to each count so actual output can be compared against known-good numbers at a glance.

-- Cross-check: total revenue should match across tables
SELECT SUM(total_revenue) FROM gold_monthly_revenue;
SELECT SUM(total_revenue) FROM gold_category_performance;
SELECT SUM(total_revenue) FROM gold_pareto_analysis;

-- Row counts
SELECT COUNT(*) FROM gold_monthly_revenue;        -- expect 23
SELECT COUNT(*) FROM gold_category_performance;   -- expect ~71
SELECT COUNT(*) FROM gold_delivery_performance;   -- expect ~2970
SELECT COUNT(*) FROM gold_satisfaction_driver;    -- expect 5
SELECT COUNT(*) FROM gold_pareto_analysis;        -- expect ~2970

-- Average review score (real weighted average)
SELECT AVG(TRY_CAST(review_score AS FLOAT)) FROM silver_reviews;  -- expect ~4.09

-- Pareto cumulative should reach 100%
SELECT MAX(cumulative_percentage) FROM gold_pareto_analysis;  -- expect 100