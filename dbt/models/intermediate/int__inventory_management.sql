with
    inventory as (
        select
            product_id
            , category_id
            , supplier_id
            , unit_price
            , quantity_per_unit
            , units_in_stock
            , units_on_order
            , reorder_level
            , is_discontinued
            , _updated_at
        from {{ ref('stg__northwind_product') }}
    )

    , inventory_status as (
        select
            product_id
            , category_id
            , supplier_id
            , unit_price
            , quantity_per_unit
            , units_in_stock
            , units_on_order
            , reorder_level
            , is_discontinued
            , case
                when units_in_stock = 0 then 'Out of Stock'
                when units_in_stock <= reorder_level then 'Reorder'
                else 'In Stock'
            end as inventory_status
            , _updated_at
        from inventory
    )

select * from inventory_status
