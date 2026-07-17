{{
    config(
        alias='customer'
    )
}}

with
    renamed as (
        select
            cast(id as string) as customer_id
            , cast(companyname as string) as company_name
            , cast(contactname as string) as contact_name
            , cast(contacttitle as string) as contact_title
            , cast(address as string) as address
            , cast(city as string) as city
            , cast(region as string) as region
            , cast(postalcode as string) as postal_code
            , cast(country as string) as country
            , cast(phone as string) as phone
            , cast(fax as string) as fax
            , cast(_updated_at as timestamp) as _updated_at
        from {{ source('northwind', 'customer') }}
    )

select * from renamed
