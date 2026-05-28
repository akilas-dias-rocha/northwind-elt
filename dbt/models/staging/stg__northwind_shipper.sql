with source as (

    select * from {{ source('northwind', 'shipper') }}

),

renamed as (

    select
        cast(id as integer) as shipper_id,
        cast(companyname as string) as company_name,
        cast(phone as string) as phone

    from source

)

select * from renamed
