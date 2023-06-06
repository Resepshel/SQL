DROP DATABASE IF EXISTS lesson_3;
CREATE DATABASE lesson_3;
USE lesson_3;

DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	firstname VARCHAR(45),
	lastname VARCHAR(45),
	post VARCHAR(100),
	seniority INT, 
	salary INT, 
	age INT
);

-- Наполнение данными
INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
('Вася', 'Петров', 'Начальник', '40', 100000, 60),
('Петр', 'Власов', 'Начальник', '8', 70000, 30),
('Катя', 'Катина', 'Инженер', '2', 70000, 25),
('Саша', 'Сасин', 'Инженер', '12', 50000, 35),
('Иван', 'Иванов', 'Рабочий', '40', 30000, 59),
('Петр', 'Петров', 'Рабочий', '20', 25000, 40),
('Сидр', 'Сидоров', 'Рабочий', '10', 20000, 35),
('Антон', 'Антонов', 'Рабочий', '8', 19000, 28),
('Юрий', 'Юрков', 'Рабочий', '5', 15000, 25),
('Максим', 'Максимов', 'Рабочий', '2', 11000, 22),
('Юрий', 'Галкин', 'Рабочий', '3', 12000, 24),
('Людмила', 'Маркина', 'Уборщик', '10', 10000, 49);


-- Отсортируйте данные по полю заработная плата (salary) в порядке: убывания; возрастания.
SELECT *
FROM staff
ORDER BY salary DESC;

SELECT *
FROM staff
ORDER BY salary;

-- Выведите 5 максимальных заработных плат (saraly).
SELECT *
FROM staff
ORDER BY salary DESC
LIMIT 5;

-- Посчитайте суммарную зарплату (salary) по каждой специальности (роst).
SELECT post, SUM(salary)
FROM staff
GROUP BY post;

-- Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
SELECT post, COUNT(*) AS Amount
FROM staff
WHERE age>=24 AND age<=49
GROUP BY post
HAVING post='Рабочий';

-- Найдите количество специальностей.
SELECT post, COUNT(*) AS Amount
FROM staff
GROUP BY post;

-- Выведите специальности, у которых средний возраст сотрудников меньше 30 лет.
SELECT post, ROUND(AVG(age)) AS AverAge
FROM staff
GROUP BY post
HAVING AverAge<=30;
