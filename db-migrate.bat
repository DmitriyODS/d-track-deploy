@echo off

set migrate=%1
echo Your migrate script version: %migrate%\n

echo Migrate DB ...
docker compose exec -T postgres psql -U postgres -d d_track -v "ON_ERROR_STOP=1" -f ./scripts/migrations/migrate_%migrate%.sql

pause