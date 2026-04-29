{{ config({"severity":"Warn","tags":[]}) }}
{{ test_unique(column_name="r_regionkey", model=get_where_subquery(source('tpch', 'region'))) }}