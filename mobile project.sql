USE eia_test;
SELECT * FROM smartphones
SELECT TOP 1 brand_name, model, price, screen_size
FROM smartphones
WHERE brand_name = 'Samsung'
ORDER BY screen_size DESC, price DESC;

SELECT model, SUM(num_rear_cameras + num_front_cameras) AS total_cameras
FROM smartphones
GROUP BY model
ORDER BY total_cameras DESC;

SELECT model,
       ROUND(
           CAST(resolution_width AS DECIMAL(10,2)) * CAST(resolution_height AS DECIMAL(10,2)) / 
           (CAST(screen_size AS DECIMAL(10,2)) * CAST(screen_size AS DECIMAL(10,2))), 2) AS highest_ppi
FROM smartphones
ORDER BY highest_ppi DESC

SELECT brand_name, model, battery_capacity
FROM smartphones
ORDER BY battery_capacity DESC
OFFSET 1 ROW
FETCH FIRST 1 ROW ONLY;

SELECT brand_name, model, MAX(rating) AS highest_rating
FROM smartphones
GROUP BY brand_name, model
ORDER BY brand_name ASC, highest_rating DESC;

SELECT brand_name, AVG(max_price) AS average_costliest_price
FROM (
    SELECT brand_name, MAX(price) AS max_price
    FROM smartphones
    GROUP BY brand_name
) AS max_prices
GROUP BY brand_name;

SELECT TOP 1 brand_name,
    COUNT(*) AS count_of_phones,
    AVG(price) AS average_price,
    MAX(rating) AS max_rating,
    AVG(screen_size) AS average_screen_size,
    AVG(battery_capacity) AS average_battery_capacity
FROM smartphones
GROUP BY brand_name
ORDER BY max_rating DESC

SELECT
    AVG(price) AS average_price_5g,
    AVG(rating) AS average_rating_5g
FROM smartphones
WHERE has_5g = 1;

SELECT TOP 1 brand_name	, screen_size
FROM smartphones
GROUP BY brand_name, screen_size
ORDER BY AVG(screen_size) ASC

SELECT TOP 1 brand_name, COUNT(*) AS model_count
FROM smartphones
WHERE has_nfc = 1 AND has_ir_blaster = 1
GROUP BY brand_name
ORDER BY model_count DESC

SELECT AVG(price) AS average_price
FROM smartphones
WHERE brand_name = 'Samsung' AND has_5g = 1 AND has_nfc = 'True';

SELECT brand_name, COUNT(*) AS count_of_phones, AVG(rating) AS average_rating
FROM smartphones
GROUP BY brand_name
HAVING COUNT(*) > 40;

WITH BrandAvgRam AS (
    SELECT brand_name, AVG(ram_capacity) AS avg_ram
    FROM smartphones
    GROUP BY brand_name
    HAVING COUNT(*) >= 10
)
SELECT TOP 1 brand_name, ROUND(MAX(avg_ram), 2) AS highest_avg_ram
FROM BrandAvgRam
WHERE brand_name IN (
    SELECT brand_name
    FROM smartphones
    WHERE refresh_rate > 90 AND fast_charging_available = 1
)
GROUP BY brand_name
ORDER BY highest_avg_ram DESC;

WITH BrandAvgRating AS (
    SELECT brand_name, AVG(rating) AS avg_rating
    FROM smartphones
    WHERE has_5g = 1
    GROUP BY brand_name
    HAVING COUNT(*) > 10 AND AVG(rating) > 70
)
SELECT brand_name, MAX(avg_price) AS highest_avg_price
FROM (
    SELECT brand_name, AVG(price) AS avg_price
    FROM smartphones
    WHERE brand_name IN (SELECT brand_name FROM BrandAvgRating)
    GROUP BY brand_name
) AS BrandAvgPrice
GROUP BY brand_name
ORDER BY highest_avg_price DESC;







