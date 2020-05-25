SET SERVEROUTPUT OFF;
column ABLE new_value ABLE noprint
select decode(&1, 1, 'ENABLE', 0, 'DISABLE') AS ABLE from dual;

begin
  for l_const_row in (select *
                      from user_constraints uc
                     order by uc.CONSTRAINT_NAME desc)
  loop
    begin
      execute immediate 'ALTER TABLE ' || l_const_row.table_name || ' MODIFY CONSTRAINT ' || l_const_row.constraint_name || ' ' || '&&ABLE' ;
      exception when others then null;
    end;
  end loop;
  for l_const_row in (select *
                      from user_constraints uc
                     order by uc.CONSTRAINT_NAME asc)
  loop
    begin
      execute immediate 'ALTER TABLE ' || l_const_row.table_name || ' MODIFY CONSTRAINT ' || l_const_row.constraint_name || ' ' || '&&ABLE' ;
      exception when others then null;
    end;
  end loop;
end;
/

SET SERVEROUTPUT ON;