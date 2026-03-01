--show pdbs;

--alter session set container=PDB1;


--Local user t?o trên Pluggable DataBase (PDB)

--CREATE USER test_user3 IDENTIFIED BY password1 CONTAINER=CURRENT;

--GRANT CREATE SESSION TO test_user3 CONTAINER=CURRENT;

-------------------------------------------------
SQL> alter session set container=pdb1;

Session altered.

SQL> CREATE USER test_user4 IDENTIFIED BY password1;

User created.

SQL> GRANT CREATE SESSION TO test_user4;

Grant succeeded.

SQL>

-------------------------------------------
---Common Roles

SQL> create role c##test_role1;

Role created.

SQL> GRANT CREATE SESSION TO c##test_role1;

Grant succeeded.

SQL> GRANT c##test_role1 TO c##test-user1 CONTAINER=ALL;
GRANT c##test_role1 TO c##test-user1 CONTAINER=ALL
                              *
ERROR at line 1:
ORA-00933: SQL command not properly ended


SQL> GRANT c##test_role1 TO c##test_user1 CONTAINER=ALL;

Grant succeeded.

SQL> alter session set container=pdb1;

Session altered.

SQL> grant c##test_role1 TO test_user3;

Grant succeeded.

SQL>

---Local Roles

[oracle@linux7 admin]$ sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Tue Feb 24 21:35:35 2026
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> alter session set container=pdb1;

Session altered.

SQL> create ROLE test_role1;

Role created.

SQL> grant create session to test_role1;

Grant succeeded.

SQL> GRANT test_role1 to c##test_user1;

Grant succeeded.

SQL> GRANT test_role1 to test_user3
  2  ;

Grant succeeded.

SQL>




--GÁN QUY?N, ROLE CHO COMMON VÀ LOCAL USER 

[oracle@linux7 admin]$ sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Tue Feb 24 21:46:57 2026
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> GRANT CREATE SESSION TO c##test_user1 CONTAINER=ALL;

Grant succeeded.

SQL> GRANT CREATE SESSION TO c##test_role1 CONTAINER=ALL;

Grant succeeded.

SQL> GRANT c##test_role1 TO c##test_user1 CONTAINER=ALL;

Grant succeeded.

SQL> alter session set container=pdb1;

Session altered.

SQL> GRANT CREATE SESSION TO test_user3;

Grant succeeded.

SQL> GRANT CREATE SESSION TO test_role1;

Grant succeeded.

SQL> GRANT test_role1 TO test_user3;

Grant succeeded.

SQL>

---Bai2------
--1. Check
select sid, serial#, username, osuser, machine from v$session where username is not NULL;

select username, account_status, expiry_date, profile from dba_users;

--2. Create User
CREATE USER BINHTV IDENTIFIED BY binhtv DEFAULT TABLESPACE USERS;


GRANT CONNECT,RESOURCE, DBA TO BINHTV

CREATE USER sidney 
    IDENTIFIED BY out_standing1 
    DEFAULT TABLESPACE USERS 
    QUOTA 10M ON system 
    TEMPORARY TABLESPACE temp
    QUOTA 5M ON system 
    PROFILE default 
    PASSWORD EXPIRE;
    
    
    SQL> alter user ecartman identified by newpassword123#;
SP2-0640: Not connected
SQL> create user ecartman identified by newpassword123#;
SP2-0640: Not connected
SQL> exit
[oracle@linux7 admin]$ sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Tue Feb 24 22:36:18 2026
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> alter session set container=pdb1;

Session altered.

SQL> create user ecartman identified by newpassword123#;

User created.

SQL> alter user ecartman identified by newpassword;

User altered.

SQL> ALTER USER sidney ACCOUNT LOCK;

User altered.

SQL> ALTER USER sidney ACCOUNT UNLOCK;

User altered.

SQL> DROP USER sidney CASCADE;

User dropped.

SQL>

---Bai 03-----------
select * from dictionary ORDER BY TABLE_NAME;


select * from DBA_SYS_PRIVS where grantee like 'DBA';	

select * from DBA_ROLE_PRIVS where granted_role='DBA'; 

select * from dba_tab_privs where grantee like 'SYSTEM'; 

---Qu?n lý Profile trong Oracle Database-------------

https://www.tranvanbinh.vn/2020/11/quan-ly-profile.html?fbclid=IwZXh0bgNhZW0CMTAAYnJpZBEyMXNDS2pHOUxEYnhhQ1JxWHNydGMGYXBwX2lkEDIyMjAzOTE3ODgyMDA4OTIAAR5t8wpv8f3LP6JriVAm6WGS9JknNCTRyHh_JKC3_opzPWmVy-6JOXs6umeV6A_aem_1mQpMXK4peIiZEVldbgcpg

--In CDB
Profile dùng chung toàn CDB g?i là COMMON PROFILE
Tên ph?i b?t ??u b?ng prefix c?a parameter:

SHOW PARAMETER common_user_prefix;
-->C##
--N?u mu?n t?o LOCAL profile (ch? trong PDB)
alter session set container=pdb1;


	CREATE PROFILE PDB1_TEST_PROFILE LIMIT
	  SESSIONS_PER_USER 200
	  CPU_PER_SESSION DEFAULT
	  CPU_PER_CALL DEFAULT
	  CONNECT_TIME DEFAULT
	  IDLE_TIME DEFAULT
	  LOGICAL_READS_PER_SESSION DEFAULT
	  LOGICAL_READS_PER_CALL DEFAULT
	  COMPOSITE_LIMIT DEFAULT
	  PRIVATE_SGA DEFAULT
	  FAILED_LOGIN_ATTEMPTS DEFAULT
	  PASSWORD_LIFE_TIME DEFAULT
	  PASSWORD_REUSE_TIME DEFAULT
	  PASSWORD_REUSE_MAX DEFAULT
	  PASSWORD_LOCK_TIME DEFAULT
	  PASSWORD_GRACE_TIME DEFAULT
	  PASSWORD_VERIFY_FUNCTION DEFAULT;
      
      
--Check profiles      
Select * from dba_profiles

	ALTER PROFILE PDB1_TEST_PROFILE 
   LIMIT PASSWORD_REUSE_TIME 90 
   PASSWORD_REUSE_MAX UNLIMITED

---------------------------------------
--Qu?n lý Role trong Oracle Database

1. Dinh nghia nhom quyen
	DBA_ROLES	DS role                            
	DBA_ROLE_PRIVS 	- Role gán cho user
	USER_ROLE_PRIVS  	- Role gán cho user hi?n t?i
	ROLE_SYS_PRIVS	- DS system privileges of roles
    
ROLE:	PRIVILEGES:
CONNECT	ALTER SESSION
		CREATE CLUSTER 
		CREATE DATABASE LINK
		CREATE SEQUENCE
		CREATE SESSION
		CREATE SYNONYM
		CREATE TABLE
		CREATE VIEW
	RESOURCE	CREATE CLUSTER
		CREATE PROCEDURE
		CREATE SEQUENCE
		CREATE TABLE
		CREATE TRIGGER
	DBA	ALL PRIVILEGES WITH ADMIN OPTION
		(allows grants to other users or roles)
	EXP_FULL_DATABASE	SELECT ANY TABLE, BACKUP ANY TABLE.
		INSERT, DELETE, and UPDATE on the tables
		SYS.INCVID, SYS.INCFIL, and SYS.INCEXP
	IMP_FULL_DATABASE	BECOME USER 
		WRITEDOWN (trusted Oracle only)

--list all role
Select * from dba_roles; 

SELECT * FROM SESSION_ROLES; 

--Listing All Role Grants for User
Select * from DBA_ROLE_PRIVS;

--role ?ã gán cho user hi?n t?i
select * from USER_ROLE_PRIVS;


select * from ROLE_ROLE_PRIVS

--CREATE ROLE
show pdbs;

alter session set container=PDB1;

CREATE ROLE dw_manager;

CREATE ROLE dw_manager_2 IDENTIFIED BY warehouse; 

--ALTER ROLE
--Changing Role Identification: 
ALTER ROLE dw_manager_2 NOT IDENTIFIED;
--Changing a Role Password
ALTER ROLE dw_manager IDENTIFIED BY data;

--Application Roles ????
ALTER ROLE dw_manager IDENTIFIED USING hr.admin;

--DROP ROLE

DROP ROLE dw_manager; 

--SET ROLE
---To enable the role dw_manager identified by the password warehouse for your current session, issue the following statement:
SET ROLE dw_manager IDENTIFIED BY warehouse; 

--To enable all roles granted to you for the current session, issue the following statement:
SET ROLE ALL;

--To enable all roles granted to you except dw_manager, issue the following statement:
SET ROLE ALL EXCEPT dw_manager;

--To disable all roles granted to you for the current session, issue the following statement:
SET ROLE NONE; 



