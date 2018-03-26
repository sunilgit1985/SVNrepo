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






