USE `service`;

set sql_safe_updates=0;
DELETE from `service`.`service_master` where company= 'UOB' and service='FILE-PROCESS';
INSERT INTO `service`.`service_master` (`company`, `service`, `status`, `vendor`) VALUES ('UOB', 'FILE-PROCESS', 'A', 'VENDOR');

DELETE from `service`.`service_config_details` where company= 'UOB' and service='FILE-PROCESS';
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_ISSUE_EMAIL', 'support@dot.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_LOCAL_SRC_DIRECTORY', 'D:/data/eodfiles', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_POST_DB_PROCESS', '', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_POST_INSTRUCTION', '', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_PRE_DB_PROCESS', '', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_PRE_INSTRUCTION', '', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SFTP_HOST', 'uat.invessence.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SFTP_PASSWORD', 'T35t123', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SFTP_SRC_DIRECTORY', '/data/download/', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SFTP_USERNAME', 'abhangp', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SUCCESS_EMAIL', 'operations@dot.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_ISSUE_EMAIL', 'support@dot.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_LOCAL_SRC_DIRECTORY', 'D:/data/tradefiles', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_POST_DB_PROCESS', '', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_POST_INSTRUCTION', '', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_PRE_DB_PROCESS', '', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_PRE_INSTRUCTION', '', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SFTP_HOST', 'uat.invessence.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SFTP_PASSWORD', 'T35t123', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SFTP_SRC_DIRECTORY', '/data/eodfiles/', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SFTP_USERNAME', 'abhangp', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SUCCESS_EMAIL', 'operations@dot.com', 'N');


CREATE
     OR REPLACE ALGORITHM = UNDEFINED
    SQL SECURITY DEFINER
VIEW `service`.`vw_invessence_switch` AS
    SELECT
        `invdb`.`invessence_switch`.`name` AS `name`,
        `invdb`.`invessence_switch`.`description` AS `description`,
        `invdb`.`invessence_switch`.`value` AS `value`,
        `invdb`.`invessence_switch`.`format` AS `format`,
        `invdb`.`invessence_switch`.`created` AS `created`,
        `invdb`.`invessence_switch`.`lastupdated` AS `lastupdated`
    FROM
        `invdb`.`invessence_switch`;

DROP TABLE IF EXISTS `service`.`file_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service`.`file_details` (
  `vendor` varchar(20) NOT NULL,
  `fileName` varchar(40) NOT NULL,
  `processId` varchar(40) NOT NULL,
  `process` varchar(40) NOT NULL,
  `fileType` varchar(10) DEFAULT NULL,
  `fileExtension` varchar(10) DEFAULT NULL,
  `fileId` varchar(45) NOT NULL,
  `containsHeader` varchar(1) DEFAULT 'N',
  `active` varchar(1) NOT NULL DEFAULT 'N',
  `seqNo` int(2) DEFAULT NULL,
  `uploadDir` varchar(80) DEFAULT NULL,
  `preDBProcess` varchar(80) DEFAULT NULL,
  `postDBProcess` varchar(80) DEFAULT NULL,
  `preInstruction` varchar(80) DEFAULT NULL,
  `postInstruction` varchar(80) DEFAULT NULL,
  `fileNameAppender` varchar(20) DEFAULT NULL,
  `appenderFormat` varchar(20) DEFAULT NULL,
  `available` varchar(7) DEFAULT NULL,
  `sourcePath` varchar(80) DEFAULT NULL,
  `downloadDir` varchar(80) DEFAULT NULL,
  `loadFormat` varchar(10) DEFAULT NULL,
  `required` varchar(1) DEFAULT 'N',
  `canBeEmpty` varchar(1) DEFAULT NULL,
  `keyData` varchar(5) DEFAULT NULL,
  `encryptionMethod` varchar(10) DEFAULT NULL,
  `encColumns` varchar(20) DEFAULT NULL,
  `tmpTableName` varchar(45) DEFAULT NULL,
  `canBeDups` varchar(1) DEFAULT 'N',
  `delimiter` varchar(5) DEFAULT NULL,
  `delFlagServerFile` varchar(1) DEFAULT 'N',
  `delDayServerFile` int(3) DEFAULT '30',
  `delFlagLocalFile` varchar(1) DEFAULT 'N',
  `delDayLocalFile` int(3) DEFAULT '0',
  `delFlagDecrFile` varchar(1) DEFAULT 'N',
  `fileProcessType` varchar(45) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `lastupdated` datetime DEFAULT NULL,
  PRIMARY KEY (`vendor`,`fileName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


LOCK TABLES `service`.`file_details` WRITE;
/*!40000 ALTER TABLE `service`.`file_details` DISABLE KEYS */;
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `fileType`, `fileExtension`, `fileId`, `containsHeader`, `active`, `seqNo`, `uploadDir`, `postDBProcess`, `fileNameAppender`, `appenderFormat`, `sourcePath`, `downloadDir`, `loadFormat`, `required`, `canBeEmpty`, `tmpTableName`, `canBeDups`, `delimiter`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CBL', 'UPLD3', 'UPLOAD', 'TEXT', 'csv', 'BB_CBL', 'N', 'A', '1', '/Abhang/trade files', 'temp.sp_upload_td_unrealized', 'POSTFIX', 'YYYYMMDD', '/tcm/AGWQ/', '/tcm/TEST/', 'DELIMITED', 'Y', 'N', 'temp_td_unrealized', 'N', ',', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `fileType`, `fileExtension`, `fileId`, `containsHeader`, `active`, `seqNo`, `uploadDir`, `postDBProcess`, `fileNameAppender`, `appenderFormat`, `sourcePath`, `downloadDir`, `loadFormat`, `required`, `canBeEmpty`, `tmpTableName`, `canBeDups`, `delimiter`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CBLCOLON', 'UPLD2', 'UPLOAD', 'TEXT', 'csv', 'BB_CBL', 'N', 'A', '1', '/Abhang/trade files', 'temp.sp_upload_td_unrealized', 'POSTFIX', 'YYYYMMDD', '/tcm/AGWQ/', '/tcm/TEST/', 'DELIMITED', 'Y', 'N', 'temp_td_unrealized', 'N', ':', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `fileType`, `fileExtension`, `fileId`, `containsHeader`, `active`, `seqNo`, `uploadDir`, `postDBProcess`, `fileNameAppender`, `appenderFormat`, `sourcePath`, `downloadDir`, `loadFormat`, `required`, `canBeEmpty`, `tmpTableName`, `canBeDups`, `delimiter`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CBLDOLLAR', 'UPLD3', 'UPLOAD', 'TEXT', 'csv', 'BB_CBL', 'N', 'A', '1', '/Abhang/trade files', '', 'POSTFIX', 'YYYYMMDD', '/tcm/AGWQ/', '/tcm/TEST/', 'DELIMITED', 'Y', 'N', 'temp_td_unrealized', 'N', '$', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `fileType`, `fileExtension`, `fileId`, `containsHeader`, `active`, `seqNo`, `uploadDir`, `postDBProcess`, `fileNameAppender`, `appenderFormat`, `sourcePath`, `downloadDir`, `loadFormat`, `required`, `canBeEmpty`, `tmpTableName`, `canBeDups`, `delimiter`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CBLHASH', 'UPLD3', 'UPLOAD', 'TEXT', 'csv', 'BB_CBL', 'N', 'A', '1', '/Abhang/trade files', '', 'POSTFIX', 'YYYYMMDD', '/tcm/AGWQ/', '/tcm/TEST/', 'DELIMITED', 'Y', 'N', 'temp_td_unrealized', 'N', '#', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `fileType`, `fileExtension`, `fileId`, `containsHeader`, `active`, `seqNo`, `uploadDir`, `postDBProcess`, `fileNameAppender`, `appenderFormat`, `sourcePath`, `downloadDir`, `loadFormat`, `required`, `canBeEmpty`, `tmpTableName`, `canBeDups`, `delimiter`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CBLNEGETION', 'UPLD3', 'UPLOAD', 'TEXT', 'csv', 'BB_CBL', 'N', 'A', '1', '/Abhang/trade files', '', 'POSTFIX', 'YYYYMMDD', '/tcm/AGWQ/', '/tcm/TEST/', 'DELIMITED', 'Y', 'N', 'temp_td_unrealized', 'N', '!', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `fileType`, `fileExtension`, `fileId`, `containsHeader`, `active`, `seqNo`, `uploadDir`, `postDBProcess`, `fileNameAppender`, `appenderFormat`, `sourcePath`, `downloadDir`, `loadFormat`, `required`, `canBeEmpty`, `tmpTableName`, `canBeDups`, `delimiter`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CBLPIPE', 'UPLD3', 'UPLOAD', 'TEXT', 'csv', 'BB_CBL', 'N', 'A', '1', '/Abhang/trade files', '', 'POSTFIX', 'YYYYMMDD', '/tcm/AGWQ/', '/tcm/TEST/', 'DELIMITED', 'Y', 'N', 'temp_td_unrealized', 'N', '|', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `fileType`, `fileExtension`, `fileId`, `containsHeader`, `active`, `seqNo`, `uploadDir`, `postDBProcess`, `fileNameAppender`, `appenderFormat`, `sourcePath`, `downloadDir`, `loadFormat`, `required`, `canBeEmpty`, `tmpTableName`, `canBeDups`, `delimiter`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CBLSTAR', 'UPLD3', 'UPLOAD', 'TEXT', 'csv', 'BB_CBL', 'N', 'A', '1', '/Abhang/trade files', '', 'POSTFIX', 'YYYYMMDD', '/tcm/AGWQ/', '/tcm/TEST/', 'DELIMITED', 'Y', 'N', 'temp_td_unrealized', 'N', '*', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `fileType`, `fileExtension`, `fileId`, `containsHeader`, `active`, `seqNo`, `uploadDir`, `preDBProcess`, `appenderFormat`, `sourcePath`, `downloadDir`, `loadFormat`, `required`, `canBeEmpty`, `tmpTableName`, `canBeDups`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CLNTBAL', 'UPLD1', 'UPLOAD', 'TEXT', 'dat', 'UOB_CLIENT_ACCT_BALANCE_FILE', 'N', 'A', '2', '/Abhang/tradeFiles', '', 'YYYYMMDD', '/uob/', '/uob/', 'FIXED', 'Y', 'Y', 'tmp_nav_daily', 'N', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `fileType`, `fileExtension`, `fileId`, `containsHeader`, `active`, `seqNo`, `uploadDir`, `preDBProcess`, `appenderFormat`, `sourcePath`, `downloadDir`, `loadFormat`, `required`, `canBeEmpty`, `tmpTableName`, `canBeDups`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CLNTHOLD', 'UPLD1', 'UPLOAD', 'TEXT', 'dat', 'UOB_CLIENT_ACCT_HOLDING_FILE', 'N', 'A', '3', '/Abhang/tradeFiles', '', 'YYYYMMDD', '/uob/', '/uob/', 'FIXED', 'Y', 'Y', 'tmp_position', 'N', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `fileType`, `fileExtension`, `fileId`, `containsHeader`, `active`, `seqNo`, `uploadDir`, `preDBProcess`, `fileNameAppender`, `appenderFormat`, `loadFormat`, `required`, `canBeDups`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CLNTORD', 'DOWD1', 'DOWNLOAD', 'TEXT', 'dat', 'UOB_ORDER_INSTRUCTION_FILE', 'N', 'A', '4', '/Abhang/tradeFiles', 'invdb.sp_trade_process_both', 'PREFIX', 'YYYYMMDD', 'FIXED', 'N', 'N', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `fileType`, `fileExtension`, `fileId`, `containsHeader`, `active`, `seqNo`, `uploadDir`, `preDBProcess`, `appenderFormat`, `sourcePath`, `downloadDir`, `loadFormat`, `required`, `canBeEmpty`, `tmpTableName`, `canBeDups`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CLNTORDEXE', 'UPLD1', 'UPLOAD', 'TEXT', 'dat', 'UOB_EOD_ORDER_EXEC_FILE', 'N', 'A', '4', '/Abhang/tradeFiles', '', 'YYYYMMDD', '/uob/', '/uob/', 'FIXED', 'N', 'N', 'tmp_transaction', 'N', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `fileType`, `fileExtension`, `fileId`, `containsHeader`, `active`, `seqNo`, `uploadDir`, `preDBProcess`, `appenderFormat`, `sourcePath`, `downloadDir`, `loadFormat`, `required`, `canBeEmpty`, `tmpTableName`, `canBeDups`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CLNTSTATUS', 'UPLD1', 'UPLOAD', 'TEXT', 'dat', 'UOB_CLIENT_STATUS_FILE', 'N', 'A', '1', '/Abhang/tradeFiles', '', 'YYYYMMDD', '/uob/', '/uob/', 'FIXED', 'N', 'N', 'tmp_client_data', 'N', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `fileType`, `fileExtension`, `fileId`, `containsHeader`, `active`, `seqNo`, `uploadDir`, `preDBProcess`, `fileNameAppender`, `appenderFormat`, `loadFormat`, `canBeDups`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'TRADE_DETAILS', 'DOWD1', 'DOWNLOAD', 'TEXT', 'trd', 'TRADE_FILE', 'N', 'A', '4', '/Abhang/tradeFiles', 'invdb.sp_trade_process_both', 'PREFIX', 'YYYYMMDD', 'FIXED', 'N', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `fileType`, `fileExtension`, `fileId`, `containsHeader`, `active`, `seqNo`, `uploadDir`, `preDBProcess`, `fileNameAppender`, `appenderFormat`, `loadFormat`, `canBeDups`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`, `fileProcessType`) VALUES ('UOB', 'TRADE_SUMMURY_BUY', 'DOWD1', 'DOWNLOAD', 'TEXT', 'buy', 'TRADE_FILE', 'N', 'A', '5', '/Abhang/tradeFiles', 'invdb.sp_trade_process_buy', 'POSTFIX', 'YYYYMMDD', 'FIXED', 'N', 'N', '30', 'N', '0', 'N', 'SFTP');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `fileType`, `fileExtension`, `fileId`, `containsHeader`, `active`, `seqNo`, `uploadDir`, `preDBProcess`, `appenderFormat`, `loadFormat`, `canBeDups`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`, `fileProcessType`) VALUES ('UOB', 'TRADE_SUMMURY_SELL', 'DOWD1', 'DOWNLOAD', 'TEXT', 'trd', 'TRADE_FILE_SELL', 'Y', 'A', '6', '/Abhang/tradeFiles', 'invdb.sp_trade_process_sell', 'YYYYMMDD', 'FIXED', 'N', 'N', '30', 'N', '0', 'N', 'DOWNLOAD');
/*!40000 ALTER TABLE `service`.`file_details` ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS `service`.`file_process_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service`.`file_process_rules` (
  `fileId` varchar(45) NOT NULL,
  `dataField` varchar(45) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `seqNo` int(11) DEFAULT NULL,
  `startPos` int(11) DEFAULT NULL,
  `endPos` int(11) DEFAULT NULL,
  `length` int(11) DEFAULT NULL,
  `format` varchar(45) DEFAULT NULL,
  `decimals` int(11) DEFAULT NULL,
  `isDelimited` varchar(45) DEFAULT NULL,
  `delimiter` varchar(5) DEFAULT NULL,
  `justified` varchar(45) DEFAULT NULL,
  `dbColumn` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`fileId`,`dataField`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES `service`.`file_process_rules` WRITE;
/*!40000 ALTER TABLE `file_process_rules` DISABLE KEYS */;
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'ACCOUNTNUMBER', 'accountNumber', '3', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'accountNumber');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'ACCOUNTTYPE', 'accountType', '4', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'accountType');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'ADJUSTEDCOSTBASIS', 'adjustedCostBasis', '9', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'adjustedCostBasis');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'AVERAGEDCOST', 'averagedCost', '17', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'averagedCost');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'BOOKCOST', 'bookCost', '18', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'bookCost');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'BOOKPROCEEDS', 'bookProceeds', '19', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'bookProceeds');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'BUSINESSDATE', 'businessDate', '2', '0', '0', '0', 'TEXT', '0', 'N', 'Left', '');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'CERTIFIEDFLAG', 'certifiedFlag', '12', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'certifiedFlag');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'COSTBASIS', 'costBasis', '8', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'costBasis');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'COSTBASISFULLYKNOWN', 'costBasisFullyKnown', '11', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'costBasisFullyKnown');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'COVERED', 'covered', '23', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'covered');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'CURRENTQUANTITY', 'currentQuantity', '7', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'currentQuantity');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'CUSTODIALID', 'custodialID', '1', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'custodialID');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'DISALLOWEDAMOUNT', 'disallowedAmount', '16', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'disallowedAmount');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'FIXEDINCOMECOSTADJUSTMENT', 'fixedIncomeCostAdjustment', '20', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'fixedIncomeCostAdjustment');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'ID', 'ID', '21', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'ID');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'ORIGINALPURCHASEDATE', 'originalPurchaseDate', '13', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'originalPurchaseDate');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'ORIGINALPURCHASEPRICE', 'originalPurchasePrice', '14', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'originalPurchasePrice');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'SECURITYNAME', 'securityName', '22', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'securityName');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'SECURITYTYPE', 'securityType', '5', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'securityType');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'SYMBOLCUSIP', 'symbolCUSIP', '6', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'symbolCUSIP');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'UNKNOWNTOTAL', 'unknownTotal', '24', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'unknownTotal');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'UNREALIZEDGAINLOSS', 'unrealizedGainLoss', '10', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'unrealizedGainLoss');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_CBL', 'WASHSALEINDICATOR', 'washSaleIndicator', '15', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'washSaleIndicator');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_POS', 'ACCOUNTNUMBER', 'accountNumber', '1', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'accountNumber');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_POS', 'ACCOUNTTYPE', 'accountType', '2', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'accountType');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_POS', 'AMOUNT', 'amount', '6', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'amount');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_POS', 'QUANTITY', 'quantity', '5', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'quantity');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_POS', 'SECURITYTYPE', 'securityType', '3', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'securityType');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_POS', 'SYMBOLCUSIP', 'symbolCUSIP', '4', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'symbolCUSIP');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'ACCOUNTNUMBER', 'accountNumber', '14', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'accountNumber');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'ACCOUNTTYPE', 'accountType', '19', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'accountType');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'ADDRESS2', 'address2', '5', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'address2');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'ADDRESS3', 'address3', '6', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'address3');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'ADDRESS4', 'address4', '7', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'address4');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'ADDRESS5', 'address5', '8', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'address5');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'ADDRESS6', 'address6', '9', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'address6');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'ADVISORID', 'advisorID', '15', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'advisorID');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'BILLINGACCOUNTNUMBER', 'billingAccountNumber', '21', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'billingAccountNumber');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'BILLINGINCEPTIONDATE', 'billingInceptionDate', '25', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'billingInceptionDate');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'BIRTHDATE', 'birthDate', '34', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'birthDate');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'CITY', 'city', '10', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'city');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'COMMENTS', 'comments', '19', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'comments');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'COMPANYNAME', 'companyName', '1', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'companyName');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'DEFAULTACCOUNT', 'defaultAccount', '22', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'defaultAccount');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'DISCOUNTRATE', 'discountRate', '35', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'discountRate');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'DISPLAYACCRUEDDIVIDENDS', 'displayAccruedDividends', '32', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'displayAccruedDividends');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'DISPLAYACCRUEDGAINS', 'displayAccruedGains', '33', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'displayAccruedGains');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'DISPLAYACCRUEDINTEREST', 'displayAccruedInterest', '31', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'displayAccruedInterest');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'FAXNUMBER', 'faxNumber', '18', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'faxNumber');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'FEDERALTAXRATE', 'federalTaxRate', '26', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'federalTaxRate');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'FIRSTNAME', 'firstName', '3', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'firstName');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'FISCALYEAREND', 'fiscalYearEnd', '29', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'fiscalYearEnd');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'LASTNAME', 'lastName', '2', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'lastName');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'MONTHSINSHORTTERMHOLDINGPERIOD', 'monthsInShortTermholdingperiod', '28', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'monthsInShortTermholdingperiod');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'OBJECTIVE', 'objective', '20', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'objective');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'PAYOUTRATE', 'payoutRate', '36', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'payoutRate');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'PERFORMANCEINCEPTIONDATE', 'performanceInceptionDate', '24', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'performanceInceptionDate');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'PHONENUMBER', 'phoneNumber', '17', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'phoneNumber');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'SSNORTAXID', 'SSNOrTaxID', '13', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'SSNOrTaxID');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'STATE', 'state', '11', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'state');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'STATEOFPRIMARYRESIDENCE', 'stateOfPrimaryResidence', '23', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'stateOfPrimaryResidence');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'STATETAXRATE', 'stateTaxRate', '27', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'stateTaxRate');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'STREET', 'street', '4', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'street');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'TAXABLE', 'taxable', '16', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'taxable');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'USEAVERAGECOSTACCOUNTING', 'useAverageCostAccounting', '30', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'useAverageCostAccounting');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRD', 'ZIPCODE', 'zipCode', '12', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'zipCode');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'ACCOUNTNUMBER', 'accountNumber', '3', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'accountNumber');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'ACCOUNTTYPE', 'accountType', '16', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'accountType');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'ACCRUEDINTEREST', 'accruedInterest', '17', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'accruedInterest');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'BROKERACCOUNT', 'brokerAccount', '1', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'brokerAccount');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'BROKERFEE', 'brokerFee', '12', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'brokerFee');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'CANCELSTATUSFLAG', 'cancelStatusFlag', '5', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'cancelStatusFlag');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'CLOSINGACCOUNTINGMETHOD', 'closingAccountingMethod', '18', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'closingAccountingMethod');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'COMMENTS', 'comments', '19', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'comments');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'FILEDATE', 'fileDate', '2', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'fileDate');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'FROMTOACCOUNT', 'fromToAccount', '15', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'fromToAccount');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'NETAMOUNT', 'netAmount', '10', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'netAmount');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'OTHERFEES', 'otherFees', '13', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'otherFees');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'PRINCIPALGROSSAMOUNT', 'principalGrossAmount', '11', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'principalGrossAmount');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'QUANTITY', 'quantity', '9', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'quantity');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'SECURITYCODE', 'securityCode', '7', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'securityCode');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'SETTLEDATEEXDATE', 'settleDateExDate', '14', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'settleDateExDate');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'SYMBOLCUSIP', 'symbolCUSIP', '6', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'symbolCUSIP');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'TRADEDATEPAYDATE', 'tradeDatePayDate', '8', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'tradeDatePayDate');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('BB_TRN', 'TRANSACTIONCODE', 'transactionCode', '4', '0', '0', '0', 'TEXT', '0', 'N', 'Left', 'transactionCode');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('TRADE_FILE', 'ACTION', 'Transaction Action', '6', '91', '91', '1', 'TEXT', '0', 'N', 'Left', 'action');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('TRADE_FILE', 'EXCHANGE', 'Exchange Code', '2', '21', '24', '4', 'TEXT', '0', 'N', 'Left', 'exchange');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('TRADE_FILE', 'INDPRICE', 'Indicative Transaction Price', '7', '92', '102', '11', 'NUMERIC', '5', 'N', 'Left', 'tradeprice');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('TRADE_FILE', 'QUANTITY', 'Order Quantity', '5', '80', '90', '11', 'TEXT', '0', 'N', 'Left', 'qty');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('TRADE_FILE', 'RIC', 'Exchange stock code', '3', '25', '39', '15', 'TEXT', '0', 'N', 'Left', 'ticker');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('TRADE_FILE', 'ROBOID', 'Unique Robo User ID', '1', '1', '20', '20', 'TEXT', '0', 'N', 'Left', 'clientAccountID');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('TRADE_FILE', 'STKNAME', 'Stock name', '4', '40', '79', '40', 'TEXT', '0', 'N', 'Left', 'ticker');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('TRADE_FILE', 'TRANSDATE', 'Transaction Date', '8', '103', '112', '10', 'TEXT', '0', 'N', 'Left', 'tradedate');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`) VALUES ('TRADE_FILE_SELL', 'ACTION', 'Transaction Action', '6', '91', '91', '1', 'TEXT', '0', 'Y', ',', 'Left', 'action');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`) VALUES ('TRADE_FILE_SELL', 'EXCHANGE', 'Exchange Code', '2', '21', '24', '4', 'TEXT', '0', 'Y', ',', 'Left', 'exchange');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`) VALUES ('TRADE_FILE_SELL', 'INDPRICE', 'Indicative Transaction Price', '7', '92', '102', '11', 'NUMERIC', '0', 'Y', ',', 'Left', 'tradeprice');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`) VALUES ('TRADE_FILE_SELL', 'QUANTITY', 'Order Quantity', '5', '80', '90', '11', 'TEXT', '0', 'Y', ',', 'Left', 'qty');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`) VALUES ('TRADE_FILE_SELL', 'RIC', 'Exchange stock code', '3', '25', '39', '15', 'TEXT', '0', 'Y', ',', 'Left', 'ticker');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`) VALUES ('TRADE_FILE_SELL', 'ROBOID', 'Unique Robo User ID', '1', '1', '20', '20', 'TEXT', '0', 'Y', ',', 'Left', 'clientAccountID');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`) VALUES ('TRADE_FILE_SELL', 'STKNAME', 'Stock name', '4', '40', '79', '40', 'TEXT', '0', 'Y', ',', 'Left', 'ticker');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`) VALUES ('TRADE_FILE_SELL', 'TRANSDATE', 'Transaction Date', '8', '103', '112', '10', 'TEXT', '0', 'Y', ',', 'Left', 'tradedate');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`) VALUES ('UOB_CLIENT_ACCT_BALANCE_FILE', 'ACCTBAL', 'Account Balance', '3', '25', '39', '15', 'NUMERIC', '2', 'N', 'Left');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`) VALUES ('UOB_CLIENT_ACCT_BALANCE_FILE', 'CCYCDE', 'Currency Code', '2', '21', '24', '4', 'TEXT', '0', 'N', 'Left');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('UOB_CLIENT_ACCT_BALANCE_FILE', 'ROBOID', 'Unique Robo User ID', '1', '1', '20', '20', 'TEXT', '0', 'N', 'Left', 'accountNumber');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`) VALUES ('UOB_CLIENT_ACCT_HOLDING_FILE', 'EXCHANGE', 'Exchange Code', '2', '21', '24', '4', 'TEXT', '0', 'N', 'Left');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('UOB_CLIENT_ACCT_HOLDING_FILE', 'QUANTITY', 'Holding Quantity', '5', '80', '90', '11', 'TEXT', '0', 'N', 'Left', 'quantity');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`) VALUES ('UOB_CLIENT_ACCT_HOLDING_FILE', 'RIC', 'Exchange stock code', '3', '25', '39', '15', 'TEXT', '0', 'N', 'Left');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('UOB_CLIENT_ACCT_HOLDING_FILE', 'ROBOID', 'Unique Robo User ID', '1', '1', '20', '20', 'TEXT', '0', 'N', 'Left', 'accountNumber');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('UOB_CLIENT_ACCT_HOLDING_FILE', 'STKNAME', 'Stock name', '4', '40', '79', '40', 'TEXT', '0', 'N', 'Left', 'symbolCUSIP');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('UOB_CLIENT_STATUS_FILE', 'NAME', 'Name', '2', '21', '80', '60', 'TEXT', '0', 'N', 'Left', 'firstName');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('UOB_CLIENT_STATUS_FILE', 'ROBOID', 'Unique Robo User ID', '1', '1', '20', '20', 'TEXT', '0', 'N', 'Left', 'acctnum');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`) VALUES ('UOB_CLIENT_STATUS_FILE', 'STATUS', 'Status Code', '3', '81', '84', '4', 'TEXT', '0', 'N', 'Left');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`) VALUES ('UOB_EOD_ORDER_EXEC_FILE', 'ACTION', 'Transaction Action', '6', '91', '91', '1', 'TEXT', '0', 'N', 'Left');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`) VALUES ('UOB_EOD_ORDER_EXEC_FILE', 'EXCHANGE', 'Exchange Code', '2', '21', '24', '4', 'TEXT', '0', 'N', 'Left');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`) VALUES ('UOB_EOD_ORDER_EXEC_FILE', 'EXEPRICE', 'Execution Price', '7', '92', '102', '11', 'NUMERIC', '5', 'N', 'Left');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`) VALUES ('UOB_EOD_ORDER_EXEC_FILE', 'QUANTITY', 'Order Quantity', '5', '80', '90', '11', 'TEXT', '0', 'N', 'Left');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`) VALUES ('UOB_EOD_ORDER_EXEC_FILE', 'RIC', 'Exchange stock code', '3', '25', '39', '15', 'TEXT', '0', 'N', 'Left');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('UOB_EOD_ORDER_EXEC_FILE', 'ROBOID', 'Unique Robo User ID', '1', '1', '20', '20', 'TEXT', '0', 'N', 'Right', 'accountNumber');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`) VALUES ('UOB_EOD_ORDER_EXEC_FILE', 'STKNAME', 'Stock name', '4', '40', '79', '40', 'TEXT', '0', 'N', 'Left');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`) VALUES ('UOB_EOD_ORDER_EXEC_FILE', 'TRANSDATE', 'Transaction Date', '8', '103', '112', '10', 'TEXT', '0', 'N', 'Left');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('UOB_ORDER_INSTRUCTION_FILE', 'ACTION', 'Transaction Action', '6', '91', '91', '1', 'TEXT', '0', 'N', 'Left', 'action');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('UOB_ORDER_INSTRUCTION_FILE', 'EXCHANGE', 'Exchange Code', '2', '21', '24', '4', 'TEXT', '0', 'N', 'Left', 'exchange');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('UOB_ORDER_INSTRUCTION_FILE', 'INDPRICE', 'Indicative Transaction Price', '7', '92', '102', '11', 'NUMERIC', '5', 'N', 'Left', 'tradeprice');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('UOB_ORDER_INSTRUCTION_FILE', 'QUANTITY', 'Order Quantity', '5', '80', '90', '11', 'TEXT', '0', 'N', 'Left', 'qty');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('UOB_ORDER_INSTRUCTION_FILE', 'RIC', 'Exchange stock code', '3', '25', '39', '15', 'TEXT', '0', 'N', 'Left', 'ticker');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('UOB_ORDER_INSTRUCTION_FILE', 'ROBOID', 'Unique Robo User ID', '1', '1', '20', '20', 'TEXT', '0', 'N', 'Left', 'clientAccountID');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('UOB_ORDER_INSTRUCTION_FILE', 'STKNAME', 'Stock name', '4', '40', '79', '40', 'TEXT', '0', 'N', 'Left', 'ticker');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`) VALUES ('UOB_ORDER_INSTRUCTION_FILE', 'TRANSDATE', 'Transaction Date', '8', '103', '112', '10', 'TEXT', '0', 'N', 'Left', 'tradedate');
/*!40000 ALTER TABLE `service`.`file_process_rules` ENABLE KEYS */;
UNLOCK TABLES;



USE `service`;
DROP procedure IF EXISTS `sel_service_details`;

DELIMITER $$
USE `service`$$
CREATE PROCEDURE `sel_service_details`(
IN p_product  varchar(50),
IN p_service  varchar(50),
IN p_type  varchar(50),
IN p_info varchar(50)
)
BEGIN
if(p_service ='FILE-PROCESS' and p_type='ADDITIONAL_DETAILS' and p_info='FILE_DETAILS')then

	select vendor, fileName, processId, process, fileType, fileExtension, fileId, containsHeader,
    active, seqNo, uploadDir, preDBProcess, postDBProcess, preInstruction, postInstruction, fileNameAppender,
    appenderFormat, available, sourcePath, downloadDir, loadFormat, required, canBeEmpty, keyData, encryptionMethod,
    encColumns, tmpTableName, canBeDups, delimiter, delFlagServerFile, delDayServerFile, delFlagLocalFile,
	delDayLocalFile, delFlagDecrFile, fileProcessType, parentPreDBProcess, parentPostDBProcess, parentPreInstruction,
    parentPostInstruction, created, lastupdated
	from service.file_details
    where vendor= p_product;
elseif(p_service ='FILE-PROCESS' and p_type='COMMON_DETAILS' and p_info='FILE_RULES')then

	select fcr.fileId, fcr.dataField, fcr.description, fcr.seqNo, fcr.startPos, fcr.endPos, 
    fcr.length, fcr.format, fcr.decimals, fcr.isDelimited, fcr.delimiter, fcr.justified, fcr.dbColumn 
	from service.file_process_rules fcr 
	where fcr.fileId in(select fileId from service.file_details where vendor= p_product) order by fileId, fcr.seqNo;
elseif(p_service ='DOCUSIGN-SERVICES' and p_type='COMMON_DETAILS' and p_info='DOCUSIGN_MAPPING')then

	select * from service.dc_template_mapping
    where (dbColumn IS NOT NULL or dbColumn != '')
    order by tempCode, role, tab;
 elseif(p_service ='DOCUSIGN-SERVICES' and p_type='ADDITIONAL_DETAILS' and p_info='TEMPLATE_DETAILS')then

	select * from service.dc_template_details
    where company= p_product
    order by company,mode, tempCode;

elseif(p_type='OPERATION_DETAILS' and p_info='OPERATION_DETAILS')then

	select * from service.service_operation_details
    where  status='A' and company=p_product and service=p_service
	order by operation;
end if;

END$$

DELIMITER ;



UPDATE `service`.`file_process_rules` SET `dbColumn`='clientAccountID' WHERE `fileId`='UOB_CLIENT_ACCT_BALANCE_FILE' and`dataField`='ROBOID';
UPDATE `service`.`file_process_rules` SET `dbColumn`='clientAccountID' WHERE `fileId`='UOB_CLIENT_ACCT_HOLDING_FILE' and`dataField`='ROBOID';
UPDATE `service`.`file_process_rules` SET `dbColumn`='clientAccountID' WHERE `fileId`='UOB_EOD_ORDER_EXEC_FILE' and`dataField`='ROBOID';
UPDATE `service`.`file_process_rules` SET `dbColumn`='clientAccountID' WHERE `fileId`='UOB_CLIENT_STATUS_FILE' and`dataField`='ROBOID';
UPDATE `service`.`file_process_rules` SET `dbColumn`='lastName' WHERE `fileId`='UOB_CLIENT_STATUS_FILE' and`dataField`='NAME';

UPDATE `service`.`file_details` SET `postDBProcess`='invdb.sp_upload_ext_acct_info' WHERE `vendor`='UOB' and`fileName`='CLNTSTATUS';
UPDATE `service`.`file_details` SET `postDBProcess`='invdb.sp_upload_nav' WHERE `vendor`='UOB' and`fileName`='CLNTBAL';
UPDATE `service`.`file_details` SET `postDBProcess`='invdb.sp_upload_position' WHERE `vendor`='UOB' and`fileName`='CLNTHOLD';
UPDATE `service`.`file_details` SET `postDBProcess`='invdb.sp_upload_tranaction' WHERE `vendor`='UOB' and`fileName`='CLNTORDEXE';

UPDATE `service`.`service_config_details` SET `value`='D:/data/tradeFiles' WHERE `mode`='UAT' and`company`='UOB' and`service`='FILE-PROCESS' and`vendor`='VENDOR' and`name`='DOWNLOAD_LOCAL_SRC_DIRECTORY';


ALTER TABLE `service`.`file_details`
ADD COLUMN `parentPreDBProcess` VARCHAR(80) NULL DEFAULT NULL AFTER `fileProcessType`,
ADD COLUMN `parentPostDBProcess` VARCHAR(80) NULL DEFAULT NULL AFTER `parentPreDBProcess`,
ADD COLUMN `parentPreInstruction` VARCHAR(80) NULL DEFAULT NULL AFTER `parentPostDBProcess`,
ADD COLUMN `parentPostInstruction` VARCHAR(80) NULL DEFAULT NULL AFTER `parentPreInstruction`;

UPDATE `service`.`file_details` SET `fileNameAppender`='PREFIX' WHERE `vendor`='UOB' and`fileName`='CLNTBAL';
UPDATE `service`.`file_details` SET `fileNameAppender`='PREFIX' WHERE `vendor`='UOB' and`fileName`='CLNTHOLD';
UPDATE `service`.`file_details` SET `fileNameAppender`='POSTFIX' WHERE `vendor`='UOB' and`fileName`='CLNTORDEXE';
UPDATE `service`.`file_details` SET `fileNameAppender`='POSTFIX' WHERE `vendor`='UOB' and`fileName`='CLNTSTATUS';

UPDATE `service`.`file_details` SET `uploadDir`='/eodFiles' WHERE `vendor`='UOB' and`fileName`='CLNTBAL';
UPDATE `service`.`file_details` SET `uploadDir`='/eodFiles' WHERE `vendor`='UOB' and`fileName`='CLNTSTATUS';
UPDATE `service`.`file_details` SET `uploadDir`='/eodFiles' WHERE `vendor`='UOB' and`fileName`='CLNTORDEXE';
UPDATE `service`.`file_details` SET `uploadDir`='/eodFiles' WHERE `vendor`='UOB' and`fileName`='CLNTHOLD';


ALTER TABLE `service`.`file_process_rules`
ADD COLUMN `isRequired` VARCHAR(1) NULL DEFAULT 'N' AFTER `dbColumn`,
ADD COLUMN `needToEncrypt` VARCHAR(1) NULL DEFAULT 'N' AFTER `isRequired`;


ALTER TABLE `service`.`file_details`
DROP PRIMARY KEY,
ADD PRIMARY KEY (`vendor`, `fileName`, `processId`);
