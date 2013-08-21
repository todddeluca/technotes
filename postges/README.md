

## Passwordless login

Create a `~/.pgpass` file with restrictive permissions (so psql does not
complain):

    touch ~/.pgpass
    chmod 600 ~/.pgpass

Add lines to the file specifying the password for a particular user/host/db
combination.  The format of the file lines is:

    hostname:port:database:username:password

For more information see:

- http://www.postgresql.org/docs/9.1/static/libpq-pgpass.html
- http://scratching.psybermonkey.net/2009/02/postgres-sql-passwordless-login-within.html


## Translating between MySQL and Postgres

How to `SHOW TABLES`, etc.:

- http://www.linuxscrew.com/2009/07/03/postgresql-show-tables-show-databases-show-columns/

Here are the commands:

    mysql: SHOW TABLES
    postgresql: \d
    postgresql: SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';

    mysql: SHOW DATABASES
    postgresql: \l
    postgresql: SELECT datname FROM pg_database;

    mysql: SHOW COLUMNS
    postgresql: \d table
    postgresql: SELECT column_name FROM information_schema.columns WHERE table_name ='table';

    mysql: DESCRIBE TABLE
    postgresql: \d+ table
    postgresql: SELECT column_name FROM information_schema.columns WHERE table_name ='table';
