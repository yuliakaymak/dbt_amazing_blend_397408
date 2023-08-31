select *
from {{ source('project', 'dim_sku') }}