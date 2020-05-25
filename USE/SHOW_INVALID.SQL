break on c1 skip 2

set pages 999

PROMPT ============================================================
PROMPT SHOW INVALID OBJECTS
PROMPT ============================================================


col c1 heading 'owner' format a15
col c2 heading 'name' format a40
col c3 heading 'type' format a10

ttitle 'Invalid|Objects'

select
   object_type c3,
   object_name c2
from
   user_objects
where
   status != 'VALID'
order by
   object_type;