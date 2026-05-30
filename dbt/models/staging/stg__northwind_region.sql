{{
    config(
        alias='region'
    )
}}

with
    renamed as (
        select
            cast(id as integer) as region_id
            , cast(regiondescription as string) as region_description
        from {{ source('northwind', 'region') }}
    )

select * from renamed
