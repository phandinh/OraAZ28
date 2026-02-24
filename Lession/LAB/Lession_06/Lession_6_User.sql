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


