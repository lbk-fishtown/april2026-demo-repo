{{ config({"severity":"Warn","tags":[]}) }}
{{ test_not_null(column_name="s_suppkey", model=get_where_subquery(source('tpch', 'supplier'))) }}