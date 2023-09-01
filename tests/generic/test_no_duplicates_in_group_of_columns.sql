/*
    Test that there is only one record in a group of columns.
*/
{% test test_no_duplicates_in_group_of_columns(model, group_by_column, select_column_with_alias = "same_as_group_by_column", filter_condition = "1=1") %}

    SELECT 
        {% if select_column_with_alias == "same_as_group_by_column" %}
            {{ group_by_column }}
        {% else %}
            {{ select_column_with_alias }}
        {% endif %}
        , count(*) AS cnt
    FROM {{ model }}
    WHERE {{ filter_condition }}
    GROUP BY {{ group_by_column }}
    HAVING count(*) > 1

{% endtest %}