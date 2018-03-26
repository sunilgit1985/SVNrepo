
INSERT INTO `invdb`.`web_site_info` (`url`, `name`, `status`, `value`, `encrFlag`, `created`) 
select url, 'CUSTODY.UPLOAD.PATH', 'A', '/data/upload/uob/consumerUpload/', 'N',now() from web_site_info group by url;
INSERT INTO `invdb`.`web_site_info` (`url`, `name`, `status`, `value`, `encrFlag`, `created`) 
select url, 'CUSTODY.DOWNLOAD.PATH', 'A', '/data/download/uob/custodyFiles/', 'N',now() from web_site_info group by url;