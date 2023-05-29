CREATE ROLE "harpocrates" SUPERUSER LOGIN PASSWORD 'harpocrates';

ALTER USER "harpocrates" WITH PASSWORD 'harpocrates';

CREATE DATABASE "harpocrates" OWNER "harpocrates";

ALTER DATABASE "harpocrates" OWNER TO "harpocrates";

REVOKE ALL ON DATABASE "harpocrates" FROM PUBLIC;

grant all privileges ON DATABASE "harpocrates" TO "harpocrates";

-------------------------------------------------------------------------------------------------------------

CREATE ROLE "v-github-a-postgres-X1nqilNeejAgBUEWcgtG-1622608554" LOGIN PASSWORD 'harpocrates';

grant ALL PRIVILEGES ON DATABASE "harpocrates" TO "v-github-a-postgres-X1nqilNeejAgBUEWcgtG-1622608554";

SELECT * FROM pg_stat_activity WHERE datname = 'postgres';

SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE usename = 'v-github-a-postgres-AZu3cntVdGhN9pArlpWb-1622580196';

REASSIGN OWNED BY "v-github-a-postgres-X1nqilNeejAgBUEWcgtG-1622608554" TO "harpocrates";  -- or some other trusted role

DROP OWNED BY "v-github-a-postgres-X1nqilNeejAgBUEWcgtG-1622608554";

REVOKE ALL ON DATABASE "harpocrates" FROM "v-github-a-postgres-X1nqilNeejAgBUEWcgtG-1622608554";

drop USER  "v-github-a-postgres-X1nqilNeejAgBUEWcgtG-1622608554";