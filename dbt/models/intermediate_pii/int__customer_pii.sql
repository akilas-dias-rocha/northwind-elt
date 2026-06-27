with
    customer as (
        select
            customer_id
            , company_name
            , contact_name
            , contact_title
            , address
            , city
            , region
            , postal_code
            , country
            , phone
            , fax
        from {{ ref('stg__northwind_customer') }}
    )

select * from customer
