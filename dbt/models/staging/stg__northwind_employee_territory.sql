{{
    config(
        alias='employee_territory'
    )
}}

with
    renamed as (
        select
            cast(id as string) as id
            , cast(employeeid as integer) as employee_id
            , cast(territoryid as integer) as territory_id
            , cast(_updated_at as timestamp) as _updated_at
        from {{ source('northwind', 'employeeterritory') }}
    )

select * from renamed
