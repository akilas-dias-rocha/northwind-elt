{{
    config(
        alias='category'
    )
}}

with
    renamed as (
        select
            cast(id as integer) as category_id
            , cast(categoryname as string) as category_name
            , cast(description as string) as category_description
            , cast(_updated_at as timestamp) as _updated_at
        from {{ source('northwind', 'category') }}
    )

select * from renamed
