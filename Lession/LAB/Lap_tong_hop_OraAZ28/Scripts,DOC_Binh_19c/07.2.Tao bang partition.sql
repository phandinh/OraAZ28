--Thủ tục tạo bảng partition theo ngày trong Oracle Database
--Thủ tục tạo partition theo ngày trong Oracle Database

--drop table oaz20.table1;

create user oaz20 identified by oracle;

grant connect, resource, dba to oaz20;

-- 07.2.1.Tao bang
CREATE TABLE oaz20.table1
    (id                     VARCHAR2(15) NOT NULL,
    create_datetime              DATE NOT NULL,    
    col2                    VARCHAR2(20),
    col3                 NUMBER(10,2)
)
TABLESPACE DATA
PARTITION BY RANGE (create_datetime)
(
  PARTITION DATA20220101 VALUES LESS THAN (TO_DATE('2022-01-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
  TABLESPACE DATA2022
);

--07.2.2.Add them partition
--Add them partition 2022: Bôi đen và ấn F5 --> Vào DBMS Ouput copy nội dung và mở Tab mới để chạy 
DECLARE
   v_nam          NUMBER (4) := 2022; --2014
   v_tablename    VARCHAR2 (50) := 'table1';
   v_date_from   date    := to_date('02/01/2022','dd/mm/yyyy');
   v_date_to     date    := to_date('31/12/2022','dd/mm/yyyy');
   v_numday     number(5);
   v_tablespace varchar2(50):='DATA2022';
BEGIN
    DBMS_OUTPUT.ENABLE (buffer_size => NULL);
   v_numday:=v_date_to-v_date_from; 
   FOR i IN 0 .. v_numday
   LOOP
      DBMS_OUTPUT.put_line ('alter table oaz20.'|| v_tablename || ' add PARTITION DATA'||to_char(v_date_from+i,'YYYYMMDD')||' VALUES LESS THAN (TO_DATE('''|| to_char(v_date_from+i+1,'YYYY-MM-DD')||' 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) LOGGING TABLESPACE '||v_tablespace||';');      
   END LOOP;
END;

-- 07.2.3.Add them partition 2023: Bôi đen rồi F5 --> Vào DBMS Ouput copy nội dung và mở Tab mới để chạy 
DECLARE
   v_nam          NUMBER (4) := 2023; 
   v_tablename    VARCHAR2 (50) := 'table1';
   v_date_from   date    := to_date('01/01/2023','dd/mm/yyyy');
   v_date_to     date    := to_date('31/12/2023','dd/mm/yyyy');
   v_numday     number(5);
   v_tablespace varchar2(50):='DATA2023';
BEGIN
    DBMS_OUTPUT.ENABLE (buffer_size => NULL);
   v_numday:=v_date_to-v_date_from; 
   FOR i IN 0 .. v_numday
   LOOP
      DBMS_OUTPUT.put_line ('alter table oaz20.'|| v_tablename || ' add PARTITION DATA'||to_char(v_date_from+i,'YYYYMMDD')||' VALUES LESS THAN (TO_DATE('''|| to_char(v_date_from+i+1,'YYYY-MM-DD')||' 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) LOGGING TABLESPACE '||v_tablespace||';');
   END LOOP;
END;

--table1

-- Check lai cac partition vua tao
select * from dba_tab_partitions where table_owner ='OAZ20'
and table_name='TABLE1'
order by partition_name;

-- Hoac dua chuot vao table1 an nut F4

--3.Tao index
select * from  oaz20.table1 where create_datetime>sysdate-2
and id='1';

-- Go ctrl+P sẽ là explain plan

-- local: index partition
create index  oaz20.table1_I1 on oaz20.table1(id) LOCAL parallel 8 nologging online;

alter index oaz20.table1_I1 noparallel;

--Ctr+E: Explain Plan
select * from  oaz20.table1 where create_datetime>sysdate-2
and id='1';

-- global non-partition
create index  oaz20.table1_I2 on oaz20.table1(col2)  parallel 8 nologging online;

alter index oaz20.table1_I2 noparallel;

-- Them du lieu 01/01/2022, 02/01/2022
insert into oaz20.table1 values(5,to_date('01/01/2022','dd/mm/yyyy'),2,3);
commit;

select * from oaz20.table1;

alter table  oaz20.table1 truncate partition data20220101; -- Khi do index global table1_i2  unusable

insert into oaz20.table1 values(5,to_date('01/01/2022','dd/mm/yyyy'),2,3);

commit;

insert into oaz20.table1 values(5,to_date('02/01/2022','dd/mm/yyyy'),2,3);

commit;

insert into oaz20.table1 values(5,to_date('03/01/2022','dd/mm/yyyy'),2,3);

commit;


select * from oaz20.table1;

alter table  oaz20.table1 drop partition data20220101;

select * from oaz20.table1 where col2 = 3;

delete  oaz20.table1  where col2=2;

commit;

--oaz20	TABLE1_I2	UNUSABLE
select owner, index_name, status from dba_indexes where index_name='TABLE1_I2';

--insert into oaz20.table1 values(5,to_date('01/05/2021','dd/mm/yyyy'),2,3);
--commit;
--
--update oaz20.table1 set col2='col2';
--commit;

-- Cay index table1_i2 unusable: DML loi

 alter index oaz20.table1_I2 rebuild online;
 
 select * from oaz20.table1 where col2 = 3;

select * from dba_indexes where owner='OAZ20'
and table_name='TABLE1';

select * from dba_ind_partitions  where index_owner='OAZ20'
and index_name like 'TABLE1%'
order by 1,2,4;

insert into oaz20.table1 values(5,to_date('02/01/2022','dd/mm/yyyy'),2,3);
commit;

alter table  oaz20.table1 truncate partition data20220102 update global indexes;

alter table  oaz20.table1 drop partition data20220102 update global indexes;

alter table  oaz20.table1 drop partition data20220103;

select * from dba_ind_partitions 
where index_owner='OAZ20'
and index_name='TABLE1_I1'
--and status!='USABLE';

alter index  oaz20.table1_I1 nologging noparallel;

--3.Rebuild index ve tablespace INDX2022, INDX2023: Bôi đen đoạn dưới và ấn F5
--2022, 2023
DECLARE
   v_date_from   date    := to_date('01/01/2022','dd/mm/yyyy');
   v_date_to     date    := to_date('31/12/2023','dd/mm/yyyy');
   v_numday     number;
   v_tablespace varchar2(50):='INDX';
   cursor c1 is
     select a.* from DBA_PART_INDEXES a, DBA_TAB_PARTITIONS b where a.owner=B.TABLE_OWNER  and a.table_name=B.TABLE_NAME  and b.table_owner='OAZ20' and b.table_name='TABLE1'  and a.index_name not like '%$%' and b.partition_name like '%20231231'  order by a.owner,a.index_name;
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
        select distinct a.index_owner, a.index_name from DBA_ind_partitions a where  a.index_owner='OAZ20' and a.index_name not like '%$%' and a.partition_name like '%20231231'  
        order by a.index_owner,a.index_name;
BEGIN
   FOR i1 in c1
   LOOP
            DBMS_OUTPUT.put_line ('alter index '||i1.index_owner||'.'||i1.index_name || ' nologging noparallel;');
   END LOOP;
END;

alter index oaz20.TABLE1_I1 nologging noparallel;