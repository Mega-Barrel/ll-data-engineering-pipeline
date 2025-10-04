
WITH stg_products AS (
    SELECT
        product_id,
        name AS product_name,
        category AS product_category,
        collection AS product_collection,
        price AS product_price,
        rating AS product_rating,
        availability AS product_availability
    FROM
        {{ source('raw_data', 'products') }}
)

SELECT
    product_id,
    product_name,
    product_category,
    product_collection,
    product_price,
    product_rating,
    product_availability
FROM
    stg_products
