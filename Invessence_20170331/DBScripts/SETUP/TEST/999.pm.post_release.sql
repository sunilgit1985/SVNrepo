/* Post release fixes */

UPDATE `invdb`.`dc_advisor_details` SET `advisorCode`='ALRG', `repId`='CATCHALL' WHERE `id`='2';
UPDATE `invdb`.`dc_advisor_details` SET `advisorCode`='ALRG' WHERE `id`='3';
UPDATE `invdb`.`dc_advisor_details` SET `advisorCode`='DAFF', `repId`='100' WHERE `id`='4';

UPDATE `invdb`.`user_advisor_access` SET `advisor`='BB%', `rep`='%' WHERE `logonid`='101';
UPDATE `invdb`.`user_advisor_access` SET `advisor`='BB%', `rep`='%' WHERE `logonid`='102';

DELETE FROM `invdb`.`user_logon` WHERE `logonid`='109';
DELETE FROM `invdb`.`user_advisor_access` WHERE `logonid`='106';
DELETE FROM `invdb`.`user_advisor_access` WHERE `logonid`='107';
DELETE FROM `invdb`.`user_advisor_access` WHERE `logonid`='108';
DELETE FROM `invdb`.`user_advisor_access` WHERE `logonid`='109';
DELETE FROM `invdb`.`user_advisor_info` WHERE `logonid`='106';
DELETE FROM `invdb`.`user_advisor_info` WHERE `logonid`='107';
DELETE FROM `invdb`.`user_advisor_info` WHERE `logonid`='108';
DELETE FROM `invdb`.`user_advisor_info` WHERE `logonid`='109';
