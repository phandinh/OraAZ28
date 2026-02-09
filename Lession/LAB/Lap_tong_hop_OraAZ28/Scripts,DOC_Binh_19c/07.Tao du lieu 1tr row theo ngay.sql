--drop table bang_to purge;
-oaz18

CREATE TABLE oaz18.bang_to (
    bang_toID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255),
    create_date date
)
TABLESPACE DATA
PARTITION BY RANGE (create_date)
( 
 PARTITION DATA20230101 VALUES LESS THAN (TO_DATE('2023-01-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
 TABLESPACE DATA2023);

-- Add partition het nam 2023, boi den xong an F5
DECLARE
   v_nam          NUMBER (4) := 2023;
   v_owner        varchar2 (50) := 'oaz18';
   v_tablename    VARCHAR2 (50) := 'bang_to';
   v_date_from   date    := to_date('02/01/2023','dd/mm/yyyy');
   v_date_to     date    := to_date('31/12/2023','dd/mm/yyyy');
   v_numday     number(5);
   v_tablespace varchar2(50):='DATA';
BEGIN
   v_numday:=v_date_to-v_date_from; 
   FOR i IN 0 .. v_numday
   LOOP
      DBMS_OUTPUT.put_line ('alter table '||v_owner||'.'|| v_tablename || ' add PARTITION DATA' ||to_char(v_date_from+i,'YYYYMMDD')||' VALUES LESS THAN (TO_DATE('''|| to_char(v_date_from+i+1,'YYYY-MM-DD')||' 00:00:00'',''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) LOGGING TABLESPACE DATA'|| to_char(v_date_from+i,'YYYY')||';');
   END LOOP;
END;

-- Them du lieu deu co cac partition theo ngay
declare
    v_commit number;
    v_reset_date number;
    v_start date := to_date('01/01/2023','dd/mm/yyyy');
BEGIN
FOR v_LoopCounter IN 1..1000000 LOOP
    if v_start = to_date('31/12/2023','dd/mm/yyyy') then
        v_start := to_date('01/01/2023','dd/mm/yyyy');
    end if;
    INSERT INTO bang_to (bang_toID, LastName, FirstName, Address, City,create_date) 
    VALUES (TO_CHAR(v_LoopCounter),'Name'||v_LoopCounter,'FirstName'||v_LoopCounter,'HANOI','HANOI',v_start);
    v_start := v_start+1;
    v_commit := v_commit + 1;
    if v_commit=1000 then
        commit;
        v_commit :=1;
    end if;
END LOOP;

END;


--Them 10.000 ro cho ngay hien tai (vd 20/06/2023)
BEGIN
    FOR v_LoopCounter IN 1..100000 LOOP
    INSERT INTO bang_to (bang_toID, LastName, FirstName, Address, City, create_date) 
    VALUES (TO_CHAR(v_LoopCounter),'Name'||v_LoopCounter,'FirstName'||v_LoopCounter,'HANOI','HANOI', sysdate);
    END LOOP;
    COMMIT;
END;

--Them 10.000 ro cho ngay hien tai (vd 20/06/2023)
BEGIN
    FOR v_LoopCounter IN 1..1000 LOOP
    INSERT INTO bang_to (bang_toID, LastName, FirstName, Address, City, create_date) 
    VALUES (TO_CHAR(v_LoopCounter),'Name'||v_LoopCounter,'FirstName'||v_LoopCounter,'HANOI','HANOI', sysdate);
    END LOOP;
    COMMIT;
END;

select * from bang_to;

Plan
SELECT STATEMENT  ALL_ROWSCost: 99,273  Bytes: 56,610,000  Cardinality: 1,110,000  		
	2 PARTITION RANGE ALL  Cost: 99,273  Bytes: 56,610,000  Cardinality: 1,110,000  Partition #: 1  Partitions accessed #1 - #365	
		1 TABLE ACCESS FULL TABLE OAZ18.BANG_TO Cost: 99,273  Bytes: 56,610,000  Cardinality: 1,110,000  Partition #: 1  Partitions accessed #1 - #365

-- TAO GLOBAL INDEX
create index bang_to_ind1 on bang_to(bang_toID) tablespace INDX;

select * from bang_to where bang_toID=1234;

Plan
SELECT STATEMENT  ALL_ROWSCost: 6  		
	2 TABLE ACCESS BY GLOBAL INDEX ROWID BATCHED TABLE OAZ18.BANG_TO Cost: 6  Bytes: 153  Cardinality: 3  Partition #: 1  Partition access computed by row location	
		1 INDEX RANGE SCAN INDEX OAZ18.BANG_TO_IND1 Cost: 3  Cardinality: 3  

alter table bang_to truncate partition data20230101;
		
--Sau do index bang_to_ind1 unusable do la global index 

select * from bang_to where bang_toID=1234;

Plan
SELECT STATEMENT  ALL_ROWSCost: 98,999  		
	2 PARTITION RANGE ALL  Cost: 98,999  Bytes: 153  Cardinality: 3  Partition #: 1  Partitions accessed #1 - #365	
		1 TABLE ACCESS FULL TABLE OAZ18.BANG_TO Cost: 98,999  Bytes: 153  Cardinality: 3  Partition #: 1  Partitions accessed #1 - #365
		
-- Xu ly
alter index bang_to_ind1 rebuild online;

-- Muon khong bi unusable phai update global index
alter table bang_to truncate partition data20230102 update global indexes;

-- TAO LOCAL INDEX
create index bang_to_ind1 on bang_to(bang_toID) tablespace INDX local parallel 8 online ;

--Rebuild partition index ve tablespace tuong ung
DECLARE
   v_date_from   date    := to_date('01/01/2023','dd/mm/yyyy');
   v_date_to     date    := to_date('31/12/2023','dd/mm/yyyy');
   v_numday     number;
   v_tablespace varchar2(50):='INDX';
   cursor c1 is
     select a.* from DBA_PART_INDEXES a, DBA_TAB_PARTITIONS b where a.owner=B.TABLE_OWNER  and a.table_name=B.TABLE_NAME  and b.table_owner='OAZ18' and b.table_name='BANG_TO'  and a.index_name not like '%$%' and b.partition_name like '%20231231'  order by a.owner,a.index_name;
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

select * from bang_to where bang_toID=1234 and create_date>=to_date('21/06/2023','dd/mm/yyyy') and create_date<to_date('22/06/2023','dd/mm/yyyy');

select * from bang_to where lastname like 'Binh%' and create_date>=to_date('21/06/2023','dd/mm/yyyy') and create_date<to_date('22/06/2023','dd/mm/yyyy');

Plan
SELECT STATEMENT  ALL_ROWSCost: 276  Bytes: 50  Cardinality: 1  		
	2 PARTITION RANGE SINGLE  Cost: 276  Bytes: 50  Cardinality: 1  Partition #: 1  Partitions accessed #172	
		1 TABLE ACCESS FULL TABLE OAZ18.BANG_TO Cost: 276  Bytes: 50  Cardinality: 1  Partition #: 2  Partitions accessed #172


create index OAZ18.IDX$$_00220001 on OAZ18.BANG_TO("LASTNAME") tablespace INDX local parallel 8 online;

alter index OAZ18.IDX$$_00220001 noparallel ;

-- Cau lenh quet ko co partiiton_key
select * from bang_to where lastname like 'Binh%';

Plan
SELECT STATEMENT  ALL_ROWSCost: 98,730  Bytes: 153  Cardinality: 3  		
	2 PARTITION RANGE ALL  Cost: 98,730  Bytes: 153  Cardinality: 3  Partition #: 1  Partitions accessed #1 - #365	
		1 TABLE ACCESS FULL TABLE OAZ18.BANG_TO Cost: 98,730  Bytes: 153  Cardinality: 3  Partition #: 1  Partitions accessed #1 - #365

--Khuyen nghi Oracle
create index OAZ18.IDX$$_001F0001 on OAZ18.BANG_TO("LASTNAME");


select * from bang_to where lastname like 'Binh%' and create_date>=to_date('21/05/2023','dd/mm/yyyy') and create_date<to_date('22/06/2023','dd/mm/yyyy');


