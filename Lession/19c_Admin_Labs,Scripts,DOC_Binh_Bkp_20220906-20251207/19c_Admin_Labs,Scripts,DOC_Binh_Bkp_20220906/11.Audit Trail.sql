-- Cấu hình extended auditing.
CONN sys/password AS SYSDBA
--CDB
ALTER SYSTEM SET audit_trail=DB,EXTENDED SCOPE=SPFILE;
SHUTDOWN IMMEDIATE
STARTUP
TRUNCATE TABLE aud$;
TRUNCATE TABLE fga_log$;

AUDIT ALL BY user1 BY ACCESS;

grant update on OAZ13.TABLE1 to user1;

-- Thực hiện audit 
CONN user1/oracle

select * from OAZ13.TABLE1;

UPDATE oaz13.TABLE1 SET cold2 = cold2||'_NEW';
commit;

-- Kiểm tra dữ liệu audit trail
SELECT * FROM dba_common_audit_trail order by extended_timestamp desc;

select * from aud$ order by ntimestamp# desc;

SQL_TEXT
----------------------------
UPDATE emp SET ename = ename