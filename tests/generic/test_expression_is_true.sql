{% test test_expression_is_true(model, expression, column_name=None, condition='1=1', selected_columns="*") %}
with meet_condition as (
    select {{selected_columns}} from {{ model }} where {{ condition }}
)

select
    *
from meet_condition
{% if column_name is none %}
where not({{ expression }})
{%- else %}
where not({{ column_name }} {{ expression }})
{%- endif %}

{% endtest %}
