/* 01.ap.PREUAT- FileProcessor SERVICE.sql190218_abhang*/

USE `service`;

ALTER TABLE `service`.`file_process_rules` 
ADD COLUMN `type` VARCHAR(45) NULL DEFAULT NULL AFTER `length`;

set sql_safe_updates=0;
delete from service.file_process_rules where fileId in (select fileID from service.file_details where vendor='UOB');
delete from service.file_details where vendor='UOB';


INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `seqNo`, `fileId`, `fileType`, `fileExtension`, `containsHeader`, `active`, `fileNameAppender`, `appenderFormat`, `uploadDir`, `sourcePath`, `downloadDir`, `loadFormat`, `delimiter`, `required`, `canBeEmpty`, `canBeDups`, `tmpTableName`, `parentPreDBProcess`, `parentPostDBProcess`, `parentPreInstruction`, `postDBProcess`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CLNTCASH', 'UPLD1', 'UPLOAD', '6', 'UOB_ACCOUNT_CASH_FILE', 'TEXT', 'dat', 'N', 'A', 'POSTFIX', 'YYYYMMDD', '/eodFiles', '/uob/', '/uob/', 'DELIMITED', ',', 'Y', 'Y', 'N', 'temp.tmp_nav', 'temp.parentDBProcedure', 'temp.sp_td_eod_process', '', 'temp.sp_upload_nav', 'Y', '5', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `seqNo`, `fileId`, `fileType`, `fileExtension`, `containsHeader`, `active`, `fileNameAppender`, `appenderFormat`, `uploadDir`, `sourcePath`, `downloadDir`, `loadFormat`, `delimiter`, `required`, `canBeEmpty`, `canBeDups`, `tmpTableName`, `parentPreDBProcess`, `parentPostDBProcess`, `parentPreInstruction`, `postDBProcess`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CLNTEXCHRATE', 'UPLD1', 'UPLOAD', '7', 'UOB_EXCHANGE_RATE_FILE', 'TEXT', 'dat', 'N', 'A', 'POSTFIX', 'YYYYMMDD', '/eodFiles', '/uob/', '/uob/', 'DELIMITED', ',', 'Y', 'Y', 'N', 'temp.tmp_exchange_rate', 'temp.parentDBProcedure', 'temp.sp_td_eod_process', '', 'temp.sp_upload_exchange_rate', 'Y', '5', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `seqNo`, `fileId`, `fileType`, `fileExtension`, `containsHeader`, `active`, `fileNameAppender`, `appenderFormat`, `uploadDir`, `sourcePath`, `downloadDir`, `loadFormat`, `delimiter`, `required`, `canBeEmpty`, `canBeDups`, `tmpTableName`, `parentPreDBProcess`, `parentPostDBProcess`, `postDBProcess`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CLNTFUND', 'UPLD1', 'UPLOAD', '3', 'UOB_ACCOUNT_FUNDING_FILE', 'TEXT', 'dat', 'N', 'I', 'POSTFIX', 'YYYYMMDD', '/eodFiles', '/uob/', '/uob/', 'DELIMITED', ',', 'Y', 'N', 'N', 'temp.tmp_investment', 'temp.parentDBProcedure', 'temp.sp_td_eod_process', 'temp.sp_upload_investment', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `seqNo`, `fileId`, `fileType`, `fileExtension`, `containsHeader`, `active`, `fileNameAppender`, `appenderFormat`, `uploadDir`, `sourcePath`, `downloadDir`, `loadFormat`, `delimiter`, `required`, `canBeEmpty`, `canBeDups`, `tmpTableName`, `parentPreDBProcess`, `parentPostDBProcess`, `postDBProcess`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CLNTHOLD', 'UPLD1', 'UPLOAD', '5', 'UOB_ACCOUNT_HOLDING_FILE', 'TEXT', 'dat', 'N', 'A', 'POSTFIX', 'YYYYMMDD', '/eodFiles', '/uob/', '/uob/', 'DELIMITED', ',', 'Y', 'Y', 'N', 'temp.tmp_position', 'temp.parentDBProcedure', 'temp.sp_td_eod_process', 'temp.sp_upload_position', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `seqNo`, `fileId`, `fileType`, `fileExtension`, `containsHeader`, `active`, `fileNameAppender`, `appenderFormat`, `uploadDir`, `loadFormat`, `delimiter`, `required`, `canBeDups`, `fileProcessType`, `preDBProcess`, `postDBProcess`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CLNTORD', 'DOWD1', 'DOWNLOAD', '1', 'UOB_ORDER_PROCESSING_FILE', 'TEXT', 'dat', 'Y', 'A', 'PREFIX', 'YYYYMMDD', '/tradeFiles', 'DELIMITED', ',', 'N', 'N', 'SFTP,MAIL', 'temp.sp_trade_process_both', 'temp.sp_trade_process_both_update', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `seqNo`, `fileId`, `fileType`, `fileExtension`, `containsHeader`, `active`, `fileNameAppender`, `appenderFormat`, `uploadDir`, `sourcePath`, `downloadDir`, `loadFormat`, `delimiter`, `required`, `canBeEmpty`, `canBeDups`, `tmpTableName`, `parentPreDBProcess`, `parentPostDBProcess`, `postDBProcess`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CLNTORDEXE', 'UPLD1', 'UPLOAD', '7', 'UOB_ORDER_EXECUTION_FILE', 'TEXT', 'dat', 'N', 'I', 'POSTFIX', 'YYYYMMDD', '/eodFiles', '/uob/', '/uob/', 'DELIMITED', ',', 'Y', 'N', 'N', 'temp.tmp_transaction', 'temp.parentDBProcedure', 'temp.sp_td_eod_process', '', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `seqNo`, `fileId`, `fileType`, `fileExtension`, `containsHeader`, `active`, `fileNameAppender`, `appenderFormat`, `uploadDir`, `loadFormat`, `delimiter`, `required`, `canBeDups`, `fileProcessType`, `preDBProcess`, `postDBProcess`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CLNTORDISIN', 'DOWD1', 'DOWNLOAD', '2', 'UOB_ORDER_PROCESSING_FILE_ISIN_WISE', 'TEXT', 'dat', 'Y', 'A', 'PREFIX', 'YYYYMMDD', '/tradeFiles', 'DELIMITED', ',', 'N', 'N', 'SFTP,MAIL', 'temp.sp_trade_process_isin_wise', '', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `seqNo`, `fileId`, `fileType`, `fileExtension`, `containsHeader`, `active`, `fileNameAppender`, `appenderFormat`, `uploadDir`, `sourcePath`, `downloadDir`, `loadFormat`, `delimiter`, `required`, `canBeEmpty`, `canBeDups`, `tmpTableName`, `parentPreDBProcess`, `parentPostDBProcess`, `postDBProcess`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CLNTOTHREF', 'UPLD1', 'UPLOAD', '1', 'UOB_OTHER_REFERENCE_DATA_FROM_UOBKH', 'TEXT', 'dat', 'N', 'A', 'POSTFIX', 'YYYYMMDD', '/eodFiles', '/uob/', '/uob/', 'DELIMITED', ',', 'Y', 'Y', 'N', 'temp.tmp_sales_rep', 'temp.parentDBProcedure', 'temp.sp_td_eod_process', 'temp.sp_upload_sales_rep', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `seqNo`, `fileId`, `fileType`, `fileExtension`, `containsHeader`, `active`, `fileNameAppender`, `appenderFormat`, `uploadDir`, `sourcePath`, `downloadDir`, `loadFormat`, `delimiter`, `required`, `canBeEmpty`, `canBeDups`, `tmpTableName`, `parentPreDBProcess`, `parentPostDBProcess`, `postDBProcess`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CLNTSETT', 'UPLD1', 'UPLOAD', '4', 'UOB_SETTLEMENT_FILE', 'TEXT', 'dat', 'N', 'A', 'POSTFIX', 'YYYYMMDD', '/eodFiles', '/uob/', '/uob/', 'DELIMITED', ',', 'Y', 'Y', 'N', 'temp.tmp_transaction', 'temp.parentDBProcedure', 'temp.sp_td_eod_process', '', 'N', '30', 'N', '0', 'N');
INSERT INTO `service`.`file_details` (`vendor`, `fileName`, `processId`, `process`, `seqNo`, `fileId`, `fileType`, `fileExtension`, `containsHeader`, `active`, `fileNameAppender`, `appenderFormat`, `uploadDir`, `sourcePath`, `downloadDir`, `loadFormat`, `delimiter`, `required`, `canBeEmpty`, `canBeDups`, `tmpTableName`, `parentPreDBProcess`, `parentPostDBProcess`, `parentPostInstruction`, `postDBProcess`, `delFlagServerFile`, `delDayServerFile`, `delFlagLocalFile`, `delDayLocalFile`, `delFlagDecrFile`) VALUES ('UOB', 'CLNTSTATUS', 'UPLD1', 'UPLOAD', '2', 'UOB_ACCOUNT_STATUS_FILE', 'TEXT', 'dat', 'N', 'A', 'POSTFIX', 'YYYYMMDD', '/eodFiles', '/uob/', '/uob/', 'DELIMITED', ',', 'Y', 'Y', 'N', 'temp.tmp_client_data', 'temp.parentDBProcedure', 'temp.sp_td_eod_process', '/data/eodFiles/test.sh', 'temp.sp_upload_ext_acct_info', 'N', '30', 'N', '0', 'N');


INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_CASH_FILE', 'AMOUNTINTRUST', 'Amount in trust', '3', '19', '34', '16', 'NUMERIC', '2', 'N', 'Left', 'cash', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_CASH_FILE', 'BUSINESSDATE', 'Business Date', '2', '11', '18', '8', 'DATE', 'yyyyMMdd', '0', 'N', 'Left', 'reportDate', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_CASH_FILE', 'CURRENCYCODE', 'Currency Code', '4', '35', '37', '3', 'TEXT', '0', 'N', 'Left', 'currencyPrimary', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_CASH_FILE', 'UOBKHID', 'UOBKH ID', '1', '1', '10', '10', 'TEXT', '0', 'N', 'Left', 'clientAccountID', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_FUNDING_FILE', 'AMOUNTINTRUST', 'Amount in trust', '3', '13', '15', '13', 'NUMERIC', '0', 'N', 'Left', 'cash', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_FUNDING_FILE', 'BUSINESSDATE', 'Business Date', '2', '11', '12', '8', 'DATE', 'yyyyMMdd', '0', 'N', 'Left', 'reportDate', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_FUNDING_FILE', 'CURRENCYCODE', 'Currency Code', '4', '16', '19', '3', 'TEXT', '0', 'N', 'Left', 'currencyPrimary', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_FUNDING_FILE', 'UOBKHID', 'UOBKH ID', '1', '1', '10', '10', 'TEXT', '0', 'N', 'Left', 'clientAccountID', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_HOLDING_FILE', 'BUSINESSDATE', 'Business Date', '2', '11', '18', '8', 'DATE', 'yyyyMMdd', '0', 'N', 'Left', 'reportDate', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_HOLDING_FILE', 'CURRENCYCODE', 'Currency Code', '4', '31', '33', '3', 'TEXT', '0', 'N', 'Left', 'currencyPrimary', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_HOLDING_FILE', 'INSTRUMENTID(ISINORRIC)', 'Instrument ID (Isin or RIC)', '3', '19', '30', '12', 'TEXT', '0', 'N', 'Left', 'symbol', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_HOLDING_FILE', 'MARKPRICE', 'Mark Price', '6', '45', '58', '14', 'NUMERIC', '6', 'N', 'Left', 'markPrice', 'N', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_HOLDING_FILE', 'MONEYVALUE', 'Money Value ', '7', '59', '74', '16', 'NUMERIC', '2', 'N', 'Left', 'positionValue', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_HOLDING_FILE', 'SHAREQUANTITY', 'Share Quantity', '5', '34', '44', '11', 'NUMERIC', '0', 'N', 'Left', 'quantity', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_HOLDING_FILE', 'UOBKHID', 'UOBKH ID', '1', '1', '10', '10', 'TEXT', '0', 'N', 'Left', 'clientAccountID', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_STATUS_FILE', 'ADDRESSLINE1', 'addressLine1', '9', '182', '221', '40', 'TEXT', '0', 'N', 'Left', 'street', 'N', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_STATUS_FILE', 'ADDRESSLINE2', 'addressLine2', '10', '222', '261', '40', 'TEXT', '0', 'N', 'Left', 'address2', 'N', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_STATUS_FILE', 'ADDRESSLINE3', 'addressLine3', '11', '262', '301', '40', 'TEXT', '0', 'N', 'Left', 'address3', 'N', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_STATUS_FILE', 'ADDRESSLINE4', 'addressLine4', '12', '302', '341', '40', 'TEXT', '0', 'N', 'Left', 'address4', 'N', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_STATUS_FILE', 'APPLICATIONSFULLNAME', 'Applications Full Name', '4', '34', '93', '60', 'TEXT', '0', 'N', 'Left', 'fullName', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_STATUS_FILE', 'CITY', 'City', '13', '342', '366', '25', 'TEXT', '0', 'N', 'Left', 'city', 'N', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_STATUS_FILE', 'COUNTRY', 'Country', '16', '417', '446', '30', 'TEXT', '0', 'N', 'Left', 'country', 'N', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_STATUS_FILE', 'DATEOFBIRTH', 'Date of Birth', '7', '162', '169', '8', 'DATE', 'yyyyMMdd', '0', 'N', 'Left', 'birthDate', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_STATUS_FILE', 'DATEOPENED', 'Date Opened', '6', '154', '161', '8', 'DATE', 'yyyyMMdd', '0', 'N', 'Left', 'dateOpened', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_STATUS_FILE', 'EMAILADDRESS', 'Email Address', '5', '94', '153', '60', 'TEXT', '0', 'N', 'Left', 'emailAddress', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_STATUS_FILE', 'PRIMARYPHONENBR', 'Primary Phone Nbr', '17', '447', '466', '20', 'TEXT', '0', 'N', 'Left', 'phoneNumber', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_STATUS_FILE', 'REPCODE', 'RepCode', '8', '170', '181', '12', 'TEXT', '0', 'N', 'Left', 'advisorID', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_STATUS_FILE', 'ROBOID', 'RoboID', '1', '1', '20', '20', 'NUMERIC', '0', 'N', 'Left', 'acctnum', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_STATUS_FILE', 'STATE/PROVENCE', 'State/Provence', '14', '367', '406', '40', 'TEXT', '0', 'N', 'Left', 'state', 'N', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_STATUS_FILE', 'STATUS', 'Status', '3', '31', '33', '3', 'TEXT', '0', 'N', 'Left', 'status', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_STATUS_FILE', 'UOBKHID', 'UOBKH ID', '2', '21', '30', '10', 'TEXT', '0', 'N', 'Left', 'clientAccountID', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCOUNT_STATUS_FILE', 'ZIPCODE', 'Zip Code', '15', '407', '416', '10', 'TEXT', '0', 'N', 'Left', 'zipCode', 'N', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `format`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_EXCHANGE_RATE_FILE', 'BUSINESSDATE', 'Business Date', '1', '11', '18', '8', 'DATE', 'yyyyMMdd', '0', 'N', 'Left', 'reportDate', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_EXCHANGE_RATE_FILE', 'EXCHANGERATE', 'Exchange Rate', '3', '34', '44', '11', 'NUMERIC', '0', 'N', 'Left', 'exchangeRate', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_EXCHANGE_RATE_FILE', 'TRADECURRENCY', 'Trade CUrrency', '2', '1', '10', '10', 'TEXT', '0', 'N', 'Left', 'tradeCurrency', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_EXECUTION_FILE', 'BASECURRENCY', 'Base Currency', '9', '76', '78', '3', 'TEXT', '0', 'N', 'Left', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_EXECUTION_FILE', 'BROKERFEE', 'brokerFee', '14', '201', '214', '14', 'NUMERIC', '6', 'N', 'Left', 'N', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_EXECUTION_FILE', 'COMMENT', 'Comment', '13', '121', '200', '80', 'TEXT', '0', 'N', 'Left', 'N', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_EXECUTION_FILE', 'CONFIRMATIONNUMBER', 'Confirmation Number', '12', '101', '120', '20', 'TEXT', '0', 'N', 'Left', 'N', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_EXECUTION_FILE', 'EXCHANGERATETOBASECURRENCY', 'Exchange Rate to Base Currency', '10', '79', '92', '14', 'NUMERIC', '6', 'N', 'Left', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_EXECUTION_FILE', 'EXECUTIONCURRENCY', 'Execution Currency', '4', '31', '33', '3', 'TEXT', '0', 'N', 'Left', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_EXECUTION_FILE', 'EXECUTIONPRICE', 'Execution Price ', '7', '46', '59', '14', 'NUMERIC', '6', 'N', 'Left', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_EXECUTION_FILE', 'ISIN', 'ISIN', '3', '19', '30', '12', 'TEXT', '0', 'N', 'Left', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_EXECUTION_FILE', 'NETMONEYVALUE', 'Net Money Value', '8', '60', '75', '16', 'NUMERIC', '2', 'N', 'Left', 'N', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_EXECUTION_FILE', 'OTHERFEE', 'otherFee', '15', '215', '228', '14', 'NUMERIC', '6', 'N', 'Left', 'N', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_EXECUTION_FILE', 'QUANTITY', 'Quantity', '6', '35', '45', '11', 'NUMERIC', '0', 'N', 'Left', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `format`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_EXECUTION_FILE', 'SETTLEMENTDATE', 'Settlement Date', '11', '93', '100', '8', 'DATE', 'yyyyMMdd', '0', 'N', 'Left', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `format`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_EXECUTION_FILE', 'TRADEDATE', 'Trade Date', '2', '11', '18', '8', 'DATE', 'yyyyMMdd', '0', 'N', 'Left', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_EXECUTION_FILE', 'TRANSACTIONTYPE', 'Transaction Type', '5', '34', '34', '1', 'TEXT', '0', 'N', 'Left', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_EXECUTION_FILE', 'UOBKHID', 'UOBKH ID', '1', '1', '10', '10', 'TEXT', '0', 'N', 'Left', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE', 'BUY/SELLINDICATOR', 'Buy/Sell Indicator', '6', '52', '52', '1', 'TEXT', '0', 'Y', ',', 'Left', 'action', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE', 'EXCHANGE', 'Exchange', '3', '23', '26', '4', 'TEXT', '0', 'Y', ',', 'Left', 'exchange', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `format`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE', 'FILEDATE', 'File Date', '9', '72', '79', '8', 'DATE', 'yyyyMMdd', '0', 'Y', ',', 'Left', 'tradeDate', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE', 'INDICATIVECURRENCY', 'Indicative Currency', '7', '53', '55', '3', 'TEXT', '0', 'Y', ',', 'Left', 'currency', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE', 'INDICATIVEPRICE*', 'Indicative Price*', '5', '38', '51', '14', 'NUMERIC', '6', 'Y', ',', 'Left', 'tradePrice', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE', 'INDICATIVEVALUE*', 'Indicative Value*', '8', '56', '71', '16', 'NUMERIC', '2', 'Y', ',', 'Left', 'investmentamount', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE', 'ISIN', 'ISIN', '2', '11', '22', '12', 'TEXT', '0', 'Y', ',', 'Left', 'ticker', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE', 'QUANTITY', 'Quantity', '4', '27', '37', '11', 'NUMERIC', '0', 'Y', ',', 'Left', 'qty', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE', 'UOBKHID', 'UOBKH ID', '1', '1', '10', '10', 'TEXT', '0', 'Y', ',', 'Left', 'clientAccountID', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE_ISIN_WISE', 'BUYQUANTITY', 'Buy Quantity', '2', '13', '23', '11', 'NUMERIC', '0', 'Y', ',', 'Left', 'buyQty', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `format`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE_ISIN_WISE', 'FILEDATE', 'File Date', '5', '46', '53', '8', 'DATE', 'yyyyMMdd', '0', 'Y', ',', 'Left', 'tradeDate', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE_ISIN_WISE', 'ISIN', 'ISIN', '1', '1', '12', '12', 'TEXT', '0', 'Y', ',', 'Left', 'ticker', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE_ISIN_WISE', 'SELLQUANTITY', 'Sell Quantity', '3', '24', '34', '11', 'NUMERIC', '0', 'Y', ',', 'Left', 'sellQty', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE_ISIN_WISE', 'TOTALNETQUANTITY', 'Total Net Quantity', '4', '35', '45', '11', 'NUMERIC', '0', 'Y', ',', 'Left', 'netQty', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_OTHER_REFERENCE_DATA_FROM_UOBKH', 'OTHERREFERENCE', 'Other Reference', '3', '73', '132', '60', 'TEXT', '0', 'N', 'Left', 'otherRefe', 'N', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_OTHER_REFERENCE_DATA_FROM_UOBKH', 'REPID', 'REPID', '1', '1', '12', '12', 'TEXT', '0', 'N', 'Left', 'repId', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_OTHER_REFERENCE_DATA_FROM_UOBKH', 'REPNAME', 'Rep Name', '2', '13', '72', '60', 'TEXT', '0', 'N', 'Left', 'repName', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_SETTLEMENT_FILE', 'BASECURRENCY', 'Base Currency', '8', '77', '79', '3', 'TEXT', '0', 'N', 'Left', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_SETTLEMENT_FILE', 'BOUGHTQUANTITY', 'Bought Quantity', '3', '21', '31', '11', 'NUMERIC', '0', 'N', 'Left', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_SETTLEMENT_FILE', 'EXCHANGERATETOBASECURRENCY', 'Exchange Rate to Base currency', '7', '60', '76', '17', 'NUMERIC', '6', 'N', 'Left', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_SETTLEMENT_FILE', 'ISIN', 'ISIN', '2', '9', '20', '12', 'TEXT', '0', 'N', 'Left', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_SETTLEMENT_FILE', 'MARKPRICE', 'Mark Price', '5', '43', '56', '14', 'NUMERIC', '6', 'N', 'Left', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `format`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_SETTLEMENT_FILE', 'SETTLEMENTDATE', 'Settlement Date', '1', '1', '8', '8', 'DATE', 'yyyyMMdd', '0', 'N', 'Left', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_SETTLEMENT_FILE', 'SOLDQUANTITY', 'Sold Quantity', '4', '32', '42', '11', 'NUMERIC', '0', 'N', 'Left', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `justified`, `isRequired`, `needToEncrypt`) VALUES ('UOB_SETTLEMENT_FILE', 'TRADEDCURRENCY', 'Traded Currency', '6', '57', '59', '3', 'TEXT', '0', 'N', 'Left', 'Y', 'N');



set sql_safe_updates=0;
update service.file_process_rules set type= format, format=null where fileId in(select fileId from service.file_details where vendor='BUILDINGBENJAMINS'); 
update service.file_process_rules set type= 'DATE', format='MM/dd/yyyy' where fileId in(select fileId from service.file_details where vendor='BUILDINGBENJAMINS') and dataField like '%date%'; 



USE `service`;
DROP procedure IF EXISTS `sel_service_details`;

DELIMITER $$
USE `service`$$
CREATE  PROCEDURE `sel_service_details`(
IN p_product  varchar(50),
IN p_service  varchar(50),
IN p_type  varchar(50),
IN p_info varchar(50)
)
BEGIN
if(p_service ='DOCUMENT-SERVICES' and p_type='ADDITIONAL_DETAILS' and p_info='PDF_FILE_DETAILS')then

select vendor, fileName, fileId, fileExtension, description, active, fileNameAppender, appenderType, appenderFormat, available, 
	sourceDir, uploadDir, isPwdProtected, pwdRules
	from service.pdf_file_details
    where vendor= p_product and active='A' order by fileId;
elseif(p_service ='DOCUMENT-SERVICES' and p_type='COMMON_DETAILS' and p_info='PDF_FILE_RULES')then

select fileId, dataField, description, pageNo, xcord, ycord, length, dbColumn, isRequired, needToEncrypt,role
	from service.pdf_file_rules fcr
	where fcr.fileId in(select fileId from service.pdf_file_details where vendor= p_product and active='A') order by fileId, role;
	
elseif(p_service ='FILE-PROCESS' and p_type='ADDITIONAL_DETAILS' and p_info='FILE_DETAILS')then

select vendor, fileName, processId, process, fileType, fileExtension, fileId, containsHeader,
    active, seqNo, uploadDir, preDBProcess, postDBProcess, preInstruction, postInstruction, fileNameAppender,
    appenderFormat, available, sourcePath, downloadDir, loadFormat, required, canBeEmpty, encryptionMethod, decrFileExtension,
    tmpTableName, canBeDups, delimiter, delFlagServerFile, delDayServerFile, delFlagLocalFile,
	delDayLocalFile, delFlagDecrFile, fileProcessType, parentPreDBProcess, parentPostDBProcess, parentPreInstruction,
    parentPostInstruction
	from service.file_details
    where vendor= p_product and active='A' order by processId, seqNo;
elseif(p_service ='FILE-PROCESS' and p_type='COMMON_DETAILS' and p_info='FILE_RULES')then

	select fcr.fileId, fcr.dataField, fcr.description, fcr.seqNo, fcr.startPos, fcr.endPos,
    fcr.length, fcr.type, fcr.format, fcr.decimals, fcr.isDelimited, fcr.delimiter, fcr.justified,fcr.dbColumn, fcr.isRequired, fcr.needToEncrypt
	from service.file_process_rules fcr
	where fcr.fileId in(select fileId from service.file_details where vendor= p_product and active='A') order by fileId, fcr.seqNo;
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





















set sql_Safe_updates=0;

delete from service.service_config_details where service='DOCUMENT-SERVICES' and company='UOB';
delete from service.service_config_details where service='FILE-PROCESS' and company='UOB';



INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'CC_EXTERNAL_RECEIVER', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'CC_INVESSENCE_RECEIVER', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'HOST', 'smtp.gmail.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'L1_SUPPORT_EMAIL', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'L2_SUPPORT_EMAIL', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'LOCAL_SRC_DIRECTORY', 'C:/UOB/data/acctOpenfiles', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'OPERATIONS_EMAIL', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PASSWORD', 'G3n3r@l89', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PDF_FILES_CUST_DIRECTORY', 'D:/data1/pdf/UOB/customerFiles/', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PDF_FILES_MASTER_DIRECTORY', 'D:/data1/pdf/UOB/masterFiles/', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PORT', '587', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'SENDER_EMAIL', 'no-reply@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'SFTP_SRC_DIRECTORY', '/data/download/UOB/acctOpenfiles', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'USERNAME', 'no-reply@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'ZIP_FILES_DIRECTORY', 'D:/data1/pdf/UOB/zipFiles/', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'CC_EXTERNAL_RECEIVER', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'CC_INVESSENCE_RECEIVER', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'HOST', 'smtp.gmail.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'L1_SUPPORT_EMAIL', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'L2_SUPPORT_EMAIL', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'LOCAL_SRC_DIRECTORY', 'C:/UOB/data/acctOpenfiles', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'OPERATIONS_EMAIL', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PASSWORD', 'G3n3r@l89', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PDF_FILES_CUST_DIRECTORY', '/data/pdf/UOB/customerFiles/', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PDF_FILES_MASTER_DIRECTORY', '/data/pdf/UOB/masterFiles/', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PORT', '587', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'SENDER_EMAIL', 'no-reply@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'SFTP_SRC_DIRECTORY', '/data/download/UOB/acctOpenfiles', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'USERNAME', 'no-reply@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'ZIP_FILES_DIRECTORY', '/data/pdf/UOB/zipFiles/', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'CC_EXTERNAL_RECEIVER', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'CC_INVESSENCE_RECEIVER', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'HOST', 'smtp.gmail.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'L1_SUPPORT_EMAIL', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'L2_SUPPORT_EMAIL', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'LOCAL_SRC_DIRECTORY', 'C:/UOB/data/acctOpenfiles', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'OPERATIONS_EMAIL', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PASSWORD', 'G3n3r@l89', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PDF_FILES_CUST_DIRECTORY', '/data/pdf/UOB/customerFiles/', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PDF_FILES_MASTER_DIRECTORY', '/data/pdf/UOB/masterFiles/', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PORT', '587', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'SENDER_EMAIL', 'no-reply@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'SFTP_SRC_DIRECTORY', '/data/download/UOB/acctOpenfiles', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'USERNAME', 'no-reply@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'ZIP_FILES_DIRECTORY', '/data/pdf/UOB/zipFiles/', 'N', '2017-11-16 11:10:02');




INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_ISSUE_EMAIL', 'support@dot.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_LOCAL_SRC_DIRECTORY', 'D:/data/tradeFiles', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SFTP_HOST', 'uat.invessence.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SFTP_PASSWORD', 'T35t123', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SFTP_SRC_DIRECTORY', '/data/download/', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SFTP_USERNAME', 'abhangp', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SUCCESS_EMAIL', 'operations@dot.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'ENCRY_DECRY_KEY', 'aRXDugfr4WQpVrxu', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'GPG_PASSWORD', 'Inv3ss3nc3', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'GPG_PRIVATE_KEY', 'C:/INV/data/gnupg/secring.gpg', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'GPG_PUBLIC_KEY', 'C:/INV/data/gnupg/pubring.gpg', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'OPERATIONS_EMAIL', 'abhangp@invessence.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_ISSUE_EMAIL', 'support@dot.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_LOCAL_SRC_DIRECTORY', 'D:/data/eodfiles', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SFTP_HOST', 'uat.invessence.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SFTP_PASSWORD', 'T35t123', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SFTP_SRC_DIRECTORY', '/data/eodfiles/', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SFTP_USERNAME', 'abhangp', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SUCCESS_EMAIL', 'operations@dot.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('DEV', 'UOB', 'FILE-PROCESS', 'VENDOR', 'ZIP_FILES_DIRECTORY', 'D:/data/eodfiles', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_ISSUE_EMAIL', 'support@dot.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_LOCAL_SRC_DIRECTORY', '/data/download/uob/eodFiles', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SFTP_HOST', 'uat.invessence.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SFTP_PASSWORD', 'y91C9ry0PCOfH2AR', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SFTP_SRC_DIRECTORY', '/data/download/', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SFTP_USERNAME', 'sftpuser', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SUCCESS_EMAIL', 'operations@dot.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'ENCRY_DECRY_KEY', 'aRXDugfr4WQpVrxu', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'GPG_PASSWORD', 'Inv3ss3nc3', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'GPG_PRIVATE_KEY', '/data/gnupg/secring.gpg', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'GPG_PUBLIC_KEY', '/data/gnupg/pubring.gpg', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'OPERATIONS_EMAIL', 'abhangp@invessence.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_ISSUE_EMAIL', 'support@dot.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_LOCAL_SRC_DIRECTORY', '/data/upload/uob/tradeFiles', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SFTP_HOST', 'uat.invessence.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SFTP_PASSWORD', 'y91C9ry0PCOfH2AR', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SFTP_SRC_DIRECTORY', '/data/eodfiles/', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SFTP_USERNAME', 'sftpuser', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SUCCESS_EMAIL', 'operations@dot.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'FILE-PROCESS', 'VENDOR', 'ZIP_FILES_DIRECTORY', '/data/eodfiles', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_ISSUE_EMAIL', 'support@dot.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_LOCAL_SRC_DIRECTORY', '/data/download/uob/eodFiles', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SFTP_HOST', 'uat.invessence.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SFTP_PASSWORD', 'y91C9ry0PCOfH2AR', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SFTP_SRC_DIRECTORY', '/data/download/', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SFTP_USERNAME', 'sftpuser', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'DOWNLOAD_SUCCESS_EMAIL', 'operations@dot.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'ENCRY_DECRY_KEY', 'aRXDugfr4WQpVrxu', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'GPG_PASSWORD', 'Inv3ss3nc3', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'GPG_PRIVATE_KEY', '/data/gnupg/secring.gpg', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'GPG_PUBLIC_KEY', '/data/gnupg/pubring.gpg', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'OPERATIONS_EMAIL', 'abhangp@invessence.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_ISSUE_EMAIL', 'support@dot.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_LOCAL_SRC_DIRECTORY', '/data/upload/uob/tradeFiles', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SFTP_HOST', 'uat.invessence.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SFTP_PASSWORD', 'y91C9ry0PCOfH2AR', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SFTP_SRC_DIRECTORY', '/data/eodfiles/', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SFTP_USERNAME', 'sftpuser', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'UPLOAD_SUCCESS_EMAIL', 'operations@dot.com', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('UAT', 'UOB', 'FILE-PROCESS', 'VENDOR', 'ZIP_FILES_DIRECTORY', '/data/eodfiles', 'N');




DELETE FROM `service`.`service_master` WHERE `company`='UOB' and`service`='EMAIL-SERVICE' and`vendor`='BB-GMAIL';


INSERT INTO `service`.`service_master` (`company`, `service`, `status`, `vendor`) VALUES ('UOB', 'EMAIL-SERVICE', 'A', 'UOB-MAIL');

INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'EMAIL-SERVICE', 'UOB-MAIL', 'CC_EXTERNAL_RECEIVER', '', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'EMAIL-SERVICE', 'UOB-MAIL', 'CC_INVESSENCE_RECEIVER', '', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'EMAIL-SERVICE', 'UOB-MAIL', 'HOST', '10.160.10.35', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'EMAIL-SERVICE', 'UOB-MAIL', 'L1_SUPPORT_EMAIL', 'supportL1@invessence.com', 'N', '2016-11-12 14:50:06');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'EMAIL-SERVICE', 'UOB-MAIL', 'L2_SUPPORT_EMAIL', 'supportL2@invessence.com', 'N', '2016-11-12 14:50:06');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'EMAIL-SERVICE', 'UOB-MAIL', 'PASSWORD', '', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'EMAIL-SERVICE', 'UOB-MAIL', 'PORT', '25', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('PROD', 'UOB', 'EMAIL-SERVICE', 'UOB-MAIL', 'SENDER_EMAIL', 'noreply@uobkayhian.com', 'N', '2016-11-12 14:50:06');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'EMAIL-SERVICE', 'UOB-MAIL', 'USERNAME', '', 'N');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`) VALUES ('PROD', 'UOB', 'EMAIL-SERVICE', 'UOB-MAIL', 'USERTITLE', 'UOB Kay Hian', 'N');


/* 02.ap.PREUAT- FileProcessor INVDB .sql190218_abhang*/

USE `invdb`;



CREATE TABLE `ext_exchange_rate` (
  `reportDate` varchar(10) NOT NULL,
  `tradeCurrency` varchar(3) NOT NULL,
  `settleCurrency` varchar(3) NOT NULL,
  `exchangeRate` double DEFAULT NULL,
  PRIMARY KEY (`reportDate`,`tradeCurrency`,`settleCurrency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `holiday_master` (
  `hdate` varchar(10) NOT NULL,
  `country` varchar(20) NOT NULL,
  `hdaycomment` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`hdate`,`country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `invdb`.`holiday_master` (`hdate`, `country`, `hdaycomment`) VALUES ('20180204', 'SGD', 'Testing');
INSERT INTO `invdb`.`holiday_master` (`hdate`, `country`, `hdaycomment`) VALUES ('20180206', 'SGD', 'Test Holiday');
INSERT INTO `invdb`.`holiday_master` (`hdate`, `country`, `hdaycomment`) VALUES ('20180207', 'SGD', 'Test2 Holiday');
INSERT INTO `invdb`.`holiday_master` (`hdate`, `country`, `hdaycomment`) VALUES ('20180216', 'SGD', 'Chienese New Year');



USE `invdb`;
DROP function IF EXISTS `get_exchange_rate`;

DELIMITER $$
USE `invdb`$$
CREATE  FUNCTION `get_exchange_rate`( p_from_currency varchar(20), p_to_currency varchar(20)) RETURNS double
    DETERMINISTIC
begin
    declare p_frstcd,p_scndcd,p_fromCurrency,p_toCurrency,baseCrncy,p_symbol varchar(10);
    declare p_exchngGiven, p_exchngavailable int;
    declare p_multiplying_factor double;
    declare p_priceDate,exhangeStatus, p_businessdate varchar(20);
    declare retExchangeRate double;
	set p_exchngGiven=0;
    set p_exchngavailable=0;
    set p_symbol=concat(p_from_currency,p_to_currency);   
    set exhangeStatus='Failed';
		
	set p_priceDate = `invdb`.`FUNCT_GET_SWITCH`('PRICE_DATE');
    set p_businessdate = `invdb`.`FUNCT_GET_SWITCH`('BUSINESS_DATE');
    
    select count(*) into p_exchngGiven from invdb.ext_exchange_rate  
    where reportDate= p_businessdate and settleCurrency=p_from_currency and tradeCurrency=p_to_currency;
    
   if(p_exchngGiven>0) then
   select 1/exchangeRate into retExchangeRate from invdb.ext_exchange_rate  
   where reportDate= p_businessdate and settleCurrency=p_from_currency and tradeCurrency=p_to_currency;
             set exhangeStatus='Success';
   
   else
    select count(*) into p_exchngavailable from invdb.sec_exchangerate_master where symbol=p_symbol;
    -- select p_priceDate,p_exchngavailable;
    
  
    if(p_exchngavailable>0) then
             select sed.exchangeRate into retExchangeRate from rbsa.sec_exchangerate_data sed where sed.symbol=p_symbol and sed.exchangeDate=DATE_FORMAT(p_priceDate, '%Y-%m-%d');
             set exhangeStatus='Success';
        else
  
    	set p_exchngavailable=0;
        SELECT SUBSTRING(p_symbol,1,3) into p_frstcd;
        SELECT SUBSTRING(p_symbol,4,6) into p_scndcd;
        set p_symbol=concat(p_scndcd,p_frstcd);
    	select count(*) into p_exchngavailable from invdb.sec_exchangerate_master where symbol=p_symbol;
  
    		if(p_exchngavailable>0) then
               select sed.reverseExchangeRate into retExchangeRate from rbsa.sec_exchangerate_data sed where sed.symbol=p_symbol and sed.exchangeDate=DATE_FORMAT(p_priceDate, '%Y-%m-%d');
               set exhangeStatus='Success';
    		end if;
    end if;
    
    end if;
   -- select exhangeStatus,retExchangeRate;
return retExchangeRate;
END$$

DELIMITER ;



ALTER TABLE `invdb`.`ext_acct_info` 
ADD COLUMN `ssn` VARCHAR(50) NULL DEFAULT NULL AFTER `faxNbr`;


ALTER TABLE `invdb`.`ext_position` ADD COLUMN `settleValue` DOUBLE NULL DEFAULT NULL  AFTER `settleMarkPrice` 
, DROP PRIMARY KEY 
, ADD PRIMARY KEY (`clientAccountID`, `symbol`, `reportDate`, `purchaseDate`, `costBasisPrice`, `levelOfDetail`, `settleCurrency`) ;


ALTER TABLE `invdb`.`ext_investment` 
CHANGE COLUMN `investmentCurrency` `investmentCurrency` VARCHAR(3) NOT NULL DEFAULT 'USD' ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`clientAccountID`, `ticker`, `investmentDate`, `investmentCurrency`);


ALTER TABLE `invdb`.`ext_position` 
CHANGE COLUMN `settleCurrency` `settleCurrency` VARCHAR(3) NOT NULL DEFAULT 'USD' ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`clientAccountID`, `reportDate`, `purchaseDate`, `symbol`, `costBasisPrice`, `levelOfDetail`, `settleCurrency`);

ALTER TABLE `invdb`.`registration_audit` 
CHANGE COLUMN `ip` `ip` VARCHAR(45) NULL DEFAULT NULL ;



USE `invdb`;
DROP procedure IF EXISTS `sp_user_advisor_info`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sp_user_advisor_info`(
    IN p_logonid  bigint(20)    ,
IN p_advisor varchar(20)   ,
IN p_rep  varchar(20)   ,
IN p_accttype varchar(20)   ,
IN p_companyname varchar(60)   ,
IN p_displayName varchar(60)   ,
IN p_logo  varchar(60)   ,
IN p_advisor_css varchar(30)
 )
BEGIN 
 
    DECLARE v_req_count INTEGER;
 
	select count(*) into v_req_count from invdb.user_advisor_info WHERE `logonid` = p_logonid;    
    
    if(v_req_count>0)then
    BEGIN
 		UPDATE `invdb`.`user_advisor_info`
		SET
		`advisor` = p_advisor,
		`rep` = p_rep,
		`accttype` = p_accttype,
		`companyname` = p_companyname,
		`displayName` = p_displayName,
		`logo` = p_logo,
		`advisor_css` = p_advisor_css,
		`lastupdated` = now()
		WHERE `logonid` = p_logonid;         
    END;
    else
	BEGIN
		INSERT INTO `invdb`.`user_advisor_info`
		(`logonid`,
		`advisor`,
		`rep`,
		`accttype`,
		`companyname`,
		`displayName`,
		`logo`,
		`advisor_css`,
		`created`)
		VALUES
		(p_logonid,
		p_advisor,
		p_rep,
		p_accttype,
		p_companyname,
		p_displayName,
		p_logo,
		p_advisor_css,
		now());
    END;     
    end if;
 END$$

DELIMITER ;





UPDATE `invdb`.`notification_message_lookup` 
SET 
    `emailAdvisorRecepient` = 'prathamesh.hule@invessence.com'
WHERE
    `advisor` = 'UOB'
        and `messageType` = 'FUNDED';
INSERT INTO `invdb`.`notification_message_lookup` (`advisor`, `messageType`, `includeAdvisor`, `advisorsubject`, `includeAdvisorEmail`, `emailAdvisorSubject`, `emailAdvisorRecepient`, `includeUser`, `userSubject`) VALUES ('UOB', 'TRADEEXECUTED', 'N', 'Trade Executed', 'Y', 'Trade Executed', 'abhangp@invessence.com', 'N', 'Trade Executed');
UPDATE `invdb`.`notification_message_lookup` 
SET 
    `emailAdvisorRecepient` = 'sagar.patil@invessence.com'
WHERE
    `advisor` = 'UOB'
        and `messageType` = 'OPENED';



ALTER TABLE `invdb`.`email_messages` ADD COLUMN `acctnum` BIGINT NULL DEFAULT NULL  AFTER `attachments` , ADD COLUMN `templateId` VARCHAR(45) NULL DEFAULT NULL  AFTER `acctnum` ;
ALTER TABLE `invdb`.`email_alerts` ADD COLUMN `acctnum` BIGINT NULL DEFAULT NULL  AFTER `attachments` , ADD COLUMN `templateId` VARCHAR(45) NULL DEFAULT NULL  AFTER `acctnum` ;


ALTER TABLE `invdb`.`notification_message_lookup` ADD COLUMN `notificationTempIdUser` VARCHAR(45) NULL DEFAULT NULL  AFTER `updated` , ADD COLUMN `emailTempIdUser` VARCHAR(45) NULL DEFAULT NULL  AFTER `notificationTempIdUser` , ADD COLUMN `notificationTempIdAdvisor` VARCHAR(45) NULL DEFAULT NULL  AFTER `emailTempIdUser` , ADD COLUMN `emailTempIdAdvisor` VARCHAR(45) NULL DEFAULT NULL  AFTER `notificationTempIdAdvisor` , ADD COLUMN `ccUserSalesRep` VARCHAR(1) NULL DEFAULT NULL  AFTER `emailTempIdAdvisor` , ADD COLUMN `ccAdvisorSalesRep` VARCHAR(1) NULL DEFAULT NULL COMMENT 'Sending Advisor\'s email CC to Sales Rep associated to User.'  AFTER `ccUserSalesRep` ;


CREATE  TABLE `invdb`.`notofication_email_templates` (
  `advisor` VARCHAR(20) NOT NULL ,
  `messageType` VARCHAR(20) NOT NULL ,
  `templateId` VARCHAR(45) NOT NULL ,
  `contentType` VARCHAR(10) NULL DEFAULT NULL ,
  `userType` VARCHAR(10) NULL DEFAULT NULL ,
  `emailSubject` VARCHAR(45) NULL DEFAULT NULL ,
  `templateContent` BLOB NULL DEFAULT NULL ,
  `created` DATETIME NULL DEFAULT NULL ,
  `updated` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`advisor`, `messageType`, `templateId`) );


INSERT INTO `invdb`.`web_site_info`
(`url`,
`name`,
`status`,
`value`,
`encrFlag`,
`created`,
`updated`)
VALUES
(
'utraderobo', 'SERVICE.FILEPROCESS.MODE', 'A', 'PROD', 'N', '2017-05-30 07:03:12', NULL
);




USE `invdb`;
DROP function IF EXISTS `get_exchange_rate_date_wise`;

DELIMITER $$
USE `invdb`$$
CREATE  FUNCTION `get_exchange_rate_date_wise`( p_from_currency varchar(20), p_to_currency varchar(20),p_businessdate varchar(20)) RETURNS double
    DETERMINISTIC
BEGIN
 	 declare p_frstcd,p_scndcd,p_fromCurrency,p_toCurrency,baseCrncy,p_symbol varchar(10);
     declare p_exchngavailable int;
     declare p_multiplying_factor double;
     declare retExchangeRate double;
   
     set p_exchngavailable=0;
     set p_symbol=concat(p_from_currency,p_to_currency);   
     set retExchangeRate=0.0;
     set p_multiplying_factor=1;
     
     
     if(p_from_currency=p_to_currency) then 
      set retExchangeRate=1;
     else 
     select count(*),multiplyFactor into p_exchngavailable,p_multiplying_factor from invdb.sec_exchangerate_master where symbol=p_symbol;
     
     
   
     if(p_exchngavailable>0) then
              select sed.exchangeRate*p_multiplying_factor into retExchangeRate 
              from rbsa.sec_exchangerate_data sed where sed.symbol=p_symbol and sed.exchangeDate=DATE_FORMAT(p_businessdate, '%Y-%m-%d');
         else
   
     	set p_exchngavailable=0;
         SELECT SUBSTRING(p_symbol,1,3) into p_frstcd;
         SELECT SUBSTRING(p_symbol,4,6) into p_scndcd;
         set p_symbol=concat(p_scndcd,p_frstcd);
     	select count(*),multiplyFactor into p_exchngavailable,p_multiplying_factor from invdb.sec_exchangerate_master where symbol=p_symbol;
   
     		if(p_exchngavailable>0) then
                select sed.reverseExchangeRate*p_multiplying_factor into retExchangeRate
                from rbsa.sec_exchangerate_data sed where sed.symbol=p_symbol and sed.exchangeDate=DATE_FORMAT(p_businessdate, '%Y-%m-%d');               
     		end if;
     end if;
     end if;
     
     
 		RETURN retExchangeRate;
 END$$

DELIMITER ;




USE `invdb`;
DROP procedure IF EXISTS `sel_advisor_currencies`;

DELIMITER $$
USE `invdb`$$
CREATE  PROCEDURE `sel_advisor_currencies`(in p_advisor varchar(20),in p_from_currency varchar(20))
begin
   declare p_businessdate varchar(20);
   select isw.value into p_businessdate from invdb.invessence_switch isw where isw.name='BUSINESS_DATE'; 
   select supportCurrency,invdb.get_exchange_rate_date_wise(p_from_currency , supportCurrency,p_businessdate) as exchangeRate 
   from invdb.advisor_currency where advisor= ( CASE
                            WHEN p_advisor IS NULL
                                  OR p_advisor = '' THEN 'CATCHALL'
                            ELSE p_advisor
                          end );
   end$$

DELIMITER ;

/* 03.ap.PREUAT - FileProcessor Temp.sql190218_abhang*/

CREATE DATABASE  IF NOT EXISTS `temp` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `temp`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: temp
-- ------------------------------------------------------
-- Server version	5.5.57

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tmp_client_data`
--

DROP TABLE IF EXISTS `tmp_client_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tmp_client_data` (
  `clientAccountID` varchar(20) DEFAULT '',
  `acctnum` varchar(20) DEFAULT NULL,
  `companyName` varchar(20) DEFAULT NULL,
  `lastName` varchar(20) DEFAULT NULL,
  `firstName` varchar(20) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `address3` varchar(50) DEFAULT NULL,
  `address4` varchar(50) DEFAULT NULL,
  `address5` varchar(50) DEFAULT NULL,
  `address6` varchar(50) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `zipCode` varchar(20) DEFAULT NULL,
  `SSNOrTaxID` varchar(20) DEFAULT NULL,
  `advisorID` varchar(20) DEFAULT '',
  `taxable` varchar(20) DEFAULT NULL,
  `phoneNumber` varchar(20) DEFAULT NULL,
  `faxNumber` varchar(20) DEFAULT NULL,
  `accountType` varchar(100) DEFAULT NULL,
  `objective` varchar(20) DEFAULT NULL,
  `billingAccountNumber` varchar(20) DEFAULT NULL,
  `defaultAccount` varchar(20) DEFAULT NULL,
  `stateOfPrimaryResidence` varchar(20) DEFAULT NULL,
  `performanceInceptionDate` varchar(20) DEFAULT NULL,
  `billingInceptionDate` varchar(20) DEFAULT NULL,
  `federalTaxRate` varchar(20) DEFAULT NULL,
  `stateTaxRate` varchar(20) DEFAULT NULL,
  `monthsInShortTermholdingperiod` varchar(20) DEFAULT NULL,
  `fiscalYearEnd` varchar(20) DEFAULT NULL,
  `useAverageCostAccounting` varchar(20) DEFAULT NULL,
  `displayAccruedInterest` varchar(20) DEFAULT NULL,
  `displayAccruedDividends` varchar(20) DEFAULT NULL,
  `displayAccruedGains` varchar(20) DEFAULT NULL,
  `birthDate` varchar(20) DEFAULT NULL,
  `discountRate` varchar(20) DEFAULT NULL,
  `payoutRate` varchar(20) DEFAULT NULL,
  `fullName` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `dateOpened` varchar(45) DEFAULT NULL,
  `emailAddress` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tmp_exchange_rate`
--

DROP TABLE IF EXISTS `tmp_exchange_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tmp_exchange_rate` (
  `reportDate` varchar(10) NOT NULL,
  `tradeCurrency` varchar(3) NOT NULL,
  `settleCurrency` varchar(3) DEFAULT NULL,
  `exchangeRate` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tmp_investment`
--

DROP TABLE IF EXISTS `tmp_investment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tmp_investment` (
  `clientAccountID` varchar(8) NOT NULL DEFAULT '',
  `reportDate` varchar(10) NOT NULL DEFAULT '',
  `currencyPrimary` varchar(3) DEFAULT 'USD',
  `fxRateToBase` double DEFAULT NULL,
  `cash` double DEFAULT NULL,
  `stock` double DEFAULT NULL,
  `funds` double DEFAULT NULL,
  `interestAccrual` double DEFAULT NULL,
  `dividentAccrual` double DEFAULT NULL,
  `total` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tmp_nav`
--

DROP TABLE IF EXISTS `tmp_nav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tmp_nav` (
  `clientAccountID` varchar(8) NOT NULL DEFAULT '',
  `reportDate` varchar(10) NOT NULL DEFAULT '',
  `currencyPrimary` varchar(3) DEFAULT 'USD',
  `fxRateToBase` double DEFAULT NULL,
  `cash` double DEFAULT NULL,
  `stock` double DEFAULT NULL,
  `funds` double DEFAULT NULL,
  `interestAccrual` double DEFAULT NULL,
  `dividentAccrual` double DEFAULT NULL,
  `total` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tmp_position`
--

DROP TABLE IF EXISTS `tmp_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tmp_position` (
  `clientAccountID` varchar(8) DEFAULT NULL,
  `accountAlias` varchar(10) DEFAULT NULL,
  `currencyPrimary` varchar(3) DEFAULT NULL,
  `assetClass` varchar(10) DEFAULT NULL,
  `fxRateToBase` double DEFAULT NULL,
  `symbol` varchar(12) DEFAULT NULL,
  `description` varchar(60) DEFAULT NULL,
  `reportDate` varchar(8) DEFAULT NULL,
  `side` varchar(6) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `costBasisPrice` double DEFAULT NULL,
  `CostBasisMoney` double DEFAULT NULL,
  `markPrice` double DEFAULT NULL,
  `positionValue` double DEFAULT NULL,
  `fifoPnlUnrealized` double DEFAULT NULL,
  `LevelOfDetail` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tmp_sales_rep`
--

DROP TABLE IF EXISTS `tmp_sales_rep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tmp_sales_rep` (
  `repId` varchar(12) DEFAULT NULL,
  `repName` varchar(60) DEFAULT NULL,
  `otherRefe` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'temp'
--
/*!50003 DROP PROCEDURE IF EXISTS `parentDBProcedure` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `parentDBProcedure`()
BEGIN

    delete from temp.tmp_nav;
    delete from temp.tmp_position;
    delete from temp.tmp_transaction;
    delete from temp.tmp_client_data;

    delete from temp.tmp_td_unrealized;
    delete from temp.tmp_td_position;
    delete from temp.tmp_td_price;
    delete from temp.tmp_td_security;
    delete from temp.tmp_td_demographic;
    delete from temp.tmp_td_transaction;
    
	delete from temp.tmp_investment;
    delete from temp.tmp_sales_rep;

	delete from temp.tmp_exchange_rate;

  END ;;
DELIMITER ;





/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_td_eod_process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_td_eod_process`(
)
BEGIN
	DECLARE tDate	varchar(10);
    
    
    
    CALL `temp`.`sp_updt_ext_acct_flag`();
    
    SELECT max(`ext_nav`.`reportDate`)
    INTO tDate
    FROM `invdb`.`ext_nav`;

	if(tDate is null)then
		select hdate into tDate from invdb.holiday_master where hdate=invdb.FUNCT_GET_SWITCH('BUSINESS_DATE');
	end if;

	CALL `temp`.`sp_inv_switch_eod`(tDate);
    
    update invdb.ext_acct_info set status='A'
			where  invdb.ext_acct_info.status = 'O' 
			and invdb.ext_acct_info.clientAccountID in ( select distinct(tmpNav.clientAccountID)
			from temp.tmp_nav tmpNav) ;

END ;;
DELIMITER ;




/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_trade_process_isin_wise` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_trade_process_isin_wise`()
BEGIN

declare v_tradeDate varchar(10);
select value into v_tradeDate from invdb.invessence_switch where name='BUSINESS_DATE';

select ifnull((select ISIN from invdb.sec_master where ticker=a.ticker),a.ticker)ticker, sum(a.buyQty)buyQty, sum(a.sellQty)sellQty, sum(a.buyQty-a.sellQty)netQty, v_tradeDate tradeDate from 
(SELECT  utl.ticker,
   -- DATE_FORMAT(utl.tradedate,'%Y%m%d')tradedate,
    ABS(sum(utl.qty))buyQty, ''sellQty
FROM
    invdb.user_trade_log utl,
    invdb.ext_acct_info daod
WHERE
    utl.acctnum = daod.acctnum
        -- AND utl.tradeStatus = 'P'
        AND utl.action = 'BUY'
        and utl.qty<>0
        AND utl.investmentamount<>0
        group by ticker -- , tradedate
        
        union all
        SELECT  
    utl.ticker,
    -- DATE_FORMAT(utl.tradedate,'%Y%m%d')tradedate,
    ''buyQty, ABS(sum(utl.qty))sellQty
FROM
    invdb.user_trade_log utl,
    invdb.ext_acct_info daod
WHERE
    utl.acctnum = daod.acctnum
        -- AND utl.tradeStatus = 'P'
        AND utl.action = 'SELL'
        and utl.qty<>0
        AND utl.investmentamount<>0
        group by ticker -- , tradedate
        )a
        group by a.ticker
	ORDER BY a.ticker;


END ;;

DELIMITER ;




/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_upload_exchange_rate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_upload_exchange_rate`(
)
BEGIN 

   DECLARE tReportDate	VARCHAR(10);
	DECLARE vSettCurrency	VARCHAR(3);

set vSettCurrency = ifnull(invdb.FUNCT_GET_SWITCH('SETT_CURRUNCY'),'USD');
      
   set tReportDate = `invdb`.`FUNCT_GET_SWITCH`('BROKER_BDATE');
 
   begin
		delete from `invdb`.`ext_exchange_rate`
		where `reportDate` in (select distinct IFNULL(`reportDate`,tReportDate)
																  from tmp_exchange_rate);

INSERT INTO `invdb`.`ext_exchange_rate`
(`reportDate`,
`tradeCurrency`,
`settleCurrency`,
`exchangeRate`)
select 
reportDate,
tradeCurrency,
ifnull(settleCurrency,vSettCurrency),
ifnull(exchangeRate,1)

from temp.tmp_exchange_rate;
   end;

END ;;
DELIMITER ;




/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_upload_ext_acct_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_upload_ext_acct_info`(
)
BEGIN
    set sql_safe_updates=0;
    
    UPDATE `invdb`.`ext_acct_info`, `temp`.`tmp_client_data` as `client_data`
    SET
		`ext_acct_info`.`rep` = `client_data`.`advisorID`,
		
		`ext_acct_info`.`accountType` = `client_data`.`accountType`,
		`ext_acct_info`.`applicantFName` = `client_data`.`firstName`,
		
		`ext_acct_info`.`applicantLName` = `client_data`.`lastName`,
`ext_acct_info`.`fullname` = `client_data`.`fullname`,
		`ext_acct_info`.`address1` = `client_data`.`street`,
		`ext_acct_info`.`address2` = `client_data`.`address2`,
		`ext_acct_info`.`address3` = `client_data`.`address3`,
		`ext_acct_info`.`city` = `client_data`.`city`,
		`ext_acct_info`.`state` = `client_data`.`state`,
		`ext_acct_info`.`zipcode` = `client_data`.`zipCode`,
		
		`ext_acct_info`.`primaryPhoneNbr` = `client_data`.`phoneNumber`,
		
		
		`ext_acct_info`.`faxNbr` = `client_data`.`faxNumber`,
		`ext_acct_info`.`ssn` = `client_data`.`SSNOrTaxID`,
		 `ext_acct_info`.`dob` = `client_data`.`birthDate`,
		`ext_acct_info`.`taxable` = `client_data`.`taxable`,
		`ext_acct_info`.`objective` = `client_data`.`objective`,
        
		
		`ext_acct_info`.`lastUpdated` = now()
	WHERE `ext_acct_info`.`clientAccountID` = `client_data`.`clientAccountID`;
    
	
	INSERT INTO `invdb`.`ext_acct_info`
	(
		`clientAccountID`,
		`acctnum`,
		`status`,
		`rep`,
		`email`,
        `accountType`,
		`applicantFName`,
		`applicantMName`,
		`applicantLName`,
		`fullname`,
		`address1`,
		`address2`,
		`address3`,
		`city`,
		`state`,
		`zipcode`,
		`country`,
		`primaryPhoneNbr`,
		`secondayPhoneNbr`,
		`workPhoneNbr`,
		`faxNbr`,
		`ssn`,
		`dob`,
		`taxable`,
		`objective`,
        `dateOpened`,
		`created`,
		`lastUpdated`
    )
    SELECT
		`client_data`.`clientAccountID`, 
		`client_data`.`acctnum`, 
		'O', 
		`client_data`.`advisorID`, 
		null, 
        `client_data`.`accountType`, 
		`client_data`.`firstName`, 
		null, 
		`client_data`.`lastName`, 
		`client_data`.`fullname`, 
		`client_data`.`street`, 
		`client_data`.`address2`, 
		`client_data`.`address3`, 
		`client_data`.`city`, 
		`client_data`.`state`, 
		`client_data`.`zipCode`, 
		null,  
		`client_data`.`phoneNumber`,  
		null,  
		null, 
		`client_data`.`faxNumber`, 
		`client_data`.`SSNOrTaxID`, 
		`client_data`.`birthDate`,
		`client_data`.`taxable`, 
		`client_data`.`objective`, 
		CASE WHEN (`client_data`.`performanceInceptionDate` is NULL)
			THEN `invdb`.`funct_date2inv_date`(now())
				WHEN (trim(`client_data`.`performanceInceptionDate`) = '')
			THEN `invdb`.`funct_date2inv_date`(now())
			ELSE `client_data`.`performanceInceptionDate`
		END as `performanceInceptionDate`, 
		now(), 
		null 
	FROM `temp`.`tmp_client_data` as `client_data`
    WHERE  (`client_data`.`acctnum` is not null and `client_data`.`acctnum` !='') and `client_data`.`clientAccountID` not in (select `clientAccountID` from `invdb`.`ext_acct_info`)
    ;
    
    UPDATE `invdb`.`user_trade_profile`, `invdb`.`ext_acct_info`
		set `user_trade_profile`.`clientAccountID` = `ext_acct_info`.`clientAccountID`,
			`user_trade_profile`.`firstname` = `ext_acct_info`.`applicantFName`,
			`user_trade_profile`.`lastname` = `ext_acct_info`.`applicantLName`,
            `user_trade_profile`.`managed` = CASE WHEN (`ext_acct_info`.`status` in ('A', 'O')) THEN 'A'
												  ELSE 'X'
											 END,
            `user_trade_profile`.`status` = `ext_acct_info`.`status`,
            `user_trade_profile`.`lastUpdated` = now()
	WHERE `user_trade_profile`.`acctnum` = `ext_acct_info`.`acctnum`;

END ;;
DELIMITER ;




/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_upload_investment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_upload_investment`(
)
BEGIN 

   DECLARE tReportDate	VARCHAR(10);
      
   set tReportDate = `invdb`.`FUNCT_GET_SWITCH`('BROKER_BDATE');
 
   begin
		delete from `invdb`.`ext_investment`
		where concat(`clientAccountID`,`investmentDate`) in (select concat(`clientAccountID`,IFNULL(`reportDate`,tReportDate))
																  from tmp_investment);


INSERT INTO `invdb`.`ext_investment`
(`acctnum`,
`clientAccountID`,
`ticker`,
`investmentDate`,
`tradeCurrency`,
`netAmount`,
`comment`,
`fxRateToBase`,
`settleCurrency`,
`convertedNetAmount`,
`status`,
`created`)
(select extAcct.acctnum, tmpInv.clientAccountID,'Cash' ticker,tmpInv.reportDate investmentDate,trdProf.tradeCurrency tradeCurrency,trdProf.initialInvestment netAmount,null comment,
`invdb`.`get_exchange_rate`(trdProf.tradeCurrency,settleCurrency) fxRateToBase, settleCurrency,(`invdb`.`get_exchange_rate`(trdProf.tradeCurrency,settleCurrency)*trdProf.initialInvestment) convertedNetAmount,'A', now() created
-- ,tmpInv.* 
from 
temp.tmp_investment tmpInv, 
invdb.ext_acct_info extAcct,
invdb.user_trade_profile trdProf
where  extAcct.clientAccountID=tmpInv.clientAccountID
and trdProf.acctnum=extAcct.acctnum
);

		
   end;

END ;;
DELIMITER ;




/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_upload_nav` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_upload_nav`(
)
BEGIN 

   DECLARE tReportDate	VARCHAR(10);
   DECLARE acctStatus	VARCHAR(10);
	DECLARE vSettCurrency	VARCHAR(3);

set vSettCurrency = ifnull(invdb.FUNCT_GET_SWITCH('SETT_CURRUNCY'),'USD');
      
   set tReportDate = `invdb`.`FUNCT_GET_SWITCH`('BUSINESS_DATE');
 
   begin
		delete from `invdb`.`ext_nav`
		where concat(`clientAccountID`,`reportDate`) in (select distinct concat(`clientAccountID`,IFNULL(`reportDate`,tReportDate))
																  from tmp_nav)
		;
delete from `invdb`.`ext_position`
		where concat(`clientAccountID`,`reportDate`) in (select distinct  concat(`clientAccountID`,IFNULL(`reportDate`,tReportDate))
																  from tmp_nav)
		and levelOfDetail='Cash';

delete from `invdb`.`ext_investment`
		where concat(`clientAccountID`,`investmentDate`) in (select distinct  concat(`clientAccountID`,IFNULL(`reportDate`,tReportDate))
																  from tmp_nav)
                                                                  
		;

 INSERT INTO `invdb`.`ext_nav`
			(`clientAccountID`,
			`reportDate`,
			`tradeCurrency`,
			`exchangeRate`,
            `settleCurrency`,
			`cash`,
			`stock`,
			`funds`,
			`interestAccrual`,
			`dividentAccrual`,
			`total`)
		select eai.clientAccountID, 
		IFNULL(ep.reportDate,tReportDate) as `reportDate`,
		IFNULL(ep.settleCurrency,tn.currencyPrimary) as tradeCurrency, 
		IFNULL(`invdb`.`get_exchange_rate`(vSettCurrency,ep.settleCurrency),1) as exchangeRate, 
		vSettCurrency as settleCurrency, 
		ifnull(sum(tn.cash),0)as cash,
		sum(case when ep.levelOfDetail ='Cash'then 0 else ep.settleMoney end) as stock,  
		tn.funds,
		tn.interestAccrual,
		tn.dividentAccrual,
		(sum(case when ep.levelOfDetail ='Cash'then 0 else ep.settleMoney end)+ifnull(sum(tn.cash),0)) total
		from invdb.ext_acct_info  eai
		inner join invdb.ext_position ep
		on (eai.clientAccountID=ep.clientAccountID 
		and ep.reportDate=tReportDate
		-- and ep.levelOfDetail not in ('Cash')
		)
		left join temp.tmp_nav tn
		on(eai.clientAccountID=tn.clientAccountID
		 and ep.settleCurrency=tn.currencyPrimary
        ) group by ep.levelOfDetail, ep.tradeCurrency, tn.currencyPrimary
                union 
        select eai.clientAccountID, 
		IFNULL(tn.reportDate,tReportDate) as `reportDate`,
		IFNULL(tn.currencyPrimary,'USD') as tradeCurrency, 
		IFNULL(`invdb`.`get_exchange_rate`(vSettCurrency,tn.currencyPrimary),1) as exchangeRate, 
		vSettCurrency as settleCurrency, 
		ifnull(sum(tn.cash),0)as cash,
		0 as stock,  
		tn.funds,
		tn.interestAccrual,
		tn.dividentAccrual,
		ifnull(sum(tn.cash),0) total
		from invdb.ext_acct_info  eai		
		inner join temp.tmp_nav tn
		on(eai.clientAccountID=tn.clientAccountID
        and tn.currencyPrimary not in(select settleCurrency from invdb.ext_position where reportDate=tn.reportDate)
        ) group by tn.currencyPrimary;
/*

		SELECT `tmp_nav`.`clientAccountID`,
			IFNULL(`tmp_nav`.`reportDate`,tReportDate) as `reportDate`,
			IFNULL(`tmp_nav`.`currencyPrimary`,'USD') as currencyPrimary,
			IFNULL(`tmp_nav`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(vSettCurrency,tmp_nav.currencyPrimary),1)) as fxRateToBase,
			vSettCurrency as settleCurrency,
			`tmp_nav`.`cash`,
			`tmp_nav`.`stock`,
			`tmp_nav`.`funds`,
			`tmp_nav`.`interestAccrual`,
			`tmp_nav`.`dividentAccrual`,
			`tmp_nav`.`total`
		FROM `temp`.`tmp_nav`;

*/


  
  			INSERT INTO invdb.ext_position
  				(acctnum,
  				clientAccountID,
  				tradeCurrency,
  				fxRateToBase,
  				symbol,
  				reportDate,
  				purchaseDate,
  				side,
  				quantity,
  				costBasisPrice,
  				costBasisMoney,
  				markPrice,
  				positionValue,
  				pnlUnrealized,
  				levelOfDetail,
                settleCurrency,
                settleQty,
				settlePrice, 
				settleMoney, 
				settlePnL,
  				created
  				)
  			SELECT
  				eai.acctnum
  				, eai.clientAccountID as clientAccountID
  				, extNav.settleCurrency
  				, extNav.exchangeRate
  				, 'Cash' as symbol
  				, extNav.reportDate as reportDate
  				, extNav.reportDate as purchaseDate
  				, 'Long' as side
  				, (extNav.cash* (1/extNav.exchangeRate)) as quantity
  				, 1 as costBasisPrice
  				, (extNav.cash* (1/extNav.exchangeRate)) as costBasisMoney
  				, 1 as markPrice
  				, (extNav.cash* (1/extNav.exchangeRate)) as positionValue
  				, 0 as pnlUnrealized
  				, 'Cash' as levelOfDetail
				, extNav.tradeCurrency as settleCurrency
                , extNav.cash as settleQty
                , 1 as settlePrice
                , extNav.cash as settleMoney
				, 0 as settlePnL
  				, now() as created
  			FROM invdb.ext_acct_info as eai, invdb.ext_nav extNav, temp.tmp_nav tmpNav
  			WHERE eai.clientAccountID = extNav.clientAccountID   
			and extNav.reportDate =  tmpNav.reportDate 
			and extNav.clientAccountID =tmpNav.clientAccountID
			and extNav.tradeCurrency =  tmpNav.currencyPrimary 
  			;



				INSERT INTO `invdb`.`ext_investment`
				(`acctnum`,
				`clientAccountID`,
				`ticker`,
				`investmentDate`,
				`investmentCurrency`,
				`netAmount`,
				`comment`,
				`fxRateToBase`,
				`baseCurrency`,
				`convertedNetAmount`,
				`status`,
				`created`)
				SELECT
  				eai.acctnum
  				, eai.clientAccountID as clientAccountID
  				, 'Cash' as ticker
  				, extNav.reportDate as investmentDate
				, extNav.tradeCurrency as investmentCurrency
				, extNav.cash as netAmount
				, 'Initial' as `comment`
  				, extNav.exchangeRate as fxRateToBase
				, extNav.settleCurrency as `baseCurrency`
				, (extNav.cash* extNav.exchangeRate) as convertedNetAmount
				, 'A' as `status`  
				,now() as created
  			FROM invdb.ext_acct_info as eai, invdb.ext_nav extNav, temp.tmp_nav tmpNav
  			WHERE eai.clientAccountID = extNav.clientAccountID  
			and eai.status = 'O'
			and extNav.reportDate =  tmpNav.reportDate 
			and extNav.clientAccountID =tmpNav.clientAccountID
			and extNav.tradeCurrency =  tmpNav.currencyPrimary 
  			;

			
   end;





END ;;
DELIMITER ;




/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_upload_position` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_upload_position`(
)
BEGIN 

	DECLARE tReportDate	VARCHAR(10);

	DECLARE vSettCurrency	VARCHAR(3);

	set vSettCurrency = ifnull(invdb.FUNCT_GET_SWITCH('SETT_CURRUNCY'),'USD');
      
	set tReportDate = `invdb`.`FUNCT_GET_SWITCH`('BUSINESS_DATE');
   
	begin

		delete from `invdb`.`ext_nav`
		where concat(`clientAccountID`,`reportDate`) in (select distinct concat(`clientAccountID`,IFNULL(`reportDate`,tReportDate))
																  from tmp_position)
		;

		DELETE FROM `invdb`.`ext_position` 
WHERE
    CONCAT(`clientAccountID`, `reportDate`) IN (SELECT DISTINCT
        CONCAT(`clientAccountID`,
                    IFNULL(`reportDate`, tReportDate))
    FROM
        `temp`.`tmp_position`)
		;
   end;

   begin


INSERT INTO `invdb`.`ext_position`
(`acctnum`,
`clientAccountID`,
`tradeCurrency`,
`fxRateToBase`,
`symbol`,
`reportDate`,
`purchaseDate`,
`side`,
`quantity`,
`costBasisPrice`,
`costBasisMoney`,
`markPrice`,
`positionValue`,
`pnlUnrealized`,
`levelOfDetail`,
`settleCurrency`,
`settleQty`,
`settlePrice`,
`settleMoney`,
`settleMarkPrice`,
`settleValue`,
`settlePnL`,
`created`)
select acct_info.acctnum,
			pos.clientAccountID	,
			vSettCurrency ,
			IFNULL(`pos`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(vSettCurrency,pos.currencyPrimary),1)) as fxRateToBase,
			ifnull((select ticker from invdb.sec_master where isin=symbol),symbol) as symbol,
			IFNULL(`reportDate`,tReportDate),
			IFNULL(`reportDate`,tReportDate),
			'Long' as side,
			`quantity`	,
			(markPrice*IFNULL(`pos`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(vSettCurrency,pos.currencyPrimary),1))) as costBasisPrice,
			(positionvalue*IFNULL(`pos`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(vSettCurrency,pos.currencyPrimary),1))) as costBasisMoney,
			(markPrice*IFNULL(`pos`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(vSettCurrency,pos.currencyPrimary),1))) as markPrice,
			(positionvalue*IFNULL(`pos`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(vSettCurrency,pos.currencyPrimary),1))) as  positionValue	,
			(positionvalue*IFNULL(`pos`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(vSettCurrency,pos.currencyPrimary),1))-positionvalue*IFNULL(`pos`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(vSettCurrency,pos.currencyPrimary),1)))`fifoPnlUnrealized`	, 
			'Securities' as levelOfDetail	,		
			IFNULL(`pos`.`currencyPrimary`,'USD') as settleCurrency,
			quantity as settleQty,
			markPrice as settlePrice	,
			positionvalue as settleMoney	,
			markPrice as settleMarkPrice	,
			positionvalue as settleValue	,
			(positionvalue-positionvalue) as settlePnL,
  			now() as created
	  from `temp`.`tmp_position` pos, invdb.ext_acct_info acct_info
where acct_info.clientAccountID=pos.clientAccountID
	  ;
/*

INSERT INTO invdb.ext_position
  				(acctnum,
  				clientAccountID,
  				tradeCurrency,
  				fxRateToBase,
  				symbol,
  				reportDate,
  				purchaseDate,
  				side,
  				quantity,
  				costBasisPrice,
  				costBasisMoney,
  				markPrice,
  				positionValue,
  				pnlUnrealized,
  				levelOfDetail,
                settleCurrency,
                settleQty,
				settlePrice, 
				settleMoney, 
				settlePnL,
  				created
  				)
	  select acct_info.acctnum,
			pos.clientAccountID	,
			vSettCurrency ,
			IFNULL(`pos`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(vSettCurrency,pos.currencyPrimary),1)) as fxRateToBase,
			`symbol`	,
			IFNULL(`reportDate`,tReportDate),
			IFNULL(`reportDate`,tReportDate),
			`side`	,
			`quantity`	,
			 1 as costBasisPrice,
			(positionvalue*IFNULL(`pos`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(vSettCurrency,pos.currencyPrimary),1))) as settleMoney,
			(markPrice*IFNULL(`pos`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(vSettCurrency,pos.currencyPrimary),1))) as settlePrice,
			`positionValue`	,
			`fifoPnlUnrealized`	,
			'Securities' as levelOfDetail	,		
			IFNULL(`pos`.`currencyPrimary`,'USD') as currencyPrimary,
			quantity,
			`markPrice`	,
			positionvalue `CostBasisMoney`	,
			0 as settlePnL,
  			now() as created
	  from `temp`.`tmp_position` pos, invdb.ext_acct_info acct_info
where acct_info.clientAccountID=pos.clientAccountID
	  ;
*/      
   end;
END ;;
DELIMITER ;



/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_upload_sales_rep` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_upload_sales_rep`()
BEGIN 

DECLARE tReportDate	VARCHAR(10);
set tReportDate = `invdb`.`FUNCT_GET_SWITCH`('BROKER_BDATE');

	begin
		DECLARE v_req_count INTEGER;
        DECLARE v_logonid bigint(20);
        DECLARE v_counter INTEGER DEFAULT 1;
		DECLARE v_finished INTEGER DEFAULT 0;
		DECLARE v_repId varchar(12) DEFAULT NULL;
		DECLARE v_repName varchar(60) DEFAULT NULL;
		DECLARE v_otherRefe varchar(60) DEFAULT NULL;
		
		-- declare cursor for employee email
		DEClARE sales_rep_cursor CURSOR FOR 
		SELECT repId, repName, otherRefe FROM temp.tmp_sales_rep;
		
		-- declare NOT FOUND handler
		DECLARE CONTINUE HANDLER 
		FOR NOT FOUND SET v_finished = 1;
		OPEN sales_rep_cursor;
        

			get_sales_rep: LOOP

				FETCH sales_rep_cursor INTO v_repId, v_repName, v_otherRefe;

				IF v_finished = 1 THEN 
					LEAVE get_sales_rep;
				END IF;
                
                select count(*) into v_req_count from invdb.user_advisor_info where rep=v_repId and advisor='UOB';

				if(v_req_count>0)then
					begin
                    
                    select logonid into v_logonid from invdb.user_advisor_info where rep=v_repId and advisor='UOB';
                    /*set sql_safe_updates=0;
						update invdb.user_advisor_info set 
                        displayName=v_repName
                        ,lastupdated =now()
                        where rep=v_repId;*/
                       CALL `invdb`.`sp_user_advisor_info`(v_logonid, 'UOB', v_repId, 'UOBInternal', 'UOB Kay Hain', v_repName, null, null);
                       CALL `invdb`.`sp_login_add_mod`(null, v_logonid, null, null, null, null, null, null, null, null, null, null, null,null, null, null, null, null, null, null, null, null, 'UOB', v_repId, null, v_repName);
                            
					end;
                    else
                    
					begin
						DECLARE a_logonid BIGINT(20);
						declare v_uniq_id varchar(20);
						SELECT concat(DATE_FORMAT(NOW(), '%Y%m%d%h%m%s'),v_counter) into v_uniq_id;
						-- if('TF'=v_repId || '{T'=v_repId )then
							CALL `invdb`.`sp_login_add_mod`(null, a_logonid, null, concat('dummy',v_uniq_id), concat(v_uniq_id,'@dummy.com'), concat(v_uniq_id,'@dummy.com'),  'T', null, null, null, null, null, null,null, null, null, null, null, null, null, null, null, 'UOB', v_repId, null, v_repName);
                            CALL `invdb`.`sp_user_advisor_info`(a_logonid, 'UOB', v_repId, 'UOBInternal', 'UOB Kay Hain', v_repName, null, null);

							-- select a_logonid;
                            set v_counter = v_counter+1;
						-- end if;                        
                    end;
                end if;
			END LOOP get_sales_rep;

		CLOSE sales_rep_cursor;

		-- select v_counter;	
	end;

END ;;
DELIMITER ;





/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_trade_process_both` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_trade_process_both`()
BEGIN

declare v_tradeDate varchar(10);
select value into v_tradeDate from invdb.invessence_switch where name='BUSINESS_DATE';

update invdb.user_trade_log utl
  set utl.tradeStatus='P'
  WHERE utl.tradeStatus = 'S'
  and utl.qty<>0
  AND utl.investmentamount<>0;

SELECT 
    utl.acctnum,
    utl.clientAccountID,
    utl.tradeStatus,
    -- DATE_FORMAT(utl.tradedate,'%Y%m%d')tradedate,
    v_tradeDate tradedate,
    ifnull((select ISIN from invdb.sec_master where ticker=utl.ticker),utl.ticker)ticker,
    -- utl.ticker,
    utl.ticker ric,
    case utl.action when 'BUY' then 'B'
    when 'SELL' then 'S'
    else 'N'
    end action,
    utl.sectype,
    -- utl.exchange,
    'SGX' exchange,
    utl.currency,
    utl.timeinforce,
    ABS(utl.qty)qty,
    utl.tradeprice,
    abs(utl.investmentamount)investmentamount,
    utl.tradeID,
    utl.ordertype,
    utl.confirmationID,
    utl.firmAccount,
    utl.created,
    utl.lastupdated,
    daod.email
FROM
    invdb.user_trade_log utl,
    invdb.ext_acct_info daod
WHERE
    utl.acctnum = daod.acctnum
        AND utl.tradeStatus = 'P'
        AND daod.acctnum = daod.acctnum
        and utl.qty<>0
        AND utl.investmentamount<>0
	ORDER BY acctnum,ticker,action;
	/*update invdb.user_trade_log utl
  set utl.tradeStatus='I'
  WHERE utl.tradeStatus = 'P'
  and utl.qty<>0
  AND utl.investmentamount<>0;*/

END ;;
DELIMITER ;



/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_trade_process_both_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_trade_process_both_update`()
BEGIN

update invdb.user_trade_log utl
set utl.tradeStatus='S'
WHERE utl.tradeStatus = 'I';

END ;;
DELIMITER ;



USE `temp`;
DROP procedure IF EXISTS `sp_upload_nav`;

DELIMITER $$
USE `temp`$$
CREATE  PROCEDURE `sp_upload_nav`(
)
BEGIN 

   DECLARE tReportDate	VARCHAR(10);
   DECLARE acctStatus	VARCHAR(10);
	DECLARE vSettCurrency	VARCHAR(3);

set vSettCurrency = ifnull(invdb.FUNCT_GET_SWITCH('SETT_CURRUNCY'),'USD');
      
   set tReportDate = `invdb`.`FUNCT_GET_SWITCH`('BUSINESS_DATE');
 
   begin
		delete from `invdb`.`ext_nav`
		where concat(`clientAccountID`,`reportDate`) in (select distinct concat(`clientAccountID`,IFNULL(`reportDate`,tReportDate))
																  from tmp_nav)
		;
delete from `invdb`.`ext_position`
		where concat(`clientAccountID`,`reportDate`) in (select distinct  concat(`clientAccountID`,IFNULL(`reportDate`,tReportDate))
																  from tmp_nav)
		and levelOfDetail='Cash';

delete from `invdb`.`ext_investment`
		where concat(`clientAccountID`,`investmentDate`) in (select distinct  concat(`clientAccountID`,IFNULL(`reportDate`,tReportDate))
																  from tmp_nav)
                                                                  
		;

 INSERT INTO `invdb`.`ext_nav`
			(`clientAccountID`,
			`reportDate`,
			`tradeCurrency`,
			`exchangeRate`,
            `settleCurrency`,
			`cash`,
			`stock`,
			`funds`,
			`interestAccrual`,
			`dividentAccrual`,
			`total`)
		select eai.clientAccountID, 
		IFNULL(ep.reportDate,tReportDate) as `reportDate`,
		IFNULL(ep.settleCurrency,tn.currencyPrimary) as tradeCurrency, 
		IFNULL(`invdb`.`get_exchange_rate`(vSettCurrency,ep.settleCurrency),1) as exchangeRate, 
		vSettCurrency as settleCurrency, 
		ifnull(sum(tn.cash),0)as cash,
		sum(case when ep.levelOfDetail ='Cash'then 0 else ep.settleMoney end) as stock,  
		tn.funds,
		tn.interestAccrual,
		tn.dividentAccrual,
		(sum(case when ep.levelOfDetail ='Cash'then 0 else ep.settleMoney end)+ifnull(sum(tn.cash),0)) total
		from invdb.ext_acct_info  eai
		inner join invdb.ext_position ep
		on (eai.clientAccountID=ep.clientAccountID 
		and ep.reportDate=tReportDate
		-- and ep.levelOfDetail not in ('Cash')
		)
		left join temp.tmp_nav tn
		on(eai.clientAccountID=tn.clientAccountID
		 and ep.settleCurrency=tn.currencyPrimary
        ) group by ep.levelOfDetail, ep.tradeCurrency, tn.currencyPrimary
                union 
        select eai.clientAccountID, 
		IFNULL(tn.reportDate,tReportDate) as `reportDate`,
		IFNULL(tn.currencyPrimary,'USD') as tradeCurrency, 
		IFNULL(`invdb`.`get_exchange_rate`(vSettCurrency,tn.currencyPrimary),1) as exchangeRate, 
		vSettCurrency as settleCurrency, 
		ifnull(sum(tn.cash),0)as cash,
		0 as stock,  
		tn.funds,
		tn.interestAccrual,
		tn.dividentAccrual,
		ifnull(sum(tn.cash),0) total
		from invdb.ext_acct_info  eai		
		inner join temp.tmp_nav tn
		on(eai.clientAccountID=tn.clientAccountID
        and tn.currencyPrimary not in(select settleCurrency from invdb.ext_position where reportDate=tn.reportDate)
        ) group by tn.currencyPrimary;
/*

		SELECT `tmp_nav`.`clientAccountID`,
			IFNULL(`tmp_nav`.`reportDate`,tReportDate) as `reportDate`,
			IFNULL(`tmp_nav`.`currencyPrimary`,'USD') as currencyPrimary,
			IFNULL(`tmp_nav`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(vSettCurrency,tmp_nav.currencyPrimary),1)) as fxRateToBase,
			vSettCurrency as settleCurrency,
			`tmp_nav`.`cash`,
			`tmp_nav`.`stock`,
			`tmp_nav`.`funds`,
			`tmp_nav`.`interestAccrual`,
			`tmp_nav`.`dividentAccrual`,
			`tmp_nav`.`total`
		FROM `temp`.`tmp_nav`;

*/


  
  			INSERT INTO invdb.ext_position
  				(acctnum,
  				clientAccountID,
  				tradeCurrency,
  				fxRateToBase,
  				symbol,
  				reportDate,
  				purchaseDate,
  				side,
  				quantity,
  				costBasisPrice,
  				costBasisMoney,
  				markPrice,
  				positionValue,
  				pnlUnrealized,
  				levelOfDetail,
                settleCurrency,
                settleQty,
				settlePrice, 
				settleMoney, 
				settlePnL,
  				created
  				)
  			SELECT
  				eai.acctnum
  				, eai.clientAccountID as clientAccountID
  				, extNav.settleCurrency
  				, extNav.exchangeRate
  				, 'Cash' as symbol
  				, extNav.reportDate as reportDate
  				, extNav.reportDate as purchaseDate
  				, 'Long' as side
  				, (extNav.cash* extNav.exchangeRate) as quantity
  				, 1 as costBasisPrice
  				, (extNav.cash* extNav.exchangeRate) as costBasisMoney
  				, 1 as markPrice
  				, (extNav.cash* extNav.exchangeRate) as positionValue
  				, 0 as pnlUnrealized
  				, 'Cash' as levelOfDetail
				, extNav.tradeCurrency as settleCurrency
                , extNav.cash as settleQty
                , 1 as settlePrice
                , extNav.cash as settleMoney
				, 0 as settlePnL
  				, now() as created
  			FROM invdb.ext_acct_info as eai, invdb.ext_nav extNav, temp.tmp_nav tmpNav
  			WHERE eai.clientAccountID = extNav.clientAccountID   
			and extNav.reportDate =  tmpNav.reportDate 
			and extNav.clientAccountID =tmpNav.clientAccountID
			and extNav.tradeCurrency =  tmpNav.currencyPrimary 
  			;



				INSERT INTO `invdb`.`ext_investment`
				(`acctnum`,
				`clientAccountID`,
				`ticker`,
				`investmentDate`,
				`investmentCurrency`,
				`netAmount`,
				`comment`,
				`fxRateToBase`,
				`baseCurrency`,
				`convertedNetAmount`,
				`status`,
				`created`)
				SELECT
  				eai.acctnum
  				, eai.clientAccountID as clientAccountID
  				, 'Cash' as ticker
  				, extNav.reportDate as investmentDate
				, extNav.tradeCurrency as investmentCurrency
				, extNav.cash as netAmount
				, 'Initial' as `comment`
  				, extNav.exchangeRate as fxRateToBase
				, extNav.settleCurrency as `baseCurrency`
				, (extNav.cash* extNav.exchangeRate) as convertedNetAmount
				, 'A' as `status`  
				,now() as created
  			FROM invdb.ext_acct_info as eai, invdb.ext_nav extNav, temp.tmp_nav tmpNav
  			WHERE eai.clientAccountID = extNav.clientAccountID  
			and eai.status = 'O'
			and extNav.reportDate =  tmpNav.reportDate 
			and extNav.clientAccountID =tmpNav.clientAccountID
			and extNav.tradeCurrency =  tmpNav.currencyPrimary 
  			;

			
   end;





END$$

DELIMITER ;




  
  USE `temp`;
DROP procedure IF EXISTS `sp_updt_ext_acct_flag`;

DELIMITER $$
USE `temp`$$
CREATE PROCEDURE `sp_updt_ext_acct_flag`()
BEGIN

  DECLARE done INT DEFAULT FALSE;
  DECLARE tAcctNum VARCHAR(20);
  DECLARE tLastManaged VARCHAR(1);
  DECLARE tTotal DOUBLE;
  declare tLogonId BIGINT(20);
  
  DECLARE cur1 CURSOR FOR 
  SELECT distinct
		 `ext_acct_info`.`acctnum`,
         `ext_nav`.`total`, uar.logonid
  FROM `invdb`.`ext_acct_info`, `invdb`.`ext_nav`, `invdb`.`user_trade_profile` , invdb.user_access_role uar
  WHERE `ext_acct_info`.`acctnum` = `user_trade_profile`.`acctnum`
  AND `ext_acct_info`.`clientAccountID` = `ext_nav`.`clientAccountID`
  AND `ext_nav`.`reportDate` = (select max(reportDate) from `invdb`.`ext_nav`)
  AND `user_trade_profile`.`status` not in ('A')
  AND `ext_nav`.`total` > 0
  and uar.acctnum= `ext_acct_info`.`acctnum`
  and uar.role='OWNER'
  ;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
  OPEN cur1;
 
the_loop: LOOP
    
    FETCH cur1 INTO tAcctNum, tTotal, tLogonId;
	
    IF done THEN
      LEAVE the_loop;
    END IF;
    
    update `invdb`.`ext_acct_info`
		set `ext_acct_info`.`status` = 'A'
	WHERE `ext_acct_info`.`acctnum` = tAcctNum;

	CALL `invdb`.`sp_user_profile_manage`(tAcctNum, 'A', tLogonId);

  END LOOP the_loop;
 
  CLOSE cur1;
END$$

DELIMITER ;





/* 04.ap.invdb_sec_master.sql190218_abhang*/

delete from invdb.sec_master;


ALTER TABLE `invdb`.`sec_master` 
ADD COLUMN `sedol` VARCHAR(12) NULL DEFAULT NULL AFTER `ric`;


INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('1', 'A', 'A', 'Cash', 'Cash', 'Cash', 'Cash', 'Cash', 'Cash', 'Cash', '0', '0', '', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('2', 'A', 'A', 'BIL.N', 'BIL.N', 'Cash', 'Cash', 'Cash', 'Cash', 'Cash', '0', '0', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('3', 'A', 'A', 'BKLN', 'BKLN', 'PowerShares Senior Loan', 'Bond', 'Senior Loan', 'Fixed Income', 'Fixed Income', '0.0065', '0.022778', '', 'SGX', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('4', 'A', 'A', 'CWB.N', 'CWB.N', 'SPDR Barclays Capital Convertible Secs', 'Bond', 'Convertible', 'Fixed Income', 'Fixed Income', '0.004', '0.098135', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('5', 'A', 'A', 'EEM.N', 'EEM.N', 'iShares MSCI Emerging Markets', 'International', 'Emerging Market', 'Equity', 'Equity', '0.0067', '0.162104', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('6', 'A', 'A', 'EFA.N', 'EFA.N', 'iShares MSCI EAFE', 'International', 'Large Cap Int', 'Equity', 'Equity', '0.0034', '0.122497', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('7', 'A', 'A', 'EMB.N', 'EMB.N', 'iShares JPMorgan USD Emerg Markets Bond', 'Bond', 'Emerging HY', 'Fixed Income', 'Fixed Income', '0.0007', '0.052482', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('8', 'A', 'A', 'EMLC.N', 'EMLC.N', 'Market Vector EM Local Currency', 'HighYield', 'Emerging HY', 'Fixed Income', 'Fixed Income', '0.0047', '0.071652', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('9', 'A', 'A', 'FCNTX', 'FCNTX', 'Fidelity® Contrafund®', 'Mutual Fund', 'Mix', 'Equity', 'Equity', '0.0063', '0.104227', '', 'SGX', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('10', 'A', 'A', 'FFKEX', 'FFKEX', 'Fidelity Freedom 2030', 'Mutual Fund', 'Mix', 'Equity', 'Equity', '0.0063', '0.104227', '', 'SGX', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('12', 'A', 'A', 'HYG.N', 'HYG.N', 'iShares iBoxx $ High Yield Corporate Bd', 'Bond', 'Corporate Junk', 'Fixed Income', 'Fixed Income', '0.005', '0.040909', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `isin`, `ric`, `sedol`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('13', 'A', 'A', 'IAU.N', 'US4642851053', 'IAU.N', 'B05ND15', 'iShares Gold Trust', 'Alternative', 'Gold', 'Fixed Income', 'Fixed Income', '0', '0', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('14', 'A', 'A', 'IEF.N', 'IEF.N', 'iShares 7-10 Year Treasury Bond', 'Bond', 'Medium Term', 'Fixed Income', 'Fixed Income', '0.0015', '0.048191', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('15', 'A', 'A', 'IJR.N', 'IJR.N', 'iShares Core S&P Small-Cap', 'Domestic', 'Small Cap', 'Equity', 'Equity', '0.0028', '0.153552', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('16', 'A', 'A', 'ITM.N', 'ITM.N', 'Market Vectors Intermediate Muni', 'Bond', 'Medium Term', 'Fixed Income', 'Fixed Income', '0.0024', '0.030404', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('17', 'A', 'A', 'IVV.N', 'IVV.N', 'iShares Core S&P 500', 'Domestic', 'Large Cap', 'Equity', 'Equity', '0.0007', '0.10901', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('18', 'A', 'A', 'IVW.N', 'IVW.N', 'iShares S&P 500 Growth', 'Domestic', 'LargeCap Growth', 'Equity', 'Equity', '0.0018', '0.118889', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('19', 'A', 'A', 'IWB.N', 'IWB.N', 'iShares Russell 1000', 'Domestic', 'Large Cap', 'Equity', 'Equity', '0.0015', '0.110353', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('20', 'A', 'A', 'IWM.N', 'IWM.N', 'iShares Russell 2000', 'Domestic', 'Small Cap', 'Equity', 'Equity', '0.0028', '0.153552', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('21', 'A', 'A', 'IWR.N', 'IWR.N', 'iShares Russell Mid-Cap', 'Domestic', 'Mid Cap', 'Equity', 'Equity', '0.2', '0.120254', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('22', 'A', 'A', 'IYR.N', 'IYR.N', 'iShares US Real Estate', 'Domestic', 'RealEstateTrust', 'Equity', 'Equity', '0.0045', '0.102856', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('23', 'A', 'A', 'JNK.N', 'JNK.N', 'SPDR Barclays High Yield Bond ETF', 'HighYield', 'Corporate Junk', 'Fixed Income', 'Fixed Income', '0.004', '0.041494', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('24', 'A', 'A', 'LQD.N', 'LQD.N', 'iShares iBoxx $ Invst Grade Crp Bond (LQD)', 'Bond', 'Investment Grade', 'Fixed Income', 'Fixed Income', '0.0007', '0.042155', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('25', 'A', 'A', 'LSHIX', 'LSHIX', 'Loomis Sayles Instl High Income', 'Mutual Fund', 'Mix', 'Equity', 'Equity', '0.0068', '0.104227', '', 'SGX', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('26', 'A', 'A', 'LTPZ.N', 'LTPZ.N', 'BofA ML 15+ Year US Inflation Linked Treasury', 'Bond', 'TIPS', 'Fixed Income', 'Fixed Income', '0.002', '0.117131', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('27', 'A', 'A', 'MALOX', 'MALOX', 'BlackRock Global Allocation', 'Mutual Fund', 'Mix', 'Equity', 'Equity', '0.0063', '0.104227', '', 'SGX', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('28', 'A', 'A', 'MDY.N', 'MDY.N', 'SPDR S&P MidCap 400 ETF', 'Domestic', 'Mid Cap', 'Equity', 'Equity', '0.0025', '0.128349', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('29', 'A', 'A', 'MLN.N', 'MLN.N', 'Market Vectors Long Municipal', 'Bond', 'Long Term', 'Fixed Income', 'Fixed Income', '0.0024', '0.048282', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('30', 'A', 'A', 'MUB.N', 'MUB.N', 'iShares National AMT-Free Muni Bond', 'Bond', 'Medium Term', 'Fixed Income', 'Fixed Income', '0.0025', '0.028862', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('31', 'A', 'A', 'OAKIX', 'OAKIX', 'Oakmark International I', 'Mutual Fund', 'Mix', 'Equity', 'Equity', '0.0095', '0.104227', '', 'SGX', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('32', 'A', 'A', 'PFF.N', 'PFF.N', 'iShares US Preferred Stock', 'Domestic', 'Preferred', 'Equity', 'Equity', '0.0048', '0.042116', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('33', 'A', 'A', 'SHM.N', 'SHM.N', 'SPDR Nuveen Barclays ST Muni Bd', 'Bond', 'Short Term', 'Fixed Income', 'Fixed Income', '0.002', '0.013782', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('34', 'A', 'A', 'SHY.N', 'SHY.N', 'iShares 1-3 Year Treasury Bond', 'Bond', 'Short Term', 'Fixed Income', 'Fixed Income', '0.0015', '0.006902', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('35', 'A', 'A', 'SPY.N', 'SPY.N', 'SPDR S&P 500', 'Domestic', 'Large Cap', 'Equity', 'Equity', '0.0009', '0.104227', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('36', 'A', 'A', 'STPZ.N', 'STPZ.N', 'BofA ML 1-5 Year US Inflation Linked Treasury', 'Bond', 'TIPS', 'Fixed Income', 'Fixed Income', '0.002', '0.018082', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('37', 'A', 'A', 'SUB.N', 'SUB.N', 'iShares ST National AMTFree Muni Bnd', 'Bond', 'Municipal', 'Fixed Income', 'Fixed Income', '0.0025', '0.010566', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('38', 'A', 'A', 'TIPZ.N', 'TIPZ.N', 'BofA ML US Inflation Linked Treasury', 'Bond', 'TIPS', 'Fixed Income', 'Fixed Income', '0.002', '0.047781', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('39', 'A', 'A', 'TLT.N', 'TLT.N', 'iShares 20+ Year Treasury Bond', 'Bond', 'Long Term', 'Fixed Income', 'Fixed Income', '0.0015', '0.104806', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('40', 'A', 'A', 'VCLT.N', 'VCLT.N', 'Vanguard Long Term Corporate', 'HighYield', 'Investment Grade', 'Fixed Income', 'Fixed Income', '0.0012', '0.074551', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('42', 'A', 'A', 'VEU.N', 'VEU.N', 'Vanguard FTSE All-World ex-US', 'International', 'Large Cap', 'Equity', 'Equity', '0.0015', '0.112023', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('43', 'A', 'A', 'VGK.N', 'VGK.N', 'Vanguard European Stock Index ETF', 'International', 'Large Cap', 'Equity', 'Equity', '0.0012', '0.135258', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('44', 'A', 'A', 'VNQ.N', 'VNQ.N', 'Vanguard REIT', 'Alternative', 'RealEstateTrust', 'Fixed Income', 'Fixed Income', '0.0025', '0.114353', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('45', 'A', 'A', 'VOO.N', 'VOO.N', 'Vanguard S&P 500 ETF', 'Domestic', 'Large Cap', 'Equity', 'Equity', '0.0005', '0.110353', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('47', 'A', 'A', 'VWO.N', 'VWO.N', 'Vanguard FTSE Emerging Markets', 'International', 'Emerging Market', 'Equity', 'Equity', '0.0015', '0.15477', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('65', 'A', 'A', 'AGAZX', 'AGAZX', '361 Global Long/Short Equity Institutional Fund', 'Alternatives', 'Long/Short Equity', 'Equity', 'Equity', '0', '0', '', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('66', 'A', 'A', 'AVRPX', 'AVRPX', 'Stone Ridge All Asset Variance Risk Premium Fund', 'Alternatives', 'Variance Risk Premium Harvesting', 'Equity', 'Equity', '0', '0', '', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('67', 'A', 'A', 'EMRIX', 'EMRIX', 'VanEck Emerging Markets Institutional Fund', 'Emerging Markets Equity', 'Diversified Emrg. Mrkts.', 'Equity', 'Equity', '0', '0', '', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('68', 'A', 'A', 'LENDX', 'LENDX', 'Stone Ridge Alternative Lending Risk Premium Fund', 'Fixed Income', 'Alternative Lending', 'Fixed Income', 'Fixed Income', '0', '0', '', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('69', 'A', 'A', 'LJMIX', 'LJMIX', 'LJM Preservation and Growth Instl Fund', 'Alternatives', 'Variance Risk Premium Harvesting', 'Fixed Income', 'Fixed Income', '0', '0', '', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('70', 'A', 'A', 'SCZ.N', 'SCZ.N', 'iShares MSCI EAFE Small-Cap', 'International Equity', 'Small/Mid Blend', 'Equity', 'Equity', '0', '0', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('71', 'A', 'A', 'SRRIX', 'SRRIX', 'Stone Ridge Reinsurance Risk Premium Interval Fund', 'Alternatives', 'Reinsurance', 'Fixed Income', 'Fixed Income', '0', '0', '', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('72', 'A', 'A', 'VCIT.N', 'VCIT.N', 'Vanguard Intermediate-Term Corp Bond ETF', 'Fixed Income', 'Domestic', 'Fixed Income', 'Fixed Income', '0', '0', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('73', 'A', 'A', 'VCMIX', 'VCMIX', 'Versus Capital Multi-Manager Real Estate Income Fund', 'Real Assets', 'Real Estate Income', 'Fixed Income', 'Fixed Income', '0', '0', '', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('74', 'A', 'A', 'VCSH.N', 'VCSH.N', 'Vanguard Short-Term Corporate Bond ETF', 'Fixed Income', 'Domestic', 'Fixed Income', 'Fixed Income', '0', '0', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('75', 'A', 'A', 'VEA.N', 'VEA.N', 'Vanguard FTSE Developed Markets ETF', 'International Equity', 'Large Blend', 'Equity', 'Equity', '0', '0', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('76', 'A', 'A', 'VRGIX', 'VRGIX', 'Stone Ridge Global Equity Variance Risk Prem. Fund', 'Alternatives', 'Equity & Variance Risk Prem. Harvesting', 'Equity', 'Equity', '0', '0', '', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('77', 'A', 'A', 'VSS.N', 'VSS.N', 'Vanguard FTSE All-World ex-US Small Cap ETF', 'International Equity', 'Small/Mid Blend', 'Equity', 'Equity', '0', '0', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('78', 'A', 'A', 'VTI.N', 'VTI.N', 'Vanguard Total Stock Market ETF', 'Domestic Equity', 'Large Blend', 'Equity', 'Equity', '0', '0', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('79', 'A', 'A', 'VTV.N', 'VTV.N', 'Vanguard Value ETF', 'Domestic Equity', 'Large Value', 'Equity', 'Equity', '0', '0', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('80', 'A', 'A', 'VUG.N', 'VUG.N', 'Vanguard Growth ETF', 'Domestic Equity', 'Large Growth', 'Equity', 'Equity', '0', '0', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('81', 'A', 'A', 'VYM.N', 'VYM.N', 'Vanguard High Dividend Yield ETF', 'Domestic Equity', 'Large Value', 'Equity', 'Equity', '0', '0', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('82', 'A', 'A', 'XILSX', 'XILSX', 'Pioneer ILS Interval Fund', 'Alternatives', 'Reinsurance', 'Fixed Income', 'Fixed Income', '0', '0', '', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('83', 'A', 'A', 'IDA12.N', 'IDA12.N', 'FDIC INSURED DEPOSIT ACCOUNT IDA12 NOT COVERED BY SIPC', 'Money', 'Money', 'Fixed Income', 'Fixed Income', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('84', 'A', 'A', 'VFIDX', 'VFIDX', 'VANGUARD INTRM-TERM INVT GRADE ADMIRAL', 'Mutual fund', 'Mutual fund', 'Equity', 'Equity', 'SGX', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('85', 'A', 'A', 'VRIIX', 'VRIIX', 'Stone Ridge International Variance Risk Prem. Fund', 'Alternatives', 'Equity & Variance Risk Prem. Harvesting', 'Equity', 'Equity', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('86', 'A', 'A', 'VRPIX', 'VRPIX', 'STONE RIDGE US MASTER VAR RISK PERM CL I', 'Mutual fund', 'Mutual fund', 'Equity', 'Equity', 'SGX', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('90', 'A', 'A', 'AGAQX', 'AGAQX', '361 Global Long/Short Equity Fund', 'Alternatives', 'Long/Short Equity', 'Equity', 'Equity', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('91', 'A', 'A', 'IOFIX', 'IOFIX', 'Alphacentric Income Opportunities Fund Institutional', 'Fixed Income', 'RMBS', 'Fixed Income', 'Fixed Income', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `exchange`, `base_currency`) VALUES ('93', 'A', 'A', 'EMRYX', 'EMRYX', 'VanEck Emerging Markets Fund Y', 'Emerging Markets Equity', 'Diversified Emrg. Mrkts.', 'Equity', 'Equity', '0', '0', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `exchange`, `base_currency`) VALUES ('94', 'A', 'A', 'VB.N', 'VB.N', 'Vanguard Small-Cap ETF', 'Domestic Equity', 'US Small Cap Blend', 'Equity', 'Equity', '0', '0', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('96', 'A', 'A', 'GBFAX', 'GBFAX', 'VanEck Emerging Markets Fund', 'Emerging Markets Equity', 'Diversified Emrg. Mrkts.', 'Equity', 'Equity', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('97', 'A', 'A', 'MGCEX', 'MGCEX', 'MIRAE FUNDS ASIA GREAT CONSUME R A', 'Mutual fund', 'Mutual fund', 'Equity', 'Equity', 'SGX', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('99', 'A', 'A', 'LJMAX', 'LJMAX', 'LJM Preservation and Growth Fund', 'Alternatives', 'Variance Risk Premium Harvesting', 'Equity', 'Equity', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `exchange`, `base_currency`) VALUES ('100', 'A', 'A', '2821.HK', '2821.HK', 'ABF Pan Asia Bond Index Fund', 'Fixed Income', 'Pan Asia Bonds', 'Fixed Income', 'Fixed Income', '0', '0', 'SGX', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `exchange`, `base_currency`) VALUES ('101', 'A', 'A', 'IPXJ.L', 'IPXJ.L', 'iShares MSCI Pacific ex Japan', 'Equity', 'Dev Asia X Japan Equities', 'Equity', 'Equity', '0', '0', 'LSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `isin`, `ric`, `sedol`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `exchange`, `base_currency`) VALUES ('102', 'A', 'A', 'EIMI.L', 'IE00BKM4GZ66', 'EIMI.L', 'BKM4GZ6', 'iShares Core MSCI Emerging Markets IMI', 'Equity', 'Emerging Mkt. Equities', 'Equity', 'Equity', '0', '0', 'LSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `isin`, `ric`, `sedol`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `exchange`, `base_currency`) VALUES ('103', 'A', 'A', 'IHYG.L', 'IE00B66F4759', 'IHYG.L', 'B66F475', 'iShares Euro High Yield Corporate Bond UCITS ETF', 'Fixed Income', 'E.U. High Yield Bonds', 'Equity', 'Equity', '0', '0', 'LSE', 'EUR');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `isin`, `ric`, `sedol`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `exchange`, `base_currency`) VALUES ('104', 'A', 'A', 'IHYU.L', 'IE00B4PY7Y77', 'IHYU.L', 'B4PY7Y7', 'iShares $ High Yield Corporate Bond UCITS ETF', 'Fixed Income', 'U.S. High Yield Bonds', 'Equity', 'Equity', '0', '0', 'LSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `exchange`, `base_currency`) VALUES ('105', 'A', 'A', 'SJPA.L', 'SJPA.L', 'iShares Core MSCI Japan IMI UCITS ETF', 'Equity', 'Japan Equities', 'Equity', 'Equity', '0', '0', 'LSE', 'GBX');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `exchange`, `base_currency`) VALUES ('106', 'A', 'A', 'IMEU.L', 'IMEU.L', 'iShares MSCI Europe UCITS ETF (Dist)', 'Equity', 'Europe Equities', 'Equity', 'Equity', '0', '0', 'LSE', 'GBX');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `isin`, `ric`, `sedol`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `exchange`, `base_currency`) VALUES ('107', 'A', 'A', 'IUAG.L', 'IE00B44CGS96', 'IUAG.L', 'B44CGS9', 'iShares US Aggregate Bond UCITS ETF', 'Fixed Income', 'U.S. Bonds', 'Fixed Income', 'Fixed Income', '0', '0', 'LSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `cusip`, `isin`, `ric`, `sedol`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('111', 'A', 'A', 'EWS.N', '46434G780', 'US46434G7806', 'EWS.N', 'BDR79Y1', 'iShares MSCI Singapore Capped', 'Equity', 'Singapore Equities', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `exchange`, `base_currency`) VALUES ('112', 'A', 'A', 'IEUR.N', 'IEUR.N', 'iShares MSCI Europe UCITS ETF (Dist)', 'Equity', 'Europe Equities', 'Equity', 'Equity', '0', '0', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `exchange`, `base_currency`) VALUES ('113', 'A', 'A', 'EPP.N', 'EPP.N', 'iShares MSCI Pacific ex Japan', 'Equity', 'Dev Asia X Japan', 'Equity', 'Equity', '0', '0', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `exchange`, `base_currency`) VALUES ('114', 'A', 'A', 'EWJ.N', 'EWJ.N', 'ISHARES CORE MSCI JAP IMI UCITS', 'Equity', 'Japan Equities', 'Equity', 'Equity', '0', '0', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `exchange`, `base_currency`) VALUES ('115', 'A', 'A', 'IEMG.N', 'IEMG.N', 'iShares Core MSCI Emerging Markets IMI', 'Equity', 'Emerging Mkt. Equities', 'Equity', 'Equity', '0', '0', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `exchange`, `base_currency`) VALUES ('116', 'A', 'A', 'AGG.N', 'AGG.N', 'iShares US Aggregate Bond UCITS ETF', 'Fixed Income', 'U.S. Bonds', 'Fixed Income', 'Fixed Income', '0', '0', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `isin`, `ric`, `sedol`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `exchange`, `base_currency`) VALUES ('117', 'A', 'A', 'VUSD.L', 'IE00B3XXRP09', 'VUSD.L', 'B7NLJN4', 'Vanguard S&P 500 UCITS ETF', 'Equity', 'U.S. Equities', 'Equity', 'Equity', '0', '0', 'LSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('118', 'A', 'A', 'ES3.SI', 'ES3.SI', 'SPDR Straits Times Index ETF', 'Equity', 'Singapore Equities', 'Equity', 'Equity', 'SGX', 'SGD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `exchange`, `base_currency`) VALUES ('119', 'A', 'A', 'KV4.SI', 'KV4.SI', 'Markit iBoxx ABF Singapore Government UCITS ETF 1C (KV4)', 'Fixed Income', 'Singapore Bonds', 'Fixed Income', 'Fixed Income', '0.2', 'SGX', 'SGD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('132', 'A', 'A', 'GLD.N', 'GLD.N', 'SPDR® Gold Shares', 'Commodity', 'Precious Metals', 'Fixed Income', 'Fixed Income', '0.004', '0.134075', '', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('133', 'A', 'A', 'IOFAX', 'IOFAX', 'Alphacentric Income Opportunities Fund', 'Fixed Income', 'RMBS', 'Fixed Income', 'Fixed Income', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('134', 'A', 'A', 'LQTVX', 'LQTVX', 'LS Theta Fund', 'Alternatives', 'Equity & Variance Risk Prem. Harvesting', 'Equity', 'Equity', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('135', 'A', 'A', 'RMPLX', 'RMPLX', 'RiverNorth Marketplace Lending Fund', 'Fixed Income', 'Alternative Lending', 'Fixed Income', 'Fixed Income', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('136', 'A', 'A', 'IVE.N', 'IVE.N', 'ISHARES S&P 500 VALUE ETF', 'Equity', 'Equity', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('137', 'A', 'A', 'IWS.N', 'IWS.N', 'ISHARES RUSSELL MID-CAP VALUE ETF', 'Equity', 'Equity', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('138', 'A', 'A', 'SCHB.N', 'SCHB.N', 'SCHWAB US BROAD MARKET ETF', 'Equity', 'Equity', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('139', 'A', 'A', 'SCHF.N', 'SCHF.N', 'SCHWAB INTL EQUITY ETF', 'Equity', 'Equity', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('140', 'A', 'A', 'VBR.N', 'VBR.N', 'VANGUARD CRSP US SMALL CAP VAL UE IND ET', 'Equity', 'Equity', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('141', 'A', 'A', 'C.N', 'C.N', 'Citigroup Inc.', 'Equity', 'Equity', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('142', 'A', 'A', 'IBM.N', 'IBM.N', 'International Business Machines Corporation', 'Equity', 'Equity', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('143', 'A', 'A', 'MRK.N', 'MRK.N', 'Merck & Co., Inc.', 'Equity', 'Large Cap', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('144', 'A', 'A', 'UL.N', 'UL.N', 'Unilever PLC', 'Equity', 'Large Cap', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('145', 'A', 'A', 'DAL.N', 'DAL.N', 'Delta Air Lines, Inc. ', 'Equity', 'Large Cap', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('146', 'A', 'A', 'TOL.N', 'TOL.N', 'Toll Brothers, Inc.', 'Equity', 'Large Cap', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `base_currency`) VALUES ('147', 'A', 'A', 'AFICX', 'AFICX', 'AMERICAN FUNDS FUNDAMENTAL INV ESTORS C', 'Mutual fund', 'Mutual fund', 'Equity', 'Equity', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `base_currency`) VALUES ('148', 'A', 'A', 'CWBCX', 'CWBCX', 'AMERICAN FUNDS CAPITAL WORLD B OND C', 'Mutual fund', 'Mutual fund', 'Equity', 'Equity', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `base_currency`) VALUES ('149', 'A', 'A', 'CWGCX', 'CWGCX', 'AMERICAN FUNDS CAPITAL WORLD G RWTH & INCOME C', 'Mutual fund', 'Mutual fund', 'Equity', 'Equity', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `base_currency`) VALUES ('150', 'A', 'A', 'GFACX', 'GFACX', 'AMERICAN FUNDS GROWTH FUND OF AMERICA C', 'Mutual fund', 'Mutual fund', 'Equity', 'Equity', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `base_currency`) VALUES ('151', 'A', 'A', 'SCWCX', 'SCWCX', 'AMERICAN FUNDS SMALLCAP WORLD C', 'Mutual fund', 'Mutual fund', 'Equity', 'Equity', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('152', 'A', 'A', 'MGCIX', 'MGCIX', 'Mirae Asia Great Consumer Fund', 'Equity', 'International', 'Equity', 'Equity', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `isin`, `ric`, `sedol`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `inception`, `issuer`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('600', 'A', 'A', 'VEUR.L', 'IE00B945VV12', 'VEUR.L', 'B8Y8834', 'VANGUARD FTSE DEV EU UCITS ETF', 'Equity', 'Europe Equities', 'NULL', 'NULL', '0', '0000-00-00', 'NULL', '0', 'N', 'LSE', 'GBP');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `isin`, `ric`, `sedol`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `inception`, `issuer`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('601', 'A', 'A', '1306.T', 'JP3027630007', '1306.T', '6378080', 'TOPIX EXCHANGE TRADED', 'Equity', 'Japan Equities', 'NULL', 'NULL', '0', '0000-00-00', 'NULL', '0', 'N', 'TSE', 'JPY');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `cusip`, `ric`, `sedol`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `inception`, `issuer`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('602', 'A', 'A', 'XIC.TO', '46430J101', 'XIC.TO', '2735009', 'iShares Core SP TSX CA', 'Equity', 'Australian Equities', 'NULL', 'NULL', '0', '0000-00-00', 'NULL', '0', 'N', 'TSE', 'CAD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `isin`, `ric`, `sedol`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `inception`, `issuer`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('603', 'A', 'A', 'VAS.AX', 'AU000000VAS1', 'VAS.AX', 'B42HLD6', 'iShares Core MSCI Emerging Markets IMI', 'Equity', 'Emerging Mkt. Equities', 'NULL', 'NULL', '0', '0000-00-00', 'NULL', '0', 'N', 'ASX', 'AUD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `isin`, `ric`, `sedol`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `inception`, `issuer`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('610', 'A', 'A', 'LQDE.L', 'IE0032895942', 'LQDE.L', '3289594', 'iShares $ Corp Bond UCITS ETF USD (Dist)', 'Fixed Income', 'Corporate Bonds', 'NULL', 'NULL', '0', '0000-00-00', 'NULL', '0', 'N', 'LSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `isin`, `ric`, `sedol`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `inception`, `issuer`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('611', 'A', 'A', 'IEMB.L', 'IE00B2NPKV68', 'IEMB.L', 'B2NXVM8', 'iShares J P Morgan $EM Bond ETF', 'Fixed Income', 'Emerging Market Bonds', 'NULL', 'NULL', '0', '0000-00-00', 'NULL', '0', 'N', 'LSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `isin`, `ric`, `sedol`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `inception`, `issuer`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('612', 'A', 'A', 'IEML.L', 'IE00B5M4WH52', 'IEML.L', 'B5M4WH5', 'iShares J P Morgan $EM Local Bond ETF', 'Fixed Income', 'Emerging Market Local Bonds', 'NULL', 'NULL', '0', '0000-00-00', 'NULL', '0', 'N', 'LSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('1000', 'A', 'A', 'GIOIX', 'GIOIX', 'Guggenheim Macro Opportunities Fund Institutional', 'Fixed Income', 'Unconstrained Fixed Income', 'Fixed Income', 'Fixed Income', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('1001', 'A', 'A', 'GIOPX', 'GIOPX', 'Guggenheim Macro Opportunities Fund', 'Fixed Income', 'Unconstrained Fixed Income', 'Fixed Income', 'Fixed Income', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('1002', 'A', 'A', 'LQTIX', 'LQTIX', 'LS Theta Fund Institutional', 'Alternatives', 'Equity & Variance Risk Prem. Harvesting', 'Fixed Income', 'Fixed Income', 'USD', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('1003', 'A', 'A', 'MMDA12', 'MMDA12', 'FDIC INSURED DEPOSIT ACCOUNT IDA12 NOT COVERED BY SIPC', 'Money', 'Money', 'Fixed Income', 'Fixed Income', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('1004', 'A', 'A', 'VCRRX', 'VCRRX', 'VERSUS CAPITAL REAL ASSETS FUN D LLC', 'Mutual fund', 'Mutual fund', 'Fixed Income', 'Fixed Income', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `exchange`, `base_currency`) VALUES ('1005', 'A', 'A', 'SPTM', 'SPTM', 'SPDR SERIES TRUST PORTFOLIO TO TAL STK MRKT ETF', 'Equity', 'Equity', 'Fixed Income', 'Fixed Income', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `exchange`, `base_currency`) VALUES ('1006', 'A', 'A', 'SPYD', 'SPYD', 'SPDR SERIES TRUST S&P HIGH DIV IDEND ETF', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `exchange`, `base_currency`) VALUES ('1007', 'A', 'A', 'SPYG', 'SPYG', 'SPDR SERIES TRUST S&P 500 GROW TH ETF', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `ric`, `name`, `assetclass`, `subclass`, `exchange`, `base_currency`) VALUES ('1008', 'A', 'A', 'SPYV', 'SPYV', 'SPDR SERIES TRUST  S&P500 VL E TF', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `isin`, `ric`, `sedol`, `name`, `assetclass`, `subclass`, `inception`, `exchange`, `base_currency`) VALUES ('1009', 'A', 'A', 'F00000MQNO.MSTA', 'SG9999007454', 'F00000MQNO.MSTA', 'BD3FQJ3', 'Eastspring Investments Unit Trusts', 'Fixed Income', 'Singapore Bonds', '2011-04-08', 'MSTA', 'SGD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `name`, `assetclass`, `subclass`, `exchange`, `base_currency`) VALUES ('1010', 'A', 'A', 'SCZ', 'ISHARES MSCI EAFE SMALL-CAP ET F', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `name`, `assetclass`, `subclass`, `exchange`, `base_currency`) VALUES ('1011', 'A', 'A', 'VB', 'VANGUARD SMALL CAP ETF', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `name`, `assetclass`, `subclass`, `exchange`, `base_currency`) VALUES ('1012', 'A', 'A', 'VCSH', 'VANGUARD SHORT TERM CORP BOND ETF', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `name`, `assetclass`, `subclass`, `exchange`, `base_currency`) VALUES ('1013', 'A', 'A', 'VEA', 'VANGUARD FTSE DEVELOPED MARKET S ETF', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `name`, `assetclass`, `subclass`, `exchange`, `base_currency`) VALUES ('1014', 'A', 'A', 'VRFIX', 'STONE RIDGE INTL DEVELOPED MKT S VAR RP I', 'Mutual fund', 'Mutual fund', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `name`, `assetclass`, `subclass`, `exchange`, `base_currency`) VALUES ('1015', 'A', 'A', 'VSS', 'VANGUARD WORLD EX US SMALL CAP ETF', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `name`, `assetclass`, `subclass`, `exchange`, `base_currency`) VALUES ('1016', 'A', 'A', 'VTI', 'VANGUARD TOTAL STOCK MARKET ET F', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `name`, `assetclass`, `subclass`, `exchange`, `base_currency`) VALUES ('1017', 'A', 'A', 'VTV', 'VANGUARD CRSP US LARGE CAP VAL UE IND ET', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `name`, `assetclass`, `subclass`, `exchange`, `base_currency`) VALUES ('1018', 'A', 'A', 'VUG', 'VANGUARD CRSP US LARGE CAP GRO W IND ETF', 'Equity', 'Equity', 'NYSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `name`, `assetclass`, `subclass`, `exchange`, `base_currency`) VALUES ('1019', 'A', 'A', 'VYM', 'VANGUARD HIGH DIVIDEND YIELD E TF', 'Equity', 'Equity', 'NYSE', 'USD');





