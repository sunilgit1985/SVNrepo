# Script for assigning developer role to qa USER

use invdb;

INSERT INTO invdb.user_logon ( userid, pwd, logonstatus, lastname, firstname, email, stateRegistered, advisor, rep, emailmsgtype, access, created) VALUES ( 'uob.superadmin', 'c39680887e67fa9860fd197f1279805d', 'A', 'UOB', 'SuperAdmin', 'uob.superadmin@invessence.com', 'NJ', 'UOB', '', 'HTML', 'SuperAdmin', now());
INSERT INTO invdb.user_logon ( userid, pwd, logonstatus, lastname, firstname, email, stateRegistered, advisor, rep, emailmsgtype, access, created) VALUES ( 'bb.superadmin', 'c39680887e67fa9860fd197f1279805d', 'A', 'BBDemo', 'SuperAdmin', 'bb.superadmin@invessence.com', 'NJ', 'BB', '', 'HTML', 'SuperAdmin', now());
INSERT INTO invdb.user_logon ( userid, pwd, logonstatus, lastname, firstname, email, stateRegistered, advisor, rep, emailmsgtype, access, created) VALUES ('tcm.superadmin', 'c39680887e67fa9860fd197f1279805d', 'A', 'TCMDemo', 'SuperAdmin', 'tcm.superadmin@invessence.com', 'NJ', 'BB-TCM', '', 'HTML', 'SuperAdmin',now());

insert into invdb.role(logonid,role,status)select logonid,'Operations','A' from invdb.user_logon where userid='bb.advisor';

insert into invdb.role(logonid,role,status)select logonid,'Operations','A' from invdb.user_logon where userid='uob.advisor';

insert into invdb.role(logonid,role,status)select logonid,'Operations','A' from invdb.user_logon where userid='tcm.advisor';