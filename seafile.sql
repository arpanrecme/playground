CREATE DATABASE IF NOT EXISTS harpocrates CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

CREATE USER IF NOT EXISTS 'seafile'@'%' IDENTIFIED BY 'seafile';
ALTER USER 'seafile'@'%' IDENTIFIED BY 'seafile';
GRANT Create user ON *.* TO 'seafile'@'%';
GRANT Create role ON *.* TO 'seafile'@'%';
GRANT Drop role ON *.* TO 'seafile'@'%';
GRANT Reload ON *.* TO 'seafile'@'%';
GRANT ALL PRIVILEGES ON harpocrates.* TO 'seafile'@'%';
GRANT Grant option ON harpocrates.* TO 'seafile'@'%';
flush privileges;
