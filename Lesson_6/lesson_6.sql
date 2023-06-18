USE lesson_4;

/* Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру, с
помощью которой можно переместить любого (одного) пользователя из таблицы
users в таблицу users_old. (использование транзакции с выбором commit или rollback
– обязательно). */
START TRANSACTION;
	DROP TABLE IF EXISTS users_old;
	CREATE TABLE users_old SELECT * FROM users;
	DROP PROCEDURE IF EXISTS users_replace;
    DELIMITER //
	CREATE PROCEDURE users_replace(IN user_id INT)
	BEGIN
		INSERT INTO users_old(id, firstname, lastname, email)
        SELECT * FROM users WHERE id = user_id;
        DELETE FROM users WHERE id = user_id;
	END //
    DELIMITER ;
    CALL users_replace(3); -- 3 пункт уже удален
COMMIT;

/* Создайте хранимую функцию hello(), которая будет возвращать приветствие, в
зависимости от текущего времени суток. С 6:00 до 12:00 функция должна
возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать
фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй
ночи". */
DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()
RETURNS VARCHAR(15) DETERMINISTIC
BEGIN
	DECLARE answer VARCHAR(15);
    SELECT CASE
		WHEN CURRENT_TIME() BETWEEN '06:00:00' AND '11:59:59' THEN 'Доброе утро'
        WHEN CURRENT_TIME() BETWEEN '12:00:00' AND '17:59:59' THEN 'Добрый день'
        WHEN CURRENT_TIME() BETWEEN '18:00:00' AND '23:59:59' THEN 'Добрый вечер'
        WHEN CURRENT_TIME() BETWEEN '00:00:00' AND '05:59:59' THEN 'Доброй ночи'
        ELSE ''
	END INTO answer;
RETURN answer;
END //
DELIMITER ;
SELECT hello();

/* Создайте таблицу logs типа Archive. Пусть при каждом создании
записи в таблицах users, communities и messages в таблицу logs помещается время и
дата создания записи, название таблицы, идентификатор первичного ключа */
DROP TABLE IF EXISTS logs_t;
CREATE TABLE logs_t (
    created_at DATETIME DEFAULT NOW(),
    name_table VARCHAR(20) NOT NULL,
    pk_id INT NOT NULL
)  ENGINE = ARCHIVE;
DELIMITER //
CREATE TRIGGER  users_log
	AFTER INSERT ON users FOR EACH ROW
    BEGIN
		INSERT INTO logs_t (name_table, pk_id) VALUES
			('users', NEW.id);
	END;
CREATE TRIGGER  communities_log
	AFTER INSERT ON communities FOR EACH ROW
    BEGIN
		INSERT INTO logs_t (name_table, pk_id) VALUES
			('communities', NEW.id);
	END;
CREATE TRIGGER  messages_log
	AFTER INSERT ON messages FOR EACH ROW
    BEGIN
		INSERT INTO logs_t (name_table, pk_id) VALUES
			('communities', NEW.id);
	END; //
DELIMITER ;
INSERT INTO users (firstname, lastname, email) VALUES 
('ttt', 'mmm', 'tttmmm@mail.ru');