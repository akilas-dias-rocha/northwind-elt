{{
    config(
        alias='territory'
    )
}}

with
    renamed as (
        select
            cast(id as string) as territory_id
            , cast(territorydescription as string) as territory_description
            , cast(regionid as integer) as region_id
            , cast(_updated_at as timestamp) as _updated_at
        from {{ source('northwind', 'territory') }}
    )

select * from renamed
