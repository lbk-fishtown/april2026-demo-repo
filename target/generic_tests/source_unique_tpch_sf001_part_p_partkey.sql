{{ config({"severity":"Warn","tags":[]}) }}
{{ test_unique(column_name="p_partkey", model=get_where_subquery(source('tpch_sf001', 'part'))) }}