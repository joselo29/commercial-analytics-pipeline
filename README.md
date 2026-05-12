# commercial-analytics-pipeline
An end-to-end commercial analytics project: raw data to business insights using SQL, Microsoft Fabric, and Power BI
Set up GitHub repository, created Microsoft Fabric workspace and Lakehouse with Bronze/Silver/Gold medallion structure, uploaded 9 Olist CSV files to Bronze layer.
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

1. **Revenue Trend** — What is the monthly revenue and order volume trend over time?
2. **Category Performance** — Which product categories drive the most revenue?
3. **Seller Delivery Performance** — Which sellers have the best and worst delivery performance?
4. **Satisfaction Driver** — What is the relationship between delivery delay and customer review score?
5. **Pareto Analysis** — Which 20% of sellers drive 80% of revenue, and what distinguishes them from the rest?
