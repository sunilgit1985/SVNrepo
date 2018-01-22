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
            `user_trade_profile`.`theme`,
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
        WHERE IFNULL(`trade_process_identifier`.`processStatus`,'N') like p_filter
        AND   lower(IFNULL(`user_trade_profile`.`advisor`,'Invessence')) like tAdvisor
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
            `user_trade_profile`.`theme`,
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
