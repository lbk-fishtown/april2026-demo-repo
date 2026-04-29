with part as (

    select * from {{ref('stg_tpch_parts')}}

),

final as (
    select 
        part_key,
        {{ dbt_utils.generate_surrogate_key([
            'manufacturer',
            'brand'
        ]) }} as manufacturer_brand_key,
        manufacturer,
        name,
        brand,
        type,
        size,
        container,
        retail_price
    from
        part
)
select *
from final  
order by part_key
