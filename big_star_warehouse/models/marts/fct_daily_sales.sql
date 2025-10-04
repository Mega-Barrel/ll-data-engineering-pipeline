
WITH base_orders AS (
    SELECT
        o.order_id,
        o.product_id,
        o.customer_id,
        lower(o.order_status) AS order_status,
        coalesce(o.product_price, 0) AS product_price,
        cast(o.order_dt AS DATE) AS sales_date
    FROM {{ ref('int_orders') }} o

    {% if is_incremental() %}
        WHERE o.order_dt >= (
            dateadd(day, -5, current_date)
        )
    {% endif %}
)
,
aggregated AS (
    SELECT
        customer_id,
        sales_date,
        product_id,
        COUNT(distinct order_id) AS orders,
        COUNT(*) AS units,
        SUM(product_price) AS gross_revenue,
        SUM(case when order_status <> 'canceled' then product_price else 0 end) AS net_revenue,
        SUM(case when order_status = 'delivered' then 1 else 0 end) AS delivered_orders,
        SUM(case when order_status = 'canceled'  then 1 else 0 end) AS canceled_orders
    FROM base_orders
    GROUP BY 1, 2, 3
)
,
products AS (
    SELECT
        p.product_id,
        p.product_name
    FROM
        {{ ref('stg_products') }} p
)

SELECT
    a.customer_id,
    a.sales_date,
    SUM(a.orders) AS orders,
    SUM(a.units) AS units,
    SUM(a.gross_revenue) AS gross_revenue,
    SUM(a.net_revenue) AS net_revenue,
    SUM(a.delivered_orders) AS delivered_orders,
    SUM(a.canceled_orders) AS canceled_orders
FROM
    aggregated a
    LEFT JOIN products p
    ON p.product_id = a.product_id
GROUP BY
    a.customer_id,
    a.sales_date
ORDER BY
    sales_date ASC
