with customers as (
    select * from {{ ref('stg_customers') }}
),

orders_summary as (
    select
        customer_id,
        count(order_id)         as total_orders,
        sum(order_amount)       as lifetime_value,
        max(order_date)         as last_order_date
    from {{ ref('stg_orders') }}
    group by customer_id
)

select
    {{ generate_surrogate_key(['c.customer_id']) }}  as customer_sk,
    c.customer_id,
    c.customer_name,
    c.email,
    c.customer_tier,
    c.created_at,
    coalesce(o.total_orders, 0)         as total_orders,
    coalesce(o.lifetime_value, 0)       as lifetime_value,
    o.last_order_date
from customers c
left join orders_summary o on c.customer_id = o.customer_id
