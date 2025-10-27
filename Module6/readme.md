Папка лабораторной 3.1  
st_62  
Бочков Андрей БД251м  
  
Лабораторная 3.1 Хранилища данных: современные подходы и архитектуры(Yandex DataLens)  
Создание интерактивного дашборда по результатам опроса об архитектурах DWH  
https://datalens.yandex/hrtwm3tkksm42 дашборд  
  
Цели:  
Сбор первичных данных с помощью онлайн-опроса на тему хранилища данных: современные подходы и архитектуры  
Построить интерактивный дашборд в Yandex DataLens  
Сформулировать выводы  
  
Данные и сбор:
Инструмент опроса: Google Forms  
Ответов: 7  
Примечание: опрос искусственный, заполнен одним респондентом 7 раз для демонстрации полного цикла — от опроса до дашборда  
Причины: ограничение по доступу к респондентам и дедлайн  
Экспорт: CSV → предобработка в Excel → загрузка в DataLens (xlsx)  
  
Выводы:  
Архитектуры: присутствуют On‑prem (MS SQL Server), Cloud (BigQuery) и Hybrid (Snowflake), on‑prem встречается чуть чаще  
Интеграции: ELT доминирует, для гибридной архитектуры — смешанный подход  
Латентность: Cloud/Hybrid обновляются почасово, On‑prem — раз в день  
Оценки: средняя ~3.6, лучше всего оценены простота сопровождения (~3.8) и производительность (~4.0), слабее — масштабируемость (~3.5) и стоимость (~3.3)  
Планы: фокус на внедрении Data Catalog/Lineage, встречаютс планы об оптимизации стоимости и переходе к облаку/Lakehouse  





Лабораторная 3.1 Хранилища данных: современные подходы и архитектуры(Yandex DataLens)  
Создание интерактивного дашборда по результатам опроса об архитектурах DWH  
https://datalens.yandex/hrtwm3tkksm42 дашборд  

Введение  
Цель работы — пройти полный цикл data-driven исследования: от формулировки вопросов и сбора данных до построения интерактивного дашборда в Yandex DataLens и получения интерпретируемых выводов по теме “Хранилища данных: современные подходы и архитектуры”.  

Процесс разработки  
Данные и сбор: Инструмент опроса: Google Forms  
Исследовательские вопросы:  
•	Какие архитектуры DWH (On prem, Cloud, Hybrid) встречаются и как они связаны с подходом интеграции (ETL/ELT/смешанный)?  
•	Как размещение и архитектура соотносятся с латентностью обновления данных?  
•	Какие субъективные оценки (производительность, масштабируемость, стоимость, простота сопровождения) получают текущие решения?  
•	Какие инструменты/практики применяются и какие планы развития у команд?  
  
Ответов: 7  
Примечание: опрос искусственный, заполнен одним респондентом 7 раз для демонстрации полного цикла — от опроса до дашборда  
Причины: ограничение по доступу к респондентам и дедлайн  
Экспорт: CSV → предобработка в Excel → загрузка в DataLens (xlsx)  
<img width="974" height="1225" alt="image" src="https://github.com/user-attachments/assets/dd29de2a-9ef4-4a75-be4f-136bd65c93af" />  
<img width="974" height="1076" alt="image" src="https://github.com/user-attachments/assets/ceae1689-08f5-4e0e-8354-4d915696236c" />  
<img width="974" height="1339" alt="image" src="https://github.com/user-attachments/assets/6bb8bc7f-9525-4287-abd4-8f81afb54948" />  
<img width="974" height="876" alt="image" src="https://github.com/user-attachments/assets/f017f833-daa5-4d57-a5cb-a1cd2155a39c" />  
<img width="974" height="1297" alt="image" src="https://github.com/user-attachments/assets/573e33ef-3c3f-4899-a52e-c11d34cd7f5a" />  
<img width="972" height="972" alt="image" src="https://github.com/user-attachments/assets/84d75e4b-414f-49d6-9306-4d891c3d437a" />  

Анализ результатов:  
Создание чартов:  
<img width="1048" height="611" alt="image" src="https://github.com/user-attachments/assets/7f32b21a-9357-4f6b-9518-5c65d748ef2c" />  
<img width="1048" height="622" alt="image" src="https://github.com/user-attachments/assets/4d0d5611-f6a2-4262-b5f8-c181bcf88386" />  
<img width="1039" height="633" alt="image" src="https://github.com/user-attachments/assets/e9d40795-d4d9-45b4-8853-8986f7b4e7a4" />  
<img width="867" height="442" alt="image" src="https://github.com/user-attachments/assets/5296b87d-98af-4325-a338-1396b10ace32" />  
<img width="974" height="560" alt="image" src="https://github.com/user-attachments/assets/96f6441c-f360-4298-9821-db57f0d08e62" />  
<img width="819" height="441" alt="image" src="https://github.com/user-attachments/assets/ef776918-49e7-48b4-8d6b-b353856c75ef" />  
<img width="852" height="447" alt="image" src="https://github.com/user-attachments/assets/85fe4ebe-9bfe-4213-bfc4-e33a83f7f665" />  
<img width="752" height="436" alt="image" src="https://github.com/user-attachments/assets/f76a6bbb-e01e-47bc-bd09-3485a52cc31e" />  
<img width="802" height="441" alt="image" src="https://github.com/user-attachments/assets/5ffbade1-85a3-4268-94a3-9710ae880944" />  

  
Выводы  
Архитектуры: присутствуют On‑prem (MS SQL Server), Cloud (BigQuery) и Hybrid (Snowflake), on‑prem встречается чуть чаще  
Интеграции: ELT доминирует, для гибридной архитектуры — смешанный подход  
Латентность: Cloud/Hybrid обновляются почасово, On‑prem — раз в день  
Оценки: средняя ~3.6, лучше всего оценены простота сопровождения (~3.8) и производительность (~4.0), слабее — масштабируемость (~3.5) и стоимость (~3.3)  
Планы: фокус на внедрении Data Catalog/Lineage, встречаютс планы об оптимизации стоимости и переходе к облаку/Lakehouse  
Ограничения:  
•	Малый объем выборки (n=7), часть ответов — учебные, данные синтетические; результат не репрезентативен  
•	Оценки субъективны 
  
Заключение  
Поставленная цель достигнута: получены и нормализованы данные, построен датасет и дашборд в Yandex DataLens, сформулированы выводы. Несмотря на условность данных видно, что ELT в облаке/гибриде, меньшая латентность в Cloud/Hybrid, более высокие оценки производительности и простоты сопровождения.
