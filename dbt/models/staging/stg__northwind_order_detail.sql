{{
    config(
        alias='order_detail'
    )
}}

with
    renamed as (
        select
           cast(id as string) as order_detail_id
            , cast(orderid as integer) as order_id
            , cast(productid as integer) as product_id
            , cast(unitprice as decimal(10, 2)) as unit_price
            , cast(quantity as integer) as quantity
            , cast(discount as decimal(10, 2)) as discount
            , cast(_updated_at as timestamp) as _updated_at
        from {{ source('northwind', 'orderdetail') }}
    )

select * from renamed
