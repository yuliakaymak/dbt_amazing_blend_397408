select 
date_trunc(sales_date, month) as start_month,
sku_category,
sku_price_segment, 
count(sales_id) as sales_count
from {{ ref('staging_fact_sales_enriched') }}
group by 
start_month, 
sku_category,
sku_price_segment