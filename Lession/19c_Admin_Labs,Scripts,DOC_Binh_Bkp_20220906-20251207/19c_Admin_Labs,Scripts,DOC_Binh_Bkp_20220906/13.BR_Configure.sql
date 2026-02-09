--1.Kiem tra control file: Dam bao co 2 control file
select * from v$controlfile

SQL> show parameter control;

--+ Them control file
SQL> alter system set control_files='/u01/app/oracle/oradata/db12c/control01.ctl','/u01/app/oracle/fast_recovery_area/db12c/control02.ctl';
SQL> shutdown immediate;
$ cp /u01/app/oracle/oradata/db12c/control01.ctl /u01/app/oracle/fast_recovery_area/db12c/control02.ctl
SQL> startup

--2.Cau hinh phan vung fast recovery area mac danh
select * from v$parameter where name like '%recovery_file%'

SQL> show parmeter db_recovery_file_dest;

SQL> alter system set db_recovery_file_dest='/fra';

SQL> show parmeter DB_RECOVERY_FILE_DEST_SIZE;
SQL> alter system set DB_RECOVERY_FILE_DEST_SIZE=10G;

--3.Cau hinh nhieu redo log group
select * from v$log

select * from v$logfile

-- Add Log member
ALTER DATABASE ADD LOGFILE MEMBER '/u01/app/oracle/fast_recovery_area/db12c/DB12C/onlinelog/redo01b.log'   TO GROUP 1

--4.Dat CSDL o che do ARCHIVELOG
-- Archiver: Started
select * from v$instance

--Log_mode: ARCHIVELOG
select * from v$database

SQL> archive log list;
