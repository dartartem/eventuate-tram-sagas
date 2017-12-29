#! /bin/bash

set -e

. ./set-env-postgres-polling.sh

docker-compose -f docker-compose-postgres-polling.yml down -v

docker-compose -f docker-compose-postgres-polling.yml up -d --build zookeeper postgres kafka

./wait-for-postgres.sh

docker-compose -f docker-compose-postgres-polling.yml up -d --build

./gradlew :orders-and-customers:cleanTest build

docker-compose -f docker-compose-postgres-polling.yml down -v
