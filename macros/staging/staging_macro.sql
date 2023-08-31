{%- macro latest_staging_snapshot(table_name, filter_column, unique_key, columns) -%}
    with table1 as (
        SELECT
        {{unique_key}} as unique_key,
        MAX({{ filter_column }}) as max_valid_to
        FROM {{ table_name }}
        GROUP BY {{unique_key}}
    )

    SELECT 
        {{columns}}
    FROM {{ table_name }} as table2
    left join table1 on table1.unique_key = table2.{{unique_key}} and table2.{{ filter_column }}  = table1.max_valid_to 
    where table1.max_valid_to is not null
{%- endmacro -%}