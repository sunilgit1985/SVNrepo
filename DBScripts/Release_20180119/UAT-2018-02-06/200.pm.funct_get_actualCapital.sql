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
