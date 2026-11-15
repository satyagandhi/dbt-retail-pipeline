{% snapshot snap_customer_status %}

{{
    config(
        target_schema='snapshots',
        unique_key='customer_id',
        strategy='check',
        check_cols=['customer_tier']
    )
}}

select
    customer_id,
    customer_name,
    customer_tier
from {{ ref('stg_customers') }}

{% endsnapshot %}
