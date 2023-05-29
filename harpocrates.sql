CREATE DATABASE IF NOT EXISTS harpocrates CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

CREATE USER IF NOT EXISTS 'harpocrates'@'%' IDENTIFIED BY 'harpocrates';
ALTER USER 'harpocrates'@'%' IDENTIFIED BY 'harpocrates';
GRANT Create user ON *.* TO 'harpocrates'@'%';
GRANT Create role ON *.* TO 'harpocrates'@'%';
GRANT Drop role ON *.* TO 'harpocrates'@'%';
GRANT Reload ON *.* TO 'harpocrates'@'%';
GRANT ALL PRIVILEGES ON harpocrates.* TO 'harpocrates'@'%';
GRANT Grant option ON harpocrates.* TO 'harpocrates'@'%';
flush privileges;

CREATE USER 'demouser'@'%' IDENTIFIED BY 'demouser';
GRANT ALL PRIVILEGES ON harpocrates.* TO 'demouser'@'%';
GRANT Grant option ON harpocrates.* TO 'demouser'@'%';
flush privileges;

REVOKE ALL PRIVILEGES ON harpocrates.* FROM 'demouser'@'%';
REVOKE Grant option ON harpocrates.* FROM 'demouser'@'%';
flush privileges;
DROP USER 'demouser'@'%' ;
