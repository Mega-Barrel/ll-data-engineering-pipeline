
WITH stg_order_items AS (
    SELECT
        order_item_id,
        order_id,
        product_id,
        product_price
    FROM
        {{ source('raw_data', 'order_items') }}
)

SELECT
    order_item_id,
    order_id,
    product_id,
    product_price
FROM
    stg_order_items

