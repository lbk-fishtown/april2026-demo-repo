{{ config({"severity":"Error","tags":[]}) }}
{{ test_relationships(column_name="customer_key", field="customer_key", model=get_where_subquery(ref('fct_orders')), to=ref('dim_customers')) }}