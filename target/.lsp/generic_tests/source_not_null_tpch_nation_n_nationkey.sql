{{ config({"severity":"Warn","tags":[]}) }}
{{ test_not_null(column_name="n_nationkey", model=get_where_subquery(source('tpch', 'nation'))) }}