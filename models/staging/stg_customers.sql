with source as (
    select * from {{ source('retail', 'raw_customers') }}
),

renamed as (
    select
        customer_id,
        lower(trim(full_name))          as customer_name,
        lower(trim(email))              as email,
        lower(trim(customer_tier))      as customer_tier,
        cast(created_at as timestamp)   as created_at
    from source
    where customer_id is not null
)

select * from renamed
