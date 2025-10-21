--Проверка Задание 1(st_62): [Создать представление по выручке менеджеров]
SELECT * FROM dw.sales_by_region ORDER BY sales;
-- 0 строк
SELECT region, COUNT(*) AS persons_per_region
FROM public.people
GROUP BY region
HAVING COUNT(*) <> 1;

--Проверка Задание 2(st_62): [Определить среднюю прибыль по категориям]
SELECT * FROM dw.avg_profit_by_category ORDER BY total_profit
--Баланс сумм
SELECT
  (SELECT SUM(total_profit) FROM dw.avg_profit_by_category) AS ct_total_profit,
  (SELECT SUM(profit)       FROM dw.sales_fact)             AS fact_total_profit;

--Проверка Задание 3(st_62): [Найти количество заказов по способам доставки]
SELECT * FROM dw.v_orders_by_shipmode ORDER BY orders_cnt DESC;
--У каждого заказа один способ доставки(0 lines)
SELECT
	ORDER_ID,
	COUNT(DISTINCT SHIP_ID) AS SHIP_IDS
FROM
	DW.SALES_FACT
GROUP BY
	ORDER_ID
HAVING
	COUNT(DISTINCT SHIP_ID) <> 1;