select *
from {{ source('project', 'dim_employees') }}
