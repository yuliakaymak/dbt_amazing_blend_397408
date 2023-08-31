with locations as (
    select 
    location_id
    , region
    , country
    , city
    from {{ ref('staging_dim_locations') }}
),

employees as (
    select 
    sales_repr_id
    , full_name
    from {{ ref('staging_dim_employees') }}
), 

sku as (
    select 
    sku_id
    , sku_name
    , sku_category
    , sku_price_segment
    from {{ ref('staging_dim_sku') }}
), 

prices as (
    select 
    sku_id
    , regular_price
    , valid_from
    , valid_to
    from {{ ref('staging_dim_prices') }}
), 

discounts as (
    select 
    sku_id
    , discount
    , valid_from
    , valid_to
    from {{ ref('staging_dim_discounts') }}
)

select 
fact_sales.sales_id
, fact_sales.sales_date
, fact_sales.sku_id
, sku.sku_name
, sku.sku_category
, sku.sku_price_segment
, prices.regular_price
, discounts.discount
, fact_sales.location_id
, locations.region
, locations.country
, locations.city
, fact_sales.sales_repr_id
, employees.full_name
from {{ source('project', 'fact_sales')}} as fact_sales
    left join locations on fact_sales.location_id = locations.location_id
    left join employees on fact_sales.sales_repr_id = employees.sales_repr_id
    left join sku on fact_sales.sku_id = sku.sku_id
    left join prices on fact_sales.sku_id = prices.sku_id and fact_sales.sales_date >= prices.valid_from and fact_sales.sales_date < prices.valid_to
    left join discounts on fact_sales.sku_id = discounts.sku_id and fact_sales.sales_date >= discounts.valid_from and fact_sales.sales_date < discounts.valid_to