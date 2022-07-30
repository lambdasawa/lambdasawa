.PHONY: setup
setup:
	rm -rf docker-entrypoint-initdb.d sakila-db*

	mkdir -p docker-entrypoint-initdb.d
	curl -sSLO https://downloads.mysql.com/docs/sakila-db.tar.gz
	ouch d sakila-db.tar.gz
	mv sakila-db/sakila-schema.sql ./docker-entrypoint-initdb.d/01-sakila-schema.sql
	mv sakila-db/sakila-data.sql ./docker-entrypoint-initdb.d/02-sakila-data.sql

	rm -rf sakila-db*

.PHONY: run
run:
	docker compose up

.PHONY: healthcheck
healthcheck:
	mysql -uroot -proot -h127.0.0.1 -P3306 app -N -e "select 1"
