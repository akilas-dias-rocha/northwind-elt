{{
    config(
        alias='order_detail',
        materialized='incremental',
        unique_key='order_detail_id',
        incremental_strategy='merge',
        on_schema_change='sync_all_columns'
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

{% if is_incremental() %}
where _updated_at > (select coalesce(max(_updated_at), '1900-01-01') from {{ this }})
{% endif %}
