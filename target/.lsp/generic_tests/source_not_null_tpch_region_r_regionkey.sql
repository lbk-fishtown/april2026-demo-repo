{{ config({"severity":"Warn","tags":[]}) }}
{{ test_not_null(column_name="r_regionkey", model=get_where_subquery(source('tpch', 'region'))) }}