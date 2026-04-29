{{ config({"severity":"Warn","tags":[]}) }}
{{ test_accepted_values(column_name="l_returnflag", model=get_where_subquery(source('tpch_now', 'lineitem')), values=["R","A"]) }}