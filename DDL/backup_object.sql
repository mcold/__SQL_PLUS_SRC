SPOOL .\SQLSystem\SQL_BACKUP.SQL

REM �� �������� �� ����� ������, ������� ������������ � ���� (OFF - �� ��������; ON - ��������)
SET TERMOUT OFF 
REM ��������� ������� �� ����� ������ ������� � ��������� �����, ����������� � ������� 
SET ECHO OFF
REM ��������� �������� � ��������� ������ ������ ������ ������� �� � ����� ����������� ���������������� ����������
SET VERIFY OFF
REM ������� �������� �������
SET TRIMSPOOL ON
REM ��������� ��������� ������� ������� ����� �����������. �� ���������, ������� ����� ����������� �� ��������� ������. ��� ������� �������� OFF - ���������.
SET WRAP ON
SET PAGESIZE 0
SET FEEDBACK OFF
SET PAUSE OFF
SET LINESIZE 500
SET SERVEROUTPUT ON SIZE 1000000

--������������ ������������ ��������

DECLARE
BEGIN
  IF '&BCP_PKG' = '1' 
     OR '&BCP_FUN' = '1' 
     OR '&BCP_PRC' = '1' 
     OR '&BCP_TRG' = '1' 
     OR '&BCP_TBL' = '1'
  THEN
    BEGIN
      DBMS_OUTPUT.PUT_LINE('PROMPT ============================================================');
      DBMS_OUTPUT.PUT_LINE('PROMPT CREATE DIRECTORY');
      DBMS_OUTPUT.PUT_LINE('PROMPT ============================================================'||chr(10));
      DBMS_OUTPUT.PUT_LINE('HOST RMDIR /s /q BACKUP;'); 
      DBMS_OUTPUT.PUT_LINE('HOST MKDIR BACKUP;'||chr(10)); 
    END;
  END IF; 
    
END;
/

--�������� ���������� �� �������

DECLARE
BEGIN
  IF '&BCP_PKG' = '1' THEN
    BEGIN
      DBMS_OUTPUT.PUT_LINE('PROMPT ============================================================');
      DBMS_OUTPUT.PUT_LINE('PROMPT PACKAGE');
      DBMS_OUTPUT.PUT_LINE('PROMPT ============================================================'||chr(10));
      DBMS_OUTPUT.PUT_LINE('HOST MKDIR BACKUP\PACKAGE;'||chr(10)); 
      FOR REC IN (SELECT
                    OBJECT_NAME,
                    OBJECT_TYPE,    
                    '@SQLSystem/METADATA_SRC.SQL '''||UO.OBJECT_NAME||''''||' '''||UO.OBJECT_TYPE||''''||' ''./BACKUP/'||UO.OBJECT_TYPE||'/'||UO.OBJECT_NAME||''' ''./LOG/INSTALL'' ''SPC'';' AS PATH_SQL_SPC,
                    '@SQLSystem/METADATA_SRC.SQL '''||UO.OBJECT_NAME||''''||' '''||'PACKAGE BODY'||''''||' ''./BACKUP/'||UO.OBJECT_TYPE||'/'||UO.OBJECT_NAME||''' ''./LOG/INSTALL'' ''BDY'';' AS PATH_SQL_BDY
                  FROM
                    USER_OBJECTS UO
                  WHERE
                    UO.OBJECT_TYPE='PACKAGE')
        LOOP
          DBMS_OUTPUT.ENABLE;
          DBMS_OUTPUT.PUT_LINE('HOST MKDIR BACKUP\PACKAGE\'||REC.OBJECT_NAME||';'||chr(10)); 
    	  DBMS_OUTPUT.PUT_LINE(REC.PATH_SQL_SPC||chr(10));
    	  DBMS_OUTPUT.PUT_LINE(REC.PATH_SQL_BDY||chr(10));

        END LOOP;
    END;
  END IF; 
END;
/

--�������� ���������� �� ��������

DECLARE
BEGIN
  IF '&BCP_FUN' = '1' THEN
    BEGIN
      DBMS_OUTPUT.PUT_LINE('PROMPT ============================================================');
      DBMS_OUTPUT.PUT_LINE('PROMPT FUNCTION');
      DBMS_OUTPUT.PUT_LINE('PROMPT ============================================================'||chr(10));
      DBMS_OUTPUT.PUT_LINE('HOST MKDIR BACKUP\FUNCTION;'||chr(10)); 
      FOR REC IN (SELECT
                    OBJECT_NAME,
                    OBJECT_TYPE,    
                    '@SQLSystem/METADATA_SRC.SQL '''||UO.OBJECT_NAME||''''||' '''||UO.OBJECT_TYPE||''''||' ''./BACKUP/'||UO.OBJECT_TYPE||''' ''./LOG/INSTALL'' ''FNC'';' AS PATH_SQL_FUN
                  FROM
                    USER_OBJECTS UO
                  WHERE
                    UO.OBJECT_TYPE='FUNCTION')
        LOOP
          DBMS_OUTPUT.ENABLE;
    	  DBMS_OUTPUT.PUT_LINE(REC.PATH_SQL_FUN||chr(10));

        END LOOP;
    END;
  END IF; 
END;
/

--�������� ���������� �� ����������

DECLARE
BEGIN
  IF '&BCP_PRC' = '1' THEN
    BEGIN
      DBMS_OUTPUT.PUT_LINE('PROMPT ============================================================');
      DBMS_OUTPUT.PUT_LINE('PROMPT PROCEDURE');
      DBMS_OUTPUT.PUT_LINE('PROMPT ============================================================'||chr(10));
      DBMS_OUTPUT.PUT_LINE('HOST MKDIR BACKUP\PROCEDURE;'||chr(10)); 
      FOR REC IN (SELECT
                    OBJECT_NAME,
                    OBJECT_TYPE,    
                    '@SQLSystem/METADATA_SRC.SQL '''||UO.OBJECT_NAME||''''||' '''||UO.OBJECT_TYPE||''''||' ''./BACKUP/'||UO.OBJECT_TYPE||''' ''./LOG/INSTALL'' ''PRC'';' AS PATH_SQL
                  FROM
                    USER_OBJECTS UO
                  WHERE
                    UO.OBJECT_TYPE='PROCEDURE')
        LOOP
          DBMS_OUTPUT.ENABLE;
    	  DBMS_OUTPUT.PUT_LINE(REC.PATH_SQL||chr(10));

        END LOOP;
    END;
  END IF; 
END;
/

--�������� ���������� �� ���������

DECLARE
BEGIN
  IF '&BCP_TRG' = '1' THEN
    BEGIN
      DBMS_OUTPUT.PUT_LINE('PROMPT ============================================================');
      DBMS_OUTPUT.PUT_LINE('PROMPT TRIGGER');
      DBMS_OUTPUT.PUT_LINE('PROMPT ============================================================'||chr(10));
      DBMS_OUTPUT.PUT_LINE('HOST MKDIR BACKUP\TRIGGER;'||chr(10)); 
      FOR REC IN (SELECT
                    OBJECT_NAME,
                    OBJECT_TYPE,    
                    '@SQLSystem/METADATA_SRC.SQL '''||UO.OBJECT_NAME||''''||' '''||UO.OBJECT_TYPE||''''||' ''./BACKUP/'||UO.OBJECT_TYPE||''' ''./LOG/INSTALL'' ''TRG'';' AS PATH_SQL
                  FROM
                    USER_OBJECTS UO
                  WHERE
                    UO.OBJECT_TYPE='TRIGGER')
        LOOP
          DBMS_OUTPUT.ENABLE;
    	  DBMS_OUTPUT.PUT_LINE(REC.PATH_SQL||chr(10));

        END LOOP;
    END;
  END IF; 
END;
/

--�������� ���������� �� ��������

DECLARE
BEGIN
  IF '&BCP_TBL' = '1' THEN
    BEGIN
      DBMS_OUTPUT.PUT_LINE('PROMPT ============================================================');
      DBMS_OUTPUT.PUT_LINE('PROMPT TABLE');
      DBMS_OUTPUT.PUT_LINE('PROMPT ============================================================'||chr(10));
      DBMS_OUTPUT.PUT_LINE('HOST MKDIR BACKUP\TABLE;'||chr(10)); 
      FOR REC IN (SELECT
                    OBJECT_NAME,
                    OBJECT_TYPE,    
                    '@SQLSystem/TABLE_SRC.SQL '''||UO.OBJECT_NAME||''''||' ''./BACKUP/'||UO.OBJECT_TYPE||''' ''./LOG/INSTALL'' ''TBL'';' AS PATH_SQL
                  FROM
                    USER_OBJECTS UO
                  WHERE
                    UO.OBJECT_TYPE='TABLE')
        LOOP
          DBMS_OUTPUT.ENABLE;
    	  DBMS_OUTPUT.PUT_LINE(REC.PATH_SQL||chr(10));

        END LOOP;
    END;
  END IF; 
END;
/



SPOOL OFF