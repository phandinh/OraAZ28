 --. MONITOR
- Các view sử dụng:
	• V$UNDOSTAT
	• V$ROLLSTAT
	• V$TRANSACTION
	• DBA_UNDO_EXTENTS

-- Hiển thị các transaction cần rollback và thời gian tương ứng
select usn, state, undoblockstotal "Total", undoblocksdone "Done", undoblockstotal-undoblocksdone "ToDo",decode(cputime,0,'unknown',sysdate+(((undoblockstotal-undoblocksdone) / (undoblocksdone / cputime)) / 86400)) "Estimated time to complete"from v$fast_start_transactions;

--Hiển thị dung lượng trống của tablespace UNDOTBS1 UNDOTBS2
SELECT  a.tablespace_name,100 - ROUND ( (NVL (b.bytes_free, 0) / a.bytes_alloc) * 100) "%Usage",
    ROUND (a.bytes_alloc / 1024 / 1024) "Size MB",
    ROUND (a.bytes_alloc / 1024 / 1024)- ROUND (NVL (b.bytes_free, 0) / 1024 / 1024) "Used MB",
    ROUND (NVL (b.bytes_free, 0) / 1024 / 1024) "Free MB",
    --ROUND ( (NVL (b.bytes_free, 0) / a.bytes_alloc) * 100) "%Free",
    ROUND (maxbytes / 1048576)  "Max MB",
    round(maxbytes/1048576-(ROUND (a.bytes_alloc / 1024 / 1024)- ROUND (NVL (b.bytes_free, 0) / 1024 / 1024)),0) "Free_MB_Max",
    ROUND (ROUND ( (a.bytes_alloc - NVL (b.bytes_free, 0)) / 1024 / 1024)/  ROUND (maxbytes / 1048576) * 100) "%Used of Max"
    FROM (SELECT f.tablespace_name, SUM (f.bytes) bytes_alloc,  SUM (DECODE (f.autoextensible, 'YES', f.maxbytes, 'NO', f.bytes)) maxbytes
            FROM dba_data_files f
            GROUP BY tablespace_name) a,
        (SELECT f.tablespace_name, SUM (f.bytes) bytes_free  FROM dba_free_space f  GROUP BY tablespace_name) b
 WHERE a.tablespace_name = b.tablespace_name(+)  and  (a.tablespace_name in ('UNDOTBS1','UNDOTBS1'))
 order by "%Used of Max" desc;

--Kiểm tra session nào đang sử dụng:
SELECT s.username,
       s.sid,
       s.serial#,
       t.used_ublk,
       t.used_urec,
       rs.segment_name,
       r.rssize,
       r.status
FROM   v$transaction t,
       v$session s,
       v$rollstat r,
       dba_rollback_segs rs
WHERE  s.saddr = t.ses_addr
AND    t.xidusn = r.usn
AND    rs.segment_id = t.xidusn
ORDER BY t.used_ublk DESC;

select * from dba_data_Files where tablespace_name in ('UNDOTBS1','UNDOTBS21');
	
--1/Create undo tablespace

CREATE SMALLFILE UNDO TABLESPACE "TUNDOTBS1" DATAFILE 
'/u03/oracle/oradata/DBAViet/tundo1_01.dbf' SIZE 10G REUSE , 
'/u03/oracle/oradata/DBAViet/tundo1_02.dbf' SIZE 10G REUSE , 
'/u03/oracle/oradata/DBAViet/tundo1_03.dbf' SIZE 10G REUSE , 
'/u03/oracle/oradata/DBAViet/tundo1_04.dbf' SIZE 10G REUSE , 
'/u03/oracle/oradata/DBAViet/tundo1_05.dbf' SIZE 10G REUSE , 
'/u03/oracle/oradata/DBAViet/tundo1_06.dbf' SIZE 10G REUSE , 
'/u03/oracle/oradata/DBAViet/tundo1_07.dbf' SIZE 10G REUSE , 
'/u03/oracle/oradata/DBAViet/tundo1_08.dbf' SIZE 10G REUSE  


CREATE SMALLFILE UNDO TABLESPACE "TUNDOTBS2" DATAFILE 
'/u03/oracle/oradata/DBAViet/tundo2_01.dbf' SIZE 10G REUSE , 
'/u03/oracle/oradata/DBAViet/tundo2_02.dbf' SIZE 10G REUSE , 
'/u03/oracle/oradata/DBAViet/tundo2_03.dbf' SIZE 10G REUSE , 
'/u03/oracle/oradata/DBAViet/tundo2_04.dbf' SIZE 10G REUSE , 
'/u03/oracle/oradata/DBAViet/tundo2_05.dbf' SIZE 10G REUSE , 
'/u03/oracle/oradata/DBAViet/tundo2_06.dbf' SIZE 10G REUSE , 
'/u03/oracle/oradata/DBAViet/tundo2_07.dbf' SIZE 10G REUSE , 
'/u03/oracle/oradata/DBAViet/tundo2_08.dbf' SIZE 10G REUSE 

-- 2/ Set new undo tablespace for each intance

ALTER SYSTEM SET undo_tablespace = TUNDOTBS1 SID='DBAViet1'

ALTER SYSTEM SET undo_tablespace = TUNDOTBS2 SID='DBAViet2'


-- 3/ DROP TABLESPACE UNDOTBS1_old including contents;

DROP TABLESPACE UNDOTBS1 including contents and datafiles;

DROP TABLESPACE UNDOTBS2 including contents and datafiles;