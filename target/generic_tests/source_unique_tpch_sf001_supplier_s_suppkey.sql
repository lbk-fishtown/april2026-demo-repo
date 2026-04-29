{{ config({"severity":"Warn","tags":[]}) }}
{{ test_unique(column_name="s_suppkey", model=get_where_subquery(source('tpch_sf001', 'supplier'))) }}