whenever sqlerror exit failure rollback
whenever oserror exit failure rollback

------------------------------------------------------------------
--Проверка наличия версии
------------------------------------------------------------------
DECLARE
  l_cnt     number;
  e_version exception;
BEGIN
  SELECT count(*)
    INTO l_cnt
    FROM T_ABOUT TA
   WHERE TA.VERSION = '&PATH_VERSION';
  IF l_cnt > 0 THEN
    raise e_version;
  
  END IF;
  
  EXCEPTION
    WHEN e_version THEN
      RAISE_APPLICATION_ERROR(-20200, 'ERROR: VERSION INSTALLED YET');
END;
/
