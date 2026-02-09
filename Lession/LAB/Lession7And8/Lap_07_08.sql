--alter session set container=PDB1;

--create table HR1.dba_objects as select * from dba_objects;

--alter session set current_schema=HR1;

CREATE TABLE my_temp_table (
  id           NUMBER,
  description  VARCHAR2(20)
);

INSERT INTO my_temp_table
WITH data AS (
  SELECT 1 AS id
  FROM   dual
  CONNECT BY level < 10000
)
SELECT rownum, TO_CHAR(rownum)
FROM   data a, data b
WHERE  rownum <= 1000000;


select * from my_temp_table



SELECT  a.tablespace_name,100 - ROUND ( (NVL (b.bytes_free, 0) / a.bytes_alloc) * 100) "%Usage",   ROUND 
(a.bytes_alloc / 1024 / 1024) "Size MB",   ROUND (NVL (b.bytes_free, 0) / 1024 / 1024) "Free MB",
      (ROUND (a.bytes_alloc / 1024 / 1024)- ROUND (NVL (b.bytes_free, 0) / 1024 / 1024)) "Used MB", ROUND ( (NVL (b.bytes_free, 0) / a.bytes_alloc) * 100) "%Free", ROUND (maxbytes / 1048576)  "Max MB", 
       ROUND (ROUND ( (a.bytes_alloc - NVL (b.bytes_free, 0)) / 1024 / 1024)/  ROUND (maxbytes / 1048576) * 100) "%Used of Max"
  FROM (  SELECT f.tablespace_name, SUM (f.bytes) bytes_alloc,  SUM (DECODE (f.autoextensible, 'YES', f.maxbytes, 'NO', f.bytes)) maxbytes
            FROM dba_data_files f
        GROUP BY tablespace_name) a,
       (  SELECT f.tablespace_name, SUM (f.bytes) bytes_free  FROM dba_free_space f  GROUP BY tablespace_name) b
 WHERE a.tablespace_name = b.tablespace_name(+) --and a.tablespace_name in ('DATA201505','DATA201506','IMPORT_TBS','INDX201505','INDX201506')
 order by "%Used of Max" desc;


select * from DBA_DATA_FILES;

---Dung luong table
SELECT segment_name, ROUND(bytes/1024/1024, 2) MB , owner
FROM dba_segments
WHERE segment_type = 'TABLE' AND owner = 'HR1' 

--1. 19 MB
--Delete 500.000 row
select * from MY_TEMP_TABLE
order by ID desc

delete top (500)


select top (10)
from MY_TEMP_TABLE
order by ID desc

select * FROM MY_TEMP_TABLE
WHERE ROWNUM <= 500;

--delete from MY_TEMP_TABLE
WHERE ROWNUM <= 500000;

--dung luong van 19MB

--ALTER TABLE MY_TEMP_TABLE ENABLE ROW MOVEMENT;

ALTER TABLE MY_TEMP_TABLE SHRINK SPACE COMPACT

--dung luong van 19MB

USERS	95	34	2	32	5	32768	0

--Insert 1.000.000

USERS	94	44	3	41	6	32768	0

--dung luong table : 28MB

--Truncate table

truncate table MY_TEMP_TABLE;

USERS	30	44	31	13	70	32768	0
--dung luong table : 0.06 MB






