-- Tradition Configuration Properties
UPDATE `service`.`service_config_details` SET `value`='operations@traditioncm.com' WHERE `mode`='PROD' and`company`='TCM' and`service`='DOCUSIGN-SERVICES' and`vendor`='DOCUSIGN' and`name`='CCMAIL';
UPDATE `service`.`service_config_details` SET `value`='https://www.docusign.net/restapi' WHERE `mode`='PROD' and`company`='TCM' and`service`='DOCUSIGN-SERVICES' and`vendor`='DOCUSIGN' and`name`='BASE_URL';
UPDATE `service`.`service_config_details` SET `value`='Tradition Advisers' WHERE `mode`='PROD' and`company`='TCM' and`service`='DOCUSIGN-SERVICES' and`vendor`='DOCUSIGN' and`name`='CCMAILNAME';
UPDATE `service`.`service_config_details` SET `value`='75236371' WHERE `mode`='PROD' and`company`='TCM' and`service`='DOCUSIGN-SERVICES' and`vendor`='DOCUSIGN' and`name`='ACCOUNT_ID';
UPDATE `service`.`service_config_details` SET `value`='Tradition129!!' WHERE `mode`='PROD' and`company`='TCM' and`service`='DOCUSIGN-SERVICES' and`vendor`='DOCUSIGN' and`name`='PASSWORD';
UPDATE `service`.`service_config_details` SET `value`='documents@traditioncm.com' WHERE `mode`='PROD' and`company`='TCM' and`service`='DOCUSIGN-SERVICES' and`vendor`='DOCUSIGN' and`name`='USERNAME';


DELETE FROM `invdb`.`adv_request_document_mappings` WHERE `action`='ACCT_OPEN' and`subaction`='DEFAULT' and`reqType`='GENE_EMAIL_MESSAGE' and`templateId`='BB';
DELETE FROM `invdb`.`adv_request_document_mappings` WHERE `action`='ACCT_OPEN' and`subaction`='DEFAULT' and`reqType`='GENE_EMAIL_MESSAGE' and`templateId`='Direct';
DELETE FROM `invdb`.`adv_request_document_mappings` WHERE `action`='ACCT_OPEN' and`subaction`='DEFAULT' and`reqType`='GENE_EMAIL_MESSAGE' and`templateId`='External';
DELETE FROM `invdb`.`adv_request_document_mappings` WHERE `action`='ACCT_OPEN' and`subaction`='DEFAULT' and`reqType`='GENE_EMAIL_MESSAGE' and`templateId`='Advisor Direct';


UPDATE `service`.`dc_template_details` SET `tempId`='2a2687ba-464f-4563-bfac-fa223c338029' WHERE `mode`='PROD' and`company`='TCM' and`service`='DOCUSIGN-SERVICES' and`tempCode`='TAI_ADV_AGREE' and`tempId`='c31f1730-84be-4ee5-bf6d-318b200d7e14';
UPDATE `service`.`dc_template_details` SET `tempId`='2a2687ba-464f-4563-bfac-fa223c338029' WHERE `mode`='PROD' and`company`='TCM' and`service`='DOCUSIGN-SERVICES' and`tempCode`='TAE_ADV_AGREE' and`tempId`='d5a1c41b-21ce-4c99-9c8b-4c9ad403320a';
UPDATE `service`.`dc_template_details` SET `tempId`='1c5900d0-470b-43d2-aadf-c2d260aaa5b4' WHERE `mode`='PROD' and`company`='TCM' and`service`='DOCUSIGN-SERVICES' and`tempCode`='TAE_ACAT_OTHER' and`tempId`='c62d9775-24f8-46c4-91fe-834ce0dda1f6';
UPDATE `service`.`dc_template_details` SET `tempId`='1c5900d0-470b-43d2-aadf-c2d260aaa5b4' WHERE `mode`='PROD' and`company`='TCM' and`service`='DOCUSIGN-SERVICES' and`tempCode`='TAI_ACAT_OTHER' and`tempId`='542ad322-7aa0-4c45-9f97-6187b198b874';
UPDATE `service`.`dc_template_details` SET `tempId`='5df6203c-7748-47a6-b67c-e1e1d27a132c' WHERE `mode`='PROD' and`company`='BUILDINGBENJAMINS' and`service`='DOCUSIGN-SERVICES' and`tempCode`='GENE_EMAIL_MESSAGE' and`tempId`='6fe4789b-f36d-4c05-a974-67037c5a692e';
UPDATE `service`.`dc_template_details` SET `tempId`='5df6203c-7748-47a6-b67c-e1e1d27a132c' WHERE `mode`='PROD' and`company`='TCM' and`service`='DOCUSIGN-SERVICES' and`tempCode`='GENE_EMAIL_MESSAGE' and`tempId`='6fe4789b-f36d-4c05-a974-67037c5a692e';

-- update mode in web_site_info

UPDATE `invdb`.`web_site_info` SET `value`='PROD' WHERE `url`='buildingbenjamins' and`name`='SERVICE.DOCUSIGN.MODE';
UPDATE `invdb`.`web_site_info` SET `value`='PROD' WHERE `url`='traditionadvisers' and`name`='SERVICE.DOCUSIGN.MODE';