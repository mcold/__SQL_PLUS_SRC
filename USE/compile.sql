
SPOOL .\LOG\SQLSystem\COMPILE.LOG

PROMPT ============================================================
PROMPT COMPILLING ALL PACKAGE
PROMPT ============================================================

BEGIN
  -- COMPILE SPECIFICATION
  FOR REC1 IN (SELECT * 
                 FROM USER_OBJECTS 
                WHERE OBJECT_TYPE = 'PACKAGE' 
                  AND STATUS <> 'VALID')
  LOOP
    BEGIN
      EXECUTE IMMEDIATE 'ALTER PACKAGE '||REC1.OBJECT_NAME||' COMPILE SPECIFICATION';
    EXCEPTION
	    WHEN OTHERS THEN NULL;
    END;
  END LOOP;

  FOR REC2 IN (SELECT * 
                 FROM USER_OBJECTS 
                WHERE OBJECT_TYPE = 'PACKAGE BODY' 
                  AND STATUS <> 'VALID')
  LOOP
    BEGIN
      EXECUTE IMMEDIATE 'ALTER PACKAGE '||REC2.OBJECT_NAME||' COMPILE BODY';
	  EXCEPTION
	    WHEN OTHERS THEN NULL;
    END;
  END LOOP;

  FOR REC2 IN (SELECT * 
                 FROM USER_OBJECTS 
                WHERE OBJECT_TYPE IN ('FUNCTION','PROCEDURE')
                  AND STATUS <> 'VALID')
  LOOP
    BEGIN
      EXECUTE IMMEDIATE 'ALTER '||rec2.object_type||' '||REC2.OBJECT_NAME||' COMPILE';
	  EXCEPTION
	    WHEN OTHERS THEN NULL;
    END;
  END LOOP;

  FOR REC1 IN (SELECT * 
                 FROM USER_OBJECTS 
                WHERE OBJECT_TYPE = 'TRIGGER' 
                  AND STATUS <> 'VALID')
  LOOP
    BEGIN
      EXECUTE IMMEDIATE 'ALTER TRIGGER '||REC1.OBJECT_NAME||' COMPILE';
    EXCEPTION
	    WHEN OTHERS THEN NULL;
    END;
  END LOOP;  


  FOR REC1 IN (SELECT * 
                 FROM USER_OBJECTS 
                WHERE OBJECT_TYPE = 'VIEW' 
                  AND STATUS <> 'VALID')
  LOOP
    BEGIN
      EXECUTE IMMEDIATE 'ALTER VIEW '||REC1.OBJECT_NAME||' COMPILE';
    EXCEPTION
	    WHEN OTHERS THEN NULL;
    END;
  END LOOP;  

END;
/

SPOOL OFF
