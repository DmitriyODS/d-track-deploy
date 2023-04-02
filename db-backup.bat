@echo off

set PWD=%CD%

echo Backuping...
docker compose exec -T postgres pg_dump -c -U postgres d_track > ./backups/dump_file1.sql

pause