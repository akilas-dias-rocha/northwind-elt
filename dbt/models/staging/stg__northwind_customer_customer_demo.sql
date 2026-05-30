{{
    config(
        alias='customer_customer_demo'
    )
}}

with
    renamed as (
        select
            cast(id as integer) as id
            , cast(customertypeid as string) as customer_type_id
        from {{ source('northwind', 'customercustomerdemo') }}
    )

select * from renamed
