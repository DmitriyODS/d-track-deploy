@echo off

echo Reinit DB ...
docker compose exec -T postgres psql -U postgres -d d_track -f ./scripts/init_db.sql

pause