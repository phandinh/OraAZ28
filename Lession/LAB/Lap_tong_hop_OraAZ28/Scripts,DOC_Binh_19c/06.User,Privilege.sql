-- 1.TAO USER COMMON c##oaz23
create user c##oaz23 identified by oracle container=all;

-- Tạo xong ấn F4 kiểm tra lại

grant connect, RESOURCE , dba to c##oaz23 container=all;

-- GRANT
-- System Privilege
select * from dba_sys_privs where grantee ='C##oaz23';

-- Object privilege
select * from dba_tab_privs where grantee='C##oaz23';

-- Role:DBA, CONNECT, RESOURCE

select * from dba_role_privs where grantee='C##oaz23';

-- Vao CDB bang c##oaz23: Session
select * from session_privs;

select * from session_roles;

-- Gan quyen
grant select on SYS.FGA_LOG$ to c##oaz23  WITH admin option;

grant alter any procedure to c##oaz23 container=all;


-- Quyen view moi package:
        
grant SELECT ANY DICTIONARY to c##oaz23;

grant debug any procedure to c##oaz23;

--REVOKE
revoke debug any procedure from c##oaz23;

-- Vao PDB1 bang c##oaz23


-- 2.TAO USER LOCAL TRONG PDB1
-- Vao c##az22 TNS db19c_pdb1 de tao:
create user oaz23 identified by oracle;

grant connect, resource, dba to oaz23;

-- Tuong tu

-- PROFILE
create PROFILE "PROFILE_USER_oaz23" LIMIT
  SESSIONS_PER_USER 3
  CPU_PER_SESSION UNLIMITED
  CPU_PER_CALL UNLIMITED
  CONNECT_TIME UNLIMITED
  IDLE_TIME UNLIMITED
  LOGICAL_READS_PER_SESSION UNLIMITED
  LOGICAL_READS_PER_CALL UNLIMITED
  COMPOSITE_LIMIT UNLIMITED
  PRIVATE_SGA UNLIMITED
  FAILED_LOGIN_ATTEMPTS UNLIMITED
  INACTIVE_ACCOUNT_TIME UNLIMITED
  PASSWORD_LIFE_TIME 45
  PASSWORD_REUSE_TIME UNLIMITED
  PASSWORD_REUSE_MAX UNLIMITED
  PASSWORD_LOCK_TIME UNLIMITED
  PASSWORD_GRACE_TIME UNLIMITED
  PASSWORD_VERIFY_FUNCTION Default;
  
create PROFILE "PROFILE_APP_oaz23" LIMIT
  SESSIONS_PER_USER UNLIMITED
  CPU_PER_SESSION UNLIMITED
  CPU_PER_CALL UNLIMITED
  CONNECT_TIME UNLIMITED
  IDLE_TIME UNLIMITED
  LOGICAL_READS_PER_SESSION UNLIMITED
  LOGICAL_READS_PER_CALL UNLIMITED
  COMPOSITE_LIMIT UNLIMITED
  PRIVATE_SGA UNLIMITED
  FAILED_LOGIN_ATTEMPTS UNLIMITED
  INACTIVE_ACCOUNT_TIME UNLIMITED
  PASSWORD_LIFE_TIME UNLIMITED
  PASSWORD_REUSE_TIME UNLIMITED
  PASSWORD_REUSE_MAX UNLIMITED
  PASSWORD_LOCK_TIME UNLIMITED
  PASSWORD_GRACE_TIME UNLIMITED
  PASSWORD_VERIFY_FUNCTION Default;
  
ALTER USER oaz23
 PROFILE PROFILE_USER_oaz23;
 
-- Gan quyen tu oaz14 --> tab18

--grant UNLIMITED TABLESPACE to oaz23;
select 'grant ' || privilege || ' to TEST;' from dba_sys_privs
where grantee='oaz23';

--grant ALTER on HR.EMPLOYEES to tab18;
--grant DELETE on HR.EMPLOYEES to tab18;
--grant INDEX on HR.EMPLOYEES to tab18;
--grant INSERT on HR.EMPLOYEES to tab18;
--grant SELECT on HR.EMPLOYEES to tab18;
--grant UPDATE on HR.EMPLOYEES to tab18;
--grant REFERENCES on HR.EMPLOYEES to tab18;
--grant READ on HR.EMPLOYEES to tab18;
--grant ON COMMIT REFRESH on HR.EMPLOYEES to tab18;
--grant QUERY REWRITE on HR.EMPLOYEES to tab18;
--grant DEBUG on HR.EMPLOYEES to tab18;
--grant FLASHBACK on HR.EMPLOYEES to tab18;

select 'grant ' || privilege || ' on ' || owner||'.' || table_name ||' to oaz23;' from dba_tab_privs
where grantee='oaz23';

grant select on sys.fga_log$ to oaz23;

select * from  dba_tab_privs
where grantee='oaz23';

---ROLE PDB----

CREATE ROLE ROLE_oaz23 NOT IDENTIFIED;

alter role ROLE_oaz23 identified by oracle;

grant select any table, drop any table, insert any table, delete any table to role_oaz23;

grant all on sys.fga_log$ to role_oaz23;


grant role_oaz23 to oaz23;

grant role_oaz23 to c##oaz23;

---ROLE CDB----

CREATE ROLE c##ROLE_oaz23 NOT IDENTIFIED;

alter role c##ROLE_oaz23 identified by oracle;

grant select any table, drop any table, insert any table, delete any table to c##role_oaz23;

grant all on sys.fga_log$ to c##role_oaz23;


grant c##role_oaz23 to c##oaz23;

-- Vao PDB
grant c##role_oaz23 to oaz23;


 


