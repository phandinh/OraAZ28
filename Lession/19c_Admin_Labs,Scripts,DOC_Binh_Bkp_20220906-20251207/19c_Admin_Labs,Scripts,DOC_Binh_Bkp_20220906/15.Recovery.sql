--15.1.KHOI PHUC 1 DATAFILE CUA TABLESPACE USERS BI MAT
select * from dba_data_files order by tablespace_name;

--USERS
/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_users_jngpltl1_.dbf

-- Doi ten file thanh xxx
mv /u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_users_jngpltl1_.dbf /u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_users_jngpltl1_.dbf.xxx

SQL> shutdown immediate;
ORA-01116: error in opening database file 12
ORA-01110: data file 12: '/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_users_k2ysofg0_.dbf'
ORA-27041: unable to open file
Linux-x86_64 Error: 2: No such file or directory
Additional information: 3

SQL> Shutdown abort;

startup;

 
SQL> show pdbs;

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDB1                           MOUNTED --> Binh thuong la READ WRITE

SQL> alter session set container=pdb1;

SQL> startup
ORA-65368: unable to open the pluggable database due to errors during recovery
ORA-01110: data file 12:
'/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_us
ers_k2ysofg0_.dbf'
ORA-01157: cannot identify/lock data file 12 - see DBWR trace file
ORA-01110: data file 12:
'/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_us
ers_k2ysofg0_.dbf'
ORA-01113: file 198 needs media recovery
ORA-01110: data file 198:
'/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_da
ta2022_k5m1ymz5_.dbf'

[oracle@linux7 ~]$ ls -la /u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_users_k2ysofg0_.dbf
ls: cannot access /u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_users_k2ysofg0_.dbf: No such file or directory
		 
rman target=sys@pdb1; 

-- mat khau oracle
		 
RUN {
  ALTER DATABASE DATAFILE 12 OFFLINE;
  RESTORE DATAFILE 12;
  RECOVER DATAFILE 12;
  ALTER DATABASE DATAFILE 12 ONLINE;
}

RUN {
  ALTER DATABASE DATAFILE 198 OFFLINE;
  RESTORE DATAFILE 198;
  RECOVER DATAFILE 198;
  ALTER DATABASE DATAFILE 198 ONLINE;
}


RMAN> backup database plus archivelog ;  

SQL> show pdbs;

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDB1                           MOUNTED
SQL> alter pluggable database pdb1 open;

Pluggable database altered.

SQL> show pdbs;

SQL> alter session set container=pdb1;

Session altered.

SQL> startup;
ORA-65019: pluggable database PDB1 already open

-- 15.2.KHOI PHUC DATAFILE SYSTEM CUA PDB1
/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_system_jngplfv4_.dbf
mv /u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_system_jngplfv4_.dbf /u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_system_jngplfv4_.dbf.xxx

(hoac echo 1 >> /u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_system_jngplfv4_.dbf)

SQL> show pdbs;

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDB1                           READ WRITE NO
SQL> alter pluggable database pdb1 close;

Pluggable database altered.

SQL> alter pluggable database pdb1 open;
alter pluggable database pdb1 open
*
ERROR at line 1:
ORA-65368: unable to open the pluggable database due to errors during recovery
ORA-01110: data file 9:
'/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_sy
stem_jngplfv4_.dbf'
ORA-01157: cannot identify/lock data file 9 - see DBWR trace file
ORA-01110: data file 9:
'/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_sy
stem_jngplfv4_.dbf'
ORA-01113: file 26 needs media recovery
ORA-01110: data file 26:
'/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_un
dotbs1_jt1tx9t1_.dbf'

$ rman target=sys@pdb1;

-- Go mat khau oracle
		 
RMAN>  
RUN {
  ALTER DATABASE DATAFILE 9,24 OFFLINE;
  RESTORE DATAFILE 9,24;
  RECOVER DATAFILE 9,24;
  ALTER DATABASE DATAFILE 9,24 ONLINE;
}

SQL>  alter pluggable database pdb1 open;

SQL> show pdbs;

SQL> show pdbs;

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDB1                           READ WRITE NO

--15.3.KHOI PHUC CONTROL FILE TU BACKUP

rman> backup database plus archivelog;

SQL> show parameter control;      

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
control_file_record_keep_time        integer     7
control_files                        string      /u01/app/oracle/oradata/ORCL/cntrolfile/o1_mf_jngnomtw_.ctl, /u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl, /u01/app/oracle/oradata/ORCL/controlfile/control03.ctl

Starting Control File and SPFILE Autobackup at 06-MAY-22
piece handle=/home/oracle/backup/level0/auto_dbaviet_ctlc-1611489315-20220506-07 comment=NONE
Finished Control File and SPFILE Autobackup at 06-MAY-22

mv /u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl /u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl.xxx;
mv /u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl /u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl.xxx;
/u01/app/oracle/oradata/ORCL/controlfile/control03.ctl

--Bo qua: mv /u01/app/oracle/oradata/ORCL/controlfile/control03.ctl /u01/app/oracle/oradata/ORCL/controlfile/control03.ctl.xxx

SQL> shutdown immediate;
Database closed.
ORA-00210: cannot open the specified control file
ORA-00202: control file:
'/u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl'
ORA-27041: unable to open file
Linux-x86_64 Error: 2: No such file or directory
Additional information: 3

SQL> shutdown abort;
ORACLE instance shut down.

SQL> startup
ORACLE instance started.

Total System Global Area 2063597416 bytes
Fixed Size                  9138024 bytes
Variable Size             553648128 bytes
Database Buffers         1493172224 bytes
Redo Buffers                7639040 bytes
ORA-00205: error in identifying control file, check alert log for more info    

[oracle@linux7 datafile]$ rman target /

--New: 06/05: /home/oracle/backup/level0/auto_dbaviet_ctlc-1611489315-20220506-07
RMAN> restore controlfile from  '/home/oracle/backup/level0/auto_dbaviet_ctlc-1611489315-20220506-07';

(hoac restore controlfile from autobackup;)

Starting restore at 06-MAY-22
using target database control file instead of recovery catalog
allocated channel: ORA_DISK_1
channel ORA_DISK_1: SID=195 device type=DISK

channel ORA_DISK_1: restoring control file
channel ORA_DISK_1: restore complete, elapsed time: 00:00:01
output file name=/u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl
output file name=/u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl
output file name=/u01/app/oracle/oradata/ORCL/controlfile/control03.ctl
Finished restore at 06-MAY-22


RMAN> alter database mount;
RMAN> restore database;
RMAN> recover database;
SQL> alter database open resetlogs;


SQL> show pdbs;

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDB1                           READ WRITE NO
         
--15.4.MAT REDOLOG
--1	1	1	209715200	512	3	NO	CURRENT
--2	1	0	209715200	512	3	YES	UNUSED
--3	1	0	209715200	512	3	YES	UNUSED

select * from v$log;

--	ONLINE	/u01/app/oracle/oradata/ORCL/onlinelog/o1_mf_1_jngnoq26_.log -- doi ten
-- mv /u01/app/oracle/oradata/ORCL/onlinelog/o1_mf_1_jngnoq26_.log /u01/app/oracle/oradata/ORCL/onlinelog/o1_mf_1_jngnoq26_.log.xxx

select * from v$logfile;

create table oaz10.tab1(id number, name varchar2(20)) tablespace users;

SQL> alter system switch logfile;

alter database drop logfile member '/u01/app/oracle/oradata/ORCL/onlinelog/o1_mf_1_jngnoq26_.log';

ALTER DATABASE ADD LOGFILE MEMBER '/u01/app/oracle/oradata/ORCL/onlinelog/redo01cc.log'   TO GROUP 1;

Backup controlfile written to trace file /u01/app/oracle/diag/rdbms/orcl/orcl/trace/orcl_ora_15709.trc





