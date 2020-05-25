SET TERMOUT OFF

COLUMN database_name NEW_VALUE database_name



SELECT SYS_CONTEXT('USERENV','DB_NAME') database_name

FROM dual;


SET SQLPROMPT "&_user@&_connect_identifier(&database_name) >"

SET TERMOUT ON
