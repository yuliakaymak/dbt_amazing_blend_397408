select *
from {{ source('project', 'dim_locations') }}