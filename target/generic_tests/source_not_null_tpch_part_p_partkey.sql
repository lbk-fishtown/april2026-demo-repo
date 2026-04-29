{{ config({"severity":"Warn","tags":[]}) }}
{{ test_not_null(column_name="p_partkey", model=get_where_subquery(source('tpch', 'part'))) }}