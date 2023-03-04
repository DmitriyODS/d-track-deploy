SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'd_track'
  AND pid <> pg_backend_pid();
DROP DATABASE IF EXISTS "d_track";
CREATE DATABASE "d_track";