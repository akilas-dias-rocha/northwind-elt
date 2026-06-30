with
    customer as (
        select
            customer_id
            , company_name
        from {{ ref('dim__customer') }}
    )

    , orders as (
        select
            customer_fk
            , order_id
            , order_date
            , net_amount
        from {{ ref('fct__order') }}
    )

    , customer_order_summary as (
        select
            customer_fk
            , max(order_date) as last_order_date
            , count(distinct order_id) as frequency
            , count(distinct order_id) as qnt_orders
            , sum(net_amount) as total_amount
        from orders
        group by customer_fk
    )

    , customer_metrics as (
        select
            customer.customer_id
            , customer.company_name as customer_name
            , datediff(current_date, customer_order_summary.last_order_date) as recency
            , customer_order_summary.frequency
            , customer_order_summary.total_amount
            , customer_order_summary.qnt_orders
            , round(customer_order_summary.total_amount / customer_order_summary.qnt_orders, 2) as average_order_value
        from customer
        left join customer_order_summary
            on customer.customer_id = customer_order_summary.customer_fk
    )

select * from customer_metrics
