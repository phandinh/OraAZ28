create table oaz15.tab15(id number, name varchar2(100)) tablespace users;

grant unlimited tablespace to oaz15;


declare
    n number :=0;
begin
    for n in 1 .. 10000 
    loop
        insert into oaz15.tab15 values(n, 'Binh ' || n);
        commit; 
        --n := n+1;
    end loop;
end;

ORA-01116: error in opening database file 48
ORA-01110: data file 48: '/u01/app/oracle/oradata/ORCL/CC5C01A97A924B63E05380BDA8C055CE/datafile/o1_mf_users_koqrktbs_.dbf'
ORA-27041: unable to open file
Linux-x86_64 Error: 2: No such file or directory
Additional information: 3
ORA-06512: at line 6

create table oaz15.tab15(id number, name varchar2(100)) tablespace system;

grant unlimited tablespace to oaz15;


declare
    n number :=0;
begin
    for n in 1 .. 10000 
    loop
        insert into test.tab7 values(n, 'Binh ' || n);
        commit; 
        --n := n+1;
    end loop;
end;