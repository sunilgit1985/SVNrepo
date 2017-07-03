USE `invdb`;
CREATE TABLE `trade_process_identifier` (
  `acctnum` bigint(20) NOT NULL,
  `tradeStatus` varchar(1) DEFAULT NULL COMMENT 'N = New\nA = Allocation\nD = DateBreak\nV = View',
  `processStatus` varchar(1) DEFAULT NULL COMMENT 'N : Not Processed\nY : User Selected\nR : ReBalance\nP : Processed\nS : Sent',
  `reason` varchar(100) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`acctnum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `trade_execution_audit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product` varchar(45) NOT NULL,
  `mode` varchar(45) NOT NULL,
  `process` varchar(45) NOT NULL,
  `processId` varchar(45) NOT NULL,
  `fileName` varchar(100) NOT NULL,
  `status` varchar(45) NOT NULL,
  `remarks` varchar(500) NOT NULL,
  `executionTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



USE `invdb`;

DROP TABLE IF EXISTS `tmp_client_data`;
CREATE TABLE `tmp_client_data` (
  `clientAccountID` varchar(20) DEFAULT '',
  `acctnum`     	bigint(20) DEFAULT NULL, 
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
  `payoutRate` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

USE `invdb`;
DROP TABLE IF EXISTS `tmp_nav_daily`;
CREATE TABLE `tmp_nav_daily` (
  `clientAccountID` varchar(8) NOT NULL DEFAULT '',
  `reportDate` varchar(10) NOT NULL DEFAULT '',
  `currencyPrimary` varchar(03) DEFAULT 'USD',
  `fxRateToBase` double DEFAULT NULL,
  `cash` double DEFAULT NULL,
  `stock` double DEFAULT NULL,
  `funds` double DEFAULT NULL,
  `interestAccrual` double DEFAULT NULL,
  `dividentAccrual` double DEFAULT NULL,
  `total` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `invdb`.`tmp_position`;
CREATE TABLE `tmp_position` (
  `clientAccountID` varchar(8) NOT NULL DEFAULT '',
  `accountAlias` varchar(10) DEFAULT NULL,
  `currencyPrimary` varchar(3) DEFAULT NULL,
  `assetClass` varchar(10) DEFAULT NULL,
  `fxRateToBase` double DEFAULT NULL,
  `symbol` varchar(10) NOT NULL DEFAULT '',
  `description` varchar(60) DEFAULT NULL,
  `reportDate` varchar(8) NOT NULL DEFAULT '',
  `side` varchar(6) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `costBasisPrice` double DEFAULT NULL,
  `CostBasisMoney` double DEFAULT NULL,
  `markPrice` double DEFAULT NULL,
  `positionValue` double DEFAULT NULL,
  `fifoPnlUnrealized` double DEFAULT NULL,
  `LevelOfDetail` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `tmp_security`;
CREATE TABLE `tmp_security` (
  `symbol` varchar(12) DEFAULT NULL,
  `securityType` varchar(5) DEFAULT NULL,
  `description` varchar(60) DEFAULT NULL,
  `maturity` varchar(10) DEFAULT NULL,
  `callDate` varchar(10) DEFAULT NULL,
  `callPrice` double DEFAULT NULL,
  `issueDate` varchar(10) DEFAULT NULL,
  `firstCoupon` varchar(10) DEFAULT NULL,
  `interestRate` double DEFAULT NULL,
  `sharePerContract` int(11) DEFAULT NULL,
  `annualIncomeAmount` double DEFAULT NULL,
  `comment` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `tmp_transaction`;
CREATE TABLE `tmp_transaction` (
  `brokerAccount` varchar(20) DEFAULT '',
  `fileDate` varchar(20) DEFAULT NULL,
  `clientAccountID` varchar(20) DEFAULT '',
  `transactionCode` varchar(20) DEFAULT '',
  `cancelStatusFlag` varchar(20) DEFAULT NULL,
  `symbolCUSIP` varchar(20) DEFAULT '',
  `securityCode` varchar(20) DEFAULT NULL,
  `tradeDatePayDate` varchar(20) DEFAULT NULL,
  `quantity` varchar(20) DEFAULT NULL,
  `netAmount` varchar(20) DEFAULT NULL,
  `principalGrossAmount` varchar(20) DEFAULT NULL,
  `brokerFee` varchar(20) DEFAULT NULL,
  `otherFees` varchar(20) DEFAULT NULL,
  `settleDateExDate` varchar(20) DEFAULT NULL,
  `fromToAccount` varchar(20) DEFAULT NULL,
  `accountType` varchar(250) DEFAULT NULL,
  `accruedInterest` varchar(20) DEFAULT NULL,
  `closingAccountingMethod` varchar(20) DEFAULT NULL,
  `comments` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `tmp_unrealized`;
CREATE TABLE `tmp_unrealized` (
  `custodialID` varchar(20) NOT NULL DEFAULT '',
  `businessDate` varchar(20) NOT NULL DEFAULT '',
  `clientAccountID` varchar(20) NOT NULL DEFAULT '',
  `accountType` varchar(30) NOT NULL DEFAULT '',
  `securityType` varchar(20) DEFAULT NULL,
  `symbolCUSIP` varchar(30) NOT NULL DEFAULT '',
  `currentQuantity` varchar(20) NOT NULL DEFAULT '',
  `costBasis` varchar(20) DEFAULT NULL,
  `adjustedCostBasis` varchar(20) DEFAULT NULL,
  `unrealizedGainLoss` varchar(20) DEFAULT NULL,
  `costBasisFullyKnown` varchar(1) DEFAULT NULL,
  `certifiedFlag` varchar(1) DEFAULT NULL,
  `originalPurchaseDate` varchar(20) NOT NULL DEFAULT '',
  `originalPurchasePrice` varchar(20) DEFAULT NULL,
  `washSaleIndicator` varchar(1) DEFAULT NULL,
  `disallowedAmount` varchar(20) DEFAULT NULL,
  `averagedCost` varchar(20) DEFAULT NULL,
  `bookCost` varchar(20) DEFAULT NULL,
  `bookProceeds` varchar(20) DEFAULT NULL,
  `fixedIncomeCostAdjustment` varchar(20) DEFAULT NULL,
  `ID` varchar(30) NOT NULL DEFAULT '',
  `securityName` varchar(60) DEFAULT NULL,
  `covered` varchar(20) DEFAULT NULL,
  `unknownTotal` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


USE `invdb`;
DROP procedure IF EXISTS `file_process_auditrial`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `file_process_auditrial`(
in p_id	bigint(20),
in p_product	varchar(45),
in p_mode	varchar(45),
in p_process	varchar(45),
in p_processId	varchar(45),
in p_fileName	varchar(100),
in p_status	varchar(45),
in p_remarks	varchar(500),
in p_executionTime	datetime,
in p_opt varchar(20),
out op_msgCode int(3),out op_msg varchar(20))
BEGIN

	Insert into invdb.trade_execution_audit(
product,
mode,
process,
processId,
fileName,
status,
remarks,
executionTime)
    value(p_product,
p_mode,
p_process,
p_processId,
p_fileName,
p_status,
p_remarks,
now());

    
	SELECT 'MSG', max(id) INTO op_msg , op_msgCode from invdb.trade_execution_audit;

END$$

DELIMITER ;




USE `invdb`;
DROP procedure IF EXISTS `sp_trade_process_buy`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sp_trade_process_buy` ()
BEGIN

SELECT 
    utl.acctnum,
    utl.clientAccountID,
    utl.tradeStatus,
    DATE_FORMAT(utl.tradedate,'%Y%m%d')tradedate,
    utl.ticker,
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
    daod.emailAddress email
FROM
    invdb.user_trade_log utl,
    invdb.dc_acct_owners_details daod
WHERE
    utl.acctnum = daod.acctnum
        AND utl.tradeStatus = 'P'
        AND daod.acctnum = daod.acctnum
        AND daod.ownership = 'AOPRIMARY'
        and utl.qty<>0
        AND utl.investmentamount<>0
	    AND utl.action='BUY'
ORDER BY acctnum;


END$$

DELIMITER ;


USE `invdb`;
DROP procedure IF EXISTS `sp_trade_process_sell`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sp_trade_process_sell` ()
BEGIN

SELECT 
    utl.acctnum,
    utl.clientAccountID,
    utl.tradeStatus,
    DATE_FORMAT(utl.tradedate,'%Y%m%d')tradedate,
    utl.ticker,
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
    daod.emailAddress email
FROM
    invdb.user_trade_log utl,
    invdb.dc_acct_owners_details daod
WHERE
    utl.acctnum = daod.acctnum
        AND utl.tradeStatus = 'P'
        AND daod.acctnum = daod.acctnum
        AND daod.ownership = 'AOPRIMARY'
        and utl.qty<>0
        AND utl.investmentamount<>0
	    AND utl.action='SELL'
ORDER BY acctnum;


END$$

DELIMITER ;


USE `invdb`;
DROP procedure IF EXISTS `sp_trade_process_both`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sp_trade_process_both` ()
BEGIN

SELECT 
    utl.acctnum,
    utl.clientAccountID,
    utl.tradeStatus,
    DATE_FORMAT(utl.tradedate,'%Y%m%d')tradedate,
    utl.ticker,
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
    daod.emailAddress email
FROM
    invdb.user_trade_log utl,
    invdb.dc_acct_owners_details daod
WHERE
    utl.acctnum = daod.acctnum
        AND utl.tradeStatus = 'P'
        AND daod.acctnum = daod.acctnum
        AND daod.ownership = 'AOPRIMARY'
        and utl.qty<>0
        AND utl.investmentamount<>0
	ORDER BY acctnum;
END$$

DELIMITER ;



USE `invdb`;
DROP procedure IF EXISTS `parentDBProcedure`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `parentDBProcedure` ()
  BEGIN

    delete from temp_td_unrealized;
    delete from tmp_nav_daily;
    delete from tmp_position;
    delete from tmp_transaction;
    delete from tmp_client_data;

  END$$

DELIMITER ;

