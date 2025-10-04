
WITH stg_customers AS (
    SELECT
        customer_id,
        first_name,
        last_name,
        CONCAT(first_name, ' ', last_name) AS full_name,
        email,
        gender,
        city,
        country,
        ip_address
    FROM
        {{ source('raw_data', 'customers') }}
)

SELECT
    customer_id,
    full_name,
    email,
    gender,
    city,
    country,
    ip_address
FROM
    stg_customers
