

with hours as (

    
    select (
        

    dateadd(
        hour,
        row_number() over (order by 1) - 1,
        to_date('01/01/1990','mm/dd/yyyy')
        )


    ) as date_hour
    from table(flatten(input => array_generate_range(0, datediff(
        hour,
        to_date('01/01/1990','mm/dd/yyyy'),
        to_date('01/01/2027','mm/dd/yyyy')
        ) )))


),

final as (
    select cast(date_hour as timestamp) as date_hour
    from hours
)

select * from final