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
            , count(distinct order_id) as qnt_orders
            , sum(net_amount) as total_amount
        from orders
        group by customer_fk
    )

    , customer_metrics as (
        select
            customer.customer_id
            , customer.company_name as customer_name
            , coalesce(datediff(current_date, customer_order_summary.last_order_date), 0) as recency
            , coalesce(customer_order_summary.total_amount, 0) as total_amount
            , coalesce(customer_order_summary.qnt_orders, 0) as qnt_orders
        from customer
        left join customer_order_summary
            on customer.customer_id = customer_order_summary.customer_fk
    )

    , average_order_value as (
        select
            customer_metrics.*
            , case
                when customer_metrics.qnt_orders = 0 then 0
                else round(customer_metrics.total_amount / customer_metrics.qnt_orders, 2)
              end as average_order_value
            , case
                when customer_metrics.qnt_orders = 0 then FALSE
                else TRUE
              end as is_active
        from customer_metrics
    )

select * from average_order_value
