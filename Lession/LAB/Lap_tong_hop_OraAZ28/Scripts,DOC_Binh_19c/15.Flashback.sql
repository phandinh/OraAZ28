    
--FLASHBACK
select * from v$parameter where name like '%undo%';

select * from hr.employees;

--delete   hr.employees where  employee_id > 102;

update hr.employees set  first_name=first_name ||'_New'; 

commit;

--FLASHBACK QUERY1
create table hr.xxx_employees_20240701_21h15 as select * FROM   hr.employees AS OF TIMESTAMP TO_TIMESTAMP('20240701 21:15:00', 'YYYYMMDD HH24:MI:SS');

select * from hr.xxx_employees_20240701_21h15;

create table hr.xxx_employees_20231110_21h40 as select * FROM   hr.employees AS OF TIMESTAMP TO_TIMESTAMP('20231110 21:40:00', 'YYYYMMDD HH24:MI:SS');

select * from hr.xxx_employees_20231110_21h40;

select * from hr.employees;

insert into hr.employees  select * from hr.xxx_employees_20231110_21h45;

commit;

select * from hr.employees;

alter table hr.employees rename to xxx_employees;

alter table hr.xxx_employees_20231110_21h40 rename to employees;

select * from hr.employees;

--Flashback table
alter table hr.employees enable row movement;

FLASHBACK TABLE hr.employees TO TIMESTAMP TO_TIMESTAMP('20240701 21:15:00', 'YYYYMMDD HH24:MI:SS');

select * from hr.employees;