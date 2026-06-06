with
    territory as (
        select
            territory_id
            , territory_description
            , region_id
        from {{ ref('stg__northwind_territory') }}
    )
    ,
    region as (
        select
            region_id
            , region_description
        from {{ ref('stg__northwind_region') }}
    )
    ,
    territory_united as (
        select
            territory.territory_id
            , territory.territory_description
            , region.region_id
            , region.region_description
        from territory
        left join region on territory.region_id = region.region_id
    )

select * from territory_united
