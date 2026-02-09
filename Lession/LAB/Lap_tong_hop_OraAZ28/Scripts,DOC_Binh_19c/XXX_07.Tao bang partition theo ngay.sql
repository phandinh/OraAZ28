CREATE TABLE binhtv.tab1
    (ID                     VARCHAR2(15) NOT NULL,
    start_datetime                  DATE NOT NULL,
    col1 DATE NOT NULL,
    col2 VARCHAR2(1) NOT NULL,
    col3 NUMBER(10,0)
)
TABLESPACE DATA
PARTITION BY RANGE (start_datetime)
(
  PARTITION DATA20200101 VALUES LESS THAN (TO_DATE(' 2020-01-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
  TABLESPACE DATA2020
);

DECLARE
   v_nam          NUMBER (4) := 2020;
   v_owner        varchar2 (50) := 'binhtv';
   v_tablename    VARCHAR2 (50) := 'tab1';
   v_date_from   date    := to_date('02/01/2020','dd/mm/yyyy');
   v_date_to     date    := to_date('31/12/2021','dd/mm/yyyy');
   v_numday     number(5);
   v_tablespace varchar2(50):='DATA';
BEGIN
   v_numday:=v_date_to-v_date_from; 
   FOR i IN 0 .. v_numday
   LOOP
      DBMS_OUTPUT.put_line ('alter table '||v_owner||'.'|| v_tablename || ' add PARTITION DATA' ||to_char(v_date_from+i,'YYYYMMDD')||' VALUES LESS THAN (TO_DATE('''|| to_char(v_date_from+i+1,'YYYY-MM-DD')||' 00:00:00'',''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) LOGGING TABLESPACE DATA'|| to_char(v_date_from+i,'YYYY')||';');
   END LOOP;
END;

--F4
create index binhtv.tab1_i1 on binhtv.tab1(id) local tablespace indx parallel 8 online;

-- Rebuild index
DECLARE
   v_date_from   date    := to_date('01/01/2020','dd/mm/yyyy');
   v_date_to     date    := to_date('31/12/2021','dd/mm/yyyy');
   v_numday     number;
   v_tablespace varchar2(50):='INDX';
   cursor c1 is
     select a.* from DBA_PART_INDEXES a, DBA_TAB_PARTITIONS b where a.owner=B.TABLE_OWNER  and a.table_name=B.TABLE_NAME  and b.table_owner='BINHTV' and b.table_name='TAB1'  and a.index_name not like '%$%' and b.partition_name like '%20211231'  order by a.owner,a.index_name;
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

-- Set noparallel nologging
select distinct a.index_owner, a.index_name from DBA_ind_partitions a where  a.index_owner='user1' and a.index_name not like '%$%' and a.partition_name like '%20171231'  
order by a.index_owner,a.index_name;

DECLARE
   cursor c1 is
        select distinct a.index_owner, a.index_name from DBA_ind_partitions a where  a.index_owner='user1' and a.index_name not like '%$%' and a.partition_name like '%20171231'  
        order by a.index_owner,a.index_name;
BEGIN
   FOR i1 in c1
   LOOP
            DBMS_OUTPUT.put_line ('alter index '||i1.index_owner||'.'||i1.index_name || ' noparallel;');
   END LOOP;
END;

select * from dba_users