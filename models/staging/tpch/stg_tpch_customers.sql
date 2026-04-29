

with source as (

    select * from {{ source('tpch', 'customer') }}

),final as (

    select
    
        c_custkey as customer_key,
        c_name as name,
        split_part(c_name, '#', 1) as name_prefix,
        split_part(c_name, '#', 2) as name_id,
        c_address as address, 
        c_nationkey as nation_key,
        c_phone as phone_number,
        c_acctbal as account_balance,
        c_mktsegment as market_segment,
        c_comment as comment

    from source

)

select * from final

