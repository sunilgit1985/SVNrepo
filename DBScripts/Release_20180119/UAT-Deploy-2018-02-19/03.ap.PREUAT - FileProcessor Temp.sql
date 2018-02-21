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





