--Thủ tục tạo bảng partition theo ngày trong Oracle Database
--Thủ tục tạo partition theo ngày trong Oracle Database oaz12
-- create user oaz12 identified by oracle;
-- grant connect, resource, dba to oaz12;

-- 1.Tao bang
CREATE TABLE oaz12.table1
    (id                           VARCHAR2(15) NOT NULL,
    start_datetime                  DATE NOT NULL,    
    col3                    VARCHAR2(20),
    col4                 NUMBER(10,2)
)
TABLESPACE DATA
PARTITION BY RANGE (start_datetime)
(
  PARTITION DATA20210101 VALUES LESS THAN (TO_DATE('2021-01-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
  TABLESPACE DATA2021
);

--2.Add them partition
DECLARE
   v_nam          NUMBER (4) := 2021; --2021
   v_tablename    VARCHAR2 (50) := 'table1';
   v_date_from   date    := to_date('02/01/2021','dd/mm/yyyy');
   v_date_to     date    := to_date('31/12/2021','dd/mm/yyyy');
   v_numday     number(5);
   v_tablespace varchar2(50):='DATA2021';
BEGIN
   v_numday:=v_date_to-v_date_from; 
   FOR i IN 0 .. v_numday
   LOOP
      DBMS_OUTPUT.put_line ('alter table oaz12.'|| v_tablename || ' add PARTITION DATA'||to_char(v_date_from+i,'YYYYMMDD')||' VALUES LESS THAN (TO_DATE('''|| to_char(v_date_from+i+1,'YYYY-MM-DD')||' 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) LOGGING TABLESPACE '||v_tablespace||';');
   END LOOP;
END;

DECLARE
   v_nam          NUMBER (4) := 2022; --2022
   v_tablename    VARCHAR2 (50) := 'table1';
   v_date_from   date    := to_date('01/01/2022','dd/mm/yyyy');
   v_date_to     date    := to_date('31/12/2022','dd/mm/yyyy');
   v_numday     number(5);
   v_tablespace varchar2(50):='DATA2021';
BEGIN
   v_numday:=v_date_to-v_date_from; 
   FOR i IN 0 .. v_numday
   LOOP
      DBMS_OUTPUT.put_line ('alter table oaz12.'|| v_tablename || ' add PARTITION DATA'||to_char(v_date_from+i,'YYYYMMDD')||' VALUES LESS THAN (TO_DATE('''|| to_char(v_date_from+i+1,'YYYY-MM-DD')||' 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) LOGGING TABLESPACE '||v_tablespace||';');
   END LOOP;
END;

-- Vao muc DBMS_Ouput cua TOAD:

--3.Tao index
create index  oaz12.table1_I1 on oaz12.table1(id) local parallel 8 nologging online;

create index  oaz12.table1_I2 on oaz12.table1(col3)  parallel 8 nologging online;

alter table  oaz12.table1 truncate partition data20210101;

alter table  oaz12.table1 drop partition data20210101;

alter table  oaz12.table1 drop partition data20220101;

select * from dba_indexes where owner='OAZ12'
and table_name='TABLE1';

select rowid, a.* from oaz12.table1 a;

SET DEFINE OFF;
Insert into OAZ12.TABLE1
   (ID, START_DATETIME, COL3, COL4)
 Values
   ('1', TO_DATE('02/01/2021', 'DD/MM/YYYY'), '21', 21);
COMMIT;

select rowid, a.* from oaz12.table1  partition(data20210102) a;

alter table  oaz12.table1 truncate partition data20210102;

alter table  oaz12.table1 truncate partition data20210102;

-- Khi do index unusable

-- Insert thu du lieu
SET DEFINE OFF;

Insert into OAZ12.TABLE1
   (ID, START_DATETIME, COL3, COL4)
 Values
   ('2', TO_DATE('02/01/2021', 'DD/MM/YYYY'), '2_21', 21);
   
COMMIT;

Insert into OAZ12.TABLE1
   (ID, START_DATETIME, COL3, COL4)
 Values
   ('2', TO_DATE('03/01/2021', 'DD/MM/YYYY'), '2_21', 21);
   
COMMIT;

select rowid, a.* from oaz12.table1  partition(data20210102) a;

select rowid, a.* from oaz12.table1  partition(data20210103) a;

Insert into OAZ12.TABLE1
   (ID, START_DATETIME, COL3, COL4)
 Values
   ('2', TO_DATE('04/01/2022', 'DD/MM/YYYY'), '31_', 22);
   
COMMIT;

select * from dba_ind_partitions where index_owner='CUS'
and index_name='TABLE1_I1'
and status!='USABLE';

alter index  oaz12.table1_I1 nologging noparallel;

PDB1(3):Some indexes or index [sub]partitions of table OAZ12.TABLE1 have been marked unusable

alter table  oaz12.table1 drop partition data20210102;


Insert into OAZ12.TABLE1
   (ID, START_DATETIME, COL3, COL4)
 Values
   ('10', TO_DATE('02/01/2021', 'DD/MM/YYYY'), '31_', 22);
   
COMMIT;

select * from oaz12.table1;

drop index oaz12.table1_i2;

create index  oaz12.table1_I2 on oaz12.table1(col3)  parallel 8 nologging online local;

alter index  oaz12.table1_I1 noparallel;

alter index  oaz12.table1_I2 noparallel;

--3.Rebuild index ve tablespace INDX
DECLARE
   v_date_from   date    := to_date('01/01/2021','dd/mm/yyyy');
   v_date_to     date    := to_date('31/12/2022','dd/mm/yyyy');
   v_numday     number;
   v_tablespace varchar2(50):='INDX';
   cursor c1 is
     select a.* from DBA_PART_INDEXES a, DBA_TAB_PARTITIONS b where a.owner=B.TABLE_OWNER  and a.table_name=B.TABLE_NAME  and b.table_owner='OAZ12' and b.table_name='TABLE1'  and a.index_name not like '%$%' and b.partition_name like '%20221231'  order by a.owner,a.index_name;
BEGIN
   v_numday:=v_date_to-v_date_from; 
   FOR i1 in c1
   LOOP
       FOR i IN 0 .. v_numday
       LOOP
            DBMS_OUTPUT.put_line ('alter index '||i1.owner||'.'||i1.index_name || ' REBUILD PARTITION DATA'||to_char(v_date_from+i,'YYYYMMDD')||' TABLESPACE '||v_tablespace||to_char(v_date_from+i,'YYYY')||' nologging parallel 8 online;');
       END LOOP;
   END LOOP;
END;

-- Set nologging noparallel
DECLARE
   cursor c1 is
        select distinct a.index_owner, a.index_name from DBA_ind_partitions a where  a.index_owner='oaz12' and a.index_name not like '%$%' and a.partition_name like '%20211231'  
        order by a.index_owner,a.index_name;
BEGIN
   FOR i1 in c1
   LOOP
            DBMS_OUTPUT.put_line ('alter index '||i1.index_owner||'.'||i1.index_name || ' nologging noparallel;');
   END LOOP;
END;