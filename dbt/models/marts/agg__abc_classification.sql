with
    quarterly_sales as (
        select
            product_id,
            year,
            quarter,
            sum(total_sales) as total_sales
        from {{ ref('agg__sales_per_product') }}
        group by product_id, year, quarter
    ),

    quarterly_totals as (
        select
            *,
            sum(total_sales) over (partition by year, quarter) as quarterly_total
        from quarterly_sales
    ),

    cumulative_pct as (
        select
            *,
            sum(total_sales) over (
                partition by year, quarter
                order by total_sales desc
                rows between unbounded preceding and current row
            ) as cumulative_sales,
            case
                when quarterly_total = 0 then 0
                else round(
                    sum(total_sales) over (
                        partition by year, quarter
                        order by total_sales desc
                        rows between unbounded preceding and current row
                    ) / quarterly_total * 100, 2
                )
            end as cumulative_pct
        from quarterly_totals
    ),

    abc_classified as (
        select
            *,
            case
                when cumulative_pct <= 80 then 'A'
                when cumulative_pct <= 95 then 'B'
                else 'C'
            end as abc_class
        from cumulative_pct
    ),

    add_surrogate_key as (
        select
            {{ dbt_utils.generate_surrogate_key(['product_id', 'year', 'quarter']) }} as product_quarter_sk,
            *
        from abc_classified
    )

select * from add_surrogate_key
