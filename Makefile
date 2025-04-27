# Variables
COMPOSE_LOCAL=docker-compose
COMPOSE_PROD=docker-compose -f docker-compose.prod.yml
MYSQL_CONTAINER=sandbox-mysql
MYSQL_USER=rfess_user
MYSQL_PASSWORD=SuperUserPass456
MYSQL_DATABASE=shared_db

# Commandes

local-up:
	$(COMPOSE_LOCAL) up -d

local-down:
	$(COMPOSE_LOCAL) down

prod-up:
	$(COMPOSE_PROD) up -d

prod-down:
	$(COMPOSE_PROD) down

create-db:
	docker exec -i $(MYSQL_CONTAINER) mysql -uroot -p$(MYSQL_ROOT_PASSWORD) -e "CREATE DATABASE IF NOT EXISTS $(MYSQL_DATABASE);"

create-tables:
	docker exec -i $(MYSQL_CONTAINER) mysql -u$(MYSQL_USER) -p$(MYSQL_PASSWORD) $(MYSQL_DATABASE) < ./schema.sql

show-databases:
	docker exec -it $(MYSQL_CONTAINER) mysql -u$(MYSQL_USER) -p$(MYSQL_PASSWORD) -e "SHOW DATABASES;"

show-tables:
	docker exec -it $(MYSQL_CONTAINER) mysql -u$(MYSQL_USER) -p$(MYSQL_PASSWORD) -D $(MYSQL_DATABASE) -e "SHOW TABLES;"
