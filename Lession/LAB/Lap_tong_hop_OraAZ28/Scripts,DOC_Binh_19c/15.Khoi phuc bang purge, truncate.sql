select command_id, start_time, end_time, status,INPUT_TYPE, input_bytes_display, output_bytes_display, time_taken_display, round(compression_ratio,2) RATIO , input_bytes_per_sec_display, output_bytes_per_sec_display
from v$rman_backup_job_details 
where trunc(end_time)>=trunc(sysdate-120)
order by end_time desc; 

select * from OAZ14.TABLE1;

drop table OAZ14.TABLE1;

FLASHBACK TABLE OAZ14.TABLE1 TO BEFORE DROP;

select * from dba_segments where owner='OAZ14';

select * from OAZ14."BIN$62UUExFxAcrgU4C2qMB6hA==$0";

select * from dba_recyclebin
where owner='OAZ14'
order by droptime desc;


purge table OAZ14.TABLE1;

RECOVER TABLE 'OAZ14'.'TABLE1' OF PLUGGABLE DATABASE pdb1
  UNTIL TIME "TO_DATE('19-10-2022 21:30', 'DD-MM-YYYY HH24:MI')"
  AUXILIARY DESTINATION '/u01/aux' ;
