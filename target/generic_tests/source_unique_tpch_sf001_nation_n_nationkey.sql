{{ config({"severity":"Warn","tags":[]}) }}
{{ test_unique(column_name="n_nationkey", model=get_where_subquery(source('tpch_sf001', 'nation'))) }}