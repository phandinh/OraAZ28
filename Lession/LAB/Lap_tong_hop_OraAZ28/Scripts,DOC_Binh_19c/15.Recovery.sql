--15.1.KHOI PHUC 1 DATAFILE CUA TABLESPACE USERS BI MAT
--PDB
--/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_users_m2dv0jb7_.dbf USERS
select * from dba_data_files order by tablespace_name;

--USERS
--/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_users_m2dv0jb7_.dbf	12	USERS


ls -lt /u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_users_m2dv0jb7_.dbf;

-- Doi ten file thanh xxx
rm /u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_users_m2dv0jb7_.dbf ;
ls -lt /u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_users_m2dv0jb7_.dbf;

create table oaz22.tab21(id number, name varchar2(100)) tablespace users;

grant unlimited tablespace to oaz22;


declare
    n number :=0;
begin
    for n in 1 .. 100000 
    loop
        insert into oaz22.tab21 values(n, 'Binh ' || n);
        commit; 
        --n := n+1;
    end loop;
end;


ORA-01116: error in opening database file 12
ORA-01110: data file 12: '/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_users_m2dv0jb7_.dbf'
ORA-27041: unable to open file
Linux-x86_64 Error: 2: No such file or directory
Additional information: 3
ORA-06512: at line 6

select * from oaz22.tab21 ;

declare
    n number :=0;
begin
    for n in 1 .. 100000 
    loop
        insert into oaz22.tab21 values(n, 'Binh ' || n);
        commit; 
        --n := n+1;
    end loop;
end;

--Recovery
rman target=sys@pdb1;

RUN {
  SQL 'ALTER DATABASE DATAFILE 12 OFFLINE';
  RESTORE DATAFILE 12;
  RECOVER DATAFILE 12;
  SQL 'ALTER DATABASE DATAFILE 12 ONLINE';
}


-- XOA 1 DATAFILE ORCL (CDB)
select * from dba_data_files order by tablespace_name;

--USERS
--/u01/app/oracle/oradata/ORCL/datafile/o1_mf_users_lb5rrt69_.dbf	7	USERS


ls -lt /u01/app/oracle/oradata/ORCL/datafile/o1_mf_users_lb5rrt69_.dbf;

-- Doi ten file thanh xxx
rm -rf /u01/app/oracle/oradata/ORCL/datafile/o1_mf_users_lb5rrt69_.dbf ;
ls -lt /u01/app/oracle/oradata/ORCL/datafile/o1_mf_users_lb5rrt69_.dbf;

create user c##oaz22 identified by oracle;

grant connect, resource to c##oaz22 container=all;

grant unlimited tablespace to c##oaz22 container=all;

create table c##oaz22.tab21(id number, name varchar2(100)) tablespace users;

declare
    n number :=0;
begin
    for n in 1 .. 100000 
    loop
        insert into c##oaz22.tab21 values(n, 'CDB_Binh ' || n);
        commit; 
        --n := n+1;
    end loop;
end;

select * from c##oaz22.tab21;

ORA-01116: error in opening database file 7
ORA-01110: data file 7: '/u01/app/oracle/oradata/ORCL/datafile/o1_mf_users_lb5rrt69_.dbf'
ORA-27041: unable to open file
Linux-x86_64 Error: 2: No such file or directory
Additional information: 3
ORA-06512: at line 6

--Recovery
rman target /;
RMAN > list backup of datafile 7;

RUN {
  SQL 'ALTER DATABASE DATAFILE 7 OFFLINE';
  RESTORE DATAFILE 7;
  RECOVER DATAFILE 7;
  SQL 'ALTER DATABASE DATAFILE 7 ONLINE';
}

declare
    n number :=0;
begin
    for n in 1 .. 1000 
    loop
        insert into c##oaz22.tab21 values(n, 'CDB_Binh ' || n);
        commit; 
        --n := n+1;
    end loop;
end;

select * from c##oaz22.tab21;

--
--create table oaz22.tab17(id number, name varchar2(100)) tablespace system;
--
--grant unlimited tablespace to oaz22;
--
--
--declare
--    n number :=0;
--begin
--    for n in 1 .. 10000 
--    loop
--        insert into test.tab7 values(n, 'Binh ' || n);
--        commit; 
--        --n := n+1;
--    end loop;
--end;
--

-- Xoa file va restart DB:
/u01/app/oracle/oradata/ORCL/datafile/o1_mf_users_lb5r05l2_.dbf	7	USERS
rm -rf /u01/app/oracle/oradata/ORCL/datafile/o1_mf_users_lb5r05l2_.dbf;

ls -la /u01/app/oracle/oradata/ORCL/datafile/o1_mf_users_lb5r05l2_.dbf;

declare
    n number :=0;
begin
    for n in 1 .. 100000 
    loop
        insert into c##oaz22.tab21 values(n, 'CDB_Binh ' || n);
        commit; 
        --n := n+1;
    end loop;
end;

ORA-01565: error in identifying file '/u01/app/oracle/oradata/ORCL/datafile/o1_mf_users_lb5r05l2_.dbf'
ORA-27037: unable to obtain file status
Linux-x86_64 Error: 2: No such file or directory
Additional information: 7
ORA-06512: at line 6


SQL> shutdown immediate;

--PDB1(3):ALTER PLUGGABLE DATABASE  OPEN 
--PDB1(3):Autotune of undo retention is turned on. 
--2022-12-16T21:13:23.023153+07:00
--Errors in file /u01/app/oracle/diag/rdbms/orcl/orcl/trace/orcl_dbw0_13008.trc:
--ORA-01157: cannot identify/lock data file 48 - see DBWR trace file
--ORA-01110: data file 48: '/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_users_koqrktbs_.dbf'
--ORA-27037: unable to obtain file status
--Linux-x86_64 Error: 2: No such file or directory
--Additional information: 7
--2022-12-16T21:13:23.032919+07:00
--Pdb PDB1 hit error 1113 during open read write (1) and will be closed.

--SQL> Shutdown abort;

--Database mounted.
--ORA-01157: cannot identify/lock data file 7 - see DBWR trace file
--ORA-01110: data file 7:
--'/u01/app/oracle/oradata/ORCL/datafile/o1_mf_users_lb5r05l2_.dbf'
SQL> startup;
 
SQL> show pdbs;

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDB1                           MOUNTED --> Binh thuong la READ WRITE


RUN {
  SQL 'ALTER DATABASE DATAFILE 7 OFFLINE';
  RESTORE DATAFILE 7;
  RECOVER DATAFILE 7;
  SQL 'ALTER DATABASE DATAFILE 7 ONLINE';
}
====
--SQL> alter session set container=pdb1;
--
--SQL> startup
--ORA-65368: unable to open the pluggable database due to errors during recovery
--ORA-01110: data file 48:
--'/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_us
--ers_koqrktbs_.dbf'
--ORA-01157: cannot identify/lock data file 48 - see DBWR trace file
--ORA-01110: data file 48:
--'/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_us
--ers_koqrktbs_.dbf'
--ORA-01113: file 83 needs media recovery
--ORA-01110: data file 83:
--'/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_da
--ta_kr9ng663_.dbf'
--
--[oracle@linux7 ~]$ rman target /
--
--RMAN> list backup of datafile 48;
-- 48   0  Incr 3925611    16-DEC-22              NO    /u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_users_koqrktbs_.dbf
--
--
--[oracle@linux7 ~]$ ls -la /u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_users_k2ysofg0_.dbf
--ls: cannot access /u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_users_k2ysofg0_.dbf: No such file or directory
--		 
--rman target=sys@pdb1; 
--
---- mat khau oracle
--		 
--RUN {
--  ALTER DATABASE DATAFILE 48,83 OFFLINE;
--  RESTORE DATAFILE 48,83;
--  RECOVER DATAFILE 48,83;
--  ALTER DATABASE DATAFILE 48,83 ONLINE;
--}
--
--RMAN> backup database plus archivelog ;  
--
--SQL> show pdbs;
--
--    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
------------ ------------------------------ ---------- ----------
--         2 PDB$SEED                       READ ONLY  NO
--         3 PDB1                           MOUNTED
--SQL> alter pluggable database pdb1 open;
--
--Pluggable database altered.
--
--SQL> show pdbs;
--
--    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
------------ ------------------------------ ---------- ----------
--         2 PDB$SEED                       READ ONLY  NO
--         3 PDB1                           READ WRITE NO
--
--SQL> alter session set container=pdb1;
--
--Session altered.
--
--SQL> startup;
--ORA-65019: pluggable database PDB1 already open

/**************** 15.2.KHOI PHUC DATAFILE SYSTEM CUA PDB1 ****************/
select * from dba_data_files where tablespace_name='SYSTEM';

/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_system_l6q0vnm9_.dbf	9

mv /u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_system_l6q0vnm9_.dbf /u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_system_l6q0vnm9_.dbf.xxx;

(hoac echo 1 >> /u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_system_l6q0vnm9_.dbf)

SQL> show pdbs;

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDB1                           READ WRITE NO
SQL> alter pluggable database pdb1 close;

Pluggable database altered.

SQL> alter pluggable database pdb1 open;
alter pluggable database pdb1 open

ERROR at line 1:
ORA-65368: unable to open the pluggable database due to errors during recovery
ORA-01110: data file 9:
'/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_sy
stem_l6q0vnm9_.dbf'
ORA-01157: cannot identify/lock data file 9 - see DBWR trace file
ORA-01110: data file 9:
'/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_sy
stem_l6q0vnm9_.dbf'
ORA-01113: file 191 needs media recovery
ORA-01110: data file 191:
'/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_in
dx_log_m85k204r_.dbf'


--/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_data_kr9ng663_.dbf	83	DATA

select * from dba_data_files  where file_id=9;

select * from v$datafile where file#=9;


$ rman target=sys@pdb1;

-- Go mat khau oracle
		 
RMAN>  
RUN {
  ALTER DATABASE DATAFILE 9 OFFLINE;
  RESTORE DATAFILE 9;
  RECOVER DATAFILE 9;
  ALTER DATABASE DATAFILE 9 ONLINE;
}

SQL>  alter pluggable database pdb1 open;

SQL> show pdbs;

SQL> show pdbs;

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDB1                           READ WRITE NO

RMAN > backup database plus archivelog ;  

--15.3.KHOI PHUC CONTROL FILE TU BACKUP

-- MAT 2/3 CONTROL FILE
--rman> backup database plus archivelog;

--RMAN> backup current controlfile;

/home/oracle/backup/level0.sh 

handle '/home/oracle/backup/level0/auto_dbaviet_ctlc-1611489315-20240712-01'

SQL> show parameter control;      
                                                 
control_files   string      /u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl, /u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl, /u01/app/oracle/oradata/ORCL/controlfile/conrol03.ctl

--Control autobackup written to DISK device
--handle '/home/oracle/backup/level1/auto_dbaviet_ctlc-1611489315-20230522-01'

rm  -rf /u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl;
rm -rf  /u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl;

ls /u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl;
ls /u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl;

SQL> alter system checkpoint;

SQL> alter system switch logfile;

ORA-00202: control file: '/u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl'
ORA-27041: unable to open file
Linux-x86_64 Error: 2: No such file or directory

-- Con lai:
/u01/app/oracle/oradata/ORCL/controlfile/conrol03.ctl

--Bo qua: mv /u01/app/oracle/oradata/ORCL/controlfile/control03.ctl /u01/app/oracle/oradata/ORCL/controlfile/control03.ctl.xxx

SQL> shutdown immediate;
ORA-00210: cannot open the specified control file
ORA-00202: control file: '/u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl'
ORA-27041: unable to open file
Linux-x86_64 Error: 2: No such file or directory
Additional information: 3

SQL> shutdown abort;
ORACLE instance shut down.

SQL> startup
ORACLE instance started.

Total System Global Area 1.0737E+10 bytes
Fixed Size                 12688456 bytes
Variable Size            1744830464 bytes
Database Buffers         8959033344 bytes
Redo Buffers               20865024 bytes
ORA-00205: error in identifying control file, check alert log for more info 

2024-07-12T21:39:10.633991+07:00
Errors in file /u01/app/oracle/diag/rdbms/orcl/orcl/trace/orcl_mz00_25918.trc:
ORA-00202: control file: '/u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl'
ORA-27037: unable to obtain file status
Linux-x86_64 Error: 2: No such file or directory
Additional information: 7
ORA-00210: cannot open the specified control file
ORA-00202: control file: '/u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl'
ORA-27037: unable to obtain file status
Linux-x86_64 Error: 2: No such file or directory

cp /u01/app/oracle/oradata/ORCL/controlfile/conrol03.ctl /u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl;
cp /u01/app/oracle/oradata/ORCL/controlfile/conrol03.ctl /u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl;

[oracle@linux7 ~]$ ls -la /u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl;
-rw-r----- 1 oracle oinstall 18759680 Sep 25 22:03 /u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl
[oracle@linux7 ~]$ ls -la /u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl;
-rw-r----- 1 oracle oinstall 18759680 Sep 25 22:03 /u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl

SQL> alter database mount;

SQL> alter database open;


-- MAT 3/3 CONTROL FILE
SQL> show parameter control;      
                                                 
control_files   string  /u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl, /u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl, /u01/app/oracle/oradata/ORCL/controlfile/conrol03.ctl

piece handle=/home/oracle/backup/level0/auto_dbaviet_ctlc-1611489315-20240422-03 comment=NONE

rm  -rf /u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl;
rm -rf  /u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl;
rm -rf /u01/app/oracle/oradata/ORCL/controlfile/conrol03.ctl;

ls -la /u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl;
ls -la  /u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl;
ls -la /u01/app/oracle/oradata/ORCL/controlfile/conrol03.ctl;


SQL> alter system checkpoint;
SQL> alter system switch logfile;

Errors in file /u01/app/oracle/diag/rdbms/orcl/orcl/trace/orcl_arc3_25471.trc:
ORA-00210: cannot open the specified control file
ORA-00202: control file: '/u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl'
ORA-27041: unable to open file
Linux-x86_64 Error: 2: No such file or directory
Additional information: 3
2023-05-22T22:22:25.853159+07:00
Errors in file /u01/app/oracle/diag/rdbms/orcl/orcl/trace/orcl_mz00_25881.trc:
ORA-00202: control file: '/u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl'
ORA-27041: unable to open file
Linux-x86_64 Error: 2: No such file or directory
Additional information: 3
2023-05-22T22:22:25.977593+07:00
Errors in file /u01/app/oracle/diag/rdbms/orcl/orcl/trace/orcl_mz00_25881.trc:
ORA-00210: cannot open the specified control file
ORA-00202: control file: '/u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl'
ORA-27041: unable to open file
Linux-x86_64 Error: 2: No such file or directory
Additional information: 3
2023-05-22T22:22:29.902945+07:00

SQL> shutdown immediate;
Database closed.
ORA-00210: cannot open the specified control file
ORA-00202: control file:
'/u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl'
ORA-27041: unable to open file
Linux-x86_64 Error: 2: No such file or directory
Additional information: 3

SQL> shutdown abort;
ORACLE instance shut down.

SQL> startup

Total System Global Area 1.0737E+10 bytes
Fixed Size                 12688456 bytes
Variable Size            1744830464 bytes
Database Buffers         8959033344 bytes
Redo Buffers               20865024 bytes
ORA-00205: error in identifying control file, check alert log for more info

Errors in file /u01/app/oracle/diag/rdbms/orcl/orcl/trace/orcl_mz00_26072.trc:
ORA-00202: control file: '/u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl'
ORA-27037: unable to obtain file status
Linux-x86_64 Error: 2: No such file or directory
Additional information: 7
ORA-00210: cannot open the specified control file
ORA-00202: control file: '/u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl'
ORA-27037: unable to obtain file status
Linux-x86_64 Error: 2: No such file or directory
Additional information: 7
2023-05-22T22:24:18.984259+07:00
Errors in file /u01/app/oracle/diag/rdbms/orcl/orcl/trace/orcl_mz00_26072.trc:
ORA-00202: control file: '/u01/app/oracle/oradata/ORCL/controlfile/conrol03.ctl'

[oracle@linux7 datafile]$ rman target /

--Tim trong ALERT LOG co autobackup gan nhat2023-07-03T22:16:49.465947+07:00
--Control autobackup written to DISK device
--handle '/home/oracle/backup/level1/auto_dbaviet_ctlc-1611489315-20230703-02'
--2023-07-03T22:16:50.881356+07:00

-- Tim trong log backup dinh ky:
--piece handle=/home/oracle/backup/level1/auto_dbaviet_ctlc-1611489315-20230703-02 comment=NONE
--Finished Control File and SPFILE Autobackup at 2023-07-03 22:16:50

RMAN> restore controlfile from  '/home/oracle/backup/level0/auto_dbaviet_ctlc-1611489315-20240712-01';

(hoac restore controlfile from autobackup;)

Starting restore at 25-SEP-23
using channel ORA_DISK_1

channel ORA_DISK_1: restoring control file
channel ORA_DISK_1: restore complete, elapsed time: 00:00:01
output file name=/u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl
output file name=/u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl
output file name=/u01/app/oracle/oradata/ORCL/controlfile/conrol03.ctl
Finished restore at 25-SEP-23


RMAN> alter database mount;
--RMAN> restore database;
RMAN> recover database;
SQL> alter database open resetlogs;

select * from v$archived_log
where next_time >= trunc(sysdate);



SQL> show pdbs;

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDB1                           READ WRITE NO

select * from v$archived_log 
--where name like '%o1_mf_1_1_lk39w1hn_%'
order by resetlogs_time;

select * from v$log;

select * from v$logfile;
         
/***************************************** 15.4.MAT REDOLOG *************************************************/
-- 15.4.1.MAT 1 MEMBER cua group INACTIVE
--1	1	5	209715200	512	2	NO	CURRENT	8972298
--2	1	2	209715200	512	2	YES	INACTIVE	8972278
--4	1	3	209715200	512	2	YES	INACTIVE	8972287
--5	1	4	209715200	512	2	YES	INACTIVE	8972290
select * from v$log;


--1		ONLINE	/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_1_l6q61bd3_.log
--1		ONLINE	/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo01b.log
--2		ONLINE	/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_2_m2f002nj_.log
--2		ONLINE	/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo02b.log
--4		ONLINE	/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo04bb.log
--4		ONLINE	/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_4_l6q61c8h_.log
--5		ONLINE	/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05bb.log
--5		ONLINE	/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_5_l6q61c73_.log
select * from v$logfile order by 1;

alter system switch logfile;

-- Doi ten, 1 member group 2
mv /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_5_l6q61c73_.log /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_5_l6q61c73_.log.xxx;

SQL> alter system switch logfile;

2024-07-12T22:17:03.156367+07:00
Errors in file /u01/app/oracle/diag/rdbms/orcl/orcl/trace/orcl_lg00_26832.trc:
ORA-27041: unable to open file
Linux-x86_64 Error: 2: No such file or directory
Additional information: 3


select * from v$logfile;

alter database drop logfile member '/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_5_l6q61c73_.log';

alter system switch logfile;

ALTER DATABASE ADD LOGFILE MEMBER '/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_5_l6q61c73_new.log'   TO GROUP 5;


--Backup controlfile written to trace file /u01/app/oracle/diag/rdbms/orcl/orcl/trace/orcl_ora_15709.trc

select * from v$logfile;

select * from v$log;

alter system switch logfile;

--15.4.2.MAT TOAN BO GROUP CURRENT
--1	1	9	209715200	512	2	YES	ACTIVE	8974075	7/12/2024 10:18:30 PM
--2	1	10	209715200	512	2	YES	ACTIVE	8974206	7/12/2024 10:21:51 PM
--4	1	11	209715200	512	2	YES	ACTIVE	8974211	7/12/2024 10:21:59 PM
--5	1	12	209715200	512	2	NO	CURRENT	8974227	7/12/2024 10:22:19 PM

select * from v$log;

5		ONLINE	/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05bb.log
5		ONLINE	/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_5_l6q61c73_new.log

select * from v$logfile order by 1;

--select 'rm -rf ' || member ||';' from v$logfile order by group#;

--Group 5
rm -rf /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05bb.log;
rm -rf /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_5_l6q61c73_new.log;

select * from v$logfile;

select * from v$log;

SQL> alter system switch logfile;

2024-07-12T22:24:29.142232+07:00
Errors in file /u01/app/oracle/diag/rdbms/orcl/orcl/trace/orcl_mz00_29780.trc:
ORA-00313: open failed for members of log group 5 of thread 1
ORA-00312: online log 5 thread 1: '/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_5_l6q61c73_new.log'
ORA-27037: unable to obtain file status
Linux-x86_64 Error: 2: No such file or directory
Additional information: 7
ORA-00312: online log 5 thread 1: '/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05bb.log'
ORA-27037: unable to obtain file status
Linux-x86_64 Error: 2: No such file or directory
Additional information: 7
Checker run found 3 new persistent data failures

--Fix 
--rm -rf /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05bb.log;
--rm -rf /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_5_l6q61c73_new.log;

cd /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/
ls -lt
cp redo01b.log /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05bb.log

cd /u01/app/oracle/redolog/ORCL/onlinelog/
ls -lt
cp o1_mf_1_l6q61bd3_.log /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_5_l6q61c73_new.log

--ERROR at line 1:
--ORA-01624: log 2 needed for crash recovery of instance orcl (thread 1)
--ORA-00312: online log 2 thread 1:
--'/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo02b.log'
--ORA-00312: online log 2 thread 1:
--'/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_2_l6q61bdq_new.log'  
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 5;

alter system switch logfile;

select * from v$log;

SQL> alter database open;

Database altered.

SQL> show pdbs;

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDB1                           READ WRITE NO
         
--15.4.3.MAT TOAN BO ONLINE REDO LOG GROUP     
--1	1	13	209715200	512	2	YES	INACTIVE
--2	1	10	209715200	512	2	YES	INACTIVE
--4	1	11	209715200	512	2	YES	INACTIVE
--5	1	14	209715200	512	2	NO	CURRENT

select * from v$log;

--1		ONLINE	/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_1_l6q61bd3_.log
--1		ONLINE	/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo01b.log
--2		ONLINE	/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_2_m2f002nj_.log
--2		ONLINE	/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo02b.log
--4		ONLINE	/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo04bb.log
--4		ONLINE	/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_4_l6q61c8h_.log
--5		ONLINE	/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05bb.log
--5		ONLINE	/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_5_l6q61c73_new.log

select * from v$logfile order by 1;

select 'rm -rf ' || member ||';' from v$logfile order by 1;

rm -rf /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo01b.log;
rm -rf /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo02b.log;
rm -rf /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo04bb.log;
rm -rf /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05bb.log;
rm -rf /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_1_l6q61bd3_.log;
rm -rf /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_2_m2f002nj_.log;
rm -rf /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_4_l6q61c8h_.log;
rm -rf /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_5_l6q61c73_new.log;


alter system switch logfile;

Instance terminated by PMON, pid = 25999

--shutdown immediate;

--ORA-00313: open failed for members of log group 2 of thread 1
--ORA-00312: online log 2 thread 1:
--'/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/o1_mf_2_jngnotfp_1.log'
--ORA-27037: unable to obtain file status
--Linux-x86_64 Error: 2: No such file or directory
--Additional information: 7
--ORA-00312: online log 2 thread 1:
--'/u01/app/oracle/oradata/ORCL/onlinelog/o1_mf_2_jngnoq3d_.log'
--ORA-27037: unable to obtain file status
--Linux-x86_64 Error: 2: No such file or directory
--Additional information: 7

rm -rf /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo01b.log;
rm -rf /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo02b.log;
rm -rf /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo04bb.log;
rm -rf /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05bb.log;
rm -rf /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_1_l6q61bd3_.log;
rm -rf /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_2_m2f002nj_.log;
rm -rf /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_4_l6q61c8h_.log;
rm -rf /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_5_l6q61c73_new.log;

-- Tao lai cac group
cp /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05b.log  /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo01b.log;
cp /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05b.log  /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo02b.log;
cp /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05b.log  /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo04bb.log;
cp /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05b.log  /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05bb.log;
cp /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05b.log  /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_1_l6q61bd3_.log;
cp /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05b.log  /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_2_m2f002nj_.log;
cp /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05b.log  /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_4_l6q61c8h_.log;
cp /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05b.log  /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_5_l6q61c73_new.log;

SQL> 
SQL> ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 1; 

*
ERROR at line 1:
ORA-01624: log 1 needed for crash recovery of instance orcl (thread 1)
ORA-00312: online log 1 thread 1:
'/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_1_l6q61bd3_.log'
ORA-00312: online log 1 thread 1:
'/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo01b.log'

--1		ONLINE	/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_1_l6q61bd3_.log
--1		ONLINE	/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo01b.log

--Xoa 2 log file
rm /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_1_l6q61bd3_.log;
rm /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo01b.log;
ls /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_1_l6q61bd3_.log;
ls /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo01b.log;

--Tao lai
cp /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05b.log  /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_1_l6q61bd3_.log;
cp /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05b.log  /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo01b.log;
ls /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_1_l6q61bd3_.log;
ls /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo01b.log;

SQL> ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 1;

ERROR at line 1:
ORA-01624: log 1 needed for crash recovery of instance orcl (thread 1)
ORA-00312: online log 1 thread 1:
'/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_1_l6q61bd3_.log'
ORA-00312: online log 1 thread 1:
'/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo01b.log'

SQL> ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 2;
Database altered.

ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP  4;

ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 5;

---
SQL> shutdown immediate;
ORA-01109: database not open

Database dismounted.
ORACLE instance shut down.
SQL> startup
ORACLE instance started.

Total System Global Area 1.0737E+10 bytes
Fixed Size                 12688456 bytes
Variable Size            1744830464 bytes
Database Buffers         8959033344 bytes
Redo Buffers               20865024 bytes
Database mounted.
ORA-00341: log 2 of thread 1, wrong log # 5 in header
ORA-00312: online log 2 thread 1:
'/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/o1_mf_2_jngnotfp_1.log'
ORA-00341: log 2 of thread 1, wrong log # 5 in header
ORA-00312: online log 2 thread 1: '/u01/app/oracle/oradata/ORCL/onlinelog/o1_mf_2_jngnoq3d_.log'

SQL> select group# from v$logfile where member  in ('/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_2_l6q61bdq_new.log','/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo02b.log');

    GROUP#
----------
         2
         2
         
--Tao lai redo log group
--alter database drop logfile group 1;
--alter database drop logfile group 5;


SQL> alter database drop logfile group 2;
alter database drop logfile group 2
*
ERROR at line 1:
ORA-01624: log 2 needed for crash recovery of instance orcl (thread 1)
ORA-00312: online log 2 thread 1: '/u01/app/oracle/oradata/ORCL/onlinelog/o1_mf_2_jngnoq3d_.log'
ORA-00312: online log 2 thread 1:
'/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/o1_mf_2_jngnotfp_1.log'


SQL> alter database drop logfile group 4;
alter database drop logfile group 4
*
ERROR at line 1:
ORA-01623: log 4 is current log for instance orcl (thread 1) - cannot drop
ORA-00312: online log 4 thread 1: '/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo04bb.log'
ORA-00312: online log 4 thread 1: '/u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_4_l6q3gdso_.log'

alter database add logfile thread 1 group 1   size 200m;
alter database add logfile thread 1 group 3   size 200m;

ORA-00341: log 4 of thread 1, wrong log # 5 in header
ORA-00312: online log 4 thread 1: '/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo04bb.log'

ALTER DATABASE CLEAR LOGFILE GROUP 2;
ALTER DATABASE CLEAR LOGFILE GROUP 4;

--2
cp /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_1_l6q4s736_.log  /u01/app/oracle/oradata/ORCL/onlinelog/o1_mf_2_jngnoq3d_.log;
cp /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_1_l6q4s736_.log   /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/o1_mf_2_jngnotfp_1.log;
--4
cp /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_1_l6q4s736_.log   /u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo05bb.log;
cp /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_1_l6q4s736_.log   /u01/app/oracle/redolog/ORCL/onlinelog/o1_mf_5_l6q3x7r5_.log;

ALTER DATABASE CLEAR LOGFILE GROUP 2;
ALTER DATABASE CLEAR LOGFILE GROUP 4;

ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 2;

-- Recovery database;

RESTORE SPFILE FROM '/home/oracle/backup/level0/auto_dbaviet_ctlc-1611489315-20240712-04' TO '/tmp/spfileTEMP.ora'; 
RESTORE SPFILE TO '/tmp/spfileTEMP.ora' FROM AUTOBACKUP; # if in NOCATALOG mode

RESTORE SPFILE TO '/tmp/spfileTEMP.ora' FROM '/home/oracle/backup/level0/auto_dbaviet_ctlc-1611489315-20240712-04';

--+Case 1:
rman target /
RMAN> startup nomount force;
RMAN> RESTORE SPFILE TO '/tmp/spfileTEMP.ora' FROM '/home/oracle/backup/level0/auto_dbaviet_ctlc-1611489315-20240712-04';
RMAN> shutdown immediate
RMAN> startup nomount;
RMAN>  restore controlfile from  '/home/oracle/backup/level0/auto_dbaviet_ctlc-1611489315-20240712-04';
RMAN> alter database mount;
RMAN> restore database;
RMAN> recover database noredo;
RMAN> alter database open resetlogs;
RMAN> alter database open resetlogs;

RMAN-00571: ===========================================================
RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
RMAN-00571: ===========================================================
RMAN-03002: failure of sql statement command at 07/12/2024 22:56:24
ORA-01152: file 1 was not restored from a sufficiently old backup 
ORA-01110: data file 1: '/u01/app/oracle/oradata/ORCL/datafile/o1_mf_system_jngnlyw0_.dbf'


--+Case 2: Toi da recovery
SQL> startup nomount;
RMAN>  restore controlfile from  '/home/oracle/backup/level0/auto_dbaviet_ctlc-1611489315-20240712-04';
RMAN> alter database mount;
RMAN> restore database;
RMAN> recover database;

unable to find archived log
archived log thread=1 sequence=12
RMAN-00571: ===========================================================
RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
RMAN-00571: ===========================================================
RMAN-03002: failure of recover command at 07/12/2024 22:56:42
RMAN-06054: media recovery requesting unknown archived log for thread 1 with sequence 12 and starting SCN of 8974227

--Check sequence co the recovery
SQL> select sequence#,first_change#, to_char(first_time,'HH24:MI:SS') from v$log;

 SEQUENCE# FIRST_CHANGE# TO_CHAR(
---------- ------------- --------
         5       8972298 22:10:56
         4       8972290 22:10:52
         7       8972780 22:13:32
         6       8972772 22:13:32
 
 run {
 set until sequence=7; 
 restore database;
 recover database;
 }
 
RMAN>  alter database open resetlogs;

 run {
 set until sequence=12; 
 restore database;
 recover database;
 }