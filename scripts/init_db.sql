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

CREATE TABLE IF NOT EXISTS user_data.claim_states
(
    id   SERIAL PRIMARY KEY,
    name text NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS user_data.services
(
    id   SERIAL PRIMARY KEY,
    name text NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS user_data.customers
(
    id           SERIAL PRIMARY KEY,
    fio          text      NOT NULL,
    phone        text      NOT NULL,
    email        text      NOT NULL,
    address      text      NOT NULL,
    date_created timestamp NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS user_data.claims
(
    id                        SERIAL PRIMARY KEY,
    number                    text      NOT NULL UNIQUE,
    date_created              timestamp NOT NULL DEFAULT now(),
    date_completed            timestamp NOT NULL DEFAULT 'epoch',
    date_estimated_completion timestamp NOT NULL DEFAULT 'epoch',
    customer_id               int8      NOT NULL,
    executor_id               int8      NOT NULL,
    subject                   text      NOT NULL DEFAULT '',
    service_type_id           int8      NOT NULL,
    state_id                  int8      NOT NULL,
    description               text      NOT NULL DEFAULT '',
    CONSTRAINT claims_status_id_claim_states_fk FOREIGN KEY (state_id)
        REFERENCES user_data.claim_states (id) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    CONSTRAINT claims_service_type_id_services_fk FOREIGN KEY (service_type_id)
        REFERENCES user_data.services (id) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    CONSTRAINT claim_customer_id_customers_fk FOREIGN KEY (customer_id)
        REFERENCES user_data.customers (id) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    CONSTRAINT claim_executor_id_employees_fk FOREIGN KEY (executor_id)
        REFERENCES user_data.employees (id) ON DELETE SET DEFAULT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS user_data.tasks
(
    id                        SERIAL PRIMARY KEY,
    number                    text      NOT NULL UNIQUE,
    date_created              timestamp NOT NULL DEFAULT now(),
    date_completed            timestamp NOT NULL DEFAULT 'epoch',
    date_estimated_completion timestamp NOT NULL DEFAULT 'epoch',
    creator_id                int8      NOT NULL,
    executor_id               int8      NOT NULL,
    "name"                    text      NOT NULL DEFAULT '',
    state_id                  int8      NOT NULL,
    description               text      NOT NULL DEFAULT '',
    CONSTRAINT tasks_status_id_task_states_fk FOREIGN KEY (state_id)
        REFERENCES user_data.task_states (id) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    CONSTRAINT claim_creator_id_employees_fk FOREIGN KEY (creator_id)
        REFERENCES user_data.employees (id) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    CONSTRAINT claim_executor_id_employees_fk FOREIGN KEY (executor_id)
        REFERENCES user_data.employees (id) ON DELETE SET DEFAULT ON UPDATE CASCADE
);

COMMIT;