# Charger les variables du .env
include .env
export $(shell sed 's/=.*//' .env)

# Variables locales
COMPOSE_LOCAL=docker-compose
COMPOSE_PROD=docker-compose -f docker-compose.prod.yml

# Commandes

local-up:
	$(COMPOSE_LOCAL) up -d

local-down:
	$(COMPOSE_LOCAL) down

prod-up:
	$(COMPOSE_PROD) up -d

prod-down:
	$(COMPOSE_PROD) down

mysql-root:
	docker exec -it sandbox-mysql mysql -u root -p

mysql-user:
	docker exec -it sandbox-mysql mysql -u $(MYSQL_USER) -p
