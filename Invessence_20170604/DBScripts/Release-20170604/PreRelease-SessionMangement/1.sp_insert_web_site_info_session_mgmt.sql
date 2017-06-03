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

INSERT INTO 
`invdb`.`web_site_info` (`url`, `name`, `status`, `value`, `encrFlag`, `created`, `updated`) 
VALUES 
('uwealth', 'URL.MOBILE', 'A', 'https://www.uwealth.com/mobile.xhtml', 'N', now(), null),
('uob', 'URL.MOBILE', 'A', 'http://uob.invessence.com:8080/mobile.xhtml', 'N', now(), null),
('preuob', 'URL.MOBILE', 'A', 'http://preuob.invessence.com:8080/mobile.xhtml', 'N', now(), null),
('uatuob', 'URL.MOBILE', 'A', 'http://uatuob.invessence.com:8080/mobile.xhtml', 'N', now(), null),
('demouob', 'URL.MOBILE', 'A', 'http://demouob.invessence.com:8080/mobile.xhtml', 'N', now(), null)
;

INSERT INTO 
`invdb`.`web_site_info` (`url`, `name`, `status`, `value`, `encrFlag`, `created`, `updated`) 
VALUES 
('buildingbenjamins', 'URL.MOBILE', 'A', 'https://BuildingBenjamins.com/mobile.xhtml', 'N', now(), null),
('prebb', 'URL.MOBILE', 'A', 'http://prebb.invessence.com:8080/mobile.xhtml', 'N', now(), null),
('uatbb', 'URL.MOBILE', 'A', 'http://uatbb.invessence.com:8080/mobile.xhtml', 'N', now(), null),
('demobb', 'URL.MOBILE', 'A', 'http://demobb.invessence.com:8080/mobile.xhtml', 'N', now(), null)
;

INSERT INTO 
`invdb`.`web_site_info` (`url`, `name`, `status`, `value`, `encrFlag`, `created`, `updated`) 
VALUES 
('traditionadvisers', 'URL.MOBILE', 'A', 'https://traditionadvisers.net/mobilelogin.xhtml', 'N', now(), null),
('pretcm', 'URL.MOBILE', 'A', 'http://pretcm.invessence.com:8080/mobilelogin.xhtml', 'N', now(), null),
('uattcm', 'URL.MOBILE', 'A', 'http://uattcm.invessence.com:8080/mobilelogin.xhtml', 'N', now(), null),
('demotcm', 'URL.MOBILE', 'A', 'http://demotcm.invessence.com:8080/mobilelogin.xhtml', 'N', now(), null)
;






SET SQL_SAFE_UPDATES = 1;







