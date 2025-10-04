
WITH orders AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        order_approved_at,
        order_delivered_at
    FROM
        {{ ref('stg_orders') }}
)
,
order_items AS (
    SELECT
        order_item_id,
        order_id,
        product_id,
        product_price
    FROM
        {{ ref('stg_order_items') }}
)
,
combined_orders AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_status,
        o.order_approved_at,
        o.order_delivered_at,
        DATE(o.order_approved_at) AS order_dt,
        oi.product_id,
        oi.product_price
    FROM
        orders o
        LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
)

SELECT
    *
FROM
    combined_orders
