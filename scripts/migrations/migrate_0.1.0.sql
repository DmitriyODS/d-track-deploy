BEGIN;

INSERT INTO user_data.positions(id, name)
VALUES (0, 'Не задано'),
       (1, 'Директор'),
       (2, 'Секретарь'),
       (3, 'Администратор'),
       (4, 'Инженер-программист'),
       (5, 'Инженер-электронщик'),
       (6, 'Инженер полного цикла'),
       (7, 'Тестировщик'),
       (8, 'Бухгалтер'),
       (9, 'HR-администратор'),
       (10, 'PR-менеджер')
ON CONFLICT (id) DO UPDATE SET id=excluded.id,
                               name=excluded.name;

SELECT setval('user_data.positions_id_seq', (SELECT MAX(id) + 1 FROM user_data.positions));

INSERT INTO user_data.level_accesses(id, "name", "access")
VALUES (0, 'Не задано', '\x00'),
       (1, 'Администратор', '\xFF'),
       (2, 'Мастер', '\x5B'),
       (3, 'Менеджер', '\x7F'),
       (4, 'Документалист', '\x53'),
       (5, 'Руководитель', '\xFF')
ON CONFLICT (id) DO UPDATE SET id=excluded.id,
                               "name"=excluded."name",
                               "access"=excluded."access";

SELECT setval('user_data.level_accesses_id_seq', (SELECT MAX(id) + 1 FROM user_data.level_accesses));

INSERT INTO user_data.freedom_types(id, name)
VALUES (0, 'Не задано'),
       (1, 'Свободен'),
       (2, 'Занят'),
       (3, 'Выходной'),
       (4, 'Отпуск'),
       (5, 'Уволен')
ON CONFLICT (id) DO UPDATE SET id=excluded.id,
                               name=excluded.name;

SELECT setval('user_data.freedom_types_id_seq', (SELECT MAX(id) + 1 FROM user_data.freedom_types));

INSERT INTO user_data.task_states(id, name)
VALUES (1, 'Открыта'),
       (2, 'В работе'),
       (3, 'Оценка'),
       (4, 'Закрыта')
ON CONFLICT (id) DO UPDATE SET id=excluded.id,
                               name=excluded.name;

SELECT setval('user_data.task_states_id_seq', (SELECT MAX(id) + 1 FROM user_data.task_states));

INSERT INTO user_data.claim_states(id, name)
VALUES (1, 'Приёмка'),
       (2, 'Выезд'),
       (3, 'Ремонт'),
       (4, 'Тестирование'),
       (5, 'Выдача'),
       (6, 'Закрыта')
ON CONFLICT (id) DO UPDATE SET id=excluded.id,
                               name=excluded.name;

SELECT setval('user_data.claim_states_id_seq', (SELECT MAX(id) + 1 FROM user_data.claim_states));

INSERT INTO user_data.services(id, name)
VALUES (1, 'Обслуживание'),
       (2, 'Ремонт')
ON CONFLICT (id) DO UPDATE SET id=excluded.id,
                               name=excluded.name;

SELECT setval('user_data.services_id_seq', (SELECT MAX(id) + 1 FROM user_data.services));

INSERT INTO user_data.employees(id, fio, "login", hash_pass, position_id, level_access_id)
VALUES (1, 'admin', 'admin', crypt('admin', gen_salt('bf')), 3, 1)
ON CONFLICT (id) DO UPDATE SET id=excluded.id,
                               fio=excluded.fio,
                               "login"=excluded."login",
                               hash_pass=excluded.hash_pass,
                               phone=excluded.phone,
                               email=excluded.email,
                               address_of_residence=excluded.address_of_residence,
                               position_id=excluded.position_id,
                               level_access_id=excluded.level_access_id,
                               freedom_type_id=excluded.freedom_type_id,
                               date_appointments=excluded.date_appointments,
                               date_of_dismissal=excluded.date_of_dismissal;

SELECT setval('user_data.employees_id_seq', (SELECT MAX(id) + 1 FROM user_data.employees));

COMMIT;