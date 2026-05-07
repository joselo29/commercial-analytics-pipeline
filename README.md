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