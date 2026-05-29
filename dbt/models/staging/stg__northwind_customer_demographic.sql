{{
    config(
        alias='customer_demographic'
    )
}}

with source as (

    select * from {{ source('northwind', 'customerdemographic') }}

),

renamed as (

    select
        cast(id as integer) as id,
        cast(customerdesc as string) as customer_description

    from source

)

select * from renamed
