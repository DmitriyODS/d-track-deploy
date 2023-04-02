@echo off

set script=%1

echo Restore script: %script%\n
docker compose exec -T postgres psql -U postgres -d d_track -f ./backups/%script%

pause