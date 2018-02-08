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
