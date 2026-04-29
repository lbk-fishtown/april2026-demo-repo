with suppliers as (

    select * from analytics.dbt_lbk_fusion_mig.stg_tpch_suppliers

),

part_suppliers as (

    select * from analytics.dbt_lbk_fusion_mig.stg_tpch_part_suppliers

),

parts as (

    select * from analytics.dbt_lbk_fusion_mig.stg_tpch_parts

),

joined as (

    select
        -- supplier
        suppliers.supplier_key,
        suppliers.nation_key,
        suppliers.supplier_name,
        suppliers.supplier_address,
        suppliers.phone_number as supplier_phone_number,
        suppliers.account_balance as supplier_account_balance,
        suppliers.comment as supplier_comment,

        -- part
        parts.part_key,
        parts.name as part_name,
        parts.manufacturer as part_manufacturer,
        parts.brand as part_brand,
        parts.type as part_type,
        parts.container as part_container,
        parts.retail_price as part_retail_price,
        parts.comment as part_comment,

        -- part supplier mapping
        part_suppliers.part_supplier_key,
        concat(suppliers.supplier_key, parts.part_key) as part_supplier_sk,
        part_suppliers.available_quantity as part_supplier_available_qty,
        part_suppliers.cost as part_supplier_cost,
        part_suppliers.comment as part_supplier_comment,

        -- replicate the stored proc's post-insert update
        case
            when parts.type ilike '%BRASS' then 'brass'
            else parts.type
        end as part_material

    from suppliers
    left join part_suppliers
        on suppliers.supplier_key = part_suppliers.supplier_key
    left join parts
        on parts.part_key = part_suppliers.part_key

)

select *
from joined
where part_material is null or part_material not ilike '%steel%'