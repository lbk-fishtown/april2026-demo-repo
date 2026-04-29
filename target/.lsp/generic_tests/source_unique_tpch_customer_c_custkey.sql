{{ config({"severity":"Warn","tags":[]}) }}
{{ test_unique(column_name="c_custkey", model=get_where_subquery(source('tpch', 'customer'))) }}