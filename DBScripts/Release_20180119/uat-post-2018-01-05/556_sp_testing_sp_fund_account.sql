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

