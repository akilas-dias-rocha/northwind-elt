{{
    config(
        materialized='incremental',
        unique_key='order_detail_id',
        incremental_strategy='merge',
        on_schema_change='sync_all_columns'
    )
}}

with
    order_detail as (
        select
            order_detail_id
            , order_id
            , product_id
            , unit_price
            , quantity
            , discount
            , cast(round(quantity * unit_price, 2) as decimal(10, 2)) as gross_amount
            , case
                when discount > 0
                    then cast(round(quantity * unit_price * discount, 2) as decimal(10, 2))
                else 0
            end as discount_amount
            , _updated_at
        from {{ ref('stg__northwind_order_detail') }}
    )

    , calculated as (
        select
            order_detail_id
            , order_id
            , product_id
            , unit_price
            , quantity
            , discount
            , gross_amount
            , discount_amount
            , cast(round(gross_amount - discount_amount, 2) as decimal(10, 2)) as net_amount
            , _updated_at
        from order_detail
    )

select * from calculated

{% if is_incremental() %}
where _updated_at > (select coalesce(max(_updated_at), '1900-01-01') from {{ this }})
{% endif %}
