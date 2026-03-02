--Выбрать все автомобили, которые сейчас не заняты

SELECT cars.vin, cars_models.name FROM cars
JOIN cars_models ON cars.model_id = cars_models.id AND cars.current_rental_at IS NULL;

-- Найти самые популярные модели автомобилей (по количеству аренд)

SELECT name, brand, COUNT(rentals.id) AS rentals_count FROM rentals
JOIN cars  on rentals.car_id = cars.id
JOIN cars_models on cars.model_id = cars_models.id
GROUP BY cars_models.id
ORDER BY rentals_count DESC
LIMIT 5;

-- Выбрать клиентов с наибольшей суммой аренды (топ-3 по деньгам)

SELECT clients.name, SUM(total_price) AS sum_total FROM clients
JOIN rentals ON clients.id = rentals.client_id
group by clients.id
ORDER BY sum_total DESC
LIMIT 3;

-- Найти автомобили, которые требуют технического обслуживания (пробег > 10000 км)

SELECT cars.vin, cars.mileage
FROM cars
WHERE mileage > 10000;

-- Посчитать загрузку автопарка за последний месяц (процент времени в аренде)

WITH rlp AS (
    SELECT ROUND(100.0 *
                 SUM(EXTRACT(EPOCH FROM (COALESCE(rentals.end_date, NOW()) - rentals.start_date)) - (30 * 24 * 60 * 60))
                 FILTER (WHERE rentals.end_date IS NULL OR rentals.end_date > NOW() - INTERVAL '30 days') /
                 COUNT(*),
                 2) AS load_percentage
    FROM rentals
    WHERE start_date >= NOW() - INTERVAL '30 days'
)
SELECT * FROM rlp;

