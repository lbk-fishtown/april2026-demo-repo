{{ config({"severity":"Warn","tags":[]}) }}
{{ test_accepted_values(column_name="return_flag", model=get_where_subquery(ref('stg_tpch_line_items')), values=["returned","accepted"]) }}