
REM ��� ����� ���� ��������
SPOOL &2/&1..&4
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

SELECT 'SPOOL &3/&1&4..LOG' FROM DUAL
UNION ALL
SELECT ' ' FROM DUAL
UNION ALL
SELECT 'PROMPT ============================================================' FROM DUAL
UNION ALL
SELECT 'PROMPT TABLE &1 '||TO_CHAR(SYSDATE, 'DD.MM.YYYY HH24:MI:SS') FROM DUAL
UNION ALL
SELECT 'PROMPT ============================================================' FROM DUAL
UNION ALL
SELECT ' ' FROM DUAL;

DECLARE
  valSQL VARCHAR2(2000);
  valSQL_COMMENT_COLUMN VARCHAR2(2000); 
  valFIELD VARCHAR2(500);
  valFIELD_COMMENT VARCHAR2(500);
  valCOMMENT_TABLE VARCHAR2(500);
BEGIN
--�������������
  valSQL:='';
  valFIELD:='';
  valSQL_COMMENT_COLUMN:='';
  valCOMMENT_TABLE:='';
--����������� � �������
  SELECT TRIM(utc.COMMENTS)
  INTO valCOMMENT_TABLE
  FROM user_tab_comments utc
  WHERE utc.TABLE_NAME='&1';  
  IF valCOMMENT_TABLE = '' OR valCOMMENT_TABLE IS NULL THEN
    BEGIN
      valCOMMENT_TABLE:='COMMENT ON TABLE &1 IS ''&1'';';
    END;
  ELSE
    BEGIN
      valCOMMENT_TABLE:='COMMENT ON TABLE &1 IS '''||valCOMMENT_TABLE||''';';
    END;
  END IF;
--������������ �������
  FOR REC IN (SELECT
                COL.*,
                COM.COMMENTS
              FROM
                user_tab_columns col,
                user_col_comments com
              WHERE
                col.TABLE_NAME=com.table_name
                AND col.TABLE_NAME='&1'
                AND col.COLUMN_NAME=com.column_name
              ORDER BY
                COL.COLUMN_ID)  
  LOOP
    --�������������
    valFIELD:='';
    valFIELD_COMMENT:='';
    --�������� ����
    valFIELD:=TRIM(REC.COLUMN_NAME);
    --����������� ���� ����
    IF REC.DATA_TYPE = 'VARCHAR2' THEN
      BEGIN
        valFIELD:=valFIELD||' '||TRIM(REC.DATA_TYPE)||'('||REC.CHAR_COL_DECL_LENGTH||')';
      END;
    ELSE
      BEGIN
        valFIELD:=valFIELD||' '||TRIM(REC.DATA_TYPE);
      END; 
    END IF;
    --�������� �� ���������
    IF REC.DATA_DEFAULT IS NOT NULL THEN
      BEGIN
        valFIELD:=valFIELD||' DEFAULT '||TRIM(REC.DATA_DEFAULT);
      END;
    END IF; 
    --������, �� ������
    IF REC.NULLABLE = 'N' THEN
      BEGIN
        valFIELD:=valFIELD||' NOT NULL';
      END;
    END IF; 
    --����������� �� ����
    valFIELD_COMMENT:='COMMENT ON COLUMN &1..'||TRIM(REC.COLUMN_NAME)||' IS '''||NVL(TRIM(REC.COMMENTS), TRIM(REC.COLUMN_NAME))||''';';
    --���������� ������������� ����
    IF valSQL = '' OR valSQL IS NULL THEN
      BEGIN
        valSQL:='  '||valFIELD;
      END;
    ELSE
      BEGIN
        valSQL:=valSQL||','||chr(10)||'  '||valFIELD;
      END;
    END IF;
    --��������� �����������
    IF valSQL_COMMENT_COLUMN = '' OR valSQL_COMMENT_COLUMN IS NULL THEN
      BEGIN
        valSQL_COMMENT_COLUMN:=valFIELD_COMMENT; 
      END;
    ELSE
      BEGIN
        valSQL_COMMENT_COLUMN:=valSQL_COMMENT_COLUMN||chr(10)||valFIELD_COMMENT; 
      END;
    END IF;    
  END LOOP;
  --������� ������������� ���������
  valSQL:='CREATE TABLE &1'||' ('||chr(10)||valSQL||chr(10)||');';
  --������ ��������� �� �������
  DBMS_OUTPUT.ENABLE;
  DBMS_OUTPUT.PUT_LINE(valSQL||chr(10));
  --������� ����������� � �������
  DBMS_OUTPUT.PUT_LINE('PROMPT ============================================================');
  DBMS_OUTPUT.PUT_LINE('PROMPT COMMENT TABLE &1');
  DBMS_OUTPUT.PUT_LINE('PROMPT ============================================================'||chr(10));
  DBMS_OUTPUT.PUT_LINE(valCOMMENT_TABLE||chr(10));
  --������ ����������� �� �������
  DBMS_OUTPUT.PUT_LINE('PROMPT ============================================================');
  DBMS_OUTPUT.PUT_LINE('PROMPT COMMENT COLUMN TABLE &1');
  DBMS_OUTPUT.PUT_LINE('PROMPT ============================================================'||chr(10));
  DBMS_OUTPUT.PUT_LINE(valSQL_COMMENT_COLUMN);


END;
/


SELECT ' ' FROM DUAL
UNION ALL
SELECT 'SPOOL OFF' FROM DUAL;

SPOOL OFF;