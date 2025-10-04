
WITH orders AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        product_price,
        order_dt
    FROM
        {{ ref('int_orders') }}
)
,
customers AS (
    SELECT
        customer_id,
        full_name,
        email,
        gender,
        city,
        country
    FROM
        {{ ref('stg_customers') }}
)
,
users_static AS (
    SELECT
        c.customer_id,
        c.full_name,
        c.email,
        c.gender,
        c.city,
        c.country,

        MIN(o.order_dt) AS first_order_date,
        MAX(o.order_dt) AS most_recent_order_date,

        COUNT(o.order_id) AS total_orders,
        COUNT(
            DISTINCT
            CASE
                WHEN o.order_status = 'canceled' THEN o.order_id
            END
        ) AS total_cancelled_orders,

        SUM(CASE WHEN o.order_status <> 'canceled' THEN o.product_price END) AS total_revenue
    FROM
        customers c
        LEFT JOIN orders o
        ON c.customer_id = o.customer_id

    GROUP BY
        c.customer_id, c.full_name,
        c.email, c.gender,
        c.city, c.country
)

SELECT
    *
FROM
    users_static

