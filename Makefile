DB_NAME:=go-rest
DB_SERVICE:=db
MIGRATION_SERVICE:=migration
DOCKER_COMPOSE:=`which docker-compose`
FLYWAY_CONF:=-url=jdbc:mysql://db:3306/go-rest -user=root -password=password

mysql/client:
	$(DOCKER_COMPOSE) exec $(DB_SERVICE) \
		mysql -uroot -ppassword \
		$(DB_NAME)

mysql/init:
	$(DOCKER_COMPOSE) exec $(DB_SERVICE) \
		mysql -uroot -ppassword \
		-e "create database \`$(DB_NAME)\`"

mysql/drop:
	$(DOCKER_COMPOSE) exec $(DB_SERVICE) \
		mysql -uroot -ppassword \
		-e "drop database \`$(DB_NAME)\`"

flyway/baseline:
	$(DOCKER_COMPOSE) run --rm $(MIGRATION_SERVICE) $(FLYWAY_CONF) baseline

flyway/migrate:
	$(DOCKER_COMPOSE) run --rm $(MIGRATION_SERVICE) $(FLYWAY_CONF) migrate

flyway/repair:
	$(DOCKER_COMPOSE) run --rm $(MIGRATION_SERVICE) $(FLYWAY_CONF) repair

flyway/clean:
	$(DOCKER_COMPOSE) run --rm $(MIGRATION_SERVICE) $(FLYWAY_CONF) clean

docker-compose/up:
	$(DOCKER_COMPOSE) up

start:
	reflex -r '\.go$$' -s -- sh -c 'go run server.go'

.PHONY: start

FLYWAY_DOCKER_IMAGE:=flyway/flyway
FLYWAY_CONF_PRODUCTION:=-url=jdbc:mysql://$(RDS_ENDPOINT):3306/kikitutu -user=user -password=password
CODEBUILD_PWD:=$(shell pwd)

production/flyway/baseline:
	@echo run $(@F)
	@docker run -v $(CODEBUILD_PWD)/database/migration:/flyway/sql -i --rm $(FLYWAY_DOCKER_IMAGE) $(FLYWAY_CONF_PRODUCTION) $(@F)

production/flyway/info:
	@echo run $(@F)
	@docker run -v $(CODEBUILD_PWD)/database/migration:/flyway/sql -i --rm $(FLYWAY_DOCKER_IMAGE) $(FLYWAY_CONF_PRODUCTION) $(@F)

production/flyway/validate:
	@echo run $(@F)
	@docker run -v $(CODEBUILD_PWD)/database/migration:/flyway/sql -i --rm $(FLYWAY_DOCKER_IMAGE) $(FLYWAY_CONF_PRODUCTION) $(@F)

production/flyway/migrate:
	@echo run $(@F)
	@docker run -v $(CODEBUILD_PWD)/database/migration:/flyway/sql -i --rm $(FLYWAY_DOCKER_IMAGE) $(FLYWAY_CONF_PRODUCTION) $(@F)

