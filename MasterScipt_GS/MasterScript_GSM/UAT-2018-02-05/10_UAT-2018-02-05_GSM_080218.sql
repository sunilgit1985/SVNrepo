
/* 1.alter_user_trade_profile.sql080218_pmehta*/

ALTER TABLE `invdb`.`user_trade_profile` 
CHANGE COLUMN `lastname` `lastname` VARCHAR(40) NULL DEFAULT NULL AFTER `firstname`;

/* 2.alter_ext_investment.sql080218_pmehta*/


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
					SELECT SUM(pos.positionValue)
					INTO tPosition
					FROM ext_position pos
					WHERE pos.acctnum = p_acctnum
					AND  pos.reportDate = funct_get_switch('BROKER_BDATE')
					AND  pos.symbol in (SELECT ticker from sec_master where sec_master.`status` = 'A')
					;
                
					RETURN IFNULL(tPosition,0.0);
			END IF;
            */

			RETURN IFNULL(tAmount,0.0);
		END;
	END;
END$$
DELIMITER ;


/* 500.pm.sp_emulate_step3_activateaccount.sql080218_pmehta*/

DROP PROCEDURE IF EXISTS `testing`.`sp_emulate_step3_activateaccount`;

DELIMITER $$
CREATE PROCEDURE `testing`.`sp_emulate_step3_activateaccount`(
	IN p_acctnum	BIGINT,
	IN p_amount		DOUBLE,
    IN p_logonid BIGINT(20),
    IN p_currency   VARCHAR(3)
)
BEGIN
	DECLARE tFound1 INTEGER;
  DECLARE tFound2	INTEGER;
	DECLARE tStatus	INTEGER;
  DECLARE tClientAccountID VARCHAR(20);

    SELECT count(*)
    INTO tFound1
    FROM invdb.ext_acct_info eai
    WHERE eai.acctnum = p_acctnum
    ;

	IF (IFNULL(tFound1,0) = 0)
	THEN
		SELECT 'This account# NOT YET OPENED' as msg;
	ELSE
		SELECT clientAccountID
		INTO tClientAccountID
		FROM invdb.ext_acct_info eai
		WHERE eai.acctnum = p_acctnum
        ;

		IF (IFNULL(tClientAccountID,'XXX') != 'XXX')
		THEN

			UPDATE invdb.user_trade_profile utp
				set utp.managed = 'A',
					  utp.status = 'S'
			WHERE utp.acctnum = p_acctnum;

			UPDATE invdb.ext_acct_info eai
				set eai.status = 'A'
			WHERE eai.acctnum = p_acctnum;

            if (p_amount is not null )
            THEN
				CALL testing.sp_fund_account(p_acctnum, p_amount, IFNULL(p_currency,'USD'));
				call invdb.sp_user_profile_manage(p_acctnum, 'S', p_logonid);

				SELECT 'This account# was ACTIVATED and POSITION created' as msg;
            ELSE
				call invdb.sp_user_profile_manage(p_acctnum, 'A',p_logonid);

				SELECT 'This account# was ACTIVATED' as msg;
            END IF;

		ELSE
			SELECT 'This account# was NOT FOUND to ext_acct_info' as msg;
 		END IF;

	END IF;



END$$
DELIMITER ;


/* 501.pm.sp_fund_account.sql080218_pmehta*/

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
				`tradeCurrency`,
				`netAmount`,
				`comment`,
				`fxRateToBase`,
				`settleCurrency`,
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
  				, investment.settleCurrency
  				, investment.fxRateToBase
  				, 'Cash' as symbol
  				, tbusinessdate as reportDate
  				, tbusinessdate as purchaseDate
  				, 'Long' as side
  				, investment.convertedNetAmount as quantity
  				, 1 as costBasisPrice
  				, investment.convertedNetAmount as costBasisMoney
  				, 1 as markPrice
  				, investment.convertedNetAmount as positionValue
  				, 0 as pnlUnrealized
				, tcurrency as settleCurrency
                , p_amount as settleQty
                , 1 as settlePrice
                , p_amount as settleMoney
				, 0 as settlePnL
  				, 'Cash' as levelOfDetail
  				, now() as created
  			FROM invdb.ext_acct_info as eai
            INNER JOIN invdb.ext_investment as investment
            ON (eai.acctnum = investment.acctnum)
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
			`currencyPrimary`,
			`fxRateToBase`,
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


/* 502.pm.sp_emulate_step4_funding.sql080218_pmehta*/

DROP PROCEDURE IF EXISTS `testing`.`sp_emulate_step4_funding`;

DELIMITER $$
CREATE PROCEDURE `testing`.`sp_emulate_step4_funding`(
  IN p_acctnum BIGINT,
  IN p_amount  DOUBLE,
  IN p_logonid BIGINT(20),
  IN p_currency VARCHAR(3)
)
BEGIN
    DECLARE tFound1 INTEGER;
    DECLARE tFound2 INTEGER;
    DECLARE tStatus INTEGER;
    DECLARE tClientAccountID VARCHAR(20);

    SELECT count(*)
    INTO tFound1
    FROM invdb.ext_acct_info eai
    WHERE eai.acctnum = p_acctnum;

    IF (IFNULL(tFound1, 0) = 0)
    THEN
      SELECT 'This account# NOT YET OPENED' AS msg;
    ELSE
      SELECT clientAccountID
      INTO tClientAccountID
      FROM invdb.ext_acct_info eai
      WHERE eai.acctnum = p_acctnum;

      IF (IFNULL(tClientAccountID, 'XXX') != 'XXX')
      THEN
        CALL testing.sp_fund_account(p_acctnum, p_amount, p_currency);
        CALL invdb.sp_user_profile_manage(p_acctnum, 'F',p_logonid);

        SELECT 'This account# was ACTIVATED and POSITION created' AS msg;
      ELSE
        SELECT 'This account# was NOT FOUND to ext_acct_info' AS msg;
      END IF;

    END IF;


  END$$
DELIMITER ;


