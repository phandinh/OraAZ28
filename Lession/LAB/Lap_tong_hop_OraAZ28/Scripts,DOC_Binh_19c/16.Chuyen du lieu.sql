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
col directory_path format a70;
set linesize 200;
select DIRECTORY_NAME, directory_path from dba_directories;

 -- drop directory oaz;
 
create directory oaz as '/home/oracle/oaz';

select DIRECTORY_NAME, directory_path from dba_directories where directory_name='OAZ';

--2.Export

-- 2.1.Export 1 schema (tab18) cua pdb1
alter session set container=pdb1;
create directory oaz as '/home/oracle/oaz';

create user oaz22 identified by oracle;
grant connect, resource, dba to oaz22;

create table oaz22.tab_objects as select * from dba_objects ;

select * from oaz22.tab_objects;

--expdp \"sys/oracle@service as sysdba\"

expdp "' sys/oracle@pdb1 as sysdba'" DIRECTORY=oaz DUMPFILE=oaz22%U.dmp logfile=oaz22.log SCHEMAS=oaz22 COMPRESSION=ALL CONTENT=ALL  PARALLEL=4;

-- 2.2.Export full DB
sqlplus / as sysdba
create directory oaz as '/home/oracle/oaz';
expdp "' / as sysdba'" DIRECTORY=oaz DUMPFILE=orcl%U.dmp logfile=orcl.log COMPRESSION=ALL CONTENT=ALL FULL=y  PARALLEL=8;

-- Go mat khau: oracle

--1.8GB
select sum(bytes)/1024/1024/1024 "GB" from dba_data_files;

. . exported "oaz22"."TAB_OBJECTS"                   6.679 KB       9 rows


--3.Xoa bang tab_objects di
select * from oaz22.tab_objects;

drop table oaz22.tab_objects purge;

--Check tu tablespace: oaz22	BIN$/7+dIk6yGvXgU4C2qMBFow==$0	TABLE	12582912	65536	1048576	27	2147483645

--oaz22	BIN$BliaFOlBUzTgY4C2qMDthQ==$0	TAB_OBJECTS	DROP	TABLE	USERS	2023-09-27:20:56:44	2023-09-27:20:59:37	7364590		YES	YES	80995	80995	80995	1536

select * from dba_recyclebin;

select * from oaz22.tab_objects;

select * from oaz22."BIN$BliaFOlBUzTgY4C2qMDthQ==$0";

flashback table oaz22.tab_objects   to  before drop;

select * from oaz22.tab_objects;

drop table oaz22.tab_objects purge;

--Kiem tra tablespace: ko co

select * from dba_recyclebin;

--[Error] Execution (3: 1): ORA-38305: object not in RECYCLE BIN
flashback table oaz22.tab_objects   to  before drop;

--4.Import lai
--impdp "' / as sysdba'"  DIRECTORY=binhdir DUMPFILE=orcl%U.dmp TABLES=C##BINHTV.TAB_OBJECTS;

impdp  oaz22/oracle@pdb1   DIRECTORY=oaz DUMPFILE=oaz22%U.dmp logfile=impdp.tab_objects.log TABLES=oaz22.tab_objects  parallel=4;

select * from  oaz22.tab_objects;

impdp  oaz22/oracle@pdb1   DIRECTORY=oaz DUMPFILE=oaz22%U.dmp logfile=impdp.tab_objects.log TABLES=oaz22.tab_objects REMAP_TABLE=oaz22.tab_objects:tab_objects_new parallel=4;

impdp "' sys/oracle@pdb1 as sysdba '" directory=oaz dumpfile=oaz22%u.dmp logfile=impdp.tabl_objects.log tables=oaz22.tab_objects parallel=4; 

 impdp "' sys/oracle@pdb1 as sysdba '" directory=oaz dumpfile=oaz22%u.dmp logfile=impdp.tabl_objects.log tables=oaz22.tab_objects  REMAP_TABLE=oaz22.tab_objects:tab_objects_new parallel=4;

select * from  oaz22.tab_objects_new;

--select * from oaz22.tab_objects;

-- Test them
expdp "'/ as sysdba'" ESTIMATE_ONLY=y full=y;

expdp "'/ as sysdba'" DIRECTORY=oaz   ESTIMATE_ONLY=y full=y COMPRESSION=ALL

expdp tab18/oracle@pdb1 DIRECTORY=oaz   ESTIMATE_ONLY=y COMPRESSION=ALL;