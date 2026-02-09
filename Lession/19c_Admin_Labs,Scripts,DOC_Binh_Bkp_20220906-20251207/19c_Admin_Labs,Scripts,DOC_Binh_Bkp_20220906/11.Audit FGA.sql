-- 1.Check Policy da duoc cau hinh
select * from DBA_AUDIT_POLICIES;

SQL> show parameter audit; 

--audit_trail                       NONE


select * from hr.employees;

/***** 2.ADD *****/
BEGIN
  DBMS_FGA.add_policy(
    object_schema   => 'HR',
    object_name     => 'EMPLOYEES',
    policy_name     => 'FGA_EMPLOYEES',
    --AUDIT_CONDITION => 'SYS.check_ip_machine = 1',
    --audit_condition => SYS_CONTEXT('USERENV','SESSION_USER') <> 'BINHTV',
    statement_types => 'SELECT, INSERT,UPDATE,DELETE'
    );
END;

/***** 3.ROLLBACK: DISABLE, DROP*****/
-- Disable

BEGIN
  DBMS_FGA.disable_policy(
    object_schema   => 'HR',
    object_name     => 'EMPLOYEES',
    policy_name     => 'FGA_EMPLOYEES');
END;
/

BEGIN
  DBMS_FGA.enable_policy(
    object_schema   => 'HR',
    object_name     => 'EMPLOYEES',
    policy_name     => 'FGA_EMPLOYEES');
END;
/

-- Drop
BEGIN
  DBMS_FGA.drop_policy(
    object_schema   => 'HR',
    object_name     => 'EMPLOYEES',
    policy_name     => 'FGA_EMPLOYEES');
END;

--4.TEST
-- OAZ16
SELECT *
  FROM hr.employees
  WHERE
    department_id = 1;
    
grant all on hr.employees to oaz12;

grant all on hr.employees to user2;

--User2
SELECT *
  FROM hr.employees
  WHERE
    department_id = 1;
    
update hr.employees set email='JWHALEN_NEW' where department_id = 10;
commit;

-- 5.Check log da audit (bang sys.fga_log$)
select * from dba_fga_audit_trail 
where  timestamp > sysdate-1 order by timestamp desc

select * from sys.fga_log$ where  ntimestamp# > sysdate-1 order by ntimestamp# desc;

select * from DBA_COMMON_AUDIT_TRAIL;

--truncate table fga_log$;