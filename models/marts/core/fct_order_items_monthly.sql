{{
    config(
        tags = ['finance']
    )
}}

with order_items as (

    select *
    from {{ ref('fct_order_items') }}

),

final as (

    select
        /* month grain */
        date_trunc('month', order_date)::date as order_month,

        /* helpful counts */
        count(distinct order_key) as order_count,
        sum(order_item_count) as order_item_count,
        sum(quantity) as quantity,

        /* $ */
        sum(gross_item_sales_amount) as gross_item_sales_amount,
        sum(discounted_item_sales_amount) as discounted_item_sales_amount,
        sum(item_discount_amount) as item_discount_amount,
        sum(item_tax_amount) as item_tax_amount,
        sum(net_item_sales_amount) as net_item_sales_amount

    from order_items
    group by 1

)

select *
from final
order by order_month
