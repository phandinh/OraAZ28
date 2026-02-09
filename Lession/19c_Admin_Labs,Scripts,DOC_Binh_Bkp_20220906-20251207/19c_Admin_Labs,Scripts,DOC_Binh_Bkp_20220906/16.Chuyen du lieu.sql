--0. Check
 --OS:      
    ps -ef |grep expdp
    ps -ef |grep impdp
        
--DB    
    -- job data pump: SYS	SYS_EXPORT_FULL_01	EXPORT	FULL	EXECUTING	8	1	10
    select * from DBA_DATAPUMP_JOBS;
    
    -- session
    select * from dba_datapump_sessions;
        
    -- longops
    col table_name format a30
        
    select substr(sql_text, instr(sql_text,'"')+1, 
                   instr(sql_text,'"', 1, 2)-instr(sql_text,'"')-1) 
              table_name, 
           rows_processed, 
           round((sysdate
                  - to_date(first_load_time,'yyyy-mm-dd hh24:mi:ss'))
                 *24*60, 1) minutes, 
           trunc(rows_processed / 
                    ((sysdate-to_date(first_load_time,'yyyy-mm-dd hh24:mi:ss'))
                 *24*60)) rows_per_min 
    from 
       v$sqlarea 
    where 
      --upper(sql_text) like 'INSERT % INTO "%'       and 
      command_type = 2 
      and 
      open_versions > 0;
      
    select 
       sid, 
       serial#
    from 
       v$session s, 
       dba_datapump_sessions d
    where 
       s.saddr = d.saddr;
    select 
       sid, 
       serial#, 
       sofar, 
       totalwork 
    from    v$session_longops;
    
--1. Tao thu muc
--Tren OS tao:
$ mkdir /home/oracle/oaz

--PDB
sqlplus / as sysdba
alter session set container=pdb1;

select * from dba_directories;
cd 
desc dba_directories;
col DIRECTORY_NAME format a30;
col directory_path format a50;
set linesize 200;
 select DIRECTORY_NAME, directory_path from dba_directories;

 -- drop directory oaz;
 
create directory oaz as '/home/oracle/oaz';

select DIRECTORY_NAME, directory_path from dba_directories where directory_name='OAZ';

--2.Export

-- export 1 schema (oaz13) cua pdb1
alter session set container=pdb1;
create directory oaz as '/home/oracle/oaz';

create user oaz13 identified by oracle;
grant connect, resource, dba to oaz13;

create table oaz13.tab_objects as select * from dba_objects ;

select * from oaz13.tab_objects;

--expdp \"sys/oracle@service as sysdba\"

expdp "' sys/oracle@pdb1 as sysdba'" DIRECTORY=oaz DUMPFILE=oaz13%U.dmp logfile=oaz13.log SCHEMAS=oaz13 COMPRESSION=ALL CONTENT=ALL  PARALLEL=2;

-- Export full DB
expdp "' / as sysdba'" DIRECTORY=oaz DUMPFILE=orcl%U.dmp logfile=orcl.log COMPRESSION=ALL CONTENT=ALL FULL=y  PARALLEL=8;

-- Go mat khau: oracle

--1.8GB
select sum(bytes)/1024/1024/1024 "GB" from dba_data_files;

. . exported "oaz13"."TAB_OBJECTS"                   6.679 KB       9 rows


--3.Xoa bang TABLE1 di
select * from oaz13.tab_objects;

drop table oaz13.tab_objects purge;

select * from oaz13.tab_objects;

drop table oaz13.tab_objects purge;

[Error] Execution (3: 1): ORA-38305: object not in RECYCLE BIN

flashback table oaz13.tab_objects   to  before drop;

--4.Import lai
--impdp "' / as sysdba'"  DIRECTORY=binhdir DUMPFILE=orcl%U.dmp TABLES=C##BINHTV.TAB_OBJECTS;

impdp  oaz13/oracle@pdb1   DIRECTORY=oaz DUMPFILE=oaz13%U.dmp logfile=impdp.tab_objects.log TABLES=oaz13.tab_objects;

impdp  oaz13/oracle@pdb1   DIRECTORY=oaz DUMPFILE=orcl%U.dmp logfile=impdp.tab_objects.log TABLES=oaz13.tab_objects ;

select * from oaz13.tab_objects;

select * from oaz13.tab_objects;

expdp "'/ as sysdba'" ESTIMATE_ONLY=y full=y;

expdp "'/ as sysdba'" DIRECTORY=oaz   ESTIMATE_ONLY=y COMPRESSION=ALL

expdp oaz13/oracle@pdb1 DIRECTORY=oaz   ESTIMATE_ONLY=y COMPRESSION=ALL;