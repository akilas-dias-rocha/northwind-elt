{{
    config(
        alias='shipper'
    )
}}

with
    renamed as (
        select
            cast(id as integer) as shipper_id
            , cast(companyname as string) as company_name
            , cast(phone as string) as phone
        from {{ source('northwind', 'shipper') }}
    )

select * from renamed
