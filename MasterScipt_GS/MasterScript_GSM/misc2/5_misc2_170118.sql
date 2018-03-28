/* 0.pmfix_db_info.sql170118_pmehta*/

UPDATE `invdb`.`web_site_info` SET `value`='8.UOB' WHERE `url`='uwealth' and`name`='DEFAULT.MODEL';
UPDATE `invdb`.`web_site_info` SET `value`='UOB' WHERE `url`='uwealth' and`name`='DEFAULT.ADVISOR';
UPDATE `invdb`.`web_site_info` SET `value`='5000' WHERE `url`='uwealth' and`name`='INVESTMENT.MIN1ST';
UPDATE `invdb`.`web_site_info` SET `value`='5000' WHERE `url`='uwealth' and`name`='INVESTMENT.MIN2ND';
UPDATE `invdb`.`web_site_info` SET `value`='500' WHERE `url`='uwealth' and`name`='INVESTMENT.RECURRING1ST';
UPDATE `invdb`.`web_site_info` SET `value`='500' WHERE `url`='uwealth' and`name`='INVESTMENT.RECURRING2ND';


INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `cusip`, `isin`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `inception`, `issuer`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('601', 'A', 'A', '1306.T', 'NULL', 'NULL', '1306.T', 'TOPIX EXCHANGE TRADED', 'Equity', 'Japan Equities', 'NULL', 'NULL', '0', 'NULL', 'NULL', '0', 'NULL', 'TSE', 'JPY');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `cusip`, `isin`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `inception`, `issuer`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('611', 'A', 'A', 'IEMB.L', 'NULL', 'NULL', 'IEMB.L', 'iShares J P Morgan $EM Bond ETF', 'Fixed Income', 'Emerging Market Bonds', 'NULL', 'NULL', '0', 'NULL', 'NULL', '0', 'NULL', 'LSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `cusip`, `isin`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `inception`, `issuer`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('612', 'A', 'A', 'IEML.L', 'NULL', 'NULL', 'IEML.L', 'iShares J P Morgan $EM Local Bond ETF', 'Fixed Income', 'Emerging Market Local Bonds', 'NULL', 'NULL', '0', 'NULL', 'NULL', '0', 'NULL', 'LSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `cusip`, `isin`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `inception`, `issuer`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('610', 'A', 'A', 'LQDE.L', 'NULL', 'NULL', 'LQDE.L', 'iShares $ Corp Bond UCITS ETF USD (Dist)', 'Fixed Income', 'Corporate Bonds', 'NULL', 'NULL', '0', 'NULL', 'NULL', '0', 'NULL', 'LSE', 'USD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `cusip`, `isin`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `inception`, `issuer`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('603', 'A', 'A', 'VAS.AX', 'NULL', 'NULL', 'VAS.AX', 'iShares Core MSCI Emerging Markets IMI', 'Equity', 'Emerging Mkt. Equities', 'NULL', 'NULL', '0', 'NULL', 'NULL', '0', 'NULL', 'ASX', 'AUD');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `cusip`, `isin`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `inception`, `issuer`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('600', 'A', 'A', 'VEUR.L', 'NULL', 'NULL', 'VEUR.L', 'VANGUARD FTSE DEV EU UCITS ETF', 'Equity', 'Europe Equities', 'NULL', 'NULL', '0', 'NULL', 'NULL', '0', 'NULL', 'LSE', 'GBP');
INSERT INTO `invdb`.`sec_master` (`instrumentid`, `status`, `securityStatus`, `ticker`, `cusip`, `isin`, `ric`, `name`, `assetclass`, `subclass`, `type`, `style`, `expenseRatio`, `inception`, `issuer`, `securityRiskSTD`, `rbsaFlag`, `exchange`, `base_currency`) VALUES ('602', 'A', 'A', 'XIC.TO', 'NULL', 'NULL', 'XIC.TO', 'iShares Core SP TSX CA', 'Equity', 'Australian Equities', 'NULL', 'NULL', '0', 'NULL', 'NULL', '0', 'NULL', 'TSE', 'CAD');

/* 1.pm.fix_basket_info.sql170118_pmehta*/

DELETE FROM `invdb`.`user_basket_access` WHERE `advisor`='UOB' and`theme`='0.SGWealthSGD' and`primary`='Y';
DELETE FROM `invdb`.`user_basket_access` WHERE `advisor`='UOB' and`theme`='0.SGWealthSGD.Un' and`primary`='Y';
UPDATE `invdb`.`user_basket_access` SET `sortorder`='0' WHERE `advisor`='UOB' and`theme`='8.UOB' and`primary`='Y';
UPDATE `invdb`.`user_basket_access` SET `sortorder`='1' WHERE `advisor`='UOB' and`theme`='T.8.UOB' and`primary`='Y';
UPDATE `invdb`.`user_basket_access` SET `sortorder`='2' WHERE `advisor`='UOB' and`theme`='8.UOB.Sing' and`primary`='Y';
UPDATE `invdb`.`user_basket_access` SET `sortorder`='3' WHERE `advisor`='UOB' and`theme`='T.8.UOB.Sing' and`primary`='Y';
UPDATE `invdb`.`user_basket_access` SET `sortorder`='0' WHERE `advisor`='BB' and`theme`='0.BB' and`primary`='Y';
UPDATE `invdb`.`user_basket_access` SET `sortorder`='1' WHERE `advisor`='BB' and`theme`='T.0.BB' and`primary`='Y';
UPDATE `invdb`.`user_basket_access` SET `sortorder`='0' WHERE `advisor`='BB-TCM' and`theme`='0.TA' and`primary`='Y';
UPDATE `invdb`.`user_basket_access` SET `sortorder`='1' WHERE `advisor`='BB-TCM' and`theme`='T.0.TA' and`primary`='Y';

/* funct_get_actualCapital.sql170118_pmehta*/

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
			SELECT SUM(nav.total)
			INTO tAmount
			FROM ext_acct_info,
				 ext_nav_daily nav
			WHERE ext_acct_info.acctnum = p_acctnum
			AND  ext_acct_info.clientAccountID = nav.clientAccountID
			AND  nav.reportDate = funct_get_switch('BROKER_BDATE')
			;

			IF (IFNULL(tAmount,0.0) > 0)
			THEN return tAmount;
			ELSE
					SELECT SUM(pos.positionValue)
					INTO tPosition
					FROM ext_position pos
					WHERE pos.acctnum = p_acctnum
					AND  pos.reportDate = funct_get_switch('BROKER_BDATE')
					AND  pos.symbol in (SELECT ticker from sec_master where sec_master.`status` = 'A')
					;
                
					RETURN IFNULL(tPosition,0.0);
			END IF;

		END;
		RETURN 0.0;
	END;
END$$
DELIMITER ;

/* save_user_trade_profile.sql170118_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`save_user_trade_profile`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`save_user_trade_profile`(
   	IN	p_logonid	bigint(20),
   	INOUT	p_acctnum	bigint(20),
   	IN  p_portfolioName VARCHAR(60),
       IN  p_advisor    VARCHAR(20),
       IN  p_rep	     VARCHAR(20),
       IN  p_firstname    VARCHAR(40),
       IN  p_lastname    VARCHAR(40),
       IN  p_theme		 VARCHAR(30),
       IN  p_goal       varchar(30),
   	IN	p_acctType	varchar(30),
   	IN	p_taxable	varchar(1),
   	IN	p_age		integer,
   	IN	p_horizon	integer,
   	IN	p_initialInvestment	integer,
   	IN	p_recurringInvestment	integer,
   	IN	p_experience	tinyint,
   	IN	p_objective		tinyint,
   	IN	p_investmentplan	tinyint,
   	IN	p_charitablegoals	integer,
   	IN  p_keepLiquid 	integer,
   	IN  p_riskIndex 	  integer,
   	IN  p_riskCalcMethod  VARCHAR(1),
   	IN  p_allocIndex 	  integer,
   	IN  p_portfolioIndex  integer,
      IN  p_goalDesired 	  double,
  	IN p_customName varchar(60),
     IN p_tradeCurrency varchar(20),
     IN p_settleCurrency varchar(20),
     IN p_exchangeRate DOUBLE
   )
BEGIN 
   
   	DECLARE t_found INTEGER;
       DECLARE t_status VARCHAR(1);
   
   	BEGIN
   		IF (IFNULL(p_acctnum,0) > 0)
   			THEN
   				SELECT COUNT(*)
   				INTO t_found
   				FROM user_trade_profile
   				WHERE acctnum = p_acctnum;
   			ELSE 
   				set t_found = 0;
   		END IF;
   	END;
   
      BEGIN
   	   IF (IFNULL(t_found,0) = 0) THEN
   		   BEGIN
              
               set t_status = 
                   CASE 
   					WHEN (p_logonid is null) THEN 'V'
                       WHEN (p_logonid <= 0) THEN 'V'
                       ELSE 'N'
   				END;
   
   			INSERT INTO user_trade_profile (
   				portfolioName,
   			    advisor,
                   rep,
                   firstname,
                   lastname,
   				theme,
   				goal,
   				acctType,
   				age,
   				horizon,
   				initialInvestment,
   				recurringInvestment,
   				keepLiquid,
   				experience,
    				longTermGoal,
   				stayInvested,
   				charitablegoals,
   				riskIndex,
   				taxable,
   				assetIndex,
   				portfolioIndex,
                   goalAmount,
                   managed,
                   status,
   				created,
  				customName,tradeCurrency,settleCurrency,exchangeRate
   			)
   			VALUES (
   				IFNULL(p_portfolioName,IFNULL(p_goal,'Retirement')),
   				IFNULL(p_advisor,'Invessence'),
                   p_rep,
                   p_firstname,
                   p_lastname,
   				p_theme,  
   				IFNULL(p_goal,'Retirement')	,
   				p_acctType,
   				IFNULL(p_age,30)	,
   				IFNULL(p_horizon,35)	,
   				IFNULL(p_initialInvestment,1000000)	,
   				p_recurringInvestment	,
   				IFNULL(p_keepLiquid,0),
   				p_experience	,
   				p_objective	,
   				p_investmentplan	,
   				p_charitablegoals,
   				IFNULL(p_riskIndex,10),
   				IFNULL(p_taxable,'N'),
   				p_allocIndex,
   				p_portfolioIndex,
                   p_goalDesired,
                   'N',
                   t_status,
   				now(),p_customName,p_tradeCurrency,p_settleCurrency,p_exchangeRate
   			);
   
   			select last_insert_id() into p_acctnum;
               
   			call invdb.sp_user_profile_manage (p_acctnum, t_status,p_logonid);
   
   		   END;
   	   ELSE
   		   BEGIN
                           
   			 UPDATE  user_trade_profile
   			 SET
   				portfolioName = IFNULL(p_portfolioName,portfolioName),
   				advisor = IFNULL(p_advisor,advisor),
                   rep     = p_rep,
                   firstname = IFNULL(p_firstname,firstname),
                   lastname = IFNULL(p_lastname,lastname),
   				theme = IFNULL(p_theme,theme),
   				goal	 =	IFNULL(p_goal,goal)	,
   				acctType	 =	IFNULL(p_acctType,acctType)	,
   				age	 =	IFNULL(p_age,age)	,
   				horizon	 =	IFNULL(p_horizon,horizon)	,
   				initialInvestment	 =	IFNULL(p_initialInvestment,initialInvestment)	,
   				recurringInvestment	 =	p_recurringInvestment	,
   				experience	 =	p_experience	,
   				longTermGoal	 =	p_objective	,
   				stayInvested	 =	p_investmentplan	,
   				charitablegoals	 =	p_charitablegoals	,
   				riskIndex      =  IFNULL(p_riskIndex,riskIndex),
   				keepLiquid	 =  IFNULL(p_keepLiquid,keepLiquid),
   				taxable        =  IFNULL(p_taxable,taxable),
   				assetIndex	 =  p_allocIndex,
   				portfolioIndex =  p_portfolioIndex,
   				goalAmount	 =  p_goalDesired,
   				lastupdated    = now(),
                   customName=p_customName,tradeCurrency=p_tradeCurrency,settleCurrency=p_settleCurrency,exchangeRate=p_exchangeRate
   			 WHERE
   				acctnum = p_acctnum;
   		   END;
   	   END IF;
   	END;
   
   	IF (p_acctnum is null)
   		then set p_acctnum = 0;
   	else
   		if (IFNULL(p_logonid,0) > 0)
           then
   			call sp_login_access_add_mod( p_logonid, p_acctnum, 'OWNER', 'W');
           end if;
   	end if;
       
   
   END$$
DELIMITER ;

/* save_virtual_portfolio.sql170118_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`save_virtual_portfolio`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`save_virtual_portfolio`(
      IN p_addmodflag      VARCHAR(1),
  	IN p_acctnum bigint(20),
  	IN p_itemnum int(10) unsigned,
  	IN p_ticker varchar(20),
  	IN p_active varchar(1),
      IN p_tradeCurrency varchar(3),
  	IN p_qty double,
  	IN p_weight double,
  	IN p_tradeprice double,
  	IN p_investmentvalue double,
      IN p_settleCurrency varchar(3),
      IN p_exchangeRate double,
      IN p_settleQty double,
      IN p_settlePrice double,
      IN p_settleValue double
  )
BEGIN 
  
      INSERT INTO virtual_portfolio
           (
  		acctnum,
  		itemnum,
  		ticker,
  		active,
          tradeCurrency,
  		qty,
  		weight,
  		tradeprice,
  		investmentvalue,
          settleCurrency,
          exchangeRate,
          settleQty,
          settlePrice,
          settleValue,
  		created,
  		lastupdated
           )
      VALUES 
           ( 
  		p_acctnum,
  		p_itemnum,
  		p_ticker,
  		p_active,
          ifnull(p_tradeCurrency,'USD'),
  		p_qty,
  		p_weight,
  		p_tradeprice,
  		p_investmentvalue,
          ifnull(p_settleCurrency,'USD'),
          ifnull(p_exchangeRate,1.0),
          p_settleQty,
          p_settlePrice,
          p_settleValue,
  		now(),
  		NULL
           )
  	ON DUPLICATE key update
  		itemnum = p_itemnum,
  		active = p_active,
          tradeCurrency = ifnull(p_tradeCurrency,'USD'),
  		qty = p_qty,
  		weight = p_weight,
  		tradeprice = p_tradeprice,
  		investmentvalue = p_investmentvalue,
          settleCurrency = p_settleCurrency,
          exchangeRate = p_exchangeRate,
          settleQty = p_settleQty,
          settlePrice = p_settlePrice,
          settleValue = p_settleValue,
  		lastupdated = now()
          ;
  END$$
DELIMITER ;


/* sel_NewAccountProfile.save_user_trade_profile.sql170118_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`sel_NewAccountProfile`;


DELIMITER $$
CREATE PROCEDURE `sel_NewAccountProfile`(
	IN p_advisor VARCHAR(20),
    IN p_rep	 VARCHAR(20),
    In p_logonid BIGINT(20)
)
BEGIN

	IF (p_logonid is not null)
    THEN
			select 
				IFNULL(`user`.`advisor`,'Invessence') `advisor`,
				`user`.`rep` `rep`,
                IFNULL(`basket`.`displayName`,`user`.`advisor`)  `displayname`,
                IFNULL(`basket`.`theme`,'0.Core') `theme`
			from
				`user_logon` `user`
                LEFT JOIN `user_basket_access` `basket`
                ON (IFNULL(`p_advisor`, `user`.advisor ) = `basket`.advisor
					AND `basket`.`sortorder` = 0
					AND `basket`.`primary` = 'Y')
			where
				`user`.logonid = p_logonid
			;
	ELSE
		IF (p_advisor is not null)
        THEN 
			IF (p_rep is null) 
			THEN
					select 
					`advisor`.`advisor` `advisor`,
					`advisor`.`rep` `rep`,
					IFNULL(`basket`.`displayName`,`advisor`.`displayname`) `displayname`,
					IFNULL(`basket`.`theme`,'0.Core') `theme`
					from
						`user_advisor_info` `advisor`
						LEFT JOIN `user_basket_access` `basket`
						ON (`advisor`.advisor = `basket`.advisor
							AND `basket`.`sortorder` = 0
							AND `basket`.`primary` = 'Y')
					where
						`advisor`.advisor = p_advisor
						LIMIT 1;
			ELSE
				select 
				`advisor`.`advisor` `advisor`,
				`advisor`.`rep` `rep`,
                IFNULL(`basket`.`displayName`,`advisor`.`displayname`) `displayname`,
                IFNULL(`basket`.`theme`,'0.Core') `theme`
				from
					`user_advisor_info` `advisor`
					LEFT JOIN `user_basket_access` `basket`
					ON (`advisor`.advisor = `basket`.advisor
						AND `basket`.`sortorder` = 0
						AND `basket`.`primary` = 'Y')
				where
					`advisor`.advisor = p_advisor
				and `advisor`.rep     = p_rep;
			END IF;
		ELSE
				select 
					FUNCT_GET_SWITCH('DefaultAdvisor') `advisor`,
					FUNCT_GET_SWITCH('DefaultRep') `rep`,
					FUNCT_GET_SWITCH('Company') `displayname`,
					'0.Core' `theme`
				;
		END IF;
   END IF;
	
END$$
DELIMITER ;

/* sel_exchange_rate.sql170118_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`sel_exchange_rate`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_exchange_rate`
(in p_from_currency varchar(20),in p_to_currency varchar(20))
begin
    declare p_frstcd,p_scndcd,p_fromCurrency,p_toCurrency,baseCrncy,p_symbol varchar(10);
    declare p_exchngavailable int;
    declare p_multiplying_factor double;
    declare p_businessdate,exhangeStatus varchar(20);
    declare retExchangeRate double;
  
    set p_exchngavailable=0;
    set p_symbol=concat(p_from_currency,p_to_currency);   
    set exhangeStatus='Failed';
    
    select isw.value into p_businessdate from invdb.invessence_switch isw where isw.name='BUSINESS_DATE';  
    select count(*) into p_exchngavailable from invdb.sec_exchangerate_master where symbol=p_symbol;
    -- select p_businessdate,p_exchngavailable;
    
  
    if(p_exchngavailable>0) then
             select sed.exchangeRate into retExchangeRate from rbsa.sec_exchangerate_data sed where sed.symbol=p_symbol and sed.exchangeDate=DATE_FORMAT(p_businessdate, '%Y-%m-%d');
             set exhangeStatus='Success';
        else
  
    	set p_exchngavailable=0;
        SELECT SUBSTRING(p_symbol,1,3) into p_frstcd;
        SELECT SUBSTRING(p_symbol,4,6) into p_scndcd;
        set p_symbol=concat(p_scndcd,p_frstcd);
    	select count(*) into p_exchngavailable from invdb.sec_exchangerate_master where symbol=p_symbol;
  
    		if(p_exchngavailable>0) then
               select sed.reverseExchangeRate into retExchangeRate from rbsa.sec_exchangerate_data sed where sed.symbol=p_symbol and sed.exchangeDate=DATE_FORMAT(p_businessdate, '%Y-%m-%d');
               set exhangeStatus='Success';
    		end if;
    end if;
    select exhangeStatus,retExchangeRate;
  
    end$$
DELIMITER ;

