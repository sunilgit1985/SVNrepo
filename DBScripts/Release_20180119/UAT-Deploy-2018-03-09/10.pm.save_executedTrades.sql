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
            ifnull(tradeDate,DATE_FORMAT(now(),'%Y%m%d')) as tradedate,
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
