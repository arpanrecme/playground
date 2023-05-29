ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
flush privileges;

DROP USER 'root'@'%' ;

rename user 'root'@'localhost' to 'mysqlrootuser'@'localhost';

CREATE USER 'mysqladmin'@'%' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON *.* TO 'mysqladmin'@'%';
GRANT Grant option ON *.* TO 'mysqladmin'@'%';
flush privileges;


CREATE USER 'mysqldbavault'@'%' IDENTIFIED BY 'mysqldbavault';
ALTER USER 'mysqldbavault'@'%' IDENTIFIED BY 'mysqldbavault';
GRANT ALL PRIVILEGES ON *.* TO 'mysqldbavault'@'%';
GRANT Grant option ON *.* TO 'mysqldbavault'@'%';
flush privileges;
DROP USER 'mysqldbavault'@'%';
