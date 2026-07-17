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
            , cast(_updated_at as timestamp) as _updated_at
        from {{ source('northwind', 'region') }}
    )

select * from renamed
