select * from invdb.web_menu ;

SET SQL_SAFE_UPDATES = 0;
delete from invdb.web_menu ;

select count(*) from invdb.web_menu ;
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) 
select url, 'Advisor', 'Admin', 'Email Logs', '0', '0', '10', 'N', 'N', 'productadmin', 'email_logs.xhtml', now() from invdb.web_site_info group by url;
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created)
select url, 'Advisor', 'Admin', 'Login Management', '0', '0', '8', 'N', 'N', 'advisor', 'user_mng.xhtml',now() from invdb.web_site_info group by url;
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) 
select url, 'Advisor', 'CRM', 'RedTail', '0', '0', '7', 'A', 'N', 'advisor', 'assetworkflow.xhtml',now() from invdb.web_site_info group by url;
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) 
select url, 'Advisor', 'CRM', 'SalesFource', '0', '0', '3', 'N', 'N', 'advisor/operations', 'trade.xhtml',now() from invdb.web_site_info group by url;
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) 
select url, 'Advisor', 'Operations', 'Model', '0', '0', '7', 'N', 'N', 'advisor', 'assetworkflow.xhtml', now() from invdb.web_site_info group by url;
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) 
select url, 'Advisor', 'Operations', 'Trade', '0', '0', '3', 'A', 'N', 'advisor/operations', 'trade.xhtml',now() from invdb.web_site_info group by url;
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) 
select url, 'SuperAdmin', 'ProductAdmin', 'Account Emulation', '0', '0', '12', 'A', 'N', 'productadmin', 'accountEmulation.xhtml',now() from invdb.web_site_info group by url;
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) 
select url, 'SuperAdmin', 'ProductAdmin', 'File Processing', '0', '0', '11', 'A', 'N', 'productadmin', 'fileProcessEmulation.xhtml',now() from invdb.web_site_info group by url;
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) 
select url, 'User', 'User', 'Account', '0', '0', '11', 'A', 'N', 'consumer', 'cadd.xhtml',now() from invdb.web_site_info group by url;
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) 
select url, 'User', 'User', 'Aggregation', '0', '0', '11', 'A', 'N', '', '', now() from invdb.web_site_info group by url;
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) 
select url, 'User', 'User', 'Reports', '0', '0', '11', 'N', 'N', 'consumer', 'creports.xhtml',now() from invdb.web_site_info group by url;

SET SQL_SAFE_UPDATES = 1;
select count(*),'Done' from invdb.web_menu ;
select url from invdb.web_site_info group by url;



INSERT INTO invdb.web_site_info (url, name, status, value, encrFlag, created)
select url, 'ALLOW_VISITOR_REGISTER', 'A', 'Y', 'N', now() from invdb.web_site_info group by url;

UPDATE invdb.web_site_info SET value='N' WHERE url='traditionadvisers' and name='ALLOW_VISITOR_REGISTER';