select 
date_trunc(sales_date, month) as start_month,
sales_repr_id, 
full_name,
count(sales_id) as sales_count
from {{ ref('staging_fact_sales_enriched') }}
group by 
start_month, 
sales_repr_id, 
full_name