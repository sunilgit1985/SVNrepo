UPDATE `invdb`.`web_site_info` SET `value`='uob' WHERE `url`='uwealth' and`name`='CSS.DIR';
UPDATE `invdb`.`web_site_info` SET `value`='css/uob.css' WHERE `url`='uwealth' and`name`='CSS.CUSTOM';
UPDATE `invdb`.`web_site_info` SET `value`='css/uob.css' WHERE `url`='uwealth' and`name`='CSS.CUSTODY';
UPDATE `invdb`.`web_site_info` SET `value`='uob' WHERE `url`='uwealth' and`name`='DIR.CUSTODY';

INSERT INTO `invdb`.`web_site_info` (`url`, `name`, `status`, `value`, `encrFlag`, `created`) 
select url, , 'SERVICE.PRODUCT', 'A', 'UOB', 'N', now() from invdb.web_site_info group by url;


INSERT INTO invdb.web_site_info (url, name, status, value, encrFlag, created) 
select url, 'SERVICE.DOCUMENT.MODE', 'A', 'UAT', 'N', now() from invdb.web_site_info group by url;


