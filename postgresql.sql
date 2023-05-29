ALTER USER "postgres" WITH PASSWORD 'postgres';

CREATE ROLE "postgresdba" SUPERUSER LOGIN PASSWORD 'postgresdba';

ALTER USER "postgresdba" WITH PASSWORD 'postgresdba';

REVOKE ALL ON DATABASE postgres FROM PUBLIC;

REVOKE CONNECT ON DATABASE postgres FROM PUBLIC;

-------------------------------------------------------------

CREATE ROLE "{{name}}" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';

CREATE ROLE "vault-superuser" SUPERUSER NOINHERIT LOGIN PASSWORD 'password';

ALTER USER "vault-superuser" WITH PASSWORD 'password';

CREATE ROLE "{{name}}" SUPERUSER NOINHERIT LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'

DROP ROLE "{{name}}";

CREATE DATABASE testdb;

DROP DATABASE testdb;

create schema "testschema";

SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'testdb';
