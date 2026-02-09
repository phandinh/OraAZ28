--1.Kiem tra control file: Dam bao co 2 control file
select * from v$controlfile

--/u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl
--/u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl
SQL> show parameter control;

--+ Them control file
SQL> alter system set control_files='/u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl','/u01/app/oracle/fast_recovery_area/ORCL/controlfile/o1_mf_jngnomvm_.ctl','/u01/app/oracle/oradata/ORCL/controlfile/control03.ctl' scope=spfile;
SQL> shutdown immediate;
SQL> exit

$ cp /u01/app/oracle/oradata/ORCL/controlfile/o1_mf_jngnomtw_.ctl /u01/app/oracle/oradata/ORCL/controlfile/control03.ctl

[oracle@linux7 ~]$ sqlplus / as sysdba
SQL> startup

--2.Cau hinh phan vung fast recovery area mac danh
select * from v$parameter where name like '%recovery_file%'

SQL> show parameter db_recovery_file_dest;

SQL> alter system set db_recovery_file_dest='/backup';

SQL> show parameter db_recovery_file_dest_size;
SQL> alter system set DB_RECOVERY_FILE_DEST_SIZE=15G;

--3.Cau hinh nhieu redo log group
select * from v$log;

select * from v$logfile;

alter system switch logfile;

-- Drop di
Alter database drop logfile member '/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo01a.log';
Alter database drop logfile member '/backup/ORCL/onlinelog/o1_mf_1_kss2pck2_.log';

Alter database drop logfile member '/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo01bb.log';

Alter database drop logfile member '/backup/ORCL/onlinelog/o1_mf_3_kss2qklq_.log';
Alter database drop logfile member '/u01/app/oracle/fast_recovery_area/ORCL/onlinelog/redo01c.log';

-- Add Log member
ALTER DATABASE ADD LOGFILE MEMBER '/u01/app/oracle/fast_recovery_area/redo01b.log'   TO GROUP 1;
ALTER DATABASE ADD LOGFILE MEMBER '/u01/app/oracle/fast_recovery_area/redo02b.log'   TO GROUP 2;
ALTER DATABASE ADD LOGFILE MEMBER '/u01/app/oracle/fast_recovery_area/redo03b.log'   TO GROUP 3;



--4.Dat CSDL o che do ARCHIVELOG
-- Archiver: Started
select * from v$instance

--Log_mode: ARCHIVELOG
select * from v$database

SQL> archive log list;
Database log mode              Archive Mode
Automatic archival             Enabled
Archive destination            USE_DB_RECOVERY_FILE_DEST
Oldest online log sequence     18
Next log sequence to archive   20
Current log sequence           20

SQL> show parameter recovery;

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
db_recovery_file_dest                string      /backup
db_recovery_file_dest_size           big integer 15G
recovery_parallelism                 integer     0
remote_recovery_file_dest            string
