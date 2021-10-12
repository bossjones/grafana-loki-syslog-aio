dc-up:
	docker-compose -f ./docker-compose.yml up -d

dc-up-generator:
	docker-compose -f ./docker-compose-with-generator.yml up -d
