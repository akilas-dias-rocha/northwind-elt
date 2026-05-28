with source as (

    select * from {{ source('northwind', 'product') }}

),

renamed as (

    select
        cast(id as string) as product_id,
        cast(productname as string) as product_name,
        cast(supplierid as integer) as supplier_id,
        cast(categoryid as integer) as category_id,
        cast(quantityperunit as string) as quantity_per_unit,
        cast(unitprice as decimal(10, 2)) as unit_price,
        cast(unitsinstock as integer) as units_in_stock,
        cast(unitsonorder as integer) as units_on_order,
        cast(reorderlevel as integer) as reorder_level,
        cast(discontinued as boolean) as is_discontinued

    from source

)

select * from renamed
