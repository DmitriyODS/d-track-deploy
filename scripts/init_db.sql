BEGIN;

-- Удаляем схему, если она есть
DROP SCHEMA IF EXISTS user_data CASCADE;

-- Основная схема для хранения всех данных пользователя
CREATE SCHEMA IF NOT EXISTS user_data;

-- Включаем криптографические функции
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS user_data.positions
(
    id     SERIAL PRIMARY KEY,
    "name" text NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS user_data.level_accesses
(
    id       SERIAL PRIMARY KEY,
    "name"   text  NOT NULL DEFAULT '',
    "access" bytea NOT NULL DEFAULT '\x00'
);

CREATE TABLE IF NOT EXISTS user_data.freedom_types
(
    id   SERIAL PRIMARY KEY,
    name text NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS user_data.employees
(
    id                   SERIAL PRIMARY KEY,
    fio                  text      NOT NULL DEFAULT '',
    "login"              text      NOT NULL UNIQUE,
    hash_pass            text      NOT NULL DEFAULT '',
    phone                text      NOT NULL DEFAULT '',
    email                text      NOT NULL DEFAULT '',
    address_of_residence text      NOT NULL DEFAULT '',
    position_id          int8      NOT NULL DEFAULT 0,
    level_access_id      int8      NOT NULL DEFAULT 0,
    freedom_type_id      int8      NOT NULL DEFAULT 0,
    date_appointments    timestamp NOT NULL DEFAULT now(),
    date_of_dismissal    timestamp NOT NULL DEFAULT 'epoch',
    CONSTRAINT employees_position_id_positions_fk FOREIGN KEY (position_id)
        REFERENCES user_data.positions (id) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    CONSTRAINT employees_freedom_type_id_freedom_types_fk FOREIGN KEY (freedom_type_id)
        REFERENCES user_data.freedom_types (id) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    CONSTRAINT employees_level_access_id_level_accesses_fk FOREIGN KEY (level_access_id)
        REFERENCES user_data.level_accesses (id) ON DELETE SET DEFAULT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS user_data.task_states
(
    id   SERIAL PRIMARY KEY,
    name text NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS user_data.bid_states
(
    id   SERIAL PRIMARY KEY,
    name text NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS user_data.services
(
    id   SERIAL PRIMARY KEY,
    name text NOT NULL DEFAULT ''
);

COMMIT;