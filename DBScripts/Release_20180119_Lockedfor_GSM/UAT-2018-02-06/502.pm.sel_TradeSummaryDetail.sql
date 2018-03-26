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
