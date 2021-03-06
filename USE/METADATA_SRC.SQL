
REM ��� ����� ���� ��������
SPOOL &3/&1..&5
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
SET LINESIZE 200

SELECT 'SPOOL &4/&1&5..LOG' FROM DUAL
UNION ALL
SELECT ' ' FROM DUAL
UNION ALL
SELECT 'PROMPT ============================================================' FROM DUAL
UNION ALL
SELECT 'PROMPT &2 &1 '||TO_CHAR(SYSDATE, 'DD.MM.YYYY HH24:MI:SS') FROM DUAL
UNION ALL
SELECT 'PROMPT ============================================================' FROM DUAL
UNION ALL
SELECT ' ' FROM DUAL;

SELECT TEXT FROM
(
  SELECT
    DECODE(US.LINE, 1,'CREATE OR REPLACE '||US.TEXT,
           US.TEXT) AS TEXT 
  FROM USER_SOURCE US
  WHERE US.NAME='&1' AND US.TYPE='&2'
  ORDER BY US.LINE
)
UNION ALL
SELECT '/' FROM DUAL;

SELECT ' ' FROM DUAL
UNION ALL
SELECT 'SPOOL OFF' FROM DUAL;

SPOOL OFF;