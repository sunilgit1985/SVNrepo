
/* 100.pm.advisor_risk_master.sql080218_pmehta*/

DROP TABLE IF EXISTS `invdb`.`advisor_risk_master`;

CREATE TABLE `invdb`.`advisor_risk_master` (
  `advisor` 		varchar(20) NOT NULL,
  `sortorder`		Integer DEFAULT 1,
  `key` 			varchar(30) DEFAULT NULL,
  `displayName`		varchar(60) DEFAULT NULL,
  `defaultValue`    varchar(30) DEFAULT NULL,
  `dataType`		varchar(1)	DEFAULT "T",
  `displayOnStart`  varchar(30) DEFAULT 0,
  `displayAdvisor`  Boolean DEFAULT false,
  `saveforUser`  	Boolean DEFAULT false,
  `created` 		date DEFAULT NULL,
  `lastUpdated` 	date DEFAULT NULL,
  PRIMARY KEY `PK1_advisor_risk_master` (`advisor`,`sortorder`, `key`),
  KEY `AK1_advisor_risk_master` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM `invdb`.`advisor_risk_master` ;

INSERT INTO `invdb`.`advisor_risk_master` (`advisor`, `sortorder`,`key`, `displayName`, `defaultValue`,`dataType`
, `displayOnStart`,`displayAdvisor`,`saveforUser`) 
VALUES 
 ('UOB', 10, 'RISKQUESTIONS', null, '8','I','0',false,true)
,('UOB', 15, 'THEME', 'Investment Model','8.UOB','T','0',true,true)
,('UOB', 20, 'CALCMETHOD', null,'AGETIME','T','0',false,true)
,('UOB', 30, 'CALFORMULA', 'Calculation Process','C','T','0',true,true)
,('UOB', 40, 'GOAL', 'Goal', 'RETIREMENT','T','0',true,true)
,('UOB', 45, 'RETIRED', 'Retired', 'false','B','0',true,true)
,('UOB', 60, 'AGE', 'Age', '35','I','0',true,true)
,('UOB', 70, 'HORIZON', 'Horizon', '35','I','0',true,true)
,('UOB', 80, 'WITHDRAWALPERIOD', 'Withdrawl Period', '0','I','0',true,true)
,('UOB', 90, 'TRADECURRENCY', null, 'SGD','T','0',false,true)
,('UOB', 95, 'SETTLEMENTCURRENCY', null,'SGD','T','0',false,true)
,('UOB', 100, 'INITIALINVESTMENT', 'Investment', '10000','D','0',true,true)
,('UOB', 105, 'TOTALINVESTMENT', 'Total Invested', '10000','D','0',true,true)
,('UOB', 110, 'RECURRINGINVESTMENT', 'Recurring Investment', '1000','D','0',true,true)
,('UOB', 120, 'RECURRINGTERM', null, 'YEARLY','T','0',false,true)
,('UOB', 130, 'RECURRINGPERIOD', 'Recurring Period', '10','I','0',true,true)
,('UOB', 140, 'KEEPLIQUID', null, '0','D','0',false,true)
,('UOB', 150, 'TAXABLE', null, 'FALSE','B','0',false,true)
,('UOB', 160, 'TAXRATE', null, '0','D','0',false,true)
,('UOB', 170, 'EXPERIENCE', null, '0','I','0',false,true)
,('UOB', 180, 'RETIREMENTAGE', null, '65','I','100',false,true)
,('UOB', 190, 'WITHDRAWLAGE', null, '95','I','100',false,true)

,('UOB', 500, 'AGEPOWERVALUE', null,'1.7','D','1.0',false,false)
,('UOB', 510, 'AGEWEIGHT', null,'1.0','D','1.0',false,false)
,('UOB', 530, 'MAXDURATION', null,'15.0','D','15.0',false,false)
,('UOB', 530, 'MAXSCORE', null,'100','I','100',false,false)
,('UOB', 540, 'WITHDRAWLRATE', null,'0.04','D','100',false,false)
,('UOB', 550, 'KNOCKOUT',null,'TRUE','B','0',false,false)
,('UOB', 600, 'MININTITIALRQMT',null,'10000','I','0',false,false)
,('UOB', 610, 'MIN2NDINTIALRQMT',null,'1000','I','0',false,false)
,('UOB', 650, 'MINRECCURRINGRQMT',null,'1000','I','0',false,false)
;

/* 200.pm.funct_get_actualCapital.sql080218_pmehta*/

DROP FUNCTION IF EXISTS `invdb`.`funct_get_actualCapital`;

DELIMITER $$
CREATE FUNCTION `invdb`.`funct_get_actualCapital`(
        p_acctnum       BIGINT(20)
) RETURNS double
    DETERMINISTIC
BEGIN
	DECLARE tdestCurrency VARCHAR(3);
	DECLARE tAmount DOUBLE;
	DECLARE tPosition DOUBLE;
	BEGIN
		IF (p_acctnum is NULL)
		   THEN RETURN 0.0;
		END IF;

		BEGIN
			SELECT SUM(IFNULL(nav.total,0) * IFNULL(nav.exchangeRate,1))
			INTO tAmount
			FROM ext_acct_info,
				 ext_nav nav
			WHERE ext_acct_info.acctnum = p_acctnum
			AND  ext_acct_info.clientAccountID = nav.clientAccountID
			AND  nav.reportDate = funct_get_switch('BROKER_BDATE')
			;

			/*
			IF (IFNULL(tAmount,0.0) > 0)
			THEN return tAmount;
			ELSE
					SELECT SUM(`profile`.`initialInvestment` * IFNULL(`profile`.`exchangeRate`,1))
					INTO tAmount
					FROM `user_trade_profile` `profile`
					WHERE `profile`.`acctnum` = p_acctnum
					;
                
					RETURN IFNULL(tAmount,0.0);
			END IF;
            */

			RETURN IFNULL(tAmount,0.0);
		END;
	END;
END$$
DELIMITER ;

/* 501.pm.sel_collectTradeProfile.sql080218_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`sel_collectTradeProfile`;


DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_collectTradeProfile`(
	p_logonid	BIGINT(20),
    p_advisor	VARCHAR(20),
	p_filter 	varchar(20)
)
BEGIN
	begin
    
     	DECLARE tAdvisor VARCHAR(25);
		DECLARE tfilterType   VARCHAR(1);
     
		DECLARE vAdvisor VARCHAR(25);
 
		select advisor 
        into vAdvisor  
        from user_logon where logonid=p_logonid;
		if (vAdvisor='DEMO') then
 			 set tAdvisor = IFNULL(p_advisor,'%');
		else
			SELECT 
			  advisor
			INTO tAdvisor 
			FROM user_advisor_access
			WHERE logonid = p_logonid;
     
     end if;

    
       SELECT 
			`trade_process_identifier`.`acctnum`,
            `ext_acct_info`.`clientAccountID`,
            `ext_acct_info`.`applicantFName`,
            `ext_acct_info`.`applicantLName`,
            `ext_acct_info`.`fullname`,
			`trade_process_identifier`.`tradeStatus`,
			`trade_process_identifier`.`processStatus`,
			`trade_process_identifier`.`reason`,
            SUM(`ext_nav`.`cash` * `ext_nav`.`exchangeRate`) as `cash`,
            SUM((`ext_nav`.`stock` * `ext_nav`.`exchangeRate`) + (`ext_nav`.`funds` * `ext_nav`.`exchangeRate`)) +
            SUM((`ext_nav`.`interestAccrual`* `ext_nav`.`exchangeRate`) + (`ext_nav`.`dividentAccrual`* `ext_nav`.`exchangeRate`)) as `investment`,
            `user_trade_profile`.`advisor`,
            IFNULL(`user_basket_access`.`displayname`,`user_trade_profile`.`theme`) as `theme`,
            `user_trade_profile`.`acctType`,
            SUM(`ext_nav`.`total` * `ext_nav`.`exchangeRate`)  as `totalInvestment`,
            `user_trade_profile`.`keepLiquid`,
            `user_trade_profile`.`longTermGoal`,
            `user_trade_profile`.`stayInvested`,
			`user_trade_profile`.`calcModel`,
            `user_trade_profile`.`riskIndex`,
            `user_trade_profile`.`assetIndex`,
            `user_trade_profile`.`portfolioIndex`,
            `user_trade_profile`.`age`,
            `user_trade_profile`.`horizon`,
			`user_trade_profile`.`taxable`
            , max(date_format(`user_trade_log`.`tradedate`,'%Y-%m-%d')) as `lastTraded`
		FROM `trade_process_identifier`
        INNER JOIN `user_trade_profile`
        ON (`user_trade_profile`.`acctnum` = `trade_process_identifier`.`acctnum`)
        INNER JOIN `ext_acct_info`
        ON (`ext_acct_info`.`acctnum` = `trade_process_identifier`.`acctnum`
			AND `ext_acct_info`.`status` in ('A'))
		INNER JOIN `ext_nav`
        ON (`ext_nav`.`clientAccountID` = `ext_acct_info`.`clientAccountID`
        AND `ext_nav`.`reportDate` = `FUNCT_GET_SWITCH`('BROKER_BDATE'))
        LEFT JOIN `user_trade_log`
        ON (`user_trade_log`.`acctnum` = `trade_process_identifier`.`acctnum`)
        LEFT JOIN `user_basket_access`
        ON (`user_trade_profile`.`theme` = `user_basket_access`.`theme`)
        WHERE IFNULL(`trade_process_identifier`.`processStatus`,'N') like p_filter
        AND   lower(IFNULL(`user_trade_profile`.`advisor`,'Invessence')) like lower(tAdvisor)
        GROUP BY
			`trade_process_identifier`.`acctnum`,
            `ext_acct_info`.`clientAccountID`,
            `ext_acct_info`.`applicantFName`,
            `ext_acct_info`.`applicantLName`,
            `ext_acct_info`.`fullname`,
			`trade_process_identifier`.`tradeStatus`,
			`trade_process_identifier`.`processStatus`,
			`trade_process_identifier`.`reason`,
            `user_trade_profile`.`advisor`,
            IFNULL(`user_basket_access`.`displayname`,`user_trade_profile`.`theme`),
            `user_trade_profile`.`acctType`,
            `user_trade_profile`.`keepLiquid`,
            `user_trade_profile`.`longTermGoal`,
            `user_trade_profile`.`stayInvested`,
			`user_trade_profile`.`calcModel`,
            `user_trade_profile`.`riskIndex`,
            `user_trade_profile`.`assetIndex`,
            `user_trade_profile`.`portfolioIndex`,
            `user_trade_profile`.`age`,
            `user_trade_profile`.`horizon`,
			`user_trade_profile`.`taxable`
    	;

    end;
END$$
DELIMITER ;

/* 502.pm.sel_TradeSummaryDetail.sql080218_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`sel_TradeSummaryDetail`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_TradeSummaryDetail`(
	p_logonid 	BIGINT(20),
    p_advisor	VARCHAR(20),
    p_filter	VARCHAR(1)
)
BEGIN
	begin
    
		DECLARE tAdvisor VARCHAR(25);
		DECLARE tfilterType   VARCHAR(1);
     
		DECLARE vAdvisor VARCHAR(25);
 
		select advisor 
        into vAdvisor  
        from user_logon where logonid=p_logonid;
		if (vAdvisor='DEMO') then
 			 set tAdvisor = IFNULL(p_advisor,'%');
		else
			SELECT 
			  advisor
			INTO tAdvisor 
			FROM user_advisor_access
			WHERE logonid = p_logonid;
     
     end if;
    
       SELECT 
			`user_trade_profile`.`advisor`,
			`user_trade_profile`.`rep`,
			`user_trade_profile`.`theme`,
			`trade_process_identifier`.`acctnum`,
            `ext_acct_info`.`clientAccountID`,
            `ext_acct_info`.`applicantFName`,
            `ext_acct_info`.`applicantLName`,
			`ext_acct_info`.`fullname`,
			`trade_process_identifier`.`tradeStatus`,
			`trade_process_identifier`.`processStatus`,
            `invdb`.`funct_get_actualCapital`(`trade_process_identifier`.`acctnum`) as `totalInvestment`,
			-- SUM(`rebal`.`curQty`) sumCurQty,
			-- SUM(`rebal`.`curValue`) as sumCurValue,
			SUM(`rebal`.`curQty`) sumholdingQty,
			SUM(`rebal`.`curValue`) as sumholdingValue,
			SUM(`rebal`.`newQty`) sumNewQty,
			SUM(`rebal`.`newValue`) as sumNewValue
		FROM `trade_process_identifier`
        INNER JOIN `user_trade_profile`
        ON (`user_trade_profile`.`acctnum` = `trade_process_identifier`.`acctnum`)
        INNER JOIN `ext_acct_info`
        ON (`ext_acct_info`.`acctnum` = `trade_process_identifier`.`acctnum`
			AND `ext_acct_info`.`status` in ('A'))
        LEFT JOIN `user_trade_log`
        ON (`user_trade_log`.`acctnum` = `trade_process_identifier`.`acctnum`)
        LEFT JOIN `user_trade_preprocess` as `rebal`
        ON (`rebal`.`acctnum` = `trade_process_identifier`.`acctnum`)
        WHERE IFNULL(`trade_process_identifier`.`processStatus`,'N') like p_filter
        AND   lower(IFNULL(`user_trade_profile`.`advisor`,'Invessence')) like tAdvisor
        GROUP BY
			`user_trade_profile`.`advisor`,
			`user_trade_profile`.`rep`,
			`user_trade_profile`.`theme`,
			`trade_process_identifier`.`acctnum`,
            `ext_acct_info`.`clientAccountID`,
            `ext_acct_info`.`applicantFName`,
            `ext_acct_info`.`applicantLName`,
            `ext_acct_info`.`fullname`,
			`trade_process_identifier`.`tradeStatus`,
			`trade_process_identifier`.`processStatus`
    	;

    end;
END$$
DELIMITER ;

/* 503.pm.sp_fund_account.sql080218_pmehta*/

DROP PROCEDURE IF EXISTS `testing`.`sp_fund_account`;

DELIMITER $$
CREATE PROCEDURE `testing`.`sp_fund_account`(
    IN p_acctnum BIGINT,
    IN p_amount  DOUBLE,
    IN p_currency VARCHAR(3)
  )
BEGIN
  
    DECLARE tbusinessdate		VARCHAR(8);
    DECLARE tClientAccountID	VARCHAR(10);
    DECLARE tCurrency	VARCHAR(3);
    DECLARE tSettleCurrency		VARCHAR(3);
    DECLARE tExchangeRate	Double;
    DECLARE tSettleAmt		DOUBLE;
    
    
    set tCurrency = IFNULL(p_currency, 'USD');
    
        IF (IFNULL(p_acctnum, 'XXX') != 'XXX')
        THEN
  
			set tbusinessdate = invdb.FUNCT_GET_SWITCH('BROKER_BDATE');
            
  			SELECT clientAccountID
              INTO tClientAccountID
              FROM invdb.ext_acct_info eai
              WHERE eai.acctnum = p_acctnum;

			SELECT settleCurrency
            INTO tSettleCurrency
            FROM invdb.user_trade_profile
            WHERE acctnum = p_acctnum
            ;
            
			set tExchangeRate = `invdb`.`get_exchange_rate`(tCurrency, tSettleCurrency,tbusinessdate);
            
            set tSettleAmt = (p_amount * IFNULL(tExchangeRate,1));
            
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
				VALUES ( 
					p_acctnum,
					tClientAccountID,
					'Cash',
					tbusinessdate,
					tcurrency,
					p_amount,
					null,
					tExchangeRate,
					tSettleCurrency,
					tSettleAmt,
					'A',
					now()
                )
                ;
                
  
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
  				, tSettleCurrency
  				, tExchangeRate
  				, 'Cash' as symbol
  				, tbusinessdate as reportDate
  				, tbusinessdate as purchaseDate
  				, 'Long' as side
  				, tSettleAmt as quantity
  				, 1 as costBasisPrice
  				, tSettleAmt as costBasisMoney
  				, 1 as markPrice
  				, tSettleAmt as positionValue
  				, 0 as pnlUnrealized
  				, 'Cash' as levelOfDetail
				, tcurrency as investmentCurrency
                , p_amount as settleQty
                , 1 as settlePrice
                , p_amount as settleMoney
				, 0 as settlePnL
  				, now() as created
  			FROM invdb.ext_acct_info as eai
  			WHERE eai.acctnum = p_acctnum
              ON duplicate key update
  				    quantity = quantity + tSettleAmt
                  , costBasisMoney = costBasisMoney + tSettleAmt
                  , positionValue = positionValue + tSettleAmt
                  , settleQty = settleQty + p_amount
                  , settleMoney = settleMoney + p_amount
                  , levelOfDetail = 'Funded'
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
  			VALUES
  			(tClientAccountID,
  			tbusinessdate,
            tcurrency,
            tExchangeRate,
            tSettleCurrency,
  			p_amount,
  			0,
  			0,
  			0,
  			0,
  			p_amount)
              ON duplicate key update
  				 cash = cash + p_amount
                  , total = total + p_amount
  			;
  
  			INSERT INTO invdb.trade_process_identifier
  			(acctnum,
  			tradeStatus,
  			processStatus,
  			reason,
  			created,
  			updated)
  			VALUES
  			(p_acctnum,
  			'N',
  			null,
  			'New',
  			now(),
  			null)
              ON duplicate key update
  				tradeStatus = CASE WHEN (tradeStatus = 'N') THEN 'N'
  									 ELSE 'A'
  								END,
                  reason = 'Funded',
                  updated = now()
  			;
  
      END IF;
    END$$
DELIMITER ;

/* 504.pm.sel_collectTradeCustomerProfile.sql080218_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`sel_collectTradeCustomerProfile`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_collectTradeCustomerProfile`(
	p_acctnum 	BIGINT(20)
)
BEGIN
	begin
        SELECT
			`user_access_role`.`logonid`,
			`trade_process_identifier`.`acctnum`,
            `user_trade_profile`.`clientAccountID`,
            `user_trade_profile`.`advisor`,
            `user_trade_profile`.`theme`,
            `user_trade_profile`.`acctType`,
			`user_trade_profile`.`age`,
            `user_trade_profile`.`horizon`,
            `invdb`.`funct_get_actualCapital`(`trade_process_identifier`.`acctnum`) as `investment`
		FROM `trade_process_identifier`
		INNER JOIN `user_trade_profile`
        ON (`user_trade_profile`.`acctnum` = `trade_process_identifier`.`acctnum`)
        INNER JOIN `user_access_role`
        ON (`trade_process_identifier`.`acctnum` = `user_access_role`.`acctnum`
        AND  `user_access_role`.`role` = 'OWNER')
		WHERE `trade_process_identifier`.`acctnum` = p_acctnum
     	;

    end;
END$$
DELIMITER ;

/* 505.pm.sel_position.sql080218_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`sel_position`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_position`(
  	IN p_logonid  bigint(20),
  	IN p_acctnum  bigint(20) ,
     IN p_advisor VARCHAR(20),
     IN p_rep VARCHAR(20)
 )
BEGIN
 
 	DECLARE tAdvisor VARCHAR(25);
     DECLARE tfilterType   VARCHAR(1);
     
     DECLARE tTotalPos	 DOUBLE;
 	DECLARE tRep VARCHAR(25);
     DECLARE vAdvisor VARCHAR(25);
 
     select advisor into vAdvisor  from user_logon where logonid=p_logonid;
     if(vAdvisor='DEMO') then
 			 set tAdvisor = IFNULL(p_advisor,'%');
              set tRep = IFNULL(p_rep,'%');
     else
 		SELECT 
 		  advisor,
 		  rep
 		INTO tAdvisor, tRep 
        FROM user_advisor_access
 		WHERE logonid = p_logonid;
     
     end if;
         
 	IF (tAdvisor is NOT NULL)
 		THEN set tfilterType = 'A';
 		ELSE set tfilterType = 'O';  
 	END IF;
 
 			select SUM(ext_position.positionValue)
             INTO tTotalPos
 			FROM ext_position
 			WHERE ext_position.acctnum = p_acctnum
 			AND   ext_position.reportDate = (select max(pos.reportDate) from ext_position pos
											 where pos.acctnum = p_acctnum)
 			;
             
             IF (tTotalPos = 0)
              THEN set tTotalPos = 1;
 			END IF;
 
 	IF (tfilterType = 'O')
 		THEN
 			select
 				 IFNULL(sec_asset_mapping.assetsortorder,9999) * 1000 +
                  IFNULL(sec_asset_mapping.subclasssortorder,9999) as sortorder
 				,ext_position.clientAccountID
 				,ext_position.symbol
 				,ext_position.reportDate
 				,ext_position.side
                 ,ext_position.tradeCurrency
 				,SUM(ext_position.quantity) as quantity
 				,AVG(ext_position.costBasisPrice) costBasisPrice
 				,SUM(ext_position.costBasisMoney) as costBasisMoney
 				,AVG(ext_position.markPrice) markPrice
 				,SUM(ext_position.positionValue) as positionValue
                 ,SUM(ext_position.pnlUnrealized) as fifoPnlUnrealized
                 ,SUM(ext_position.positionValue/tTotalPos) as weight
 				, ext_acct_info.acctnum
                 , IFNULL(ext_acct_info.applicantFName,user_trade_profile.firstname) as firstname
                 , IFNULL(ext_acct_info.applicantLName,user_trade_profile.lastname) as lastname
                 , CONCAT(IFNULL(ext_acct_info.applicantFName,user_trade_profile.firstname),' ',
                  		 IFNULL(ext_acct_info.applicantLName,user_trade_profile.lastname)
                          ) as fullname  
 				,ext_acct_info.rep
 				,ext_acct_info.dateOpened
 				,sec_master.name as description
 				,IFNULL(sec_asset_mapping.assetclass,sec_master.assetclass) as assetclass
 				,IFNULL(sec_asset_mapping.subclass,sec_master.subclass) as subclass
 				,IFNULL(sec_asset_mapping.assetName,sec_master.assetclass) as assetName
 				,IFNULL(sec_asset_mapping.subclassName,sec_master.subclass) as subclassName
                 ,IFNULL(sec_asset_mapping.assetcolor,'#ffffff') as color
                 ,user_trade_profile.theme
 				,user_trade_profile.portfolioName as accountAlias
				,MAX(ext_position.fxRateToBase) as exchangeRate
				,ext_position.settleCurrency
 				,SUM(ext_position.settleQty) as settleQty
 				,AVG(ext_position.settlePrice) settlePrice
 				,SUM(ext_position.settleQty * ext_position.settlePrice) as settleCostBasisMoney
 				,AVG(ext_position.settleMarkPrice) settlementMarkPrice
 				,SUM(ext_position.settleMoney) as settleMoney
                 ,SUM(ext_position.settlePnL) as settlePnL
 			FROM ext_position
 				 INNER JOIN ext_acct_info
 				 ON (ext_position.clientAccountID = ext_acct_info.clientAccountID)
 				 INNER JOIN user_trade_profile
 				 ON (ext_acct_info.acctnum = user_trade_profile.acctnum)
 				 INNER JOIN user_access_role
 				 ON (ext_acct_info.acctnum = user_access_role.acctnum
 				 AND  user_access_role.role in ('OWNER', 'USER'))
 				 INNER JOIN user_logon
 				 ON (user_access_role.logonid = user_logon.logonid)
 				 LEFT JOIN sec_master
 				 ON (ext_position.symbol= sec_master.ticker)
 				 LEFT JOIN sec_asset_mapping
 				 ON (sec_master.ticker= sec_asset_mapping.ticker
 				 AND sec_asset_mapping.theme = user_trade_profile.theme)
 			WHERE ext_acct_info.acctnum = p_acctnum
 			AND   user_logon.logonid    = p_logonid
 			AND   ext_position.reportDate = ( select max(pos.reportDate) from ext_position pos
											  where pos.acctnum = p_acctnum)
             GROUP BY
                  sec_asset_mapping.assetsortorder
                 ,sec_asset_mapping.subclasssortorder
 				,ext_position.clientAccountID
 				,ext_position.symbol
 				,ext_position.reportDate
 				,ext_position.side
 				, ext_acct_info.acctnum
                 ,ext_position.tradeCurrency
                 , IFNULL(ext_acct_info.applicantFName,user_trade_profile.firstname)
                 , IFNULL(ext_acct_info.applicantLName,user_trade_profile.lastname)
 				,ext_acct_info.rep
 				,ext_acct_info.dateOpened
 				,sec_master.name
 				,IFNULL(sec_asset_mapping.assetName,sec_master.assetclass)
 				,IFNULL(sec_asset_mapping.assetName,sec_master.assetclass)
 				,sec_master.subclass
                 ,IFNULL(sec_asset_mapping.assetcolor,'#ffffff')
                 ,user_trade_profile.theme
 				,user_trade_profile.portfolioName
                 ,ext_position.settleCurrency
  			ORDER BY 1, ext_position.symbol
 			;
         ELSE
 			select
 				 IFNULL(sec_asset_mapping.assetsortorder,9999) * 1000 +
                  IFNULL(sec_asset_mapping.subclasssortorder,9999) as sortorder
 				,ext_position.clientAccountID
 				,ext_position.symbol
 				,ext_position.reportDate
 				,ext_position.side
                 ,ext_position.tradeCurrency
 				,SUM(ext_position.quantity) as quantity
 				,AVG(ext_position.costBasisPrice) costBasisPrice
 				,SUM(ext_position.costBasisMoney) as costBasisMoney
 				,AVG(ext_position.markPrice) markPrice
 				,SUM(ext_position.positionValue) as positionValue
                 ,SUM(ext_position.pnlUnrealized) as fifoPnlUnrealized
                 ,SUM(ext_position.positionValue/tTotalPos) as weight
 				, ext_acct_info.acctnum
                 , IFNULL(ext_acct_info.applicantFName,user_trade_profile.firstname) as firstname
                 , IFNULL(ext_acct_info.applicantLName,user_trade_profile.lastname) as lastname
                 , CONCAT(IFNULL(ext_acct_info.applicantFName,user_trade_profile.firstname),' ',
                  		 IFNULL(ext_acct_info.applicantLName,user_trade_profile.lastname)
                          ) as fullname  
 				,ext_acct_info.rep
 				,ext_acct_info.dateOpened
 				,sec_master.name as description
 				,IFNULL(sec_asset_mapping.assetclass,sec_master.assetclass) as assetclass
 				,IFNULL(sec_asset_mapping.subclass,sec_master.subclass) as subclass
 				,IFNULL(sec_asset_mapping.assetName,sec_master.assetclass) as assetName
 				,IFNULL(sec_asset_mapping.subclassName,sec_master.subclass) as subclassName
                 ,IFNULL(sec_asset_mapping.assetcolor,'#ffffff') as color
                 ,user_trade_profile.theme
 				,user_trade_profile.portfolioName as accountAlias
				,MAX(ext_position.fxRateToBase) as exchangeRate
                 ,ext_position.settleCurrency
 				,SUM(ext_position.settleQty) as settleQty
 				,AVG(ext_position.settlePrice) settlePrice
 				,SUM(ext_position.settleQty * ext_position.settlePrice) as settleCostBasisMoney
 				,AVG(ext_position.settleMarkPrice) settlementMarkPrice
 				,SUM(ext_position.settleMoney) as settleMoney
                 ,SUM(ext_position.settlePnL) as settlePnL
 		FROM ext_position
 				 INNER JOIN ext_acct_info
 				 ON (ext_position.clientAccountID = ext_acct_info.clientAccountID)
 				 INNER JOIN user_trade_profile
 				 ON (ext_acct_info.acctnum = user_trade_profile.acctnum)				 
 				 LEFT JOIN sec_master
 				 ON (ext_position.symbol= sec_master.ticker)
 				 LEFT JOIN sec_asset_mapping
 				 ON (sec_master.ticker= sec_asset_mapping.ticker
 				 AND sec_asset_mapping.theme = user_trade_profile.theme)
 			WHERE ext_acct_info.acctnum = p_acctnum
 			AND   IFNULL(user_trade_profile.advisor,'Invessence') like tAdvisor
             AND   IFNULL(user_trade_profile.rep, 'CATCALL') LIKE tRep
 			AND   ext_position.reportDate = ( select max(pos.reportDate) from ext_position pos
											  where pos.acctnum = p_acctnum)
             GROUP BY
                  sec_asset_mapping.assetsortorder
                 ,sec_asset_mapping.subclasssortorder
 				,ext_position.clientAccountID
 				,ext_position.symbol
 				,ext_position.reportDate
 				,ext_position.side
 				, ext_acct_info.acctnum
                 ,ext_position.tradeCurrency
                 , IFNULL(ext_acct_info.applicantFName,user_trade_profile.firstname)
                 , IFNULL(ext_acct_info.applicantLName,user_trade_profile.lastname)
 				,ext_acct_info.rep
 				,ext_acct_info.dateOpened
 				,sec_master.name
 				,IFNULL(sec_asset_mapping.assetName,sec_master.assetclass)
 				,IFNULL(sec_asset_mapping.assetName,sec_master.assetclass)
 				,sec_master.subclass
                 ,IFNULL(sec_asset_mapping.assetcolor,'#ffffff')
                 ,user_trade_profile.theme
 				,user_trade_profile.portfolioName
                 ,ext_position.settleCurrency
                 ,sec_asset_mapping.assetsortorder
                 ,sec_asset_mapping.subclasssortorder
 			ORDER BY 1, ext_position.symbol
 			;
 	END IF;
 
 
 
 END$$
DELIMITER ;

