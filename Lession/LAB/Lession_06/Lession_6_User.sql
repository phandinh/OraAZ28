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
select sid, serial#, username, osuser, machine from v$session where username is not NULL;

select username, account_status, expiry_date, profile from dba_users;


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



