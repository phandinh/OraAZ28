-- User1
-- 
create user user1 identified by oracle;
grant connect, resource, dba to user1;

create user user2 identified by oracle;
grant connect, resource, dba to user2;

create user hr identified by oracle;
grant connect, resource, dba to hr;


create table hr.departments (
department_id number constraint department_pk primary key,
    name                           varchar2(255),
    location                       varchar2(255),
    country                        varchar2(255)
)
;


create table hr.employees (
    department_id                  number
                                   constraint employees_department_id_fk
                                   references hr.departments on delete cascade,
    name                           varchar2(255),
    email                          varchar2(255),
    job                            varchar2(255),
    hiredate                       date
)
;

insert into departments  values (1,
    'Corporate Counsel',
    'Tanquecitos',
    'United States'
);

insert into departments  values (2,
    'Customer Support',
    'Sugarloaf',
    'United States'
);

insert into departments  values (3,
    'Electronic Data Interchange',
    'Dale City',
    'United States'
);

insert into departments  values (4,
    'Quality Assurance',
    'Grosvenor',
    'United States'
);

insert into departments  values (5,
    'Transportation',
    'Riverside',
    'United States'
);

insert into departments  values (6,
    'Finance',
    'Ridgeley',
    'United States'
);

insert into departments  values (7,
    'Real World Testing',
    'Ashley Heights',
    'United States'
);

insert into departments  values (8,
    'Human Resources',
    'Monfort Heights',
    'United States'
);

insert into departments  values (9,
    'Master Data Management',
    'Point Marion',
    'United States'
);

insert into departments  values (10,
    'Enteprise Resource Planning',
    'Eldon',
    'United States'
);

commit;
-- load data
 
insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Gricelda Luebbers',
    'gricelda.luebbers@aaab.com',
    'Support Specialist',
    sysdate - 17
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Dean Bollich',
    'dean.bollich@aaac.com',
    'Finance Analyst',
    sysdate - 29
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Milo Manoni',
    'milo.manoni@aaad.com',
    'Sales Representative',
    sysdate - 48
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Laurice Karl',
    'laurice.karl@aaae.com',
    'Systems Designer',
    sysdate - 49
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'August Rupel',
    'august.rupel@aaaf.com',
    'Solustions Specialist',
    sysdate - 1
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Salome Guisti',
    'salome.guisti@aaag.com',
    'President',
    sysdate - 95
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Lovie Ritacco',
    'lovie.ritacco@aaah.com',
    'Sustaining Engineering',
    sysdate - 8
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Chaya Greczkowski',
    'chaya.greczkowski@aaai.com',
    'Sustaining Engineering',
    sysdate - 36
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Twila Coolbeth',
    'twila.coolbeth@aaaj.com',
    'Programmer Analyst',
    sysdate - 41
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Carlotta Achenbach',
    'carlotta.achenbach@aaak.com',
    'Programmer',
    sysdate - 56
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Jeraldine Audet',
    'jeraldine.audet@aaal.com',
    'Data Architect',
    sysdate - 73
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'August Arouri',
    'august.arouri@aaam.com',
    'Cloud Architect',
    sysdate - 92
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Ward Stepney',
    'ward.stepney@aaan.com',
    'Help Desk Specialist',
    sysdate - 50
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Ayana Barkhurst',
    'ayana.barkhurst@aaao.com',
    'System Operations',
    sysdate - 45
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Luana Berends',
    'luana.berends@aaap.com',
    'Webmaster',
    sysdate - 49
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Lecia Alvino',
    'lecia.alvino@aaaq.com',
    'Business Applications',
    sysdate - 29
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Joleen Himmelmann',
    'joleen.himmelmann@aaar.com',
    'Manufacturing and Distribution',
    sysdate - 75
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Monty Kinnamon',
    'monty.kinnamon@aaas.com',
    'Security Specialist',
    sysdate - 53
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Dania Grizzard',
    'dania.grizzard@aaat.com',
    'Executive Engineer',
    sysdate - 83
);

insert into employees (
    department_id,
    name,
    email,
    job,
    hiredate
) values (
    1,
    'Inez Yamnitz',
    'inez.yamnitz@aaau.com',
    'Systems Software Engineer',
    sysdate - 91
);

commit;

select * from hr.employees;

-- Cau 1:
alter table  hr.employees add salary number default 1000;

--> Khac nhau voi cau ben dưới như nào?
alter table  hr.employees add salary number;
alter table  hr.employees modify salary default 1000;

update hr.employees  set salary=2000;
SELECT s.inst_id,s.sid, s.serial#,s.sql_id,username U_NAME, owner OBJ_OWNER,
object_name, object_type, s.osuser, s.machine,
DECODE(l.block,
  0, 'Not Blocking',
  1, 'Blocking',
  2, 'Global') STATUS,
  DECODE(v.locked_mode,
    0, 'None',
    1, 'Null',
    2, 'Row-S (SS)',
    3, 'Row-X (SX)',
    4, 'Share',
    5, 'S/Row-X (SSX)',
    6, 'Exclusive', TO_CHAR(lmode)
  ) MODE_HELD,
  decode(l.TYPE,
'MR', 'Media Recovery',
'RT', 'Redo Thread',
'UN', 'User Name',
'TX', 'Transaction',
'TM', 'DML',
'UL', 'PL/SQL User Lock',
'DX', 'Distributed Xaction',
'CF', 'Control File',
'IS', 'Instance State',
'FS', 'File Set',
'IR', 'Instance Recovery',
'ST', 'Disk Space Transaction',
'TS', 'Temp Segment',
'IV', 'Library Cache Invalidation',
'LS', 'Log Start or Switch',
'RW', 'Row Wait',
'SQ', 'Sequence Number',
'TE', 'Extend Table',
'TT', 'Temp Table',l.type) lock_type
FROM gv$locked_object v, dba_objects d,
gv$lock l, gv$session s
WHERE v.object_id = d.object_id
AND (v.object_id = l.id1)
AND v.session_id = s.sid
and object_name like upper('%EMPLOYEES')
--and username like upper('trieunv')
ORDER BY username, session_id;

rollback;

SELECT s.inst_id,s.sid, s.serial#,s.sql_id,username U_NAME, owner OBJ_OWNER,
object_name, object_type, s.osuser, s.machine,
DECODE(l.block,
  0, 'Not Blocking',
  1, 'Blocking',
  2, 'Global') STATUS,
  DECODE(v.locked_mode,
    0, 'None',
    1, 'Null',
    2, 'Row-S (SS)',
    3, 'Row-X (SX)',
    4, 'Share',
    5, 'S/Row-X (SSX)',
    6, 'Exclusive', TO_CHAR(lmode)
  ) MODE_HELD,
  decode(l.TYPE,
'MR', 'Media Recovery',
'RT', 'Redo Thread',
'UN', 'User Name',
'TX', 'Transaction',
'TM', 'DML',
'UL', 'PL/SQL User Lock',
'DX', 'Distributed Xaction',
'CF', 'Control File',
'IS', 'Instance State',
'FS', 'File Set',
'IR', 'Instance Recovery',
'ST', 'Disk Space Transaction',
'TS', 'Temp Segment',
'IV', 'Library Cache Invalidation',
'LS', 'Log Start or Switch',
'RW', 'Row Wait',
'SQ', 'Sequence Number',
'TE', 'Extend Table',
'TT', 'Temp Table',l.type) lock_type
FROM gv$locked_object v, dba_objects d,
gv$lock l, gv$session s
WHERE v.object_id = d.object_id
AND (v.object_id = l.id1)
AND v.session_id = s.sid
and object_name like upper('%EMPLOYEES')
--and username like upper('trieunv')
ORDER BY username, session_id;

commit;

-- Cau 2:
alter table  hr.employees add salary_max number;
--alter table  hr.employees modify salary default 1000;
--


UPDATE hr.employees
    SET salary=salary+101
    WHERE name='Dean Bollich';
    
    rollback;

UPDATE hr.employees
    SET salary=salary+102
    WHERE name='Dean Bollich';

SELECT s.inst_id,s.sid, s.serial#,s.sql_id,username U_NAME, owner OBJ_OWNER,
object_name, object_type, s.osuser, s.machine,
DECODE(l.block,
  0, 'Not Blocking',
  1, 'Blocking',
  2, 'Global') STATUS,
  DECODE(v.locked_mode,
    0, 'None',
    1, 'Null',
    2, 'Row-S (SS)',
    3, 'Row-X (SX)',
    4, 'Share',
    5, 'S/Row-X (SSX)',
    6, 'Exclusive', TO_CHAR(lmode)
  ) MODE_HELD,
  decode(l.TYPE,
'MR', 'Media Recovery',
'RT', 'Redo Thread',
'UN', 'User Name',
'TX', 'Transaction',
'TM', 'DML',
'UL', 'PL/SQL User Lock',
'DX', 'Distributed Xaction',
'CF', 'Control File',
'IS', 'Instance State',
'FS', 'File Set',
'IR', 'Instance Recovery',
'ST', 'Disk Space Transaction',
'TS', 'Temp Segment',
'IV', 'Library Cache Invalidation',
'LS', 'Log Start or Switch',
'RW', 'Row Wait',
'SQ', 'Sequence Number',
'TE', 'Extend Table',
'TT', 'Temp Table',l.type) lock_type
FROM gv$locked_object v, dba_objects d,
gv$lock l, gv$session s
WHERE v.object_id = d.object_id
AND (v.object_id = l.id1)
AND v.session_id = s.sid
and object_name like upper('%EMPLOYEES')
--and username like upper('trieunv')
ORDER BY username, session_id;
 
select * from  hr.employees where name='Dean Bollich';

--commit;

UPDATE hr.employees
    SET salary=salary+102
    WHERE name='Milo Manoni';
      
-- User2 
UPDATE employees
    SET salary=salary*1.1
    WHERE name='Dean Bollich';
    
    commit;
    
--    rollback;

-- Giai quyet lock
SELECT sid, serial#, username
  FROM v$session WHERE sid IN
  (SELECT blocking_session FROM v$session);
  
ALTER SYSTEM KILL SESSION '277,48698' immediate

SELECT /*SID*/  'kill -9 ' || spid a, a.INST_ID,A.SQL_ID,A.SID, A.SERIAL#, a.USERNAME, a.STATUS,A.SCHEMANAME,a.OSUSER,A.MACHINE,A.PROGRAM,A.TYPE,A.LOGON_TIME,a.prev_exec_start,BACKGROUND
FROM gv$session a, gv$process b 
WHERE b.addr = a.paddr   
AND a.inst_id=b.inst_id 
--and b.inst_id=2
AND a.sid in (
257
)
and type='USER'
order by inst_id;

-- DEADLOCK
--User1:
UPDATE hr.employees
    SET salary=salary+102
    WHERE name='Milo Manoni';
      
-- User2 
UPDATE employees
    SET salary=salary*1.1
    WHERE name='Dean Bollich';
    
--User1:
UPDATE employees
    SET salary=salary*1.1
    WHERE name='Dean Bollich';
    
-- User2   
    UPDATE hr.employees
    SET salary=salary+102
    WHERE name='Milo Manoni';


   
    