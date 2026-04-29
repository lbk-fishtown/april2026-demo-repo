{{ config({"severity":"Warn","tags":[]}) }}
{{ test_accepted_values(column_name="sentiment_value", model=get_where_subquery(source('movie_reviews', 'raw_movie_reviews')), values=[1,0]) }}