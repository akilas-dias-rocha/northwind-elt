{{
    config(
        alias='customer_customer_demo'
    )
}}

with source as (

    select * from {{ source('northwind', 'customercustomerdemo') }}

),

renamed as (

    select
        cast(id as integer) as id,
        cast(customertypeid as string) as customer_type_id

    from source

)

select * from renamed
