select *
from {{ source('project', 'dim_prices') }}