select * from c##oaz20.t1;
insert into c##oaz20.t1 values(1);
commit;

create table c##oaz20.t1 (id number);

--1 vs 11
select * from c##oaz20.t1;

select * from oaz20.oaz20_t1;

select * from c##oaz20.c##oaz20_t1;

CREATE PUBLIC DATABASE LINK dbl_pdb1
 CONNECT TO c##oaz20
 IDENTIFIED BY oracle
 USING ' (DESCRIPTION =    
    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.182.128)(PORT = 1521))    
    (CONNECT_DATA =
      (SERVICE_NAME = pdb1)
    )
  )
  ';
  
  select * from dual@dbl_pdb1;
  
  select * from c##oaz20.c##oaz20_t1@dbl_pdb1;
  
  select * from oaz20.oaz20_t1@dbl_pdb1;
  
  create table xxx_t1 as select  * from oaz20.oaz20_t1@dbl_pdb1;
  
  select * from xxx_t1;

