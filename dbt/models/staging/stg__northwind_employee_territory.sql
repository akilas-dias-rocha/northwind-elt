with source as (

    select * from {{ source('northwind', 'employeeterritory') }}

),

renamed as (

    select
        cast(id as string) as id,
        cast(employeeid as integer) as employee_id,
        cast(territoryid as integer) as territory_id

    from source

)

select * from renamed
