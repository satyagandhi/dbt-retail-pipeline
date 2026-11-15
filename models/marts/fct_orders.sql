{{
    config(
        materialized='incremental',
        unique_key='order_id',
        incremental_strategy='merge'
    )
}}

with base as (
    select * from {{ ref('int_customer_orders') }}
)

select
    {{ generate_surrogate_key(['order_id']) }}   as order_sk,
    order_id,
    customer_id,
    customer_name,
    customer_tier,
    order_date,
    order_amount,
    status
from base

{% if is_incremental() %}
    where order_date > (select max(order_date) from {{ this }})
{% endif %}
