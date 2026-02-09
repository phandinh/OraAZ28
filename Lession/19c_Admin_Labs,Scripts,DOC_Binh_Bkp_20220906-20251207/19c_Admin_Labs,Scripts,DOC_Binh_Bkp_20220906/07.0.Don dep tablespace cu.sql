DATA	10	100	90	10	90	327680	0	ONLINE	PERMANENT
DATA2021	5	200	190	10	95	327680	0	ONLINE	PERMANENT
DATA2022	10	100	90	10	90	327680	0	ONLINE	PERMANENT
DATA_LOG	10	100	90	10	90	327680	0	ONLINE	PERMANENT
DATA_NGHIEPVU1	10	100	90	10	90	327680	0	ONLINE	PERMANENT
DATA_OMF	10	100	90	10	90	327680	0	ONLINE	PERMANENT
DUMP	10	100	90	10	90	327680	0	ONLINE	PERMANENT
FDA_TS	10	91	82	9	90	327680	0	ONLINE	PERMANENT
FDA_TS2	10	91	82	9	90	327680	0	ONLINE	PERMANENT
INDX	10	100	90	10	90	327680	0	ONLINE	PERMANENT
INDX2021	10	100	90	10	90	327680	0	ONLINE	PERMANENT
INDX2022	10	100	90	10	90	327680	0	ONLINE	PERMANENT
INDX_LOG	10	100	90	10	90	327680	0	ONLINE	PERMANENT
INDX_NGHIEPVU1	10	100	90	10	90	327680	0	ONLINE	PERMANENT
SYSAUX	78	450	99	351	22	327680	0	ONLINE	PERMANENT
SYSTEM	75	380	97	283	25	327680	0	ONLINE	PERMANENT
TEMP	0	36	36	0	100	32768	0	ONLINE	TEMPORARY
UNDOTBS1	25	190	142	48	75	327680	0	ONLINE	UNDO
USERS	11	95	84	11	89	327680	0	ONLINE	PERMANENT


drop tablespace DATA including contents and datafiles;
drop tablespace INDX including contents and datafiles;
drop tablespace DATA2021 including contents and datafiles;
drop tablespace INDX2021 including contents and datafiles;
drop tablespace DATA2022 including contents and datafiles;
drop tablespace INDX2022 including contents and datafiles;
drop tablespace DATA_NGHIEPVU1 including contents and datafiles;
drop tablespace INDX_NGHIEPVU1 including contents and datafiles;
drop tablespace DATA_LOG including contents and datafiles;
drop tablespace INDX_LOG including contents and datafiles;
drop tablespace FDA_TS including contents and datafiles;
drop tablespace FDA_TS2 including contents and datafiles;
drop tablespace DUMP including contents and datafiles;
