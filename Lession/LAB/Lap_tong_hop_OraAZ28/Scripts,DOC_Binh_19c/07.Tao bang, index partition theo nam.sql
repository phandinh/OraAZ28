create user cus identified by Cus$123;
grant connect, resource, unlimited tablespace, select any table, select any dictionary to cus;

CREATE TABLE cus.table1
(
  ACTION_AUDIT_ID  NUMBER(20),
  SHOP_CODE        VARCHAR2(20 BYTE),
  ISSUE_DATETIME   DATE,
  SUB_ID           NUMBER(20),
  ACTION_ID        VARCHAR2(2 BYTE),
  USER_NAME        VARCHAR2(50 BYTE),
  PC               VARCHAR2(20 BYTE),
  REASON_ID        NUMBER(10),
  DESCRIPTION      VARCHAR2(4000 BYTE),
  FILE_ID          NUMBER(20),
  STATUS           NUMBER(1)                    DEFAULT 0,
  FREE_SIM         VARCHAR2(1 BYTE),
  EMP_CODE         VARCHAR2(15 BYTE),
  VALID            VARCHAR2(1 BYTE)
)
TABLESPACE DATA
PARTITION BY RANGE (ISSUE_DATETIME)
( 
 PARTITION DATA20020 VALUES LESS THAN (TO_DATE(' 2021-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
 TABLESPACE DATA2020,
 PARTITION DATA2021 VALUES LESS THAN (TO_DATE(' 2022-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
 TABLESPACE DATA2021);
 
 
 select * from cus.table1;
 
 --
 select * from cus.table1 partition (data2020)
 
 --alter table cus.table1  rename partition DATA20020 to DATA2020;
 
 --0
 select * from cus.table1 partition (data2021);
 