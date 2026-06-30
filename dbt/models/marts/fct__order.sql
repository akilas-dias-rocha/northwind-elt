with
    orders as (
        select
            order_id
            , customer_id as customer_fk
            , employee_id as employee_fk
            , order_date
            , required_date
            , shipped_date
            , ship_via_id as ship_via_fk
            , freight
            , ship_name
            , ship_address
            , ship_city
            , ship_region
            , ship_postal_code
            , ship_country
        from {{ ref('stg__northwind_order') }}
    )

    , order_details as (
        select
            order_detail_id
            , order_id
            , product_id
            , unit_price
            , quantity
            , discount
            , gross_amount
            , discount_amount
            , net_amount
        from {{ ref('int__order_detail') }}
    )

    , order_totals as (
        select
            order_id
            , sum(net_amount) as total_order_net_amount
        from order_details
        group by order_id
    )

    , order_with_details as (
        select
            -- IDs an FKs
            order_details.order_detail_id
            , order_details.order_id
            , order_details.product_id
            , orders.customer_fk
            , orders.employee_fk
            , orders.ship_via_fk

            -- Dates
            , orders.order_date
            , orders.required_date
            , orders.shipped_date

            -- Monetary and quantity fields
            , order_details.unit_price
            , order_details.quantity
            , order_details.discount
            , order_details.discount_amount
            , order_details.gross_amount
            , order_details.net_amount
            , orders.freight as total_order_freight
           
            -- FREIGHT ALLOCATION: Proportional to the item's net amount weight within the order.
            , case 
                when order_totals.total_order_net_amount = 0 then 0
                else round((order_details.net_amount / order_totals.total_order_net_amount) * orders.freight, 2)
              end as allocated_freight
           
            -- Ship details
            , orders.ship_name
            , orders.ship_address
            , orders.ship_city
            , orders.ship_region
            , orders.ship_postal_code
            , orders.ship_country
        from orders
        left join order_details on orders.order_id = order_details.order_id
        left join order_totals on orders.order_id = order_totals.order_id
    )

select * from order_with_details
