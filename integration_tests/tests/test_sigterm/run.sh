#!/bin/bash

docker-compose up -d consul app > /dev/null 2>&1
APP_ID="$(docker-compose ps -q app)"
docker-compose run --no-deps test /go/bin/test_probe test_sigterm $APP_ID > /dev/null 2>&1
result=$?
TEST_ID=$(docker ps -l -f "ancestor=cbfix_test_probe" --format="{{.ID}}")
docker logs $TEST_ID
docker rm -f $TEST_ID > /dev/null 2>&1
exit $result
