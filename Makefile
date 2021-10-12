gpr:
	git pull --rebase

build: gpr
	docker-compose -f ./docker-compose.yml build --build-arg GEOIP_ACCOUNTID=$(GEOIP_ACCOUNTID) --build-arg GEOIP_LICENSE=$(GEOIP_LICENSE)

dc-up: build
	docker-compose -f ./docker-compose.yml up -d

dc-down:
	docker-compose -f ./docker-compose.yml down

dc-up-generator:
	docker-compose -f ./docker-compose-with-generator.yml up -d

dc-down-generator:
	docker-compose -f ./docker-compose-with-generator.yml down

dc-reload: dc-down dc-up
