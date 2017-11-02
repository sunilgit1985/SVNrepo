
INSERT INTO invdb.web_site_info (url, name, status, value, encrFlag, created) 
select url, 'DEFAULT.CURRENCY', 'A', 'SGD', 'N', now() from invdb.web_site_info group by url;

INSERT INTO invdb.web_site_info (url, name, status, value, encrFlag, created) 
select url, 'RISK.VARIANCE', 'A', '10', 'N', now() from invdb.web_site_info group by url;

