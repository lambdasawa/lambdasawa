init:
	docker run \
    -itd \
    -p 3306:3306 \
    -v ${PWD}/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d/ \
    -e MYSQL_ROOT_PASSWORD=root \
    -e MYSQL_DATABASE=app \
    mysql:8.0
