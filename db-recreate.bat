@echo off

echo Recreate DB ...
docker compose exec -T postgres psql -U postgres -d postgres -f ./scripts/create_db.sql

pause