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
        from {{ source('northwind', 'employeeterritory') }}
    )

select * from renamed
