with source as (

    select * from {{ source('northwind', 'territory') }}

),

renamed as (

    select
        cast(id as string) as territory_id,
        cast(territorydescription as string) as territory_description,
        cast(regionid as integer) as region_id

    from source

)

select * from renamed
