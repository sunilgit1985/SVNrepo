/* 01.ap.fileProcessor.sql130318_abhang*/

INSERT INTO `invdb`.`web_site_info` (`url`, `name`, `status`, `value`, `encrFlag`, `created`) VALUES ('utraderobo', 'HTML.ACTIVATED', 'A', 'UOBKH-Activated.html', 'N', now());


UPDATE `service`.`service_config_details` SET `value`='10.160.10.37' WHERE `mode`='PROD' and`company`='UOB' and`service`='FILE-PROCESS' and`vendor`='VENDOR' and`name`='DOWNLOAD_SFTP_HOST';
UPDATE `service`.`service_config_details` SET `value`='10.160.10.37' WHERE `mode`='PROD' and`company`='UOB' and`service`='FILE-PROCESS' and`vendor`='VENDOR' and`name`='UPLOAD_SFTP_HOST';
UPDATE `service`.`service_config_details` SET `value`='robo1sftp' WHERE `mode`='PROD' and`company`='UOB' and`service`='FILE-PROCESS' and`vendor`='VENDOR' and`name`='DOWNLOAD_SFTP_USERNAME';
UPDATE `service`.`service_config_details` SET `value`='robo1sftp' WHERE `mode`='PROD' and`company`='UOB' and`service`='FILE-PROCESS' and`vendor`='VENDOR' and`name`='UPLOAD_SFTP_USERNAME';
UPDATE `service`.`service_config_details` SET `value`='SM@rtTR@ding' WHERE `mode`='PROD' and`company`='UOB' and`service`='FILE-PROCESS' and`vendor`='VENDOR' and`name`='DOWNLOAD_SFTP_PASSWORD';
UPDATE `service`.`service_config_details` SET `value`='SM@rtTR@ding' WHERE `mode`='PROD' and`company`='UOB' and`service`='FILE-PROCESS' and`vendor`='VENDOR' and`name`='UPLOAD_SFTP_PASSWORD';
UPDATE `service`.`service_config_details` SET `value`='/' WHERE `mode`='PROD' and`company`='UOB' and`service`='FILE-PROCESS' and`vendor`='VENDOR' and`name`='UPLOAD_SFTP_SRC_DIRECTORY';



UPDATE `service`.`file_details` SET `fileName`='xchg_rate' WHERE `vendor`='UOB' and`fileName`='CLNTEXCHRATE' and`processId`='UPLD1' and`seqNo`='4';
UPDATE `service`.`file_details` SET `fileName`='settlement' WHERE `vendor`='UOB' and`fileName`='CLNTSETT' and`processId`='UPLD1' and`seqNo`='6';
UPDATE `service`.`file_details` SET `fileName`='ROBO_TR', `active`='A' WHERE `vendor`='UOB' and`fileName`='CLNTOTHREF' and`processId`='UPLD1' and`seqNo`='1';
UPDATE `service`.`file_details` SET `fileName`='cash' WHERE `vendor`='UOB' and`fileName`='CLNTCASH' and`processId`='UPLD1' and`seqNo`='8';
UPDATE `service`.`file_details` SET `fileName`='acct_stats' WHERE `vendor`='UOB' and`fileName`='CLNTSTATUS' and`processId`='UPLD1' and`seqNo`='2';
UPDATE `service`.`file_details` SET `fileName`='acct_holding' WHERE `vendor`='UOB' and`fileName`='CLNTHOLD' and`processId`='UPLD1' and`seqNo`='7';


update service.file_details set sourcePath='' and fileExtension='csv' where vendor='UOB' and process='UPLOAD'; 


INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'PRICING', 'CSIDATA', 'DESTINATION.DIRECTORY', 'D:/PROJECT/SUDHIR/LOGS/CSIDATA/', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'PRICING', 'CSIDATA', 'SFTP.DIRECTORY', '/home/abhangp/Prices/', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'PRICING', 'CSIDATA', 'SFTP.HOST', 'prePROD.invessence.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'PRICING', 'CSIDATA', 'SFTP.PASSWORD', 'T35t123', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'PRICING', 'CSIDATA', 'SFTP.PORT', '22', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'PRICING', 'CSIDATA', 'SFTP.USER', 'abhangp', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'PRICING', 'FIS', 'DAILY.URL', 'http://91.212.43.32/XML/TimeSeries.xml?Symbol=$$SYMBOL$$&TimeScale=1440&MaxPoints=1&Fields=last,bid,ask,high,low,date,open,close,volume&Direction=$$DIRECTION$$&username=vyas&usergroup=INVESSENCE&password=welcome%20', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'PRICING', 'FIS', 'HISTORY.URL', 'http://91.212.43.32/XML/TimeSeries.xml?Symbol=$$SYMBOL$$&TimeScale=1440&MaxPoints=1600&Fields=last,bid,ask,high,low,date,open,close,volume&Direction=$$DIRECTION$$&username=vyas&usergroup=INVESSENCE&password=welcome%20', 'N');


/* vs.themeupdatequerey.sql130318_vinod*/

UPDATE `invdb`.`user_basket_access` SET `sortorder`='4' WHERE `advisor`='UOB' and`theme`='8.UOB' and`primary`='Y';
UPDATE `invdb`.`user_basket_access` SET `sortorder`='0' WHERE `advisor`='UOB' and`theme`='KayHian.Without.Sing' and`primary`='Y';

