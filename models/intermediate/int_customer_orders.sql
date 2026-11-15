with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

joined as (
    select
        o.order_id,
        o.order_date,
        o.order_amount,
        o.status,
        c.customer_id,
        c.customer_name,
        c.customer_tier
    from orders o
    left join customers c on o.customer_id = c.customer_id
)

select * from joined
