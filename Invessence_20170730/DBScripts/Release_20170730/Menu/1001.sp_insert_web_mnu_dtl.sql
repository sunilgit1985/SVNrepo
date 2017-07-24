## Insert menu list as per product URL

SET SQL_SAFE_UPDATES = 0;

delete from invdb.web_menu where url<>'master';

INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('pretcm.invessence.com', 'Advisor', 'Admin', 'Login Management', '0', '0', '8', 'N', 'N', 'advisor', 'user_mng.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('pretcm.invessence.com', 'Advisor', 'Admin', 'Email Logs', '0', '0', '10', 'N', 'N', 'productadmin', 'email_logs.xhtml', now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('pretcm.invessence.com', 'Advisor', 'Operations', 'Model', '0', '0', '7', 'A', 'N', 'advisor', 'assetworkflow.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('pretcm.invessence.com', 'Advisor', 'Operations', 'Trade', '0', '0', '3', 'A', 'N', 'advisor/operations', 'trade.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('pretcm.invessence.com', 'SuperAdmin', 'ProductAdmin', 'Account Emulation', '0', '0', '12', 'A', 'N', 'productadmin', 'accountEmulation.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('pretcm.invessence.com', 'SuperAdmin', 'ProductAdmin', 'File Processing', '0', '0', '11', 'A', 'N', 'productadmin', 'fileProcessEmulation.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('pretcm.invessence.com', 'User', 'User', 'Account', '0', '0', '11', 'A', 'N', 'consumer', 'cadd.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('pretcm.invessence.com', 'User', 'User', 'Aggregation', '0', '0', '11', 'N', 'N', '', '',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('pretcm.invessence.com', 'User', 'User', 'Reports', '0', '0', '11', 'N', 'N', 'consumer', 'creports.xhtml',now());

INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uattcm.invessence.com', 'Advisor', 'Admin', 'Email Logs', '0', '0', '10', 'N', 'N', 'productadmin', 'email_logs.xhtml', now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uattcm.invessence.com', 'Advisor', 'Admin', 'Login Management', '0', '0', '8', 'N', 'N', 'advisor', 'user_mng.xhtml', now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uattcm.invessence.com', 'Advisor', 'Operations', 'Model', '0', '0', '7', 'A', 'N', 'advisor', 'assetworkflow.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uattcm.invessence.com', 'Advisor', 'Operations', 'Trade', '0', '0', '3', 'A', 'N', 'advisor/operations', 'trade.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uattcm.invessence.com', 'SuperAdmin', 'ProductAdmin', 'Account Emulation', '0', '0', '12', 'A', 'N', 'productadmin', 'accountEmulation.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uattcm.invessence.com', 'SuperAdmin', 'ProductAdmin', 'File Processing', '0', '0', '11', 'A', 'N', 'productadmin', 'fileProcessEmulation.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uattcm.invessence.com', 'User', 'User', 'Account', '0', '0', '11', 'A', 'N', 'consumer', 'cadd.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uattcm.invessence.com', 'User', 'User', 'Aggregation', '0', '0', '11', 'N', 'N', '', '',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uattcm.invessence.com', 'User', 'User', 'Reports', '0', '0', '11', 'N', 'N', 'consumer', 'creports.xhtml',now());



INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('prebb.invessence.com', 'Advisor', 'Admin', 'Email Logs', '0', '0', '10', 'N', 'N', 'productadmin', 'email_logs.xhtml', now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('prebb.invessence.com', 'Advisor', 'Admin', 'Login Management', '0', '0', '8', 'N', 'N', 'advisor', 'user_mng.xhtml', now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('prebb.invessence.com', 'Advisor', 'Operations', 'Model', '0', '0', '7', 'A', 'N', 'advisor', 'assetworkflow.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('prebb.invessence.com', 'Advisor', 'Operations', 'Trade', '0', '0', '3', 'A', 'N', 'advisor/operations', 'trade.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('prebb.invessence.com', 'SuperAdmin', 'ProductAdmin', 'Account Emulation', '0', '0', '12', 'A', 'N', 'productadmin', 'accountEmulation.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('prebb.invessence.com', 'AdvSuperAdminisor', 'ProductAdmin', 'File Processing', '0', '0', '11', 'A', 'N', 'productadmin', 'fileProcessEmulation.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('prebb.invessence.com', 'User', 'User', 'Account', '0', '0', '11', 'A', 'N', 'consumer', 'cadd.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('prebb.invessence.com', 'User', 'User', 'Aggregation', '0', '0', '11', 'N', 'N', '', '',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('prebb.invessence.com', 'User', 'User', 'Reports', '0', '0', '11', 'N', 'N', 'consumer', 'creports.xhtml',now());


INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatbb.invessence.com', 'Advisor', 'Admin', 'Email Logs', '0', '0', '10', 'N', 'N', 'productadmin', 'email_logs.xhtml', now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatbb.invessence.com', 'Advisor', 'Admin', 'Login Management', '0', '0', '8', 'N', 'N', 'advisor', 'user_mng.xhtml', now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatbb.invessence.com', 'Advisor', 'Operations', 'Model', '0', '0', '7', 'A', 'N', 'advisor', 'assetworkflow.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatbb.invessence.com', 'Advisor', 'Operations', 'Trade', '0', '0', '3', 'A', 'N', 'advisor/operations', 'trade.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatbb.invessence.com', 'SuperAdmin', 'ProductAdmin', 'Account Emulation', '0', '0', '12', 'A', 'N', 'productadmin', 'accountEmulation.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatbb.invessence.com', 'SuperAdmin', 'ProductAdmin', 'File Processing', '0', '0', '11', 'A', 'N', 'productadmin', 'fileProcessEmulation.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatbb.invessence.com', 'User', 'User', 'Account', '0', '0', '11', 'A', 'N', 'consumer', 'cadd.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatbb.invessence.com', 'User', 'User', 'Aggregation', '0', '0', '11', 'N', 'N', '', '',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatbb.invessence.com', 'User', 'User', 'Reports', '0', '0', '11', 'N', 'N', 'consumer', 'creports.xhtml',now());


INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('preuob.invessence.com', 'Advisor', 'Admin', 'Email Logs', '0', '0', '10', 'N', 'N', 'productadmin', 'email_logs.xhtml', now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('preuob.invessence.com', 'Advisor', 'Admin', 'Login Management', '0', '0', '8', 'N', 'N', 'advisor', 'user_mng.xhtml', now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('preuob.invessence.com', 'Advisor', 'Operations', 'Model', '0', '0', '7', 'A', 'N', 'advisor', 'assetworkflow.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('preuob.invessence.com', 'Advisor', 'Operations', 'Trade', '0', '0', '3', 'A', 'N', 'advisor/operations', 'trade.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('preuob.invessence.com', 'SuperAdmin', 'ProductAdmin', 'Account Emulation', '0', '0', '12', 'A', 'N', 'productadmin', 'accountEmulation.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('preuob.invessence.com', 'SuperAdmin', 'ProductAdmin', 'File Processing', '0', '0', '11', 'A', 'N', 'productadmin', 'fileProcessEmulation.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('preuob.invessence.com', 'User', 'User', 'Account', '0', '0', '11', 'A', 'N', 'consumer', 'cadd.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('preuob.invessence.com', 'User', 'User', 'Aggregation', '0', '0', '11', 'N', 'N', '', '',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('preuob.invessence.com', 'User', 'User', 'Reports', '0', '0', '11', 'N', 'N', 'consumer', 'creports.xhtml',now());


INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatuob.invessence.com', 'Advisor', 'Admin', 'Email Logs', '0', '0', '10', 'N', 'N', 'productadmin', 'email_logs.xhtml', now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatuob.invessence.com', 'Advisor', 'Admin', 'Login Management', '0', '0', '8', 'N', 'N', 'advisor', 'user_mng.xhtml', now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatuob.invessence.com', 'Advisor', 'Operations', 'Model', '0', '0', '7', 'A', 'N', 'advisor', 'assetworkflow.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatuob.invessence.com', 'Advisor', 'Operations', 'Trade', '0', '0', '3', 'A', 'N', 'advisor/operations', 'trade.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatuob.invessence.com', 'SuperAdmin', 'ProductAdmin', 'Account Emulation', '0', '0', '12', 'A', 'N', 'productadmin', 'accountEmulation.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatuob.invessence.com', 'SuperAdmin', 'ProductAdmin', 'File Processing', '0', '0', '11', 'A', 'N', 'productadmin', 'fileProcessEmulation.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatuob.invessence.com', 'User', 'User', 'Account', '0', '0', '11', 'A', 'N', 'consumer', 'cadd.xhtml',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatuob.invessence.com', 'User', 'User', 'Aggregation', '0', '0', '11', 'N', 'N', '', '',now());
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) VALUES ('uatuob.invessence.com', 'User', 'User', 'Reports', '0', '0', '11', 'N', 'N', 'consumer', 'creports.xhtml',now());



SET SQL_SAFE_UPDATES = 1;
