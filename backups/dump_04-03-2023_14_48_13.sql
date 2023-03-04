--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.2 (Debian 15.2-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY user_data.employees DROP CONSTRAINT employees_position_id_positions_fk;
ALTER TABLE ONLY user_data.employees DROP CONSTRAINT employees_level_access_id_level_accesses_fk;
ALTER TABLE ONLY user_data.employees DROP CONSTRAINT employees_freedom_type_id_freedom_types_fk;
ALTER TABLE ONLY user_data.task_states DROP CONSTRAINT task_states_pkey;
ALTER TABLE ONLY user_data.services DROP CONSTRAINT services_pkey;
ALTER TABLE ONLY user_data.positions DROP CONSTRAINT positions_pkey;
ALTER TABLE ONLY user_data.level_accesses DROP CONSTRAINT level_accesses_pkey;
ALTER TABLE ONLY user_data.freedom_types DROP CONSTRAINT freedom_types_pkey;
ALTER TABLE ONLY user_data.employees DROP CONSTRAINT employees_pkey;
ALTER TABLE ONLY user_data.employees DROP CONSTRAINT employees_login_key;
ALTER TABLE ONLY user_data.bid_states DROP CONSTRAINT bid_states_pkey;
ALTER TABLE user_data.task_states ALTER COLUMN id DROP DEFAULT;
ALTER TABLE user_data.services ALTER COLUMN id DROP DEFAULT;
ALTER TABLE user_data.positions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE user_data.level_accesses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE user_data.freedom_types ALTER COLUMN id DROP DEFAULT;
ALTER TABLE user_data.employees ALTER COLUMN id DROP DEFAULT;
ALTER TABLE user_data.bid_states ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE user_data.task_states_id_seq;
DROP TABLE user_data.task_states;
DROP SEQUENCE user_data.services_id_seq;
DROP TABLE user_data.services;
DROP SEQUENCE user_data.positions_id_seq;
DROP TABLE user_data.positions;
DROP SEQUENCE user_data.level_accesses_id_seq;
DROP TABLE user_data.level_accesses;
DROP SEQUENCE user_data.freedom_types_id_seq;
DROP TABLE user_data.freedom_types;
DROP SEQUENCE user_data.employees_id_seq;
DROP TABLE user_data.employees;
DROP SEQUENCE user_data.bid_states_id_seq;
DROP TABLE user_data.bid_states;
DROP EXTENSION pgcrypto;
DROP SCHEMA user_data;
--
-- Name: user_data; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA user_data;


ALTER SCHEMA user_data OWNER TO postgres;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bid_states; Type: TABLE; Schema: user_data; Owner: postgres
--

CREATE TABLE user_data.bid_states (
    id integer NOT NULL,
    name text DEFAULT ''::text NOT NULL
);


ALTER TABLE user_data.bid_states OWNER TO postgres;

--
-- Name: bid_states_id_seq; Type: SEQUENCE; Schema: user_data; Owner: postgres
--

CREATE SEQUENCE user_data.bid_states_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_data.bid_states_id_seq OWNER TO postgres;

--
-- Name: bid_states_id_seq; Type: SEQUENCE OWNED BY; Schema: user_data; Owner: postgres
--

ALTER SEQUENCE user_data.bid_states_id_seq OWNED BY user_data.bid_states.id;


--
-- Name: employees; Type: TABLE; Schema: user_data; Owner: postgres
--

CREATE TABLE user_data.employees (
    id integer NOT NULL,
    fio text DEFAULT ''::text NOT NULL,
    login text NOT NULL,
    hash_pass text DEFAULT ''::text NOT NULL,
    phone text DEFAULT ''::text NOT NULL,
    email text DEFAULT ''::text NOT NULL,
    address_of_residence text DEFAULT ''::text NOT NULL,
    position_id bigint DEFAULT 0 NOT NULL,
    level_access_id bigint DEFAULT 0 NOT NULL,
    freedom_type_id bigint DEFAULT 0 NOT NULL,
    date_appointments timestamp without time zone DEFAULT now() NOT NULL,
    date_of_dismissal timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE user_data.employees OWNER TO postgres;

--
-- Name: employees_id_seq; Type: SEQUENCE; Schema: user_data; Owner: postgres
--

CREATE SEQUENCE user_data.employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_data.employees_id_seq OWNER TO postgres;

--
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: user_data; Owner: postgres
--

ALTER SEQUENCE user_data.employees_id_seq OWNED BY user_data.employees.id;


--
-- Name: freedom_types; Type: TABLE; Schema: user_data; Owner: postgres
--

CREATE TABLE user_data.freedom_types (
    id integer NOT NULL,
    name text DEFAULT ''::text NOT NULL
);


ALTER TABLE user_data.freedom_types OWNER TO postgres;

--
-- Name: freedom_types_id_seq; Type: SEQUENCE; Schema: user_data; Owner: postgres
--

CREATE SEQUENCE user_data.freedom_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_data.freedom_types_id_seq OWNER TO postgres;

--
-- Name: freedom_types_id_seq; Type: SEQUENCE OWNED BY; Schema: user_data; Owner: postgres
--

ALTER SEQUENCE user_data.freedom_types_id_seq OWNED BY user_data.freedom_types.id;


--
-- Name: level_accesses; Type: TABLE; Schema: user_data; Owner: postgres
--

CREATE TABLE user_data.level_accesses (
    id integer NOT NULL,
    name text DEFAULT ''::text NOT NULL,
    access bytea DEFAULT '\x00'::bytea NOT NULL
);


ALTER TABLE user_data.level_accesses OWNER TO postgres;

--
-- Name: level_accesses_id_seq; Type: SEQUENCE; Schema: user_data; Owner: postgres
--

CREATE SEQUENCE user_data.level_accesses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_data.level_accesses_id_seq OWNER TO postgres;

--
-- Name: level_accesses_id_seq; Type: SEQUENCE OWNED BY; Schema: user_data; Owner: postgres
--

ALTER SEQUENCE user_data.level_accesses_id_seq OWNED BY user_data.level_accesses.id;


--
-- Name: positions; Type: TABLE; Schema: user_data; Owner: postgres
--

CREATE TABLE user_data.positions (
    id integer NOT NULL,
    name text DEFAULT ''::text NOT NULL
);


ALTER TABLE user_data.positions OWNER TO postgres;

--
-- Name: positions_id_seq; Type: SEQUENCE; Schema: user_data; Owner: postgres
--

CREATE SEQUENCE user_data.positions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_data.positions_id_seq OWNER TO postgres;

--
-- Name: positions_id_seq; Type: SEQUENCE OWNED BY; Schema: user_data; Owner: postgres
--

ALTER SEQUENCE user_data.positions_id_seq OWNED BY user_data.positions.id;


--
-- Name: services; Type: TABLE; Schema: user_data; Owner: postgres
--

CREATE TABLE user_data.services (
    id integer NOT NULL,
    name text DEFAULT ''::text NOT NULL
);


ALTER TABLE user_data.services OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: user_data; Owner: postgres
--

CREATE SEQUENCE user_data.services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_data.services_id_seq OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: user_data; Owner: postgres
--

ALTER SEQUENCE user_data.services_id_seq OWNED BY user_data.services.id;


--
-- Name: task_states; Type: TABLE; Schema: user_data; Owner: postgres
--

CREATE TABLE user_data.task_states (
    id integer NOT NULL,
    name text DEFAULT ''::text NOT NULL
);


ALTER TABLE user_data.task_states OWNER TO postgres;

--
-- Name: task_states_id_seq; Type: SEQUENCE; Schema: user_data; Owner: postgres
--

CREATE SEQUENCE user_data.task_states_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_data.task_states_id_seq OWNER TO postgres;

--
-- Name: task_states_id_seq; Type: SEQUENCE OWNED BY; Schema: user_data; Owner: postgres
--

ALTER SEQUENCE user_data.task_states_id_seq OWNED BY user_data.task_states.id;


--
-- Name: bid_states id; Type: DEFAULT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.bid_states ALTER COLUMN id SET DEFAULT nextval('user_data.bid_states_id_seq'::regclass);


--
-- Name: employees id; Type: DEFAULT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.employees ALTER COLUMN id SET DEFAULT nextval('user_data.employees_id_seq'::regclass);


--
-- Name: freedom_types id; Type: DEFAULT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.freedom_types ALTER COLUMN id SET DEFAULT nextval('user_data.freedom_types_id_seq'::regclass);


--
-- Name: level_accesses id; Type: DEFAULT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.level_accesses ALTER COLUMN id SET DEFAULT nextval('user_data.level_accesses_id_seq'::regclass);


--
-- Name: positions id; Type: DEFAULT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.positions ALTER COLUMN id SET DEFAULT nextval('user_data.positions_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.services ALTER COLUMN id SET DEFAULT nextval('user_data.services_id_seq'::regclass);


--
-- Name: task_states id; Type: DEFAULT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.task_states ALTER COLUMN id SET DEFAULT nextval('user_data.task_states_id_seq'::regclass);


--
-- Data for Name: bid_states; Type: TABLE DATA; Schema: user_data; Owner: postgres
--

COPY user_data.bid_states (id, name) FROM stdin;
1	Приёмка
2	Выезд
3	Ремонт
4	Тестирование
5	Выдача
6	Закрыта
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: user_data; Owner: postgres
--

COPY user_data.employees (id, fio, login, hash_pass, phone, email, address_of_residence, position_id, level_access_id, freedom_type_id, date_appointments, date_of_dismissal) FROM stdin;
1	admin	admin	$2a$06$vUXDGGEJIwadRzMhd2rPh.Yu8jGtlS8OomE3dcr7XvJxFIAK6x2WG				3	1	0	2023-03-04 14:47:56.016326	1970-01-01 00:00:00
\.


--
-- Data for Name: freedom_types; Type: TABLE DATA; Schema: user_data; Owner: postgres
--

COPY user_data.freedom_types (id, name) FROM stdin;
0	Не задано
1	Свободен
2	Занят
3	Выходной
4	Отпуск
5	Уволен
\.


--
-- Data for Name: level_accesses; Type: TABLE DATA; Schema: user_data; Owner: postgres
--

COPY user_data.level_accesses (id, name, access) FROM stdin;
0	Не задано	\\x00
1	Администратор	\\xff
2	Мастер	\\x1b
3	Менеджер	\\x3f
4	Документалист	\\xc3
5	Руководитель	\\xff
\.


--
-- Data for Name: positions; Type: TABLE DATA; Schema: user_data; Owner: postgres
--

COPY user_data.positions (id, name) FROM stdin;
0	Не задано
1	Директор
2	Секретарь
3	Администратор
4	Инженер-программист
5	Инженер-электронщик
6	Инженер полного цикла
7	Тестировщик
8	Бухгалтер
9	HR-администратор
10	PR-менеджер
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: user_data; Owner: postgres
--

COPY user_data.services (id, name) FROM stdin;
1	Обслуживание
2	Ремонт
\.


--
-- Data for Name: task_states; Type: TABLE DATA; Schema: user_data; Owner: postgres
--

COPY user_data.task_states (id, name) FROM stdin;
1	Открыта
2	В работе
3	Оценка
4	Закрыта
\.


--
-- Name: bid_states_id_seq; Type: SEQUENCE SET; Schema: user_data; Owner: postgres
--

SELECT pg_catalog.setval('user_data.bid_states_id_seq', 7, true);


--
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: user_data; Owner: postgres
--

SELECT pg_catalog.setval('user_data.employees_id_seq', 2, true);


--
-- Name: freedom_types_id_seq; Type: SEQUENCE SET; Schema: user_data; Owner: postgres
--

SELECT pg_catalog.setval('user_data.freedom_types_id_seq', 6, true);


--
-- Name: level_accesses_id_seq; Type: SEQUENCE SET; Schema: user_data; Owner: postgres
--

SELECT pg_catalog.setval('user_data.level_accesses_id_seq', 6, true);


--
-- Name: positions_id_seq; Type: SEQUENCE SET; Schema: user_data; Owner: postgres
--

SELECT pg_catalog.setval('user_data.positions_id_seq', 11, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: user_data; Owner: postgres
--

SELECT pg_catalog.setval('user_data.services_id_seq', 3, true);


--
-- Name: task_states_id_seq; Type: SEQUENCE SET; Schema: user_data; Owner: postgres
--

SELECT pg_catalog.setval('user_data.task_states_id_seq', 5, true);


--
-- Name: bid_states bid_states_pkey; Type: CONSTRAINT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.bid_states
    ADD CONSTRAINT bid_states_pkey PRIMARY KEY (id);


--
-- Name: employees employees_login_key; Type: CONSTRAINT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.employees
    ADD CONSTRAINT employees_login_key UNIQUE (login);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: freedom_types freedom_types_pkey; Type: CONSTRAINT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.freedom_types
    ADD CONSTRAINT freedom_types_pkey PRIMARY KEY (id);


--
-- Name: level_accesses level_accesses_pkey; Type: CONSTRAINT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.level_accesses
    ADD CONSTRAINT level_accesses_pkey PRIMARY KEY (id);


--
-- Name: positions positions_pkey; Type: CONSTRAINT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.positions
    ADD CONSTRAINT positions_pkey PRIMARY KEY (id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: task_states task_states_pkey; Type: CONSTRAINT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.task_states
    ADD CONSTRAINT task_states_pkey PRIMARY KEY (id);


--
-- Name: employees employees_freedom_type_id_freedom_types_fk; Type: FK CONSTRAINT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.employees
    ADD CONSTRAINT employees_freedom_type_id_freedom_types_fk FOREIGN KEY (freedom_type_id) REFERENCES user_data.freedom_types(id) ON UPDATE CASCADE ON DELETE SET DEFAULT;


--
-- Name: employees employees_level_access_id_level_accesses_fk; Type: FK CONSTRAINT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.employees
    ADD CONSTRAINT employees_level_access_id_level_accesses_fk FOREIGN KEY (level_access_id) REFERENCES user_data.level_accesses(id) ON UPDATE CASCADE ON DELETE SET DEFAULT;


--
-- Name: employees employees_position_id_positions_fk; Type: FK CONSTRAINT; Schema: user_data; Owner: postgres
--

ALTER TABLE ONLY user_data.employees
    ADD CONSTRAINT employees_position_id_positions_fk FOREIGN KEY (position_id) REFERENCES user_data.positions(id) ON UPDATE CASCADE ON DELETE SET DEFAULT;


--
-- PostgreSQL database dump complete
--

