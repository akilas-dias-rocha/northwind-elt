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
        from order_detail
    )

select * from calculated
