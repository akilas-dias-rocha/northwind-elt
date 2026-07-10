with
    products as (
        select product_id
        from {{ ref('int__product') }}
    ),

    months as (
        select distinct
            year,
            month
        from {{ ref('dim__date') }}
    ),

    product_months as (
        select
            products.product_id,
            months.year,
            months.month
        from products
        cross join months
    ),

    order_detail as (
        select
            product_id,
            order_date,
            net_amount,
            quantity
        from {{ ref('fct__order') }}
        where order_detail_id is not null
    ),

    dates as (
        select
            date_day,
            month,
            year
        from {{ ref('dim__date') }}
    ),

    order_detail_with_dates as (
        select
            order_detail.product_id,
            order_detail.net_amount,
            order_detail.quantity,
            dates.year,
            dates.month
        from order_detail
        inner join dates
            on order_detail.order_date = dates.date_day
    ),

    sales_agg as (
        select
            product_id,
            year,
            month,
            sum(net_amount) as total_sales,
            sum(quantity) as total_quantity
        from order_detail_with_dates
        group by product_id, year, month
    ),

    sales_agg_not_null as (
        select
            product_months.product_id,
            product_months.year,
            product_months.month,
            coalesce(sales_agg.total_sales, 0) as total_sales,
            coalesce(sales_agg.total_quantity, 0) as total_quantity
        from product_months
        left join sales_agg
            on product_months.product_id = sales_agg.product_id
            and product_months.year = sales_agg.year
            and product_months.month = sales_agg.month
    ),

    add_surrogate_key as (
        select 
            {{ dbt_utils.generate_surrogate_key(['product_id', 'year', 'month']) }} as product_month_sk
            , *
        from sales_agg_not_null
    )


select * from add_surrogate_key