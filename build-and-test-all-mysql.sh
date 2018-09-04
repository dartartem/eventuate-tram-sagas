#! /bin/bash

set -e

. ./set-env-mysql.sh

docker-compose -f docker-compose-mysql.yml down --remove-orphans -v

docker-compose -f docker-compose-mysql.yml up -d --build zookeeper mysql kafka

./wait-for-mysql.sh

docker-compose -f docker-compose-mysql.yml up -d --build

./gradlew :orders-and-customers:cleanTest build

docker-compose -f docker-compose-mysql.yml down --remove-orphans -v
