with
    date_spine_raw as (
        {{ dbt_utils.date_spine(
            datepart="day",
            start_date="cast('2012-01-01' as date)",
            end_date="make_date(year(current_date) + 2, 1, 1)"
            )
        }}
    )

    , days_info as (
        select 
            cast(date_day as date) as date_day
            , extract(dayofweek from date_day) as day_of_week
            , extract(month from date_day) as month
            , extract(year from date_day) as year
            , extract(quarter from date_day) as quarter
            , dayofyear(date_day) as day_of_year
            , date_format(date_day, 'MMM') as month_name
            , date_format(date_day, 'dd-MM') as day_month
        from date_spine_raw
    )

, date_labels as (
    select
        *
        , case day_of_week
            when 1 then 'Sunday'
            when 2 then 'Monday'
            when 3 then 'Tuesday'
            when 4 then 'Wednesday'
            when 5 then 'Thursday'
            when 6 then 'Friday'
            when 7 then 'Saturday'
        end as week_day_name
        , concat('Q', cast(quarter as string)) as quarter_name
    from days_info
)
    
select * 
from date_labels