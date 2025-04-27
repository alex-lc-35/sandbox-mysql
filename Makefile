# Charger les variables du .env
include .env
export $(shell sed 's/=.*//' .env)

# Variables locales
COMPOSE_LOCAL=docker-compose
COMPOSE_PROD=docker-compose -f docker-compose.prod.yml
MYSQL_CONTAINER=sandbox-mysql
MYSQL_VOLUME=sandbox-mysql_mysql-data

# Commandes

local-up:
	$(COMPOSE_LOCAL) up -d

local-down:
	$(COMPOSE_LOCAL) down

prod-up:
	$(COMPOSE_PROD) up -d

prod-down:
	$(COMPOSE_PROD) down

init-db:
	docker exec -i $(MYSQL_CONTAINER) mysql -uroot -p$(MYSQL_ROOT_PASSWORD) -e "\
	CREATE DATABASE IF NOT EXISTS $(MYSQL_DATABASE) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; \
	CREATE USER IF NOT EXISTS '$(MYSQL_USER)'@'%' IDENTIFIED BY '$(MYSQL_PASSWORD)'; \
	GRANT ALL PRIVILEGES ON $(MYSQL_DATABASE).* TO '$(MYSQL_USER)'@'%'; \
	FLUSH PRIVILEGES;"

create-tables:
	docker exec -i $(MYSQL_CONTAINER) mysql -u$(MYSQL_USER) -p$(MYSQL_PASSWORD) $(MYSQL_DATABASE) < ./schema.sql

show-databases:
	docker exec -it $(MYSQL_CONTAINER) mysql -u$(MYSQL_USER) -p$(MYSQL_PASSWORD) -e "SHOW DATABASES;"

show-tables:
	docker exec -it $(MYSQL_CONTAINER) mysql -u$(MYSQL_USER) -p$(MYSQL_PASSWORD) -D $(MYSQL_DATABASE) -e "SHOW TABLES;"

reset-db:
	$(COMPOSE_LOCAL) down
	docker volume rm $(MYSQL_VOLUME)
	$(COMPOSE_LOCAL) up -d
	sleep 5
	make init-db
	make create-tables
