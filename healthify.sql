CREATE DATABASE IF NOT EXISTS healthify CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

CREATE USER IF NOT EXISTS 'healthify'@'%' IDENTIFIED BY 'healthify';
ALTER USER 'healthify'@'%' IDENTIFIED BY 'healthify';
GRANT Create user ON *.* TO 'healthify'@'%';
GRANT Create role ON *.* TO 'healthify'@'%';
GRANT Drop role ON *.* TO 'healthify'@'%';
GRANT Reload ON *.* TO 'healthify'@'%';
GRANT ALL PRIVILEGES ON healthify.* TO 'healthify'@'%';
GRANT Grant option ON healthify.* TO 'healthify'@'%';
flush privileges;

CREATE USER 'demouser'@'%' IDENTIFIED BY 'demouser';
GRANT ALL PRIVILEGES ON healthify.* TO 'demouser'@'%';
GRANT Grant option ON healthify.* TO 'demouser'@'%';
flush privileges;

REVOKE ALL PRIVILEGES ON healthify.* FROM 'demouser'@'%';
REVOKE Grant option ON healthify.* FROM 'demouser'@'%';
flush privileges;
DROP USER 'demouser'@'%' ;
