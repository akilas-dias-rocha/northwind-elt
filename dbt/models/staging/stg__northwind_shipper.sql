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
            , cast(_updated_at as timestamp) as _updated_at
        from {{ source('northwind', 'shipper') }}
    )

select * from renamed
