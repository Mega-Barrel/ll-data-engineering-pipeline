

SELECT
    customer_id,
    email,
    gender,
    city,
    country,
    ip_address
FROM
    {{ source('raw_data', 'customers') }}
