undef user;
undef pass;
create user &&1 identified by &&2;
grant create session to &&1;
grant create table to &&1;
grant create procedure to &&1;
grant create package to &&1;
grant create trigger to &&1;
grant create sequence to &&1;
grant create type to &&1;


grant debug connect session to &&1;
alter user &&1 quota unlimited on USERS;

grant SELECT_CATALOG_ROLE to &&1;
