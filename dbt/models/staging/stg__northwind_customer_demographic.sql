{{
    config(
        alias='customer_demographic'
    )
}}

with
    renamed as (
        select
            cast(id as integer) as id
            , cast(customerdesc as string) as customer_description
            , cast(_updated_at as timestamp) as _updated_at
        from {{ source('northwind', 'customerdemographic') }}
    )

select * from renamed
