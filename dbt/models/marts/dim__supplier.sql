with
    suppliers as (
        select
            supplier_id
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
            , homepage
        from {{ ref('stg__northwind_supplier') }}
    )

select * from suppliers
