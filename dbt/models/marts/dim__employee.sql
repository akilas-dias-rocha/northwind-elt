with
    employee as (
        select
            employee_id
            , last_name
            , first_name
            , title
            , title_of_courtesy
            , hire_date
            , city
            , region
            , country
            , extension
            , photo
            , notes
            , reports_to
            , photo_path
        from {{ ref('stg__northwind_employee') }}
    )

select * from employee
