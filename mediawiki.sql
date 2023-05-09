--  Create root user with password 'root_password'
CREATE USER 'root'@'%' IDENTIFIED BY 'root_password';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;

--  Create database 'mywiki' with default character set  utf8mb4
CREATE DATABASE mywiki CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

--  Create a non-root user for the 'mywiki' database with password 'user_password'
CREATE USER 'mywiki_user'@'%'  IDENTIFIED BY 'user_password';

-- Grant privileges to the non-root user on the 'mywiki' database
GRANT ALL PRIVILEGES ON mywiki.* TO 'mywiki_user'@'%';

-- Set the table prefix for the 'mywiki' database
USE mywiki;
SET GLOBAL table_definition_cache = 16384;
SET GLOBAL table_open_cache = 65536;
SET SESSION table_definition_cache = 16384;
SET SESSION table_open_cache = 65536;
SET SESSION sql_mode = 'NO_ENGINE_SUBSTITUTION;

-- Flush privileges to apply changes
FLUSH PRIVILEGES;


