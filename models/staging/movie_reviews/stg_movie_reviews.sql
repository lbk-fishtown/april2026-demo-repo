with 

source as (

    select * from {{ source('movie_reviews', 'raw_movie_reviews') }}

),

renamed as (

    select
        id as movie_review_id,
        movie_id,
        response_time as review_time,
        review_text as review_txt,
    case 
        when sentiment_value = 0 then -1
        else 1
    end as actual_sentiment

    from source

)

select * from renamed