--show pdbs;

--alter session set container=PDB1;

create user oaz28 identified by oracle;

grant connect, resource, dba to oaz28;

create tablespace DATA2024 datafile size 1m autoextend on next 10m;

CREATE TABLE oaz28.table1
    (id                     VARCHAR2(15) NOT NULL,
    create_datetime              DATE NOT NULL,    
    col2                    VARCHAR2(20),
    col3                 NUMBER(10,2)
)
TABLESPACE DATA
PARTITION BY RANGE (create_datetime)
(
  PARTITION DATA20230101 VALUES LESS THAN (TO_DATE('2023-01-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
  TABLESPACE DATA2023
);

---


DECLARE
   v_nam          NUMBER (4) := 2023; --2014
   v_tablename    VARCHAR2 (50) := 'table1';
   v_date_from   date    := to_date('02/01/2023','dd/mm/yyyy');
   v_date_to     date    := to_date('31/12/2023','dd/mm/yyyy');
   v_numday     number(5);
   v_tablespace varchar2(50):='DATA2023';
BEGIN
    DBMS_OUTPUT.ENABLE (buffer_size => NULL);
   v_numday:=v_date_to-v_date_from; 
   FOR i IN 0 .. v_numday
   LOOP
      DBMS_OUTPUT.put_line ('alter table oaz28.'|| v_tablename || ' add PARTITION DATA'||to_char(v_date_from+i,'YYYYMMDD')||' VALUES LESS THAN (TO_DATE('''|| to_char(v_date_from+i+1,'YYYY-MM-DD')||' 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) LOGGING TABLESPACE '||v_tablespace||';');      
   END LOOP;
END;

---------------------------------

DECLARE
   v_nam          NUMBER (4) := 2024; 
   v_tablename    VARCHAR2 (50) := 'table1';
   v_date_from   date    := to_date('01/01/2024','dd/mm/yyyy');
   v_date_to     date    := to_date('31/12/2024','dd/mm/yyyy');
   v_numday     number(5);
   v_tablespace varchar2(50):='DATA2024';
BEGIN
    DBMS_OUTPUT.ENABLE (buffer_size => NULL);
   v_numday:=v_date_to-v_date_from; 
   FOR i IN 0 .. v_numday
   LOOP
      DBMS_OUTPUT.put_line ('alter table oaz28.'|| v_tablename || ' add PARTITION DATA'||to_char(v_date_from+i,'YYYYMMDD')||' VALUES LESS THAN (TO_DATE('''|| to_char(v_date_from+i+1,'YYYY-MM-DD')||' 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) LOGGING TABLESPACE '||v_tablespace||';');
   END LOOP;
END;

-- Check lai cac partition vua tao
select * from dba_tab_partitions where table_owner ='OAZ28'
and table_name='TABLE1'
order by partition_name;


select * from  oaz28.table1 where create_datetime>sysdate-2
and id='1';

-- local index: index partition
create index  oaz28.table1_I1 on oaz28.table1(id) LOCAL parallel 8 nologging online;


--alter index oaz28.table1_I1 noparallel;

select * from  oaz28.table1 where create_datetime>sysdate-2
and id='1';

-- global index = global non-partition
create index  oaz28.table1_I2 on oaz28.table1(col2)  parallel 8 nologging online;