{{
    config(
        alias='region'
    )
}}

with source as (

    select * from {{ source('northwind', 'region') }}

),

renamed as (

    select
        cast(id as integer) as region_id,
        cast(regiondescription as string) as region_description

    from source

)

select * from renamed
