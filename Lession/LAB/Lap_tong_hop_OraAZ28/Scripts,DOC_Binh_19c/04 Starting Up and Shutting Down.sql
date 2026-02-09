alter system pga_aggregate_target=200M;

--1. Check
	SQL> SELECT database_status FROM v$instance;
	
-- 2. Startup
	STARTUP [FORCE] [RESTRICT] [PFILE=filename]
		[EXCLUSIVE | PARALLEL | SHARED]
		[OPEN [RECOVER][database]|MOUNT |NOMOUNT]

ALTER database { MOUNT | OPEN |OPEN READ ONLY | OPEN READ WRITTE}

-- 3. Shutdown
SHUTDOWN [NORMAL | TRANSACTIONAL | IMMEDIATE | ABORT ]

-- 4.Suspend, resume
ALTER system { SUSPEND | RESUME }

-- 5. Automatically start Instance

/var/opt/oracle/oratab (OR /etc/oratab)

-- Automatically start Oracle 11g on solaris after server reboot (N), disable (Y) 
+ASM2:/oracle/grid:N            # line added by Agent
fpdb:/oracle/db:N               # line added by Agent


select * from dictionary;

select * from CDB_ALL_TABLES;

--METADATA hay DICTIONARY VIEW
select * from dba_users where account_status='OPEN';

select * from all_tables;

select * from user_tables;

select * from dba_segments;

--DYNAMIC PERFORMANCE VIEW
select * from v$lock;

select * from v$fixed_table where name like 'GV%';