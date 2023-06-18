USE lesson_4;
-- Создайте представление, в которое попадет информация о пользователях (имя, фамилия, город и пол), которые не старше 20 лет.
CREATE OR REPLACE VIEW info_users AS
SELECT
CONCAT(u.firstname, ' ', u.lastname) AS 'User name',
p.hometown,
p.gender
FROM users u
JOIN profiles p ON u.id = p.user_id
WHERE (YEAR(NOW())-YEAR(birthday)) <= 20;

SELECT * FROM info_users;

/* Найдите кол-во, отправленных сообщений каждым пользователем и выведите
ранжированный список пользователей, указав имя и фамилию пользователя, количество
отправленных сообщений и место в рейтинге (первое место у пользователя с максимальным
количеством сообщений) . (используйте DENSE_RANK) */
SELECT
CONCAT(u.firstname, ' ', u.lastname) AS 'User name',
COUNT(m.from_user_id) AS 'Кол-во отправленных сообщений',
DENSE_RANK() OVER(ORDER BY COUNT(m.from_user_id) DESC) AS 'Ранг'
FROM users u
JOIN messages m ON u.id = m.from_user_id
GROUP BY u.id;

/* Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления
(created_at) и найдите разницу дат отправления между соседними сообщениями,
получившегося списка. (используйте LEAD или LAG) */
SELECT
m.body,
m.created_at,
TIME(m.created_at - LAG(m.created_at) OVER(ORDER BY m.created_at)) AS 'Разница между предыдущим сообщением'
FROM messages m
ORDER BY m.created_at;

