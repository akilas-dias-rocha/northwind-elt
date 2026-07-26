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
            , inventory_status
            , cast(_updated_at as date) as _updated_at
        from {{ ref('int__inventory_management') }}
    )

select * from inventory