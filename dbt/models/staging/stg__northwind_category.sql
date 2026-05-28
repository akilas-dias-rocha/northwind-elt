{{
    config(
        alias='category'
    )
}}

with source as (

    select * from {{ source('northwind', 'category') }}

),

renamed as (

    select
        cast(id as integer) as category_id,
        cast(categoryname as string) as category_name,
        cast(description as string) as category_description

    from source

)

select * from renamed
