DELETE FROM `service`.`service_operation_details` where company = 'UOB';
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'BROKER-WEBSERVICES', 'EMAIL_UPDATE', 'TD', 'I', '0', 'NULL');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'BROKER-WEBSERVICES', 'MAIL_UPDATE', 'TD', 'I', '0', 'NULL');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'BROKER-WEBSERVICES', 'FUND_ACCOUNT', 'TD', 'I', '0', 'NULL');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'BROKER-WEBSERVICES', 'FUND_TRANSFER', 'TD', 'I', '0', 'NULL');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'PRICING', 'DAILY_PRICING', 'YAHOO', 'A', '2', 'NULL');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'PRICING', 'DAILY_PRICING', 'XIGNITE', 'I', '1', 'NULL');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'PRICING', 'MONTHLY_PRICING', 'XIGNITE', 'I', '2', 'NULL');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'PRICING', 'MONTHLY_PRICING', 'YAHOO', 'A', '1', 'NULL');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'PRICING', 'ONDEMAND_PRICING', 'YAHOO', 'A', '1', 'NULL');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'PRICING', 'ONDEMAND_PRICING', 'XIGNITE', 'I', '2', 'NULL');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'PRICING', 'INITIAL_PROCESS', 'YAHOO', 'A', '1', 'NULL');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'DOCUSIGN-SERVICES', 'MOVE_MONEY_REMOVE', 'DOCUSIGN', 'I', '0', 'BB_MOVE_MONEY');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'DOCUSIGN-SERVICES', 'MOVE_MONEY_CHANGE', 'DOCUSIGN', 'I', '0', 'BB_MOVE_MONEY');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'DOCUSIGN-SERVICES', 'MOVE_MONEY_NEW', 'DOCUSIGN', 'I', '0', 'BB_MOVE_MONEY');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'DOCUSIGN-SERVICES', 'IRA_QRP_BENE_NEW', 'DOCUSIGN', 'I', '0', 'BB_IRAQRP_BENE');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'DOCUSIGN-SERVICES', 'IRA_MOVE_MONEY_REMOVE', 'DOCUSIGN', 'I', '0', 'BB_MOVE_MONEY_IRA');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'DOCUSIGN-SERVICES', 'IRA_MOVE_MONEY_CHANGE', 'DOCUSIGN', 'I', '0', 'BB_MOVE_MONEY_IRA');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'DOCUSIGN-SERVICES', 'IRA_MOVE_MONEY_NEW', 'DOCUSIGN', 'I', '0', 'BB_MOVE_MONEY_IRA');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'DOCUSIGN-SERVICES', 'IRA_APPLI_NEW', 'DOCUSIGN', 'I', '0', 'BB_IRA_APPLI');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'DOCUSIGN-SERVICES', 'ACCT_TRAN_NEW', 'DOCUSIGN', 'I', '0', 'BB_ACCT_TRANS');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'DOCUSIGN-SERVICES', 'ACCT_APPLI_NEW', 'DOCUSIGN', 'I', '0', 'BB_ACCT_APPLI');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'DOCUSIGN-SERVICES', 'ELEC_FUND_TRAN_CHANGE', 'DOCUSIGN', 'I', '0', 'BB_ELECT_FUND_TRANS');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'DOCUSIGN-SERVICES', 'ELEC_FUND_TRAN_NEW', 'DOCUSIGN', 'I', '0', 'BB_ELECT_FUND_TRANS');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'DOCUSIGN-SERVICES', 'ELEC_FUND_TRAN_REPLACE', 'DOCUSIGN', 'I', '0', 'BB_ELECT_FUND_TRANS');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'DOCUSIGN-SERVICES', 'TD_TRAN_NEW', 'DOCUSIGN', 'I', '0', 'BB_LPOA');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `priority`, `refValue`) VALUES ('UOB', 'DOCUSIGN-SERVICES', 'ACAT_OTHER_NEW', 'DOCUSIGN', 'I', '0', 'BB_ACAT_OTHER');