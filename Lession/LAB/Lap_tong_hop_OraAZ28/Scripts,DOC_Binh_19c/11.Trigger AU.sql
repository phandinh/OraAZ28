create table sys.audit_employees(os_user varchar2(20), event_date date, ip_address varchar2(30), emp_salold_salnew varchar2(50));

CREATE OR REPLACE TRIGGER sys.hrsalary_audit    
AFTER UPDATE OF salary    
ON hr.employees     
REFERENCING NEW AS NEW OLD AS OLD     FOR EACH ROW  
BEGIN 
IF :old.salary != :new.salary 
THEN     
INSERT INTO sys.audit_employees       
VALUES (sys_context('userenv','os_user'), sysdate,      sys_context('userenv','ip_address'),     :new.employee_id ||
            ' salary changed from '||:old.salary||      ' to '||:new.salary);
  END IF; 
  END;
/

select * from sys.audit_employees   ;


