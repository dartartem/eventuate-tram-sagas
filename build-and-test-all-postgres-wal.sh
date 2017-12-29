#! /bin/bash

set -e

. ./set-env-postgres-wal.sh

docker-compose -f docker-compose-postgres-wal.yml down -v

docker-compose -f docker-compose-postgres-wal.yml up -d --build zookeeper postgres kafka

./wait-for-postgres.sh

docker-compose -f docker-compose-postgres-wal.yml up -d --build

./gradlew :orders-and-customers:cleanTest build

docker-compose -f docker-compose-postgres-wal.yml down -v
