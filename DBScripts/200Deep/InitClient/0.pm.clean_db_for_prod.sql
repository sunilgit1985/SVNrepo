call `testing`.`cleandb_of_testing_data`('NEW', null);

delete from invdb.user_logon
where logonid > 100;

delete from invdb.user_access_role
where logonid > 100;

delete from invdb.user_logon
where logonid in (2,3,4,5,10,11,12,13,14,50,51,62,63,65,66,70,71,72,64);

delete from invdb.user_access_role
where logonid in (2,3,4,5,10,11,12,13,14,50,51,62,63,65,66,70,71,72,64);

delete from invdb.ext_nav;
delete from invdb.ext_position;
