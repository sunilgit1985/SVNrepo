
/* 500.pm.sel_daily_prime_historical_returns.sql170118_pmehta*/

DROP PROCEDURE IF EXISTS `rbsa`.`sel_daily_prime_historical_returns`;
DROP PROCEDURE IF EXISTS `invdb`.`sel_daily_prime_historical_returns`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_daily_prime_historical_returns`(
)
BEGIN

	DROP TEMPORARY TABLE IF EXISTS tmp_historical_dates;
	CREATE TEMPORARY TABLE tmp_historical_dates
	(
		ticker VARCHAR(20),
        tradeCurrency VARCHAR(3),
	    min_businessdate VARCHAR(10),
	    max_businessdate VARCHAR(10)
	);

	DROP TEMPORARY TABLE IF EXISTS tmp_ticker_list;
	CREATE TEMPORARY TABLE tmp_ticker_list
	(
		ticker VARCHAR(20),
        tradeCurrency VARCHAR(3)
	);

	INSERT INTO tmp_ticker_list
	SELECT DISTINCT 
			sec_assetclass_group.ticker,
            user_basket_access.tradeCurrency
	FROM invdb.sec_assetclass_group,
		 invdb.user_basket_access
	WHERE user_basket_access.theme = sec_assetclass_group.theme
    AND   user_basket_access.`status` in ('A')
    AND   sec_assetclass_group.`status` in ('A');
 
	INSERT INTO tmp_ticker_list
	SELECT DISTINCT 
		   sec_prime_asset_group.ticker,
           user_basket_access.tradeCurrency
	FROM invdb.sec_prime_asset_group,
		 invdb.user_basket_access
	WHERE user_basket_access.theme = sec_prime_asset_group.theme
    AND   user_basket_access.`status` in ('A')
    AND   sec_prime_asset_group.`status` in ('A')
	AND   sec_prime_asset_group.ticker not in (select ticker FROM invdb.sec_assetclass_group);

	DELETE FROM tmp_ticker_list
	WHERE upper(ticker) = 'CASH';

	INSERT INTO tmp_historical_dates
	SELECT `daily`.`ticker`,
		   `tmp_ticker_list`.`tradeCurrency` as `tradeCurrency`,
		   min(businessdate) as min_businessdate, 
		   max(businessdate) as max_businessdate
	FROM `rbsa`.`rbsa_daily` daily,
		 tmp_ticker_list
	WHERE daily.ticker = tmp_ticker_list.ticker
    AND   daily.dest_currency = tmp_ticker_list.tradeCurrency
	group by daily.ticker, daily.dest_currency;

	SELECT  `daily`.`ticker`,
		   `tmp_ticker_list`.`tradeCurrency` as `tradeCurrency`, 
            count(*) as maxrows
	FROM 
		 tmp_ticker_list,
		 `rbsa`.`rbsa_daily` daily,
		 (SELECT max(min_businessdate) as min_date, min(max_businessdate) as max_date from tmp_historical_dates) as tmp
	WHERE businessdate >= tmp.min_date
	AND   businessdate <= tmp.max_date
	AND   daily.ticker = tmp_ticker_list.ticker
    AND   daily.dest_currency = tmp_ticker_list.tradeCurrency
	AND   businessdate in (select businessdate from invdb.inv_date_table)
	GROUP BY daily.ticker, daily.dest_currency; 
	
	SELECT daily.ticker,
		   tmp_ticker_list.tradeCurrency,
           daily.base_currency as settleCurrency,
		   businessdate,
		   IFNULL(daily_return,0) as daily_return
	FROM 
		 tmp_ticker_list,
		 `rbsa`.`rbsa_daily` daily,
		 (SELECT max(min_businessdate) as min_date, min(max_businessdate) as max_date from tmp_historical_dates) as tmp
	WHERE businessdate >= tmp.min_date
	AND   businessdate <= tmp.max_date
	AND   daily.ticker = tmp_ticker_list.ticker
    AND   daily.dest_currency = tmp_ticker_list.tradeCurrency
	AND   businessdate in (select businessdate from invdb.inv_date_table)
	ORDER BY 1, 2, 3, 4 desc;
	

END$$
DELIMITER ;

/* 0.pm.alter_ext_acct_info.sql220118_pmehta*/

ALTER TABLE `invdb`.`ext_acct_info` 
CHANGE COLUMN `dob` `dob` VARCHAR(15) NULL DEFAULT NULL AFTER `faxNbr`,
CHANGE COLUMN `ssn` `identification` VARCHAR(60) NULL DEFAULT NULL ,
CHANGE COLUMN `acctType` `idType` VARCHAR(15) NULL DEFAULT NULL ,
CHANGE COLUMN `taxable` `taxable` VARCHAR(1) NULL DEFAULT NULL ,
CHANGE COLUMN `objective` `objective` VARCHAR(20) NULL DEFAULT NULL ,
ADD COLUMN `fullname` VARCHAR(60) NULL AFTER `applicantLName`;

/* 552_sp_invdb_sp_eod_notification.sql230118_sagar*/

USE `invdb`;
DROP procedure IF EXISTS `sp_eod_notification`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sp_eod_notification`(
)
BEGIN

  DECLARE tacctnum, tfirstname, tlastname varchar(60);
  DECLARE tWhichOne VARCHAR(1);
  DECLARE updt_done Boolean DEFAULT FALSE;
  DECLARE tFound INTEGER;
  DECLARE today  DATETIME;

  DECLARE cur1 CURSOR FOR 
	SELECT DISTINCT
			'O' as whichone
		  , `ext_acct_info`.`acctnum`
		  , upper(`ext_acct_info`.`applicantFName`) as firstname
		  , upper(`ext_acct_info`.`applicantLName`) as lastname
  FROM  `invdb`.`ext_acct_info`
  WHERE `ext_acct_info`.`status` = 'O'
  AND   `ext_acct_info`.`created` > DATE_FORMAT(now(),'%Y-%m-%d')
  UNION
	SELECT DISTINCT
			'F' as whichone
		  , `ext_acct_info`.`acctnum`
		  , upper(`ext_acct_info`.`applicantFName`) as firstname
		  , upper(`ext_acct_info`.`applicantLName`) as lastname
  FROM  `invdb`.`ext_acct_info`
  WHERE `ext_acct_info`.`status` = 'O'
  AND   `ext_acct_info`.`created` > DATE_FORMAT(now(),'%Y-%m-%d')
  AND   `ext_acct_info`.`clientAccountID` in (select `ext_nav`.`clientAccountID` from  `invdb`.`ext_nav`)
  ;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET updt_done = TRUE;
  
  BEGIN
       OPEN cur1;
	   the_loop: LOOP
 
	   FETCH cur1 INTO tWhichOne, tacctnum, tfirstname, tlastname;
	
      IF updt_done THEN
        LEAVE the_loop;
      END IF;
      
      IF (tWhichOne = 'O')
      THEN
		CALL `invdb`.`sp_user_profile_manage`(tacctnum, 'O');
      END IF;
      
      IF (tWhichOne = 'F')
      THEN
		CALL `invdb`.`sp_user_profile_manage`(tacctnum, 'F');
      END IF;

	END LOOP the_loop;
    CLOSE cur1;

  END;
END$$

DELIMITER ;


/* 553_sp_invdb_sp_upload_trade_process_indetifier.sql230118_sagar*/

USE `invdb`;
DROP procedure IF EXISTS `sp_upload_trade_process_indetifier`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sp_upload_trade_process_indetifier`(
)
BEGIN

	
	DELETE FROM `invdb`.`trade_process_indetifier`
    WHERE tradeStatus not in ('N');
    
    INSERT INTO `invdb`.`trade_process_identifier`
	(`acctnum`,`tradeStatus`,`processStatus`,`reason`,`created`)
	SELECT DISTINCT
			`ext_acct_info`.`acctnum`
		  , 'N' `tradeStatus`
		  , 'N' `processStatus`
          , 'Funded' `reason`
          , now()
    FROM  `invdb`.`ext_acct_info`
    WHERE `ext_acct_info`.`status` = 'O'
    AND   DATE_FORMAT(`ext_acct_info`.`created`,'%Y%m%d') > `invdb`.`FUNCT_GET_SWITCH`('BROKER_BDATE')
    AND   `ext_acct_info`.`clientAccountID` in (select `ext_nav`.`clientAccountID` from  `invdb`.`ext_nav`)
    AND   `ext_acct_info`.`acctnum` not in (select `trade_process_identifier`.`acctnum` FROM `trade_process_identifier`)
    ;
  
  
END$$

DELIMITER ;


/* 554_sp_testing_cleandb_of_testing_data.sql230118_sagar*/

USE `testing`;
DROP procedure IF EXISTS `cleandb_of_testing_data`;

DELIMITER $$
USE `testing`$$
CREATE  PROCEDURE `cleandb_of_testing_data`(
    p_action	VARCHAR(3),
	p_acctum	BIGINT
)
BEGIN

	SET SQL_SAFE_UPDATES = 0;

	DROP TEMPORARY TABLE IF EXISTS cleanacct;
	CREATE TEMPORARY TABLE cleanacct(
		acctnum	BIGINT(20)
	);
    
    IF (p_acctum is null)
    THEN
		IF (IFNULL(p_action,'XXX') = 'ALL')
        THEN
			INSERT INTO cleanacct
			SELECT acctnum from `testing`.`cleanup_acct`;
		ELSE 
			INSERT INTO cleanacct
			SELECT acctnum from invdb.user_access_role
			WHERE logonid < 100
			AND acctnum not in (SELECT acctnum from invdb.ext_acct_info where clientAccountID not like 'TST%')
			and acctnum > 1000
			;
			
			INSERT INTO cleanacct
			select user_access_role.acctnum 
			from invdb.user_logon, invdb.user_access_role
			where user_logon.logonid = user_access_role.logonid
			and user_logon.email like '%@invessence.com'
			and user_logon.logonid > 100
			and user_logon.logonstatus not in ('A', 'L');

		END IF;
			
        
    ELSE
		INSERT INTO cleanacct
		VALUES
		(p_acctnum)
		;
    END IF;
    
    
    DELETE FROM invdb.`acct_ben`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`acct_financial`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`acct_info`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`acct_risk_data`
    where acctnum in (select distinct acctnum from cleanacct);
    
   DELETE FROM invdb.`acct_trade_preference`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`actual_portfolio`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`advisor_notification`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`asset_alloc`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`clients_to_trade`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`dc_acct_owners_details_history`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`dc_acct_transfer_details`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`dc_benefiaciary_details`
    where acctnum in (select distinct acctnum from cleanacct);

    -- DELETE FROM invdb.`dc_decedent_information`
    -- where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_dup_doc_req_party`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_employment_details`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_ach_bank_details`
    where moveMoneyPayMethodID in (select distinct moveMoneyPayMethodID from cleanacct, invdb.dc_elecfund_transfer_details where cleanacct.acctnum = dc_elecfund_transfer_details.acctnum);

    DELETE FROM invdb.`dc_fedwire_acct_details`
    where moveMoneyPayMethodID in (select distinct moveMoneyPayMethodID from cleanacct, invdb.dc_elecfund_transfer_details where cleanacct.acctnum = dc_elecfund_transfer_details.acctnum);

    DELETE FROM invdb.`dc_internal_transfer_details`
    where moveMoneyPayMethodID in (select distinct moveMoneyPayMethodID from cleanacct, invdb.dc_elecfund_transfer_details where cleanacct.acctnum = dc_elecfund_transfer_details.acctnum);

    DELETE FROM invdb.`dc_elecfund_transfer_details`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_move_money_details`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`dc_mp_movemoney_paymethod`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_td_transfer_details`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_visa_details`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_request_audit`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_requests`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_requests_final`
    where acctnum in (select distinct acctnum from cleanacct);


    DELETE FROM invdb.`cash_report`
    where clientAccountID in (select distinct clientAccountID from cleanacct, invdb.ext_acct_info where cleanacct.acctnum = ext_acct_info.acctnum);
    
    DELETE FROM invdb.`cash_transaction`
    where clientAccountID in (select distinct clientAccountID from cleanacct, invdb.ext_acct_info where cleanacct.acctnum = ext_acct_info.acctnum);
    
    DELETE FROM invdb.`commission`
    where clientAccountID in (select distinct clientAccountID from cleanacct, invdb.ext_acct_info where cleanacct.acctnum = ext_acct_info.acctnum);

    DELETE FROM invdb.`ext_nav`
    where clientAccountID in (select distinct clientAccountID from cleanacct, invdb.ext_acct_info where cleanacct.acctnum = ext_acct_info.acctnum);

	DELETE FROM invdb.`ext_position`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`ext_transaction`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`pretrade_details`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`rebalance_info`
    where acctnum in (select distinct acctnum from cleanacct);
    
	/*
    DELETE FROM invdb.`rebalance_trade`
    where acctnum in (select distinct acctnum from cleanacct);
    */

    DELETE FROM invdb.`relAndunrel`
    where clientAccountID in (select distinct clientAccountID from cleanacct, invdb.ext_acct_info where cleanacct.acctnum = ext_acct_info.acctnum);

	/*
    DELETE FROM invdb.`sav_acct_financial`
    where acctnum in (select distinct acctnum from cleanacct);
    */

    DELETE FROM invdb.`position`
    where clientAccountID in (select distinct clientAccountID from cleanacct, invdb.ext_acct_info where cleanacct.acctnum = ext_acct_info.acctnum);
    
    DELETE FROM invdb.`trades`
    where clientAccountID in (select distinct clientAccountID from cleanacct, invdb.ext_acct_info where cleanacct.acctnum = ext_acct_info.acctnum);
   
	DELETE FROM invdb.`unbundld_commission`
    where clientAccountID in (select distinct clientAccountID from cleanacct, invdb.ext_acct_info where cleanacct.acctnum = ext_acct_info.acctnum);

	/*
	DELETE FROM invdb.`user_exclude_subclass`
    where acctnum in (select distinct acctnum from cleanacct);
    */

    DELETE FROM invdb.`user_notification`
    where logonid in (select distinct logonid from cleanacct, invdb.user_access_role where cleanacct.acctnum = user_access_role.acctnum);

	DELETE FROM invdb.`user_reports`
    where acctnum in (select distinct acctnum from cleanacct);
    
	DELETE FROM invdb.`user_risk_questions`
    where acctnum in (select distinct acctnum from cleanacct);
    
	DELETE FROM invdb.`user_risk_questions_audit`
    where acctnum in (select distinct acctnum from cleanacct);

	DELETE FROM invdb.`virtual_portfolio`
    where acctnum in (select distinct acctnum from cleanacct);

	DELETE FROM invdb.`visitor`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`ext_acct_info`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`user_trade_log`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`user_trade_profile_audit`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`user_risk_profile`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`user_risk_score`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`user_trade_profile`
    where acctnum in (select distinct acctnum from cleanacct);
    
		DELETE FROM `invdb`.`user_logon`
		WHERE logonid > 100
		AND   logonstatus not in ('A', 'L')
		and   logonid in (select logonid from invdb.`user_access_role`
							where acctnum in (select distinct acctnum from cleanacct));

		DELETE FROM invdb.`user_access_role`
		where acctnum in (select distinct acctnum from cleanacct);

    
    DELETE FROM invdb.`user_logon_exception`;
    
    
	SET SQL_SAFE_UPDATES = 0;

END$$

DELIMITER ;


/* 555_sp_testing_sp_emulate_step5_position.sql230118_sagar*/

USE `testing`;
DROP procedure IF EXISTS `sp_emulate_step5_position`;

DELIMITER $$
USE `testing`$$
CREATE PROCEDURE `sp_emulate_step5_position`(
   IN p_acctnum BIGINT,
     IN p_logonid BIGINT(20)
 )
BEGIN
 	DECLARE tStatus VARCHAR(1);
     DECLARE tClientAccountID VARCHAR(20);
     DECLARE tCash Double;
     DECLARE tTotal Double;
     DECLARE tReportDate VARCHAR(10);
     DECLARE tTradeCurrency VARCHAR(3);
 
     SELECT eai.status, eai.clientAccountID, IFNULL(profile.tradeCurrency,'USD')
     INTO tStatus, tClientAccountID, tTradeCurrency
     FROM invdb.ext_acct_info eai, invdb.user_trade_profile profile
     WHERE eai.acctnum = profile.acctnum
 	AND   eai.acctnum = p_acctnum;
 
 	set tReportDate = invdb.FUNCT_GET_SWITCH('BROKER_BDATE');
     IF (IFNULL(tStatus,'Z') != 'A')
     THEN
       SELECT 'This account# NOT YET Active' AS msg;
     ELSE
 	  select SUM(cash), sum(total)
       INTO tCash, tTotal
       from invdb.ext_nav 
       where clientAccountID = tClientAccountID
       and reportDate = tReportDate;
       
 	IF (tCash = 0.0)
 		THEN
 			SELECT 'This account# NOT YET Funded' AS msg;
 		ELSE
 			IF (tCash < tTotal)
             THEN
 				SELECT 'This account# has already been allocated' AS msg;
            ELSE
            
 				DELETE FROM invdb.ext_position 
                 where clientAccountID = tClientAccountID
                 AND reportDate = tReportDate;
  
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
 					settleMarkPrice,
 					settlePnL,
 					created)
 				SELECT 
 					virtual_portfolio.acctnum,
                     tClientAccountID,
                     virtual_portfolio.tradeCurrency,
                     virtual_portfolio.exchangeRate,
 					virtual_portfolio.ticker,
                     tReportDate,
                     tReportDate,
                     'Long',
 					virtual_portfolio.qty,
 					(tTotal * virtual_portfolio.weight) / virtual_portfolio.qty,
                     (tTotal * virtual_portfolio.weight),
 					(tTotal * virtual_portfolio.weight) / virtual_portfolio.qty,
                     (tTotal * virtual_portfolio.weight),
 					0.0,
 					'Emulated',
                     virtual_portfolio.settleCurrency,
 					IFNULL(virtual_portfolio.settleQty, virtual_portfolio.qty),
 					(tTotal * virtual_portfolio.exchangeRate * virtual_portfolio.weight) / IFNULL(virtual_portfolio.settleQty, virtual_portfolio.qty),
                     (tTotal * virtual_portfolio.exchangeRate * virtual_portfolio.weight),
 					(tTotal * virtual_portfolio.exchangeRate * virtual_portfolio.weight) / IFNULL(virtual_portfolio.settleQty, virtual_portfolio.qty),
                     0.0,				
 					now()
 				FROM invdb.virtual_portfolio
                 WHERE acctnum = p_acctnum
 				;
                 
                 SELECT costBasisMoney
                 INTO tCash
                 FROM invdb.ext_position
                 WHERE clientAccountID = tClientAccountID
                 AND   upper(symbol) = 'CASH'
                 AND reportDate = tReportDate;
                 
                 UPDATE invdb.ext_nav
                 set cash = tCash,
 					stock = total - tCash
                 where clientAccountID = tClientAccountID
                 AND reportDate = tReportDate;
 				
 				SELECT 'Success: This account# has been allocated' AS msg;
 				
 
             END IF;
 	END IF;
         
 
     END IF;
 
 
   END$$

DELIMITER ;


/* 556_sp_testing_sp_fund_account.sql230118_sagar*/

USE `testing`;
DROP procedure IF EXISTS `sp_fund_account`;

DELIMITER $$
USE `testing`$$
CREATE PROCEDURE `sp_fund_account`(
    IN p_acctnum BIGINT,
    IN p_amount  DOUBLE
  )
BEGIN
  
    DECLARE tClientAccountID	VARCHAR(10);
  
  
        IF (IFNULL(p_acctnum, 'XXX') != 'XXX')
        THEN
  
  			SELECT clientAccountID
              INTO tClientAccountID
              FROM invdb.ext_acct_info eai
              WHERE eai.acctnum = p_acctnum;
  
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
  				created
  				)
  			SELECT
  				eai.acctnum
  				, eai.clientAccountID as clientAccountID
  				, 'USD' as currencyPrimary
  				, '1.0' as fxRateToBase
  				, 'Cash' as symbol
  				, invdb.FUNCT_GET_SWITCH('BROKER_BDATE') as reportDate
  				, invdb.FUNCT_GET_SWITCH('BROKER_BDATE') as purchaseDate
  				, 'Long' as side
  				, p_amount as quantity
  				, 1 as costBasisPrice
  				, p_amount as costBasisMoney
  				, 1 as markPrice
  				, p_amount as positionValue
  				, 0 as pnlUnrealized
  				, 'Cash' as levelOfDetail
  				, now() as created
  			FROM invdb.ext_acct_info as eai
  			WHERE eai.acctnum = p_acctnum
              ON duplicate key update
  				  quantity = quantity + p_amount
                  , costBasisMoney = costBasisMoney + p_amount
                  , positionValue = positionValue + p_amount
                  , levelOfDetail = 'Funded'
  			;
  
  
  		   INSERT INTO invdb.ext_nav
  				(clientAccountID,
  				reportDate,
  				cash,
  				stock,
  				funds,
  				interestAccrual,
  				dividentAccrual,
  				total)
  			VALUES
  			(tClientAccountID,
  			invdb.FUNCT_GET_SWITCH('BROKER_BDATE'),
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


/* 1_sp_invdb_ext_nav_backup.sql230118_sagar*/

use invdb;

ALTER TABLE `invdb`.`ext_nav` 
RENAME TO  `invdb`.`ext_nav_2018_02_01` ;


CREATE TABLE ext_nav (
  clientAccountID varchar(15) NOT NULL DEFAULT '',
  tradeCurrency varchar(3) NOT NULL DEFAULT 'USD',
  reportDate varchar(10) NOT NULL DEFAULT '',
  exchangeRate double DEFAULT '1',
  settleCurrency varchar(3) NOT NULL DEFAULT 'USD',
  cash double DEFAULT '0',
  stock double DEFAULT NULL,
  funds double DEFAULT NULL,
  interestAccrual double DEFAULT NULL,
  dividentAccrual double DEFAULT NULL,
  total double DEFAULT NULL,
  PRIMARY KEY (clientAccountID,tradeCurrency,reportDate,settleCurrency)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



insert into invdb.ext_nav (clientAccountID,reportDate,cash,stock,funds,interestAccrual,dividentAccrual,total)
select clientAccountID,reportDate,cash,stock,funds,interestAccrual,dividentAccrual,total from invdb.ext_nav_2018_02_01;


/* 550_sp_invdb_funct_get_actualCapital.sql230118_sagar*/

USE `invdb`;
DROP function IF EXISTS `funct_get_actualCapital`;

DELIMITER $$
USE `invdb`$$
CREATE FUNCTION `funct_get_actualCapital`(
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
				 ext_nav nav
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


/* 551_sp_invdb_sel_advisorDashBoard.sql230118_sagar*/

USE `invdb`;
DROP procedure IF EXISTS `sel_advisorDashBoard`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sel_advisorDashBoard`(
 	IN p_logonid BIGINT,
     IN p_advisor VARCHAR(20),
     IN p_rep VARCHAR(20)
 )
BEGIN
 	DECLARE tRep 	 VARCHAR(25);
 	DECLARE tAdvisor VARCHAR(25);
 	DECLARE vAdvisor VARCHAR(25);
 
 IF (p_logonid is not null)
 	THEN
     
 		BEGIN
 
 			select advisor into vAdvisor  from user_logon where logonid=p_logonid;
 			if(vAdvisor='DEMO') then
 				set tAdvisor = IFNULL(p_advisor,'');
 				set tRep = IFNULL(p_rep,'');
 			else
 						SELECT rep, advisor
 						INTO tRep, tAdvisor
 						FROM user_advisor_access
 						WHERE logonid = p_logonid
 						LIMIT 1;
 			end if;
 		END;
 
 			SELECT
 				'AUM' src,
 				IFNULL(SUM(IFNULL(ext_nav.total,0)),0) as value
 			FROM  
 			  ext_acct_info
               INNER JOIN user_trade_profile
               ON (user_trade_profile.acctnum = ext_acct_info.acctnum)
 			  INNER JOIN ext_nav
 			  ON (ext_nav.clientAccountID = ext_acct_info.clientAccountID
 				  AND   ext_nav.reportDate = funct_get_switch('BROKER_BDATE')
 				)
 			 WHERE ext_acct_info.status = 'A'
 			 AND IFNULL(TRIM(user_trade_profile.advisor),'Invessence') like tAdvisor
 			 AND IFNULL(TRIM(user_trade_profile.rep),'CATCHALL') like tRep
 		UNION
 			SELECT
 			'Active' src,
 			count(user_trade_profile.acctnum) as value
 			FROM  
 			  ext_acct_info
               INNER JOIN user_trade_profile
               ON (user_trade_profile.acctnum = ext_acct_info.acctnum)
 			WHERE ext_acct_info.status not in ( 'X' )
 			AND IFNULL(TRIM(user_trade_profile.advisor),'Invessence') like tAdvisor
 			AND IFNULL(TRIM(user_trade_profile.rep),'CATCHALL') like tRep
  		UNION
 			SELECT
 				'Pending' src,
 				count(distinct user_trade_profile.acctnum) as value
 			FROM  user_trade_profile
 			WHERE IFNULL(user_trade_profile.managed,'N') in ( 'N' )
 			AND IFNULL(TRIM(user_trade_profile.advisor),'Inv') like tAdvisor
 			AND IFNULL(TRIM(user_trade_profile.rep),'000') like tRep
 		UNION
 			SELECT
 				'VisitorToday' src,
 				count(distinct user_trade_profile.acctnum) as value
 			FROM  user_trade_profile
 			WHERE user_trade_profile.created >= DATE_FORMAT(now(),'%Y-%m-%d')
             AND user_trade_profile.managed='N' 
             AND user_trade_profile.status = 'V'
 			AND IFNULL(TRIM(user_trade_profile.advisor),'Invessence') like tAdvisor
 			AND IFNULL(TRIM(user_trade_profile.rep),'CATCHALL') like tRep
 			;
         
         SELECT distinct idx.ticker,
 			   price.close_price
 		FROM invdb.sec_assetclass_group idx
             , invdb.sec_daily_info price
 		WHERE idx.ticker = price.ticker
         AND   DATE_FORMAT(price.businessdate,'%Y%m%d') = invdb.funct_get_switch('PRICE_DATE')
         ;
         
         
 END IF;
 
 
 END$$

DELIMITER ;

/* 501.pm.sel_collectTradeProfile.sql030218_pmehta*/

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
            IFNULL(`ext_nav`.`cash`,0) as `cash`,
            IFNULL(`ext_nav`.`stock`,0) + IFNULL(`ext_nav`.`funds`,0) +
            IFNULL(`ext_nav`.`interestAccrual`,0) + IFNULL(`ext_nav`.`dividentAccrual`,0) as `investment`,
            `user_trade_profile`.`advisor`,
            IFNULL(`user_basket_access`.`displayname`,`user_trade_profile`.`theme`) as `theme`,
            `user_trade_profile`.`acctType`,
            `ext_nav`.`total` as `totalInvestment`,
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
            IFNULL(`ext_nav`.`cash`,0),
            IFNULL(`ext_nav`.`stock`,0) + IFNULL(`ext_nav`.`funds`,0) +
            IFNULL(`ext_nav`.`interestAccrual`,0) + IFNULL(`ext_nav`.`dividentAccrual`,0),
            `user_trade_profile`.`advisor`,
            IFNULL(`user_basket_access`.`displayname`,`user_trade_profile`.`theme`),
            `user_trade_profile`.`acctType`,
            `ext_nav`.`total`,
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

/* 502.pm.sel_TradeSummaryDetail.sql030218_pmehta*/

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
            `ext_nav`.`total`  as `totalInvestment`,
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
		INNER JOIN `ext_nav`
        ON (`ext_nav`.`clientAccountID` = `ext_acct_info`.`clientAccountID`
        AND `ext_nav`.`reportDate` = `FUNCT_GET_SWITCH`('BROKER_BDATE'))
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
			`trade_process_identifier`.`processStatus`,
            `ext_nav`.`total`
    	;

    end;
END$$
DELIMITER ;

/* 1.pm.user_exclude_subclass.sql080218_pmehta*/
/* Alredy available in TCM*/

/* 2.pm.user_trade_preprocess.sql080218_pmehta*/

DROP TABLE IF EXISTS `invdb`.`user_trade_preprocess`;

CREATE TABLE `invdb`.`user_trade_preprocess` (
  `advisor` varchar(20) NOT NULL,
  `clientAccountID` varchar(20) NOT NULL,
  `acctnum` bigint(20) NOT NULL,
  `processed` varchar(1) DEFAULT NULL,
  `tradeDate` varchar(8) DEFAULT NULL,
  `tradeCurrency` varchar(3) DEFAULT 'USD',
  `assetclass` varchar(40) DEFAULT NULL,
  `subclass` varchar(40) DEFAULT NULL,
  `color` varchar(10) DEFAULT NULL,
  `holdingTicker` varchar(25) DEFAULT NULL,
  `curQty` double DEFAULT NULL,
  `curPrice` double DEFAULT NULL,
  `curValue` double DEFAULT NULL,
  `newTicker` varchar(25) DEFAULT NULL,
  `newQty` int(11) DEFAULT NULL,
  `newPrice` double DEFAULT NULL,
  `newValue` double DEFAULT NULL,
  `settleCurrency` varchar(3) DEFAULT 'USD',
  `settleQty` double DEFAULT NULL,
  `settlePrice` double DEFAULT NULL,
  `settleValue` double DEFAULT NULL,
  `exchangeRate` double DEFAULT '1',
  `settleNewQty` double DEFAULT NULL,
  `settleNewPrice` double DEFAULT NULL,
  `settleNewValue` double DEFAULT NULL,
  `tradetype` varchar(20) DEFAULT NULL,
  `reason` varchar(40) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY `user_trade_preprocess_advisor` (`advisor`,`clientAccountID`,`tradeDate`,`newTicker`),
  KEY `user_trade_preprocess_acctnum` (`acctnum`,`processed`,`tradeDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/* 503.pm.sel_executedTrades.sql080218_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`sel_executedTrades`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_executedTrades`(
 	IN p_acctnum  bigint(20)
)
BEGIN

	SELECT `ext_transaction`.`acctnum`,
		`ext_transaction`.`clientAccountID`,
		`ext_transaction`.`ticker`,
		`ext_transaction`.`isin`,
		`ext_transaction`.`confirmNumber`,
		`ext_transaction`.`transactionSource`,
		`ext_transaction`.`transactionType`,
		`ext_transaction`.`transactionStatus`,
		`ext_transaction`.`controlNumber`,
		`ext_transaction`.`quantity`,
		`ext_transaction`.`price`,
		`ext_transaction`.`netAmount`,
		`ext_transaction`.`commission`,
		`ext_transaction`.`otherFees`,
		`ext_transaction`.`tradeDate`,
		`ext_transaction`.`settDate`,
		`ext_transaction`.`voidDate`,
		`ext_transaction`.`comment`,
		`ext_transaction`.`tradedCurrency`,
		`ext_transaction`.`fxRateToBase`,
		`ext_transaction`.`settleCurrency`,
		`ext_transaction`.`settleQty`,
		`ext_transaction`.`settlePrice`,
		`ext_transaction`.`settleNetAmount`,
		`ext_transaction`.`settleFees`,
		datediff(now(),STR_TO_DATE(`ext_transaction`.`tradeDate`,'%Y%m%d')) as days_last_executed
	FROM `invdb`.`ext_transaction`
    WHERE `ext_transaction`.`acctnum` = p_acctnum
    ORDER BY `ext_transaction`.`ticker`, `ext_transaction`.`tradeDate` desc;


END$$
DELIMITER ;

/* 504.pm.save_user_trade_preprocess.sql080218_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`save_user_trade_preprocess`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`save_user_trade_preprocess`(
		IN	`p_advisor`	varchar(20)
	,	IN	`p_clientAccountID`	varchar(20)
	,	IN	`p_acctnum`	bigint(20)
	,	IN	`p_processed`	varchar(1)
	,	IN	`p_tradeDate`	varchar(8)
	,	IN	`p_tradeCurrency`	varchar(3)
	,	IN	`p_assetclass`	varchar(40)
	,	IN	`p_subclass`	varchar(40)
	,	IN	`p_color`	varchar(10)
	,	IN	`p_holdingTicker`	varchar(25)
	,	IN	`p_curQty`	double
	,	IN	`p_curPrice`	double
	,	IN	`p_curValue`	double
	,	IN	`p_newTicker`	varchar(25)
	,	IN	`p_newQty`	double
	,	IN	`p_newPrice`	double
	,	IN	`p_newValue`	double
	,	IN	`p_settleCurrency`	varchar(3)
	,	IN	`p_setleCurQty`	double
	,	IN	`p_settleCurPrice`	double
	,	IN	`p_settleCurValue`	double
	,	IN	`p_exchangeRate`	double
	,	IN	`p_settleNewQty`	double
	,	IN	`p_settleNewPrice`	double
	,	IN	`p_settleNewValue`	double
	,	IN	`p_tradeType`	varchar(40)
	,	IN	`p_reason`	varchar(40)
)
BEGIN

			INSERT INTO `invdb`.`user_trade_preprocess`
			(
            `advisor`,
			`clientAccountID`,
			`acctnum`,
			`processed`,
			`tradeDate`,
			`tradeCurrency`,
			`assetclass`,
			`subclass`,
			`color`,
			`holdingTicker`,
			`curQty`,
			`curPrice`,
			`curValue`,
			`newTicker`,
			`newQty`,
			`newPrice`,
			`newValue`,
			`settleCurrency`,
			`settleQty`,
			`settlePrice`,
			`settleValue`,
			`exchangeRate`,
			`settleNewQty`,
			`settleNewPrice`,
			`settleNewValue`,
			`tradetype`,
			`reason`,
			`created`
            )
		VALUES
        (
				`p_advisor`
			,	`p_clientAccountID`
			,	`p_acctnum`
			,	`p_processed`
			,	IFNULL(`p_tradeDate`,DATE_FORMAT(now(),'%Y%m%d'))
			,	`p_tradeCurrency`
			,	`p_assetclass`
			,	`p_subclass`
			,	`p_color`
			,	`p_holdingTicker`
			,	`p_curQty`
			,	`p_curPrice`
			,	`p_curValue`
			,	`p_newTicker`
			,	`p_newQty`
			,	`p_newPrice`
			,	`p_newValue`
			,	`p_settleCurrency`
			,	`p_setleCurQty`
			,	`p_settleCurPrice`
			,	`p_settleCurValue`
			,	`p_exchangeRate`
			,	`p_settleNewQty`
			,	`p_settleNewPrice`
			,	`p_settleNewValue`
			,	`p_tradeType`
			,	`p_reason`
            , 	now()
        )
            ON DUPLICATE KEY UPDATE
			`advisor`	=	`p_advisor`
		,	`clientAccountID`	=	`p_clientAccountID`
		,	`acctnum`	=	`p_acctnum`
		,	`processed`	=	`p_processed`
		,	`tradeDate`	=	IFNULL(`p_tradeDate`,DATE_FORMAT(now(),'%Y%m%d'))
		,	`tradeCurrency`	=	`p_tradeCurrency`
		,	`assetclass`	=	`p_assetclass`
		,	`subclass`	=	`p_subclass`
		,	`color`	=	`p_color`
		,	`holdingTicker`	=	`p_holdingTicker`
		,	`curQty`	=	`p_curQty`
		,	`curPrice`	=	`p_curPrice`
		,	`curValue`	=	`p_curValue`
		,	`newTicker`	=	`p_newTicker`
		,	`newQty`	=	`p_newQty`
		,	`newPrice`	=	`p_newPrice`
		,	`newValue`	=	`p_newValue`
		,	`settleCurrency`	=	`p_settleCurrency`
		,	`settleQty`	=	`p_setleCurQty`
		,	`settlePrice`	=	`p_settleCurPrice`
		,	`settleValue`	=	`p_settleCurValue`
		,	`exchangeRate`	=	`p_exchangeRate`
		,	`settleNewQty`	=	`p_settleNewQty`
		,	`settleNewPrice`	=	`p_settleNewPrice`
		,	`settleNewValue`	=	`p_settleNewValue`
		,	`tradeType`	=	`p_tradeType`
		,	`reason`	=	`p_reason`
        ;

END$$
DELIMITER ;

/* 505.pm.sel_user_trade_preprocess.sql080218_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`sel_user_trade_preprocess`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_user_trade_preprocess`(
	p_acctnum BIGINT(20)
)
BEGIN
	IF (p_acctnum is not null)
		then
			begin
            
				SELECT 
					 IFNULL(`sec_asset_mapping`.`assetsortorder`*10000+`sec_asset_mapping`.`subclasssortorder`,999999999) as `sortorder`,
					 IFNULL(TRIM(`user_trade_preprocess`.`holdingTicker`),`user_trade_preprocess`.`newTicker`) as `sortTicker`,					
					`user_trade_preprocess`.`curQty` as `sortQty`,
					`user_trade_preprocess`.`advisor`,
					`user_trade_preprocess`.`clientAccountID`,
					`user_trade_preprocess`.`acctnum`,
					`user_trade_preprocess`.`processed`,
					`user_trade_preprocess`.`tradeDate`,
					`user_trade_preprocess`.`tradeCurrency`,
					IFNULL(`sec_asset_mapping`.`assetName`,`user_trade_preprocess`.`assetclass`) as `assetclass`,
					IFNULL(`sec_asset_mapping`.`subclassName`,`user_trade_preprocess`.`subclass`) as `subclass`,
					IFNULL(`sec_asset_mapping`.`assetcolor`,`user_trade_preprocess`.`color`) as `assetcolor`,
                    `user_trade_preprocess`.`holdingTicker`,
					`user_trade_preprocess`.`curQty`,
					`user_trade_preprocess`.`curPrice`,
					`user_trade_preprocess`.`curValue`,
					`user_trade_preprocess`.`newTicker`,
					`user_trade_preprocess`.`newQty`,
					`user_trade_preprocess`.`newPrice`,
					`user_trade_preprocess`.`newValue`,
					`user_trade_preprocess`.`exchangeRate`,
					`user_trade_preprocess`.`settleCurrency`,
					`user_trade_preprocess`.`settleQty`,
					`user_trade_preprocess`.`settlePrice`,
					`user_trade_preprocess`.`settleValue`,
					`user_trade_preprocess`.`settleNewQty`,
					`user_trade_preprocess`.`settleNewPrice`,
					`user_trade_preprocess`.`settleNewValue`,
					`user_trade_preprocess`.`tradetype`,
					`user_trade_preprocess`.`reason`,
                    `sec_master`.`name`,
					`ext_acct_info`.`applicantLName` as `lastName`,
					`ext_acct_info`.`applicantFName` as `firstName`,
					`ext_acct_info`.`fullname` as `fullname`,
					`user_trade_profile`.`taxable`,
					`user_trade_profile`.`goal`
				FROM `user_trade_preprocess`
				INNER JOIN `user_trade_profile` 
					ON (`user_trade_preprocess`.`acctnum` = `user_trade_profile`.`acctnum`)
				INNER JOIN `ext_acct_info`
					ON (`user_trade_preprocess`.`acctnum` = `ext_acct_info`.`acctnum`)
 				LEFT JOIN `sec_master`
					ON (`user_trade_preprocess`.`newTicker` = `sec_master`.`ticker`)
 				LEFT JOIN `sec_asset_mapping`
 					ON (`user_trade_preprocess`.`newTicker` = `sec_asset_mapping`.`ticker`
 					AND `user_trade_profile`.`theme` = `sec_asset_mapping`.`theme`)
				WHERE `user_trade_preprocess`.`processed` = 'N'
				AND  `user_trade_preprocess`.`acctnum` = p_acctnum
				ORDER BY 1,2,3
                ;
			end;
	END IF;
END$$
DELIMITER ;

/* 506.pm.save_executedTrades.sql080218_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`save_executedTrades`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`save_executedTrades`(
	p_acctnum 	BIGINT(20)
)

BEGIN
	DECLARE today	VARCHAR(10);
	begin
        DELETE FROM `invdb`.`user_trade_log`
        WHERE `user_trade_log`.`acctnum` = p_acctnum
        AND `user_trade_log`.`tradeStatus` = 'P';
        
		INSERT INTO `invdb`.`user_trade_log`
		(`acctnum`,
		`clientAccountID`,
		`tradeStatus`,
		`tradedate`,
		`ticker`,
		`action`,
		`sectype`,
		`exchange`,
		`currency`,
		`timeinforce`,
		`qty`,
		`tradeprice`,
		`investmentamount`,
		`tradeID`,
		`ordertype`,
		`confirmationID`,
		`firmAccount`,
		`created`,
		`lastupdated`)
        SELECT 
			`trade_process_identifier`.`acctnum`,
            `ext_acct_info`.`clientAccountID`,
            'P' as tradeStatus,
            DATE_FORMAT(now(),'%Y%m%d') as tradedate,
            `rebal`.`newTicker`,
            CASE WHEN (`rebal`.`settleNewQty` < 0) THEN 'SELL'
				 ELSE 'BUY'
			END as `action`,
            null as `sectype`,
            `rebal`.`exchangeRate`,
            `rebal`.`settleCurrency` as `currency`,
            'DAY' as `timeinforce`,
            ABS(`rebal`.`settleNewQty`) as `qty`,
            `rebal`.`settleNewPrice` as `tradeprice`,
            ABS(`rebal`.`settleNewValue`) as `investmentamount`,
            CONCAT(`rebal`.`newTicker`,DATE_FORMAT(now(),'%Y%m%d%H%i%s')) as `tradeID`,
            'LMT' as `ordertype`,
            null as `confirmationID`,
            null as `firmAccount`,
            now() as `created`,
            null as `lastupdated`
		FROM `trade_process_identifier`
        INNER JOIN `ext_acct_info`
        ON (`ext_acct_info`.`acctnum` = `trade_process_identifier`.`acctnum`
			AND `ext_acct_info`.`status` in ('A'))
		INNER JOIN `user_trade_preprocess` as `rebal`
        ON (`rebal`.`acctnum` = `trade_process_identifier`.`acctnum`)
        INNER JOIN `sec_master`
        ON (`sec_master`.`ticker` = `rebal`.`newTicker`)
        WHERE IFNULL(`trade_process_identifier`.`processStatus`,'N') in ('R')
        AND  `trade_process_identifier`.`acctnum` = p_acctnum
    	;

    end;
    
    begin
		update trade_process_identifier
			set tradeStatus = 'V', processStatus = 'S'
		where acctnum = p_acctnum;
    end;
END$$
DELIMITER ;

