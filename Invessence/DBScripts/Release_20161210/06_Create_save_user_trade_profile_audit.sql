DROP PROCEDURE IF EXISTS invdb.`save_user_trade_profile_audit`;

DELIMITER $$
CREATE PROCEDURE   invdb.`save_user_trade_profile_audit`(
	IN	p_acctnum	bigint(100)
)
BEGIN 
		INSERT INTO  invdb.`user_trade_profile_audit` (`acctnum`,
			`advisor`,
			`rep`,
			`theme`,
			`firstname`,
			`lastname`,
			`portfolioName`,
			`goal`,
			`acctType`,
			`age`,
			`horizon`,
			`initialInvestment`,
			`recurringInvestment`,
			`experience`,
			`longTermGoal`,
			`stayInvested`,
			`charitablegoals`,
			`dependent`,
			`riskIndex`,
			`tradePreference`,
			`keepLiquid`,
			`taxable`,
			`calcModel`,
			`assetIndex`,
			`portfolioIndex`,
			`goalAmount`,
			`email`,
			`ip`,
			`created`,
			`lastUpdated`,
			`managed`,
			`clientAccountID`)
            
			select `acctnum`,
			`advisor`,
			`rep`,
			`theme`,
			`firstname`,
			`lastname`,
			`portfolioName`,
			`goal`,
			`acctType`,
			`age`,
			`horizon`,
			`initialInvestment`,
			`recurringInvestment`,
			`experience`,
			`longTermGoal`,
			`stayInvested`,
			`charitablegoals`,
			`dependent`,
			`riskIndex`,
			`tradePreference`,
			`keepLiquid`,
			`taxable`,
			`calcModel`,
			`assetIndex`,
			`portfolioIndex`,
			`goalAmount`,
			`email`,
			`ip`,
			`created`,
			`lastUpdated`,
			`managed`,
			`clientAccountID` from  invdb.`user_trade_profile` where acctnum=p_acctnum ;			

END$$
DELIMITER ;