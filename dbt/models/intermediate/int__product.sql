with
    product as (
        select
            product_id
            , product_name
            , supplier_id as supplier_fk
            , category_id as category_fk
            , quantity_per_unit
            , unit_price
            , is_discontinued
        from {{ ref('stg__northwind_product') }}
    )
    ,
    category as (
        select
            category_id
            , category_name
            , category_description
        from {{ ref('stg__northwind_category') }}
    )
    ,
    product_united as (
        select
            product.product_id
            , product.category_fk
            , product.product_name
            , category.category_name
            , category.category_description
            , product.supplier_fk
            , product.quantity_per_unit
            , product.unit_price
            , product.is_discontinued
        from product
        left join category
            on product.category_fk = category.category_id
    )

select * from product_united
