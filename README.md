# commercial-analytics-pipeline
An end-to-end commercial analytics project: raw data to business insights using SQL, Microsoft Fabric, and Power BI.

This project demonstrates commercial analytics skills using a real Brazilian e-commerce dataset (Olist, ~100,000 orders). Raw CSV data is loaded into Microsoft Fabric using a Medallion architecture (Bronze/Silver/Gold layers), transformed using SQL, and visualised in a Power BI dashboard answering five business questions relevant to any sales or operations role.


## Data Sources
**Dataset:** Brazilian E-Commerce Public Dataset by Olist  
**Source:** Kaggle (517,000+ downloads)  
**Tables:** 9 relational tables, ~100,000 orders  

| Table | Description |
|---|---|
| olist_orders | Central table , one row per order, tracks full delivery journey |
| olist_order_items | One row per item within an order , price and freight per item |
| olist_customers | Customer location and unique identity |
| olist_sellers | Seller location information |
| olist_products | Product categories and physical dimensions |
| olist_order_payments | Payment method and value per order |
| olist_order_reviews | Customer review scores and timestamps |
| olist_geolocation | Zip code to city/state/coordinates mapping |
| product_category_name_translation | Portuguese to English category translation |


## Business Questions
This project answers five business questions a commercial analyst would face in any sales or operations role:

1. **Revenue Trend** : What is the monthly revenue and order volume trend over time?
2. **Category Performance** : Which product categories drive the most revenue?
3. **Seller Delivery Performance** : Which sellers have the best and worst delivery performance?
4. **Satisfaction Driver** : What is the relationship between delivery delay and customer review score?
5. **Pareto Analysis** : Which 20% of sellers drive 80% of revenue, and what distinguishes them from the rest?


## Tech Stack
| Tool | Purpose |
|---|---|
| Microsoft Fabric | Cloud data platform : OneLake storage and Lakehouse SQL endpoint |
| DataGrip (JetBrains) | SQL development and query execution |
| Power BI | Dashboard and business intelligence reporting |
| GitHub | Version control and portfolio hosting |


## Key Findings

1. **Revenue Trend** : Olist showed consistent month-on-month growth from late 2016 through 2018, with order volume growing from under 1,000 to over 7,000 orders per month.
2. **Category Performance** : Health & beauty was the top revenue category (~R$1.26M), followed closely by watches & gifts and bed/bath/table. Revenue is distributed across categories with no single dominant vertical.
3. **Seller Delivery Performance** : Significant variation exists across sellers. The worst performer averaged 167 days late; the best averaged 66 days early.
4. **Satisfaction Driver** : A consistent pattern exists between delivery timing and review scores. Orders rated 5 stars arrived an average of 13 days before the estimated date; 1-star orders arrived only 4 days early.
5. **Pareto Analysis** : 533 sellers (17.2% of the total 3,095) drive 80% of total revenue: closely consistent with the classic 80/20 Pareto principle.


## SQL Queries

All queries are in the `/queries` folder, organised by business question:

- `01_exploration.sql` : Schema exploration and row counts across all 9 tables
- `02_revenue_trend.sql` : Monthly revenue and order volume trend
- `03_category_performance.sql` : Revenue by product category
- `04_delivery_performance.sql` : Seller delivery performance ranking
- `05_satisfaction_driver.sql` : Delivery delay versus review score correlation
- `06_pareto_analysis.sql` : Cumulative revenue share by seller (Pareto analysis)