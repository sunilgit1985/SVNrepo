use invdb;

INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'ENCRY_DECRY_KEY', 'aRXDugfr4WQpVrxu', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'LOCAL_SRC_DIRECTORY', 'C:/TCM/data/eodfiles', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'POST_PROCESSOR', '_sp_invessence_switch_eod_process', 'N');
delete from service.service_config_details where company='BUILDINGBENJAMINS' and service='DOWNLOAD-SERVICES';

INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `encrFlag`) VALUES ('UAT', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'POST_SCRIPT', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `encrFlag`) VALUES ('UAT', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'PRE_PROCESSOR', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `encrFlag`) VALUES ('UAT', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'PRE_SCRIPT', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'SFTP_HOST', 'uat.invessence.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'SFTP_PASSWORD', 'T35t123', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'SFTP_SRC_DIRECTORY', '/data/download/tcm/AGWQT', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'SFTP_USERNAME', 'abhangp', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'ENCRY_DECRY_KEY', 'aRXDugfr4WQpVrxu', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'LOCAL_SRC_DIRECTORY', 'C:/TCM/data/eodfiles', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'POST_PROCESSOR', '_sp_invessence_switch_eod_process', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `encrFlag`) VALUES ('PROD', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'POST_SCRIPT', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `encrFlag`) VALUES ('PROD', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'PRE_PROCESSOR', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `encrFlag`) VALUES ('PROD', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'PRE_SCRIPT', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'SFTP_HOST', 'PROD.invessence.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'SFTP_PASSWORD', 'T35t123', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'SFTP_SRC_DIRECTORY', '/data/download/tcm/AGWQT', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'SFTP_USERNAME', 'abhangp', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('ORIG', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'ENCRY_DECRY_KEY', 'aRXDugfr4WQpVrxu', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('ORIG', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'LOCAL_SRC_DIRECTORY', 'C:/TCM/data/eodfiles', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('ORIG', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'POST_PROCESSOR', '_sp_invessence_switch_eod_process', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `encrFlag`) VALUES ('ORIG', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'POST_SCRIPT', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `encrFlag`) VALUES ('ORIG', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'PRE_PROCESSOR', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `encrFlag`) VALUES ('ORIG', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'PRE_SCRIPT', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('ORIG', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'SFTP_HOST', 'ORIG.invessence.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('ORIG', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'SFTP_PASSWORD', 'T35t123', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('ORIG', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'SFTP_SRC_DIRECTORY', '/data/download/tcm/AGWQT', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('ORIG', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'SFTP_USERNAME', 'abhangp', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('SAV', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'ENCRY_DECRY_KEY', 'aRXDugfr4WQpVrxu', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('SAV', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'LOCAL_SRC_DIRECTORY', 'C:/TCM/data/eodfiles', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('SAV', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'POST_PROCESSOR', '_sp_invessence_switch_eod_process', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `encrFlag`) VALUES ('SAV', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'POST_SCRIPT', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `encrFlag`) VALUES ('SAV', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'PRE_PROCESSOR', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `encrFlag`) VALUES ('SAV', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'PRE_SCRIPT', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('SAV', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'SFTP_HOST', 'SAV.invessence.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('SAV', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'SFTP_PASSWORD', 'T35t123', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('SAV', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'SFTP_SRC_DIRECTORY', '/data/download/tcm/AGWQT', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('SAV', 'BUILDINGBENJAMINS', 'DOWNLOAD-SERVICES', 'TD', 'SFTP_USERNAME', 'abhangp', 'N');
