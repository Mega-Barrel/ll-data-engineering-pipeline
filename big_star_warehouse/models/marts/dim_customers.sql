
WITH orders AS (
    SELECT
        *
    FROM
        {{ ref('stg_orders') }}
)
,

customers AS (
    SELECT
        *
    FROM
        {{ ref('stg_customers') }}
)
,
customer_orders AS (
    SELECT
        c.customer_id,
        c.email,
        c.country,
        c.city,
        MIN(o.order_approved_at) AS first_order_date,
        MAX(o.order_approved_at) AS most_recent_order_date,
        COUNT(o.order_id) AS total_orders
    FROM
        customers c
        LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id, c.email,
        c.country, c.city
)

SELECT
    *
FROM
    customer_orders

