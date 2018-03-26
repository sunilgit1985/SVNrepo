UPDATE `invdb`.`notification_message_lookup` SET `includeAdvisorEmail`='N', `emailAdvisorRecepient`='operations@uobkayhian.com' WHERE `advisor`='UOB' and`messageType`='CHNGADDRS';
UPDATE `invdb`.`notification_message_lookup` SET `includeAdvisorEmail`='N', `emailAdvisorRecepient`='operations@uobkayhian.com' WHERE `advisor`='UOB' and`messageType`='OPENED';
UPDATE `invdb`.`notification_message_lookup` SET `includeAdvisorEmail`='N', `emailAdvisorRecepient`='operations@uobkayhian.com' WHERE `advisor`='UOB' and`messageType`='ACTIVE';
UPDATE `invdb`.`notification_message_lookup` SET `includeAdvisorEmail`='Y', `emailAdvisorRecepient`='finurobo@uobkayhian.com' WHERE `advisor`='UOB' and`messageType`='FUNDED';
UPDATE `invdb`.`notification_message_lookup` SET `includeAdvisorEmail`='Y', `emailAdvisorRecepient`='pwmurobo@uobkayhian.com' WHERE `advisor`='UOB' and`messageType`='PRFLCNFIRMED';
UPDATE `invdb`.`notification_message_lookup` SET `emailAdvisorRecepient`='pwmurobo@uobkayhian.com', `includeUser`='Y' WHERE `advisor`='UOB' and`messageType`='REBALANCE';
UPDATE `invdb`.`notification_message_lookup` SET `emailAdvisorRecepient`='pwmurobo@uobkayhian.com', `includeUser`='Y' WHERE `advisor`='UOB' and`messageType`='TRADEEXECUTED';
UPDATE `invdb`.`notification_message_lookup` SET `includeAdvisorEmail`='Y', `emailAdvisorRecepient`='caurobo@uobkayhian.com' WHERE `advisor`='UOB' and`messageType`='PRFLCNFREQ';
UPDATE `invdb`.`notification_message_lookup` SET `emailAdvisorRecepient`='caurobo@uobkayhian.com' WHERE `advisor`='UOB' and`messageType`='PROCESSED';



UPDATE `service`.`service_config_details` SET `value`='caurobo@uobkayhian.com' WHERE `mode`='PROD' and`company`='UOB' and`service`='DOCUMENT-SERVICES' and`vendor`='iText' and`name`='OPERATIONS_EMAIL';
UPDATE `service`.`service_config_details` SET `value`='seturobo@uobkayhian.com' WHERE `mode`='PROD' and`company`='UOB' and`service`='FILE-PROCESS' and`vendor`='VENDOR' and`name`='OPERATIONS_EMAIL';



UPDATE `service`.`service_config_details` SET `value`=NULL WHERE `mode`='PROD' and`company`='UOB' and`service`='DOCUMENT-SERVICES' and`vendor`='iText' and`name`='PASSWORD';
UPDATE `service`.`service_config_details` SET `value`='10.160.10.35' WHERE `mode`='PROD' and`company`='UOB' and`service`='DOCUMENT-SERVICES' and`vendor`='iText' and`name`='HOST';
UPDATE `service`.`service_config_details` SET `value`='supportL1@invessence.com' WHERE `mode`='PROD' and`company`='UOB' and`service`='DOCUMENT-SERVICES' and`vendor`='iText' and`name`='L1_SUPPORT_EMAIL';
UPDATE `service`.`service_config_details` SET `value`='supportL2@invessence.com' WHERE `mode`='PROD' and`company`='UOB' and`service`='DOCUMENT-SERVICES' and`vendor`='iText' and`name`='L2_SUPPORT_EMAIL';
UPDATE `service`.`service_config_details` SET `value`='' WHERE `mode`='PROD' and`company`='UOB' and`service`='DOCUMENT-SERVICES' and`vendor`='iText' and`name`='CC_EXTERNAL_RECEIVER';
UPDATE `service`.`service_config_details` SET `value`='' WHERE `mode`='PROD' and`company`='UOB' and`service`='DOCUMENT-SERVICES' and`vendor`='iText' and`name`='CC_INVESSENCE_RECEIVER';
UPDATE `service`.`service_config_details` SET `value`='25' WHERE `mode`='PROD' and`company`='UOB' and`service`='DOCUMENT-SERVICES' and`vendor`='iText' and`name`='PORT';
UPDATE `service`.`service_config_details` SET `value`='utraderobo@uobkayhian.com' WHERE `mode`='PROD' and`company`='UOB' and`service`='DOCUMENT-SERVICES' and`vendor`='iText' and`name`='SENDER_EMAIL';
UPDATE `service`.`service_config_details` SET `value`='' WHERE `mode`='PROD' and`company`='UOB' and`service`='DOCUMENT-SERVICES' and`vendor`='iText' and`name`='USERNAME';
UPDATE `service`.`service_config_details` SET `value`='operations@dot.com' WHERE `mode`='PROD' and`company`='UOB' and`service`='FILE-PROCESS' and`vendor`='VENDOR' and`name`='DOWNLOAD_SUCCESS_EMAIL';
UPDATE `service`.`service_config_details` SET `value`='supportL1@invessence.com' WHERE `mode`='PROD' and`company`='UOB' and`service`='FILE-PROCESS' and`vendor`='VENDOR' and`name`='UPLOAD_ISSUE_EMAIL';
UPDATE `service`.`service_config_details` SET `value`='seturobo@uobkayhian.com' WHERE `mode`='PROD' and`company`='UOB' and`service`='FILE-PROCESS' and`vendor`='VENDOR' and`name`='OPERATIONS_EMAIL';
UPDATE `service`.`service_config_details` SET `value`='supportL1@invessence.com' WHERE `mode`='PROD' and`company`='UOB' and`service`='FILE-PROCESS' and`vendor`='VENDOR' and`name`='DOWNLOAD_ISSUE_EMAIL';
UPDATE `service`.`service_config_details` SET `value`='caurobo@uobkayhian.com' WHERE `mode`='PROD' and`company`='UOB' and`service`='DOCUMENT-SERVICES' and`vendor`='iText' and`name`='OPERATIONS_EMAIL';

