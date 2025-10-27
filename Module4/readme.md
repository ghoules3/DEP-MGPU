Папка лабораторная работа 2.1  
st_62  
Бочков Андрей БД251м  
  
Описание архитектуры  
Архитектура dbt-проекта реализована по многоуровневому принципу: staging → intermediate → marts. Слой intermediate инкапсулирует сложную и многократно используемую бизнес-логику, а слой marts предоставляет бизнес-ориентированные витрины для BI и аналитики.  

Граф зависимостей (Lineage)  
<img width="1169" height="355" alt="image" src="https://github.com/user-attachments/assets/9c5d944c-0d85-414f-a073-a6ff7d82185d" />  

Код промежуточной модели  
Ключевые фрагменты кода  
-- models/intermediate/int_sales_orders.sql  
-- Эта модель объединяет факты со всеми измерениями, создавая  
-- широкую, денормализованную таблицу для легкого использования в витринах.  
   
SELECT  
-- Ключи  
f.order_id,  
   
-- Измерения из customer_dim  
c.customer_id,  
c.customer_name,  
   
-- Измерения из product_dim  
p.product_id,  
p.product_name,  
p.category,  
p.sub_category,  
p.segment,  
   
-- Измерения из geo_dim  
g.city,  
g.state,  
   
-- Измерения из shipping_dim  
s.ship_mode,  
   
-- Даты из calendar_dim (с правильными псевдонимами)  
cal_order.date as order_date,  
cal_ship.date as ship_date,  
   
-- Метрики из sales_fact  
f.sales,  
f.profit,  
f.quantity,  
f.discount  
   
FROM {{ source('dw_test', 'sales_fact') }} AS f  
LEFT JOIN {{ source('dw_test', 'customer_dim') }} AS c ON f.cust_id = c.cust_id  
LEFT JOIN {{ source('dw_test', 'product_dim') }} AS p ON f.prod_id = p.prod_id  
LEFT JOIN {{ source('dw_test', 'shipping_dim') }} AS s ON f.ship_id = s.ship_id  
LEFT JOIN {{ source('dw_test', 'geo_dim') }} AS g ON f.geo_id = g.geo_id  
-- ИСПРАВЛЕНО: Добавляем псевдонимы, так как календарь используется дважды  
LEFT JOIN {{ source('dw_test', 'calendar_dim') }} AS cal_order ON f.order_date_id = cal_order.dateid  
LEFT JOIN {{ source('dw_test', 'calendar_dim') }} AS cal_ship ON f.ship_date_id = cal_ship.dateid    

  
Код индивидуальной mart-модели.  
-- Топ-3 самых прибыльных товаров по каждому штату.st_62  
   
WITH product_profit AS (  
SELECT  
state,  
product_id,  
product_name,  
SUM(profit) AS total_profit,  
SUM(sales) AS total_sales  
FROM {{ ref('int_sales_orders') }}  
GROUP BY 1,2,3  
),  
ranked AS (  
SELECT  
state,  
product_id,  
product_name,  
total_profit,  
total_sales,  
ROW_NUMBER() OVER (  
PARTITION BY state  
ORDER BY total_profit DESC, total_sales DESC, product_id  
) AS rank_in_state  
FROM product_profit  
)  
SELECT  
state,  
product_id,  
product_name,  
total_profit,  
total_sales,  
rank_in_state  
FROM ranked  
WHERE rank_in_state <= 3  
ORDER BY state, rank_in_state    


Код кастомного теста  
-- tests/generic/test_is_positive.sql  
{% test is_positive(model, column_name) %}  
SELECT *  
FROM {{ model }}  
WHERE {{ column_name }} < 0  
{% endtest %}    
<img width="1009" height="433" alt="image" src="https://github.com/user-attachments/assets/e062282c-1804-450c-b13b-223ed6472aca" />    

Код снепшота  
-- snapshots/snapshot_product_dim.sql  
{% snapshot snapshot_product_dim %}  
{{  
config(  
target_schema='dw_snapshots',  
strategy='check',  
unique_key='prod_id',  
check_cols=['segment', 'category'],  
)  
}}  
SELECT prod_id, product_id, segment, category FROM {{ source('dw_test', 'product_dim') }}  
{% endsnapshot %}    

Результаты  
<img width="1009" height="517" alt="image" src="https://github.com/user-attachments/assets/9b6210b9-6913-470f-b456-34b1226dbad4" />  

<img width="1009" height="526" alt="image" src="https://github.com/user-attachments/assets/cfaba8c1-8cb9-4cbc-8885-8cdd41dcdd85" />  
<img width="1009" height="627" alt="image" src="https://github.com/user-attachments/assets/93262ccf-121b-44ca-826c-5e167f04878f" />  
  
<img width="1009" height="343" alt="image" src="https://github.com/user-attachments/assets/fb37f179-536f-4ef8-a513-683a1430aa4a" />  

<img width="1009" height="259" alt="image" src="https://github.com/user-attachments/assets/43653a44-7377-4560-8b55-f13556faf56a" />  

<img width="1009" height="259" alt="image" src="https://github.com/user-attachments/assets/3e319e3d-ea47-4fe8-bfd5-b66cb52779c3" />  
  
  
Выводы  
Преимущество использования промежуточных моделей и витрин по сравнению с работой напрямую с единой таблицей фактов:  
•	Запросы в BI становятся короткими и понятными, снижается порог ошибок.  
•	Правка в одном месте автоматически распространяется на все витрины.  
•	Каждый человек может настроить витрину под свои требования.  
