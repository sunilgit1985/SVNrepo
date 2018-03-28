
/* 01.ap.FileProcessor Updated Procedures.sql010318_abhang*/

USE `temp`;
DROP procedure IF EXISTS `sp_upload_exchange_rate`;

DELIMITER $$
USE `temp`$$
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

END$$

DELIMITER ;



USE `temp`;
DROP procedure IF EXISTS `sp_upload_ext_acct_info`;

DELIMITER $$
USE `temp`$$
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
    ;UPDATE `invdb`.`user_trade_profile`, `invdb`.`ext_acct_info`
		set `user_trade_profile`.`clientAccountID` = `ext_acct_info`.`clientAccountID`,
			`user_trade_profile`.`firstname` = `ext_acct_info`.`applicantFName`,
			`user_trade_profile`.`lastname` = `ext_acct_info`.`applicantLName`,
            `user_trade_profile`.`managed` = CASE WHEN (`ext_acct_info`.`status` in ('A', 'O')) THEN 'A'
												  ELSE 'X'
											 END,
            `user_trade_profile`.`status` = CASE WHEN (`ext_acct_info`.`status` in ('O')) THEN 'O'
												  ELSE `user_trade_profile`.`status`
											 END,
            `user_trade_profile`.`lastUpdated` = now()
	
    
    WHERE `user_trade_profile`.`acctnum` = `ext_acct_info`.`acctnum`;

END$$

DELIMITER ;







USE `temp`;
DROP procedure IF EXISTS `sp_upload_investment`;

DELIMITER $$
USE `temp`$$
CREATE  PROCEDURE `sp_upload_investment`(
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
`invdb`.`get_exchange_rate`(trdProf.tradeCurrency,settleCurrency) fxRateToBase, 
settleCurrency,(`invdb`.`get_exchange_rate`(trdProf.tradeCurrency,settleCurrency)*trdProf.initialInvestment) convertedNetAmount,'A', now() created
-- ,tmpInv.* 
from 
temp.tmp_investment tmpInv, 
invdb.ext_acct_info extAcct,
invdb.user_trade_profile trdProf
where  extAcct.clientAccountID=tmpInv.clientAccountID
and trdProf.acctnum=extAcct.acctnum
);

		
   end;

END$$

DELIMITER ;







USE `temp`;
DROP procedure IF EXISTS `sp_upload_nav`;

DELIMITER $$
USE `temp`$$
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
		IFNULL(`invdb`.`get_exchange_rate`(ep.settleCurrency,vSettCurrency),1) as exchangeRate, 
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
		IFNULL(`invdb`.`get_exchange_rate`(tn.currencyPrimary,vSettCurrency),1) as exchangeRate, 
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
         and tn.currencyPrimary not in(select currencyPrimary from temp.tmp_position tp where tp.reportDate=tn.reportDate and tp.clientAccountID=tn.clientAccountID)
        ) group by tn.clientAccountID,tn.currencyPrimary;
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
                `settleMarkPrice`,
				`settleValue`,
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
                , 1 as settleMarkPrice	
				, extNav.cash as settleValue	
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
DROP procedure IF EXISTS `sp_upload_position`;

DELIMITER $$
USE `temp`$$
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
			IFNULL(`pos`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(pos.currencyPrimary,vSettCurrency),1)) as fxRateToBase,
			ifnull((select ticker from invdb.sec_master where isin=symbol),symbol) as symbol,
			IFNULL(`reportDate`,tReportDate),
			IFNULL(`reportDate`,tReportDate),
			'Long' as side,
			`quantity`	,
			(markPrice*IFNULL(`pos`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(pos.currencyPrimary,vSettCurrency),1))) as costBasisPrice,
			(positionvalue*IFNULL(`pos`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(pos.currencyPrimary,vSettCurrency),1))) as costBasisMoney,
			(markPrice*IFNULL(`pos`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(pos.currencyPrimary,vSettCurrency),1))) as markPrice,
			(positionvalue*IFNULL(`pos`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(pos.currencyPrimary,vSettCurrency),1))) as  positionValue	,
			(positionvalue*IFNULL(`pos`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(pos.currencyPrimary,vSettCurrency),1))-positionvalue*IFNULL(`pos`.`fxRateToBase`,IFNULL(`invdb`.`get_exchange_rate`(pos.currencyPrimary,vSettCurrency),1)))`fifoPnlUnrealized`	, 
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
END$$

DELIMITER ;









USE `temp`;
DROP procedure IF EXISTS `sp_upload_transaction`;

DELIMITER $$
USE `temp`$$
CREATE PROCEDURE `sp_upload_transaction`(
)
BEGIN 

	DECLARE tReportDate	VARCHAR(10);

	DECLARE vSettCurrency	VARCHAR(3);

	set vSettCurrency = ifnull(invdb.FUNCT_GET_SWITCH('SETT_CURRUNCY'),'USD');
      
	set tReportDate = `invdb`.`FUNCT_GET_SWITCH`('BUSINESS_DATE');
   
	begin

		DELETE FROM `invdb`.`ext_transaction`  
        WHERE CONCAT(`clientAccountID`, `settDate`) IN (SELECT DISTINCT  CONCAT(`clientAccountID`,  IFNULL(`settleDate`, tReportDate)) FROM `temp`.`tmp_transaction`);
	end;

   begin


INSERT INTO `invdb`.`ext_transaction`
(`acctnum`,
`clientAccountID`,
`ticker`,
`isin`,
`confirmNumber`,
`transactionSource`,
`transactionType`,
`transactionStatus`,
`controlNumber`,
`quantity`,
`price`,
`netAmount`,
`commission`,
`otherFees`,
`tradeDate`,
`settDate`,
`voidDate`,
`comment`,
`tradedCurrency`,
`fxRateToBase`,
`settleCurrency`,
`settleQty`,
`settlePrice`,
`settleNetAmount`,
`settleFees`,
`created`)
select acct_info.acctnum as acctnum,
tmpTran.clientAccountID as clientAccountID,
ifnull((select ticker from invdb.sec_master where isin=tmpTran.symbolSIN),tmpTran.symbolSIN) ticker,
tmpTran.symbolSIN isin,
tmpTran.confirmNumber confirmNumber,
null as transactionSource,
case when (tmpTran.quantity is not null and tmpTran.quantity>0) then 'B' 
when (tmpTran.soldQuantity is not null and tmpTran.soldQuantity>0) then 'S'
else null end  as transactionType,
tmpTran.statusFlag as transactionStatus,
null as controlNumber,
case when (tmpTran.quantity is not null and tmpTran.quantity>0) then tmpTran.quantity 
when (tmpTran.soldQuantity is not null and tmpTran.soldQuantity>0) then tmpTran.soldQuantity 
else null end as quantity,
tmpTran.price as price,
ifnull(tmpTran.netAmount,tmpTran.price*quantity) as netAmount,
tmpTran.brokerFee as commission,
tmpTran.otherFees as otherFees,
null as tradeDate,
tmpTran.settleDate as settDate,
null as voidDate,
tmpTran.comments as comment,
ifnull(tmpTran.executionCurrency,'USD') as tradedCurrency,
ifnull(tmpTran.exchangeRate,IFNULL(`invdb`.`get_exchange_rate`(tmpTran.executionCurrency,vSettCurrency),1)) as fxRateToBase,
ifnull(tmpTran.localCurrency,vSettCurrency) as settleCurrency,
tmpTran.quantity as settleQty,
ifnull(tmpTran.exchangeRate,IFNULL(`invdb`.`get_exchange_rate`(tmpTran.executionCurrency,vSettCurrency),1))*tmpTran.price as settlePrice,
ifnull(tmpTran.exchangeRate,IFNULL(`invdb`.`get_exchange_rate`(tmpTran.executionCurrency,vSettCurrency),1))*ifnull(tmpTran.netAmount,(ifnull(tmpTran.exchangeRate,IFNULL(`invdb`.`get_exchange_rate`(tmpTran.executionCurrency,vSettCurrency),1))*tmpTran.price)*quantity) as settleNetAmount,
(tmpTran.brokerFee + tmpTran.otherFees )as settleFees,
now()
from `temp`.`tmp_transaction` tmpTran, invdb.ext_acct_info acct_info
where acct_info.clientAccountID=tmpTran.clientAccountID;

/*
INSERT INTO `invdb`.`ext_pos_master`
(`acctnum`,
`ticker`,
`trade`,
`type`,
`quantity`,
`price`,
`created`)
select acct_info.acctnum as acctnum,
ifnull((select ticker from invdb.sec_master where isin=tmpTran.symbolSIN),tmpTran.symbolSIN) ticker,
tmpTran.netAmount as trade,
case when (tmpTran.quantity is not null and tmpTran.quantity>0) then 'B' 
when (tmpTran.soldQuantity is not null and tmpTran.soldQuantity>0) then 'S'
else null end  as type,
case when (tmpTran.quantity is not null and tmpTran.quantity>0) then tmpTran.quantity 
when (tmpTran.soldQuantity is not null and tmpTran.soldQuantity>0) then tmpTran.soldQuantity 
else null end as quantity,
tmpTran.price as price,
now()
from `temp`.`tmp_transaction` tmpTran, invdb.ext_acct_info acct_info
where acct_info.clientAccountID=tmpTran.clientAccountID;
*/


   end;
END$$

DELIMITER ;





USE `temp`;
DROP procedure IF EXISTS `sp_td_eod_process`;

DELIMITER $$
USE `temp`$$
CREATE  PROCEDURE `sp_td_eod_process`(
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
    
    update invdb.user_trade_profile utp, invdb.ext_acct_info eai  set utp.status='S'
			where  eai.status = 'O' 
            and utp.acctnum=eai.acctnum
			and eai.clientAccountID in ( select distinct(tmpNav.clientAccountID)
			from temp.tmp_nav tmpNav) ;

    
    update invdb.ext_acct_info set status='A'
			where  invdb.ext_acct_info.status = 'O' 
			and invdb.ext_acct_info.clientAccountID in ( select distinct(tmpNav.clientAccountID)
			from temp.tmp_nav tmpNav) ;

END$$

DELIMITER ;





USE `invdb`;
DROP function IF EXISTS `get_exchange_rate`;

DELIMITER $$
USE `invdb`$$
CREATE DEFINER=`admin`@`localhost` FUNCTION `get_exchange_rate`( p_from_currency varchar(20), p_to_currency varchar(20)) RETURNS double
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
if(p_from_currency is not null and p_to_currency is not null) then
if(p_from_currency =p_to_currency) then
	set retExchangeRate =1;
else
	set p_priceDate = `invdb`.`FUNCT_GET_SWITCH`('PRICE_DATE');
    set p_businessdate = `invdb`.`FUNCT_GET_SWITCH`('BUSINESS_DATE');
    
SELECT 
    COUNT(*)
INTO p_exchngGiven FROM
    invdb.ext_exchange_rate
WHERE
    reportDate = p_businessdate
        AND settleCurrency = p_from_currency
        AND tradeCurrency = p_to_currency;
    
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
SELECT SUBSTRING(p_symbol, 1, 3) INTO p_frstcd;
SELECT SUBSTRING(p_symbol, 4, 6) INTO p_scndcd;
        set p_symbol=concat(p_scndcd,p_frstcd);
    	SELECT 
    COUNT(*)
INTO p_exchngavailable FROM
    invdb.sec_exchangerate_master
WHERE
    symbol = p_symbol;
  
    		if(p_exchngavailable>0) then
               select sed.reverseExchangeRate into retExchangeRate from rbsa.sec_exchangerate_data sed where sed.symbol=p_symbol and sed.exchangeDate=DATE_FORMAT(p_priceDate, '%Y-%m-%d');
               set exhangeStatus='Success';
    		end if;
    end if;
    
    end if;
    end if;
    end if;
   -- select exhangeStatus,retExchangeRate;
return retExchangeRate;
END$$

DELIMITER ;



USE `temp`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
   
    SQL SECURITY DEFINER
VIEW `temp`.`vw_holiday_list` AS
    SELECT 
        `invdb`.`holiday_master`.`hdate` AS `hdate`,
        `invdb`.`holiday_master`.`country` AS `country`
    FROM
        `invdb`.`holiday_master`;

/* 02.ap.File Rules.sql010318_abhang*/

delete from  service.pdf_file_rules where fileid in ('UOB_ACCT_OPEN_NEW_USER','UOB_ACCT_OPEN_EXISTING_USER');

INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'acctnum1', 'acctnum', '1', '490', '723', '1', 'acctnum', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'acctnum', 'acctnum', '1', '230', '650', '5', 'acctnum', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'existingTradeAcctNumber', 'UOBKH Existing Account Number', '1', '230', '635.45', '1', 'existingTradeAcctNumber', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'acctTypeId', 'Account Type', '1', '230', '608.532', '2', 'acctTypeVal', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'repId', 'TR Code', '1', '230', '593.982', '1', 'repId', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'salesPersonName', 'TR Name', '1', '230', '579.432', '1', 'salesPersonName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'dateOfApplication', 'Date Of Application', '1', '230', '564.883', '1', 'dateOfApplication', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'fullName', 'fullname', '1', '230', '496.497', '5', 'fullName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'icno', 'I C No.', '1', '230', '481.948', '0', 'icno', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'passport', 'Passport No.', '1', '230', '481.948', '0', 'passport', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'nric', 'NRIC', '1', '230', '481.948', '1', 'nric', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'mobNumberCD', 'Mob Number CD', '1', '230', '467.397', '1', 'mobNumberCD', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'mobNumber', 'Mobile No.', '1', '270', '467.397', '0', 'mobNumber', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'emailAddress', 'Email Address', '1', '230', '413.562', '4', 'emailAddress', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankAccountHolderName', 'Name of Bank Account Holder', '1', '230', '359.728', '4', 'bankAccountHolderName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankName', 'bankName', '1', '230', '332.81', '2', 'bankName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankAccountNo', 'bankAccountNo', '1', '230', '318.26', '1', 'bankAccountNo', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankAddressStreet1', 'bankAddressStreet1', '1', '230', '303.71', '1', 'bankAddressStreet1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankAddressStreet2', 'bankAddressStreet2', '1', '230', '289.16', '1', 'bankAddressStreet2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankAddressStreet3', 'bankAddressStreet3', '1', '230', '274.61', '1', 'bankAddressStreet3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankAddressCity,  bankAddressState', 'bankAddressCity,  bankAddressState', '1', '230', '260.06', '1', 'bankAddressCity', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankAddressZipCode', 'bankAddressZipCode', '1', '230', '245.51', '1', 'bankAddressZipCode', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankAddressCountry', 'bankAddressCountry', '1', '230', '230.96', '1', 'bankAddressCountry', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'swiftBic', 'swiftBic', '1', '230', '216.41', '1', 'swiftBic', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'correspondentBank', 'correspondentBank', '1', '230', '201.86', '1', 'correspondentBank', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'correspondentBankSwiftBic', 'correspondentBankSwiftBic', '1', '230', '187.31', '1', 'correspondentBankSwiftBic', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'acctnum2', 'acctnum', '2', '490', '723', '1', 'acctnum', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'tinUnavailableReason1', 'tinUnavailableReason1', '2', '415', '606', '0', 'tinUnavailableReason1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'taxIdentificationNumber1', 'taxIdentificationNumber1', '2', '260', '606', '0', 'taxIdentificationNumber1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'jurisdictionOfTaxResidence1', 'jurisdictionOfTaxResidence1', '2', '110', '606', '13', 'jurisdictionOfTaxResidence1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'tinUnavailableReason2', 'tinUnavailableReason2', '2', '415', '591.45', '0', 'tinUnavailableReason2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'taxIdentificationNumber2', 'taxIdentificationNumber2', '2', '260', '591.45', '0', 'taxIdentificationNumber2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'jurisdictionOfTaxResidence2', 'jurisdictionOfTaxResidence2', '2', '110', '591.45', '1', 'jurisdictionOfTaxResidence2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'taxIdentificationNumber3', 'taxIdentificationNumber3', '2', '260', '576.9', '0', 'taxIdentificationNumber3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'tinUnavailableReason3', 'tinUnavailableReason3', '2', '415', '576.9', '0', 'tinUnavailableReason3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'jurisdictionOfTaxResidence3', 'jurisdictionOfTaxResidence3', '2', '110', '576.9', '1', 'jurisdictionOfTaxResidence3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'jurisdictionOfTaxResidenceB1', 'jurisdictionOfTaxResidenceB1', '2', '110', '523.065', '4', 'jurisdictionOfTaxResidenceB1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'tinUnavailableValueB1', 'tinUnavailableValueB1', '2', '260', '523.065', '0', 'tinUnavailableValueB1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'jurisdictionOfTaxResidenceB2', 'jurisdictionOfTaxResidenceB2', '2', '110', '508.515', '1', 'jurisdictionOfTaxResidenceB2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'tinUnavailableValueB2', 'tinUnavailableValueB2', '2', '260', '508.515', '0', 'tinUnavailableValueB2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'jurisdictionOfTaxResidenceB3', 'jurisdictionOfTaxResidenceB3', '2', '110', '493.965', '1', 'jurisdictionOfTaxResidenceB3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'tinUnavailableValueB3', 'tinUnavailableValueB3', '2', '260', '493.965', '0', 'tinUnavailableValueB3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'motherMaidenName', 'Mother’s Maiden Name', '2', '230', '305.543', '14', 'motherMaidenName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'fatherName', 'Father’s Name', '2', '230', '290.992', '1', 'fatherName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'nameOfPrimarySchool', 'Name of Primary School Attended', '2', '230', '276.443', '1', 'nameOfPrimarySchool', 'Client', 'N', 'N');



INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'acctnum1', 'acctnum', '1', '490', '723', '1', 'acctnum', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'acctnum', 'acctnum', '1', '230', '650', '5', 'acctnum', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'acctTypeId', 'Account Type', '1', '230', '635.45', '1', 'acctTypeVal', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'repId', 'TR Code', '1', '230', '620.9', '1', 'repId', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'salesPersonName', 'TR Name', '1', '230', '606.35', '1', 'salesPersonName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'dateOfApplication', 'Date Of Application', '1', '230', '591.8', '1', 'dateOfApplication', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'title', 'titile', '1', '230', '524.415', '5', 'title', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'fullName', 'fullname', '1', '230', '509.865', '1', 'fullName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'gender', 'gender', '1', '230', '495.315', '1', 'gender', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'passport', 'Passport No.', '1', '230', '480.765', '0', 'passport', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'nric', 'NRIC', '1', '230', '480.765', '1', 'nric', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'icno', 'I C No.', '1', '230', '480.765', '0', 'icno', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'countryOfBirthSpecify', 'Country of Birth Other Specify', '1', '320', '466.215', '0', 'countryOfBirthSpecify', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'countryOfBirth', 'Country of Birth', '1', '230', '466.215', '1', 'countryOfBirth', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'dob', 'Date of Birth (DD/MM/YYYY)', '1', '230', '451.665', '1', 'dobDDMMYYYY', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'nationalitySpecify', 'Nationality Other Specify', '1', '320', '437.115', '0', 'nationalitySpecify', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'nationality', 'Nationality', '1', '230', '437.115', '1', 'nationality', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'permanentRsdntOfSingapore', 'Permanent Resident of Singapore', '1', '230', '422.565', '1', 'permanentRsdntOfSingapore', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mobNumber', 'Mobile No.', '1', '270', '395.647', '0', 'mobNumber', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mobNumberCD', 'Mob Number CD', '1', '230', '395.647', '2', 'mobNumberCD', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'homeTelNumberCD', 'Home TelNumber CD', '1', '230', '381.098', '1', 'homeTelNumberCD', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'homeTelNumber', 'Home Tel No.', '1', '270', '381.098', '0', 'homeTelNumber', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'emailAddress', 'Email Address', '1', '230', '366.547', '1', 'emailAddress', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'physicalAddressStreet1', 'Residential Address', '1', '230', '312.712', '4', 'physicalAddressStreet1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'physicalAddressStreet2', 'Residential Address', '1', '230', '298.163', '1', 'physicalAddressStreet2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'physicalAddressStreet3', 'Residential Address', '1', '230', '283.612', '1', 'physicalAddressStreet3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'physicalAddressCity, physicalAddressState', 'Residential City / State', '1', '230', '269.062', '1', 'physicalAddressCity', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'physicalAddressZipCode', 'Residential Postal Code', '1', '230', '254.512', '1', 'physicalAddressZipCode', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'physicalAddressCountry', 'Residential Country', '1', '230', '239.962', '1', 'physicalAddressCountry', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'acctnum2', 'acctnum', '2', '490', '723', '1', 'acctnum', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mailAddressSameAsPhysical', 'Mailing Address Same As Physical', '2', '230', '650', '5', 'mailAddressSameAsPhysical', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'reasonForMailAddreDiffer', 'reasonForMailAddreDiffer', '2', '230', '622.083', '2', 'reasonForMailAddreDiffer', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mailingAddressStreet1', 'Mailing Address', '2', '230', '607.532', '1', 'mailingAddressStreet1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mailingAddressStreet2', 'Mailing Address', '2', '230', '592.982', '1', 'mailingAddressStreet2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mailingAddressStreet3', 'Mailing Address', '2', '230', '578.432', '1', 'mailingAddressStreet3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mailingAddressCity, mailingAddressState', 'Mailing City / State', '2', '230', '563.883', '1', 'mailingAddressCity', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mailingAddressZipCode', 'Mailing Postal Code', '2', '230', '549.333', '1', 'mailingAddressZipCode', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mailingAddressCountry', 'Mailing Country', '2', '230', '534.782', '1', 'mailingAddressCountry', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankAccountHolderName', 'Name of Bank Account Holder', '2', '230', '480.948', '4', 'bankAccountHolderName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankName', 'bankName', '2', '230', '454.03', '2', 'bankName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankAccountNo', 'bankAccountNo', '2', '230', '439.48', '1', 'bankAccountNo', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankAddressStreet1', 'bankAddressStreet1', '2', '230', '424.93', '1', 'bankAddressStreet1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankAddressStreet2', 'bankAddressStreet2', '2', '230', '410.38', '1', 'bankAddressStreet2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankAddressStreet3', 'bankAddressStreet3', '2', '230', '395.83', '1', 'bankAddressStreet3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankAddressCity,  bankAddressState', 'bankAddressCity,  bankAddressState', '2', '230', '381.28', '1', 'bankAddressCity', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankAddressZipCode', 'bankAddressZipCode', '2', '230', '366.73', '1', 'bankAddressZipCode', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankAddressCountry', 'bankAddressCountry', '2', '230', '352.18', '1', 'bankAddressCountry', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'swiftBic', 'swiftBic', '2', '230', '337.63', '1', 'swiftBic', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'correspondentBank', 'correspondentBank', '2', '230', '323.08', '1', 'correspondentBank', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'correspondentBankSwiftBic', 'correspondentBankSwiftBic', '2', '230', '308.53', '1', 'correspondentBankSwiftBic', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'acctnum3', 'acctnum', '3', '490', '723', '1', 'acctnum', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'jurisdictionOfTaxResidence1', 'jurisdictionOfTaxResidence1', '3', '110', '606.35', '8', 'jurisdictionOfTaxResidence1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'tinUnavailableReason1', 'tinUnavailableReason1', '3', '415', '606.35', '0', 'tinUnavailableReason1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'taxIdentificationNumber1', 'taxIdentificationNumber1', '3', '260', '606.35', '0', 'taxIdentificationNumber1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'tinUnavailableReason2', 'tinUnavailableReason2', '3', '415', '591.8', '0', 'tinUnavailableReason2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'taxIdentificationNumber2', 'taxIdentificationNumber2', '3', '260', '591.8', '0', 'taxIdentificationNumber2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'jurisdictionOfTaxResidence2', 'jurisdictionOfTaxResidence2', '3', '110', '591.8', '1', 'jurisdictionOfTaxResidence2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'tinUnavailableReason3', 'tinUnavailableReason3', '3', '415', '577.25', '0', 'tinUnavailableReason3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'jurisdictionOfTaxResidence3', 'jurisdictionOfTaxResidence3', '3', '110', '577.25', '1', 'jurisdictionOfTaxResidence3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'taxIdentificationNumber3', 'taxIdentificationNumber3', '3', '260', '577.25', '0', 'taxIdentificationNumber3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'tinUnavailableValueB1', 'tinUnavailableValueB1', '3', '260', '521.415', '0', 'tinUnavailableValueB1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'jurisdictionOfTaxResidenceB1', 'jurisdictionOfTaxResidenceB1', '3', '110', '521.415', '4', 'jurisdictionOfTaxResidenceB1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'tinUnavailableValueB2', 'tinUnavailableValueB2', '3', '260', '506.865', '0', 'tinUnavailableValueB2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'jurisdictionOfTaxResidenceB2', 'jurisdictionOfTaxResidenceB2', '3', '110', '506.865', '1', 'jurisdictionOfTaxResidenceB2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'tinUnavailableValueB3', 'tinUnavailableValueB3', '3', '260', '492.315', '0', 'tinUnavailableValueB3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'jurisdictionOfTaxResidenceB3', 'jurisdictionOfTaxResidenceB3', '3', '110', '492.315', '1', 'jurisdictionOfTaxResidenceB3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'acctnum4', 'acctnum', '4', '490', '723', '1', 'acctnum', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'motherMaidenName', 'Mother’s Maiden Name', '4', '230', '650', '5', 'motherMaidenName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'fatherName', 'Father’s Name', '4', '230', '635.45', '1', 'fatherName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'nameOfPrimarySchool', 'Name of Primary School Attended', '4', '230', '620.9', '1', 'nameOfPrimarySchool', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'employmentStatus', 'Employment Status', '4', '230', '552.515', '5', 'emplTypeId', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'unemploymentReason', 'Unemployment Reason', '4', '230', '537.965', '1', 'reasonForUnemployment', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'occupation', 'Occupation', '4', '230', '523.415', '1', 'occupation', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'employerName', 'Name of Employer', '4', '230', '508.865', '1', 'employerName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'employerStreetAddress1', 'Employer Address', '4', '230', '494.315', '1', 'employerStreetAddress1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'employerStreetAddress2', 'Employer Address', '4', '230', '479.765', '1', 'employerStreetAddress2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'employerStreetAddress3', 'Employer Address', '4', '230', '465.215', '1', 'employerStreetAddress3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'employerCity,employerState', 'City / State', '4', '230', '450.665', '1', 'employerCity', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'employerZipCode', 'Postal Code', '4', '230', '436.115', '1', 'employerZipCode', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'employerZipCountry', 'Country', '4', '230', '421.565', '1', 'employerZipCountry', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'officeTelNumberCD', 'Office Tel Number CD', '4', '230', '407.015', '1', 'officeTelNumberCD', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'officeTelNumber', 'Office Tel No.', '4', '270', '407.015', '0', 'officeTelNumber', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'annualIncome', 'Annual Income', '4', '230', '353.18', '4', 'annualIncome', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'sourceOfFundsWealthSpecify', 'Source of Funds / Wealth Other Specify', '4', '350', '338.63', '0', 'sourceOfFundsWealthSpecify', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'sourceOfFundsWealth', 'Source of Funds / Wealth', '4', '230', '338.63', '1', 'sourceOfFundsWealth', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'networth', 'Networth', '4', '230', '324.08', '1', 'networth', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'qualifications', 'Educational Qualifications', '4', '230', '309.53', '1', 'qualifications', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'qualificationsSpecify', 'Educational Qualifications Other Specify', '4', '350', '309.53', '0', 'qualificationsSpecify', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'goodsServicesTax', 'Goods & Services Tax', '4', '230', '268.062', '3', 'havingGST', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'acctnum5', 'acctnum', '5', '490', '723', '1', 'acctnum', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'relatedToAnyEmplfUOB', 'relatedToAnyEmplfUOB', '5', '505', '645', '1', 'relatedToAnyEmplfUOB', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'relatedToAnyEmplName1', 'Name1', '5', '230', '630.45', '1', 'relatedToAnyEmplName1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'relatedToAnyEmplRelation1', 'Relationship1', '5', '230', '615.9', '1', 'relatedToAnyEmplRelation1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'relatedToAnyEmplName2', 'Name2', '5', '230', '601.35', '1', 'relatedToAnyEmplName2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'relatedToAnyEmplRelation2', 'Relationship2', '5', '230', '586.8', '1', 'relatedToAnyEmplRelation2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'areYouUnableToPayYouDebts', 'areYouUnableToPayYouDebts', '5', '230', '454.58', '9', 'areYouUnableToPayYouDebts', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'areYouUnableToPayYouDebtsDescribe', 'areYouUnableToPayYouDebtsDescribe', '5', '80', '427.663', '2', 'areYouUnableToPayYouDebtsDescribe', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'doYouHaveAnyDisputedAccount', 'doYouHaveAnyDisputedAccount', '5', '230', '371.828', '4', 'doYouHaveAnyDisputedAccount', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'doYouHaveAnyDisputedAccountDescribe', 'doYouHaveAnyDisputedAccountDescribe', '5', '80', '344.91', '2', 'doYouHaveAnyDisputedAccountDescribe', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'consentCallContact', 'consentCallContact', '5', '230', '231.24', '8', 'consentCallContact', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'consentTextContact', 'consentTextContact', '5', '230', '216.69', '1', 'consentTextContact', 'Client', 'N', 'N');
