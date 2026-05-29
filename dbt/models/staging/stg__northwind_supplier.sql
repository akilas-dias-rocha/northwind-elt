{{
    config(
        alias='supplier'
    )
}}

with source as (

    select * from {{ source('northwind', 'supplier') }}

),

renamed as (

    select
        cast(id as integer) as supplier_id,
        cast(companyname as string) as company_name,
        cast(contactname as string) as contact_name,
        cast(contacttitle as string) as contact_title,
        cast(address as string) as address,
        cast(city as string) as city,
        cast(region as string) as region,
        cast(postalcode as string) as postal_code,
        cast(country as string) as country,
        cast(phone as string) as phone,
        cast(fax as string) as fax,
        cast(homepage as string) as homepage

    from source

)

select * from renamed
