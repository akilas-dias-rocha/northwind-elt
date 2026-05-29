{{
    config(
        alias='employee'
    )
}}

with source as (

    select * from {{ source('northwind', 'employee') }}

),

renamed as (

    select
        cast(id as integer) as employee_id,
        cast(lastname as string) as last_name,
        cast(firstname as string) as first_name,
        cast(title as string) as title,
        cast(titleofcourtesy as string) as title_of_courtesy,
        cast(birthdate as date) as birth_date,      --- testar formato "date"
        cast(hiredate as date) as hire_date,        --- testar formato "date"
        cast(address as string) as address,
        cast(city as string) as city,
        cast(region as string) as region,
        cast(postalcode as string) as postal_code,
        cast(country as string) as country,
        cast(homephone as string) as home_phone,
        cast(extension as integer) as extension,
        cast(photo as string) as photo,
        cast(notes as string) as notes,
        cast(reportsto as integer) as reports_to,
        cast(photopath as string) as photo_path

    from source

)

select * from renamed
