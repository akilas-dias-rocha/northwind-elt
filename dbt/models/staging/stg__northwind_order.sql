{{
    config(
        alias='order'
    )
}}

with
    renamed as (
        select
            cast(id as integer) as order_id
            , cast(customerid as string) as customer_id
            , cast(employeeid as integer) as employee_id
            , cast(orderdate as date) as order_date
            , cast(requireddate as date) as required_date
            , cast(shippeddate as date) as shipped_date
            , cast(shipvia as integer) as ship_via_id
            , cast(freight as decimal(10, 2)) as freight
            , cast(shipname as string) as ship_name
            , cast(shipaddress as string) as ship_address
            , cast(shipcity as string) as ship_city
            , cast(shipregion as string) as ship_region
            , cast(shippostalcode as string) as ship_postal_code
            , cast(shipcountry as string) as ship_country
        from {{ source('northwind', 'order') }}
    )

select * from renamed
