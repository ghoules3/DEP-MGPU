Папка для практической 4.1  
st_62  
Бочков Андрей Бд251м  

Цель:  
Научиться создавать, настраивать и запускать Airflow DAG для выполнения команд проекта dbt (data build tool), который преобразует данные. Датасет IBM HR Analytics (анализ текучести кадров).  
  
Вариант: Docker: быстрое локальное развёртывание и отладка.  

Структура репозитория:  
local-development/docker-compose.yml  
local-development/dags/hr_dbt_local.py  
local-development/init-scripts/01-init-databases.sql  
local-development/dbt-project/hr_dbt/dbt_project.yml  
local-development/dbt-project/hr_dbt/profiles.yml  
local-development/dbt-project/hr_dbt/models/schema.yml  
local-development/dbt-project/hr_dbt/models/marts/hr_attrition_by_department.sql  
local-development/dbt-project/hr_dbt/models/marts/hr_attrition_reasons.sql  
local-development/dbt-project/hr_dbt/models/staging/G:\local-development\dbt-project\hr_dbt\models\staging  

Инструкция по запуску:  
docker compose up -d --build  
Airflow: http://localhost:8080 (admin/admin) → запустить DAG hr_dbt_local  
pgAdmin: http://localhost:5050 (admin) -> Добавить новый сервер (Name: Local PostgreSQL, Host: postgres ,Port: 5432 ,Username: dbt_user ,Password: dbt_password) → проверить таблицы в схемах analytics_*  
  
Результаты:  
<img width="974" height="128" alt="image" src="https://github.com/user-attachments/assets/d4b68860-0406-4be6-82f3-9404620f9047" />  
<img width="974" height="1043" alt="image" src="https://github.com/user-attachments/assets/a023f958-aeb6-40b2-b07a-7c9fe1f55248" />  
  
Выводы:  
Связка Airflow + dbt даёт прозрачный пайплайн ELT с проверками (tests)  
Docker-вариант удобен для обучения: локально, быстро  
Минусы: меньше автоматического масштабирования и мониторинга, чем в GCP
