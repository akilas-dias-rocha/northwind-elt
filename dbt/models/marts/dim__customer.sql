with
    customer as (
        select
            customer_id
            , company_name
            , contact_name
            , contact_title
            , city
            , region
            , country
            , phone
            , fax
        from {{ ref('stg__northwind_customer') }}
    )

select * from customer
