with prepared_table as (
    select *
    , regular_price * (1 - discount) as price_after_discount
    from {{ ref('staging_fact_sales_enriched') }}
)

select 
date_trunc(sales_date, month) as start_month,
sku_id,
sku_category,
sku_price_segment, 
sales_repr_id, 
full_name, 
location_id,
region, 
country, 
city,
count(sales_id) as sales_count, 
sum(regular_price) as sum_regular_price, 
sum(price_after_discount) as price_after_discount
from prepared_table
group by 
start_month, 
sku_id,
sku_category,
sku_price_segment, 
sales_repr_id, 
full_name, 
location_id,
region, 
country, 
city