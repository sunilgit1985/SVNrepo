## Insertion script for Session Countdown Time

SET SQL_SAFE_UPDATES = 0;

delete from invdb.web_site_info where name='WEB.SESSION.COUNTDOWNTIME';

INSERT INTO invdb.web_site_info (url, name, status, value, encrFlag, created)
select url,'WEB.SESSION.COUNTDOWNTIME','A','2','N',now() from invdb.web_site_info group by url;

## Insertion script for Session Timeout
delete from invdb.web_site_info where name='WEB.SESSION.TIMEOUT';

INSERT INTO invdb.web_site_info (url, name, status, value, encrFlag, created)
select url,'WEB.SESSION.TIMEOUT','A','15','N',now() from invdb.web_site_info group by url;

## Insertion script for mobile logout redirction
delete from invdb.web_site_info where name='URL.MOBILE';

INSERT INTO invdb.web_site_info (url, name, status, value, encrFlag, created)values('buildingbenjamins','URL.MOBILE','A','','N',now());
INSERT INTO invdb.web_site_info (url, name, status, value, encrFlag, created)values('traditionadvisers','URL.MOBILE','A','','N',now());
INSERT INTO invdb.web_site_info (url, name, status, value, encrFlag, created)values('uatbb','URL.MOBILE','A','','N',now());
INSERT INTO invdb.web_site_info (url, name, status, value, encrFlag, created)values('uattcm','URL.MOBILE','A','','N',now());

SET SQL_SAFE_UPDATES = 1;







