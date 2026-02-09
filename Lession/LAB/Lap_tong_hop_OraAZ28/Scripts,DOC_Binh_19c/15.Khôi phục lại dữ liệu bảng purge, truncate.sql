select command_id, start_time, end_time, status,INPUT_TYPE, input_bytes_display, output_bytes_display, time_taken_display, round(compression_ratio,2) RATIO , input_bytes_per_sec_display, output_bytes_per_sec_display
from v$rman_backup_job_details 
where trunc(end_time)>=trunc(sysdate-120)
order by end_time desc; 

select * from OAZ20.TAB20;

drop table OAZ20.TAB20;

FLASHBACK TABLE OAZ20.TAB20 TO BEFORE DROP;

select * from dba_segments where owner='OAZ20';

select * from OAZ20."BIN$DAKli/9pLATgY4C2qMCcig==$0";

--OAZ20	BIN$DAKli/9pLATgY4C2qMCcig==$0	TAB20	DROP	TABLE	USERS	2023-12-08:21:31:46	2023-12-08:22:58:20	9520547		YES	YES	83331	83331	83331	16
select * from dba_recyclebin
where owner='OAZ20'
order by droptime desc;

purge table OAZ20.TAB20;

RECOVER TABLE 'OAZ20'.'TAB20' OF PLUGGABLE DATABASE pdb1
  UNTIL TIME "TO_DATE('08-12-2023 22:40', 'DD-MM-YYYY HH24:MI')"
  AUXILIARY DESTINATION '/u01/aux' ;
