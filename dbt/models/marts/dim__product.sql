with
    product as (
        select
            product_id
            , category_fk
            , product_name
            , category_name
            , category_description
            , supplier_fk
            , quantity_per_unit
            , unit_price
            , is_discontinued
        from {{ ref('int__product') }}
    )

select * from product