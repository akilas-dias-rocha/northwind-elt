with
    shippers as (
        select
            shipper_id
            , company_name
            , phone
        from {{ ref('stg__northwind_shipper') }}
    )

select * from shippers
