{{
    config(
        tags=['finance']
    )
}}

with fct_orders as (

    select *
    from {{ ref('fct_orders') }}

),

final as (

    select
        status_code,
        sum(order_count) as order_count,
        sum(return_count) as return_count,
        sum(gross_item_sales_amount) as gross_item_sales_amount,
        sum(net_item_sales_amount) as net_item_sales_amount,
        sum(item_tax_amount) as item_tax_amount
    from fct_orders
    group by 1

)

select *
from final
order by status_code
