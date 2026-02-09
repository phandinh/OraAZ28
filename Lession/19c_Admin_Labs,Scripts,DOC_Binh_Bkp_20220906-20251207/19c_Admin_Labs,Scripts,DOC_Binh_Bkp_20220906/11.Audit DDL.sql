--Cấu hình Audit DDL Log Oracle Database
--Mục đích: Lưu log các thao tác DDL (drop table, create table, drop procedure, drop package,...) để truy vết các thao tác của DBA hay quản trị ứng dụng (có dùng user DB) làm sai, nhầm.
create tablespace data_log  datafile size 10M autoextend on next 10m;

create tablespace indx_log  datafile size 10M autoextend on next 10m;
 
--1. Tạo bản lưu log

drop table SYS.DDL_LOG purge;

CREATE TABLE SYS.DDL_LOG
(
  USER_NAME    VARCHAR2(30 BYTE),
  IP_ADDRESS   VARCHAR2(30 BYTE),
  HOSTNAME     VARCHAR2(30 BYTE),
  DDL_DATE     DATE,
  DDL_TYPE     VARCHAR2(30 BYTE),
  OBJECT_TYPE  VARCHAR2(18 BYTE),
  OWNER        VARCHAR2(30 BYTE),
  OBJECT_NAME  VARCHAR2(128 BYTE),
  SQL_TEXT     VARCHAR2(2000 BYTE)
)
TABLESPACE DATA_LOG
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING; 

CREATE INDEX SYS.DDL_LOG_I1 ON SYS.DDL_LOG
(DDL_DATE)
LOGGING
TABLESPACE INDX_LOG
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

--2. Tạo trigger bắt log DDL

CREATE OR REPLACE TRIGGER SYS.ddl_trig
    AFTER DDL
    ON DATABASE
--ON binhtv.tab1 -- Chỉ giám sát 1 bảng
DECLARE
    ip_addr      VARCHAR2 (30);
    hostname     VARCHAR2 (30);
    l_count      NUMBER;
    l_sql_text   ora_name_list_t;
    l_sql        VARCHAR2 (2000);
BEGIN
    l_count := ora_sql_txt (l_sql_text);

    IF l_count > 1
    THEN
        l_sql := l_sql_text (1) || l_sql_text (2);
    ELSE
        l_sql := l_sql_text (1);
    END IF;

    SELECT   SYS_CONTEXT ('USERENV', 'IP_ADDRESS') INTO ip_addr FROM DUAL;

    SELECT   SYS_CONTEXT ('USERENV', 'HOST') INTO hostname FROM DUAL;

    --IF (ip_addr NOT LIKE '192.168.1.%')
    --THEN
        INSERT INTO ddl_log (user_name,ip_address,hostname,ddl_date,ddl_type,object_type,
                             owner,object_name,sql_text)
          VALUES   (ora_login_user,ip_addr,hostname,SYSDATE,ora_sysevent,ora_dict_obj_type,
                    ora_dict_obj_owner,ora_dict_obj_name,l_sql);
    --END IF;

END ddl_trig;
/

--3. Test
CREATE TABLE oaz16.tab11 (col1 DATE);

DROP TABLE oaz16.tab11;

--4. Kiểm tra log

SELECT * FROM sys.DDL_LOG;

SELECT * FROM oaz11."BIN$2aKBPDtiQKfgU4C2qMAStA==$0";

-- Flashback before drop

flashback table oaz16.tab11 to before drop;

select * from oaz16.tab11 ;


