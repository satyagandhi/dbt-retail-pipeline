with source as (
    select * from {{ source('retail', 'raw_orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        cast(order_date as date)        as order_date,
        cast(order_amount as numeric)   as order_amount,
        lower(trim(status))             as status
    from source
    where order_id is not null
)

select * from renamed
