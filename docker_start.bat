@echo off

echo Set PWD ...
set PWD=%CD%

echo Start docker-compose-dev ...
docker compose -f ./docker-compose-dev.yml up -d

echo Dcoker containers:
docker compose ps

pause