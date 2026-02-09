rman target /

--Backup full
backup database plus archivelog;

-- Backup level 0 (full)
/home/oracle/12cWorkshop_labs/labs/backup_level0.rcv 
run{
CROSSCHECK BACKUP;
DELETE NOPROMPT EXPIRED BACKUP;
DELETE OBSOLETE;
DELETE BACKUP COMPLETED BEFORE 'SYSDATE-4' DEVICE TYPE DISK;
BACKUP AS COMPRESSED BACKUPSET INCREMENTAL LEVEL 0 DATABASE FILESPERSET 10 SKIP READONLY SKIP OFFLINE MAXSETSIZE 1 G TAG LEVEL0;
Crosscheck archivelog all;
Delete noprompt expired archivelog all;
BACKUP AS COMPRESSED BACKUPSET ARCHIVELOG ALL FILESPERSET 10 TAG ARCH ;
Delete noprompt archivelog until time 'sysdate-1';
}

-- Backup level 1 (incremental)
/home/oracle/12cWorkshop_labs/labs/backup_level1.rcv
run{
CROSSCHECK BACKUP;
DELETE NOPROMPT EXPIRED BACKUP;
DELETE OBSOLETE;
DELETE BACKUP COMPLETED BEFORE 'SYSDATE-4' DEVICE TYPE DISK;
BACKUP AS COMPRESSED BACKUPSET INCREMENTAL LEVEL 1 DATABASE FILESPERSET 10 SKIP READONLY SKIP OFFLINE MAXSETSIZE 1 G TAG LEVEL0;
Crosscheck archivelog all;
Delete noprompt expired archivelog all;
BACKUP AS COMPRESSED BACKUPSET ARCHIVELOG ALL FILESPERSET 10 TAG ARCH ;
Delete noprompt archivelog until time 'sysdate-1';
}

/home/oracle/12cWorkshop_labs/labs/run_backup_level0.sh
target='target /'
rcvcat='nocatalog'
freq=24
time=`date '+%H%M%S'`
cmdfile=/home/oracle/12cWorkshop_labs/labs/backup_level0.rcv
rman $target $rcvcat cmdfile $cmdfile
exit

/home/oracle/12cWorkshop_labs/labs/run_backup_level1.sh
target='target /'
rcvcat='nocatalog'
freq=24
time=`date '+%H%M%S'`
cmdfile=/home/oracle/12cWorkshop_labs/labs/backup_level1.rcv
rman $target $rcvcat cmdfile $cmdfile
exit

--Sunday=0: Backup level 0
0 0 * * 0 /bin/sh /home/oracle/12cWorkshop_labs/labs/run_backup_level1.sh > /dev/null

--Con lai Backup level 1
0 0 * * 1,2,3,4,5,6 /bin/sh /home/oracle/12cWorkshop_labs/labs/run_backup_level1.sh > /dev/null

select command_id, start_time, end_time, status,INPUT_TYPE, input_bytes_display, output_bytes_display, time_taken_display, round(compression_ratio,2) RATIO , input_bytes_per_sec_display, output_bytes_per_sec_display
from v$rman_backup_job_details 
where trunc(end_time)>=trunc(sysdate-120)
order by end_time desc; 

SELECT SID, SERIAL#, CONTEXT, SOFAR, TOTALWORK, ROUND(SOFAR/TOTALWORK*100,2) "%_COMPLETE"  
FROM V$SESSION_LONGOPS  
WHERE OPNAME LIKE 'RMAN%'  
  AND OPNAME NOT LIKE '%aggregate%'  
  AND TOTALWORK != 0  
  AND SOFAR  != TOTALWORK ;