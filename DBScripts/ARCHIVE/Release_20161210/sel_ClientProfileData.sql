DROP PROCEDURE IF EXISTS `invdb`.`sel_ClientProfileData`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_ClientProfileData`(
	IN p_logonid BIGINT,
	IN p_acctnum BIGINT,
	IN p_days	 INTEGER
)
BEGIN

	DECLARE consumerView Boolean;
	DECLARE singleAcct  Boolean;
	DECLARE tAdvisor VARCHAR(25);
    DECLARE  tRep     VARCHAR(25);

	-- If Account number is part of argument, then only return one row.
    -- This will be used to load only one data.
    -- Also check below who wants this data (Advisor or Consumer)
	IF (IFNULL(p_acctnum,0) = 0)
		THEN SET singleAcct = FALSE;   
		ELSE set singleAcct = TRUE;
	END IF;
    
	SELECT advisor, rep
	INTO tAdvisor, tRep
	FROM user_advisor_access
	WHERE logonid = p_logonid
	LIMIT 1;
	
    -- Determin who is calling (Advisor or Consumer)
    -- This is for security.  If Consumer is calling then both logonID and acctnum must match.
    -- If advisor is callingm then they must have access to this account.
	IF (tAdvisor is NULL)
		THEN set consumerView = TRUE;  
		ELSE set consumerView = FALSE;
	END IF;
	
	-- This number of days only applies to Advisor.  If they want the list of accounts only
    -- Then determine, how many days.  This will be sent from UI.
	IF (p_days is null)
		THEN	set p_days = -36500;
		ELSE	IF (p_days > 0)
					THEN set p_days = -1 * p_days;
				END IF;
	END IF;
    
    IF (consumerView)
		THEN
			IF (singleAcct)
				THEN
					select 
					user_logon.logonid,
					`profile`.acctnum,
                    `profile`.managed,
					IFNULL(`profile`.firstname, user_logon.firstname) as `firstname`,
					IFNULL(`profile`.lastname, user_logon.lastname) as `lastname`,
					`profile`.portfolioName,
					IFNULL(`profile`.email, user_logon.email) as `email`,
					user_logon.userid,
					`profile`.advisor,
					`profile`.rep,
					`profile`.theme,
					user_logon.lastname,
					user_logon.firstname,
					user_logon.stateRegistered as state,
					ext_acct_info.clientAccountID as clientAccountID,
					CASE WHEN (IFNULL(`profile`.`status`,'V') in ('V')) THEN 'Visitor'
						 WHEN (upper(`profile`.`status`) = 'N') THEN 'Pending'
						 WHEN (upper(`profile`.`status`) = 'P') THEN 'Processed'
						 WHEN (upper(`profile`.`status`) = 'O') THEN 'Opened'
						 WHEN (upper(`profile`.`status`) is not null) THEN 'Active'
						 ELSE 'Visitor'
					END as `status`,
					CASE WHEN (IFNULL(`profile`.`managed`,'N') in ('N')) THEN 'Pending'
						 WHEN (upper(`profile`.`managed`) in ('A')) THEN 'Active'
						 ELSE 'Pending'
					END as acctStatus,
					`profile`.tradePreference,
					IFNULL(`profile`.goal,'Retirement') as goal,
					`profile`.`acctType` as accttype,
					IFNULL(`profile`.age,30) as age,
					IFNULL(`profile`.horizon,30) as horizon,
					round(datediff(now(),IFNULL(`profile`.created,now()))/364,0) as yearnum,
					IFNULL(`profile`.riskIndex,0) as riskIndex,
					CAST(IFNULL(`profile`.initialInvestment,5000) as SIGNED) as initialInvestment,
					round(funct_get_actualCapital(`profile`.acctnum),0) as actualCapital,
					IFNULL(`profile`.keepLiquid,0) as keepLiquid,
					IFNULL(`profile`.recurringInvestment,0) as recurringInvestment,
					IFNULL(`profile`.longTermGoal,0) as longTermGoal,
					IFNULL(`profile`.stayInvested,0) as stayInvested,
					`profile`.`taxable`,
					IFNULL(`profile`.calcModel,'A') as calcModel,
					IFNULL(`profile`.assetIndex,0) as assetIndex,
					IFNULL(`profile`.portfolioIndex,0) as portfolioIndex,
					IFNULL(`acct_financial`.`dependent`,0) as dependent,
					DATE_FORMAT(`profile`.created,'%Y%m%d') as dateOpened,

							IFNULL(`acct_financial`.`householdwages`,0) as householdwages,
							IFNULL(`acct_financial`.`householdPayment`,0) as householdPayment,
							IFNULL(`acct_financial`.`miscExpenses`,0) as miscExpenses,
							IFNULL(`acct_financial`.`moneyMarket`,0) as moneyMarket,
							IFNULL(`acct_financial`.`investment`,0) as investment,
							IFNULL(`acct_financial`.`otherDebt`,0) as otherDebt,

					IFNULL(`acct_financial`.`totalIncomeAnnulized`,0) as totalIncomeAnnulized,
					IFNULL(`acct_financial`.`totalExpenseAnnulized`,0) as totalExpenseAnnulized,
					IFNULL(`acct_financial`.`totalAsset`,0) as totalAsset,
					IFNULL(`acct_financial`.`totalDebt`,0) as totalDebt,
					IFNULL(`acct_financial`.`liquidnetworth`,0) as liquidnetworth,
					IFNULL(`acct_financial`.`networth`,0) as networth,
					IFNULL(`user_risk_questions`.`ans1`,0) AS ans1,
					IFNULL(`user_risk_questions`.`ans2`,0) AS ans2,
					IFNULL(`user_risk_questions`.`ans3`,0) AS ans3,
					IFNULL(`user_risk_questions`.`ans4`,0) AS ans4,
					IFNULL(`user_risk_questions`.`ans5`,0) AS ans5,
					IFNULL(`user_risk_questions`.`ans6`,0) AS ans6,
					IFNULL(`user_risk_questions`.`ans7`,0) AS ans7,
					IFNULL(`user_risk_questions`.`ans8`,0) AS ans8,
					IFNULL(`user_risk_questions`.`ans9`,0) AS ans9,
					IFNULL(`user_risk_questions`.`ans10`,0) AS ans10,
					IFNULL(`user_risk_questions`.`ans11`,0) AS ans11,
					IFNULL(`user_risk_questions`.`ans12`,0) AS ans12,
					IFNULL(`user_risk_questions`.`ans13`,0) AS ans13,
					IFNULL(`user_risk_questions`.`ans14`,0) AS ans14,
					IFNULL(`user_risk_questions`.`ans15`,0) AS ans15,
					IFNULL(`profile`.goalAmount,0) as goalDesired,
					DATE_FORMAT(`profile`.created,'%Y-%m-%d') as created
					
					from
						user_logon,
						user_access_role,
						`user_trade_profile` `profile`
						left join `acct_financial`
						On ( `profile`.acctnum = `acct_financial`.acctnum)
						left join `user_risk_questions`
						On (`profile`.acctnum = `user_risk_questions`.acctnum)
						left join `ext_acct_info` ext_acct_info
						On (ext_acct_info.acctnum = `profile`.acctnum)
					where
						user_logon.logonid = user_access_role.logonid
					and user_access_role.acctnum = `profile`.acctnum
					and user_access_role.role in ('OWNER')
					and `profile`.acctnum = p_acctnum
					and user_logon.logonid = p_logonid
					order by `profile`.created desc
					LIMIT 1
					;
				ELSE
					select 
					user_logon.logonid,
					`profile`.acctnum,
                    `profile`.managed,
					IFNULL(`profile`.firstname, user_logon.firstname) as `firstname`,
					IFNULL(`profile`.lastname, user_logon.lastname) as `lastname`,
					`profile`.portfolioName,
					IFNULL(`profile`.email, user_logon.email) as `email`,
					user_logon.userid,
					`profile`.advisor,
					`profile`.rep,
					`profile`.theme,
					user_logon.lastname,
					user_logon.firstname,
					user_logon.stateRegistered as state,
					ext_acct_info.clientAccountID as clientAccountID,
					CASE WHEN (IFNULL(`profile`.`status`,'V') in ('V')) THEN 'Visitor'
						 WHEN (upper(`profile`.`status`) = 'N') THEN 'Pending'
						 WHEN (upper(`profile`.`status`) = 'P') THEN 'Processed'
						 WHEN (upper(`profile`.`status`) = 'O') THEN 'Opened'
						 WHEN (upper(`profile`.`status`) is not null) THEN 'Active'
						 ELSE 'Visitor'
					END as `status`,
					CASE WHEN (IFNULL(`profile`.`managed`,'N') in ('N')) THEN 'Pending'
						 WHEN (upper(`profile`.`managed`) in ('A')) THEN 'Active'
						 ELSE 'Pending'
					END as acctStatus,
					`profile`.tradePreference,
					IFNULL(`profile`.goal,'Retirement') as goal,
					`profile`.`acctType` as accttype,
					IFNULL(`profile`.age,30) as age,
					IFNULL(`profile`.horizon,30) as horizon,
					round(datediff(now(),IFNULL(`profile`.created,now()))/364,0) as yearnum,
					IFNULL(`profile`.riskIndex,0) as riskIndex,
					CAST(IFNULL(`profile`.initialInvestment,5000) as SIGNED) as initialInvestment,
					round(funct_get_actualCapital(`profile`.acctnum),0) as actualCapital,
					IFNULL(`profile`.keepLiquid,0) as keepLiquid,
					IFNULL(`profile`.recurringInvestment,0) as recurringInvestment,
					IFNULL(`profile`.longTermGoal,0) as longTermGoal,
					IFNULL(`profile`.stayInvested,0) as stayInvested,
					`profile`.`taxable`,
					IFNULL(`profile`.calcModel,'A') as calcModel,
					IFNULL(`profile`.assetIndex,0) as assetIndex,
					IFNULL(`profile`.portfolioIndex,0) as portfolioIndex,
					IFNULL(`acct_financial`.`dependent`,0) as dependent,
					DATE_FORMAT(`profile`.created,'%Y%m%d') as dateOpened,

							IFNULL(`acct_financial`.`householdwages`,0) as householdwages,
							IFNULL(`acct_financial`.`householdPayment`,0) as householdPayment,
							IFNULL(`acct_financial`.`miscExpenses`,0) as miscExpenses,
							IFNULL(`acct_financial`.`moneyMarket`,0) as moneyMarket,
							IFNULL(`acct_financial`.`investment`,0) as investment,
							IFNULL(`acct_financial`.`otherDebt`,0) as otherDebt,

					IFNULL(`acct_financial`.`totalIncomeAnnulized`,0) as totalIncomeAnnulized,
					IFNULL(`acct_financial`.`totalExpenseAnnulized`,0) as totalExpenseAnnulized,
					IFNULL(`acct_financial`.`totalAsset`,0) as totalAsset,
					IFNULL(`acct_financial`.`totalDebt`,0) as totalDebt,
					IFNULL(`acct_financial`.`liquidnetworth`,0) as liquidnetworth,
					IFNULL(`acct_financial`.`networth`,0) as networth,
					IFNULL(`user_risk_questions`.`ans1`,0) AS ans1,
					IFNULL(`user_risk_questions`.`ans2`,0) AS ans2,
					IFNULL(`user_risk_questions`.`ans3`,0) AS ans3,
					IFNULL(`user_risk_questions`.`ans4`,0) AS ans4,
					IFNULL(`user_risk_questions`.`ans5`,0) AS ans5,
					IFNULL(`user_risk_questions`.`ans6`,0) AS ans6,
					IFNULL(`user_risk_questions`.`ans7`,0) AS ans7,
					IFNULL(`user_risk_questions`.`ans8`,0) AS ans8,
					IFNULL(`user_risk_questions`.`ans9`,0) AS ans9,
					IFNULL(`user_risk_questions`.`ans10`,0) AS ans10,
					IFNULL(`user_risk_questions`.`ans11`,0) AS ans11,
					IFNULL(`user_risk_questions`.`ans12`,0) AS ans12,
					IFNULL(`user_risk_questions`.`ans13`,0) AS ans13,
					IFNULL(`user_risk_questions`.`ans14`,0) AS ans14,
					IFNULL(`user_risk_questions`.`ans15`,0) AS ans15,
					IFNULL(`profile`.goalAmount,0) as goalDesired,
					DATE_FORMAT(`profile`.created,'%Y-%m-%d') as created
					
					from
						user_logon,
						user_access_role,
						`user_trade_profile` `profile`
						left join `acct_financial`
						On ( `profile`.acctnum = `acct_financial`.acctnum)
						left join `user_risk_questions`
						On (`profile`.acctnum = `user_risk_questions`.acctnum)
						left join `ext_acct_info` ext_acct_info
						On (ext_acct_info.acctnum = `profile`.acctnum)
					where
						user_logon.logonid = user_access_role.logonid
					and user_access_role.acctnum = `profile`.acctnum
					and user_access_role.role in ('OWNER', 'USER')
					and user_logon.logonid = p_logonid
					order by `profile`.created desc
					;
			END IF;
        ELSE
			IF (singleAcct)
				THEN
					select 
					user_logon.logonid,
					`profile`.acctnum,
                    `profile`.managed,
					IFNULL(`profile`.firstname, user_logon.firstname) as `firstname`,
					IFNULL(`profile`.lastname, user_logon.lastname) as `lastname`,
					`profile`.portfolioName,
					IFNULL(`profile`.email, user_logon.email) as `email`,
					user_logon.userid,
					`profile`.advisor,
					`profile`.rep,
					`profile`.theme,
					user_logon.lastname,
					user_logon.firstname,
					user_logon.stateRegistered as state,
					ext_acct_info.clientAccountID as clientAccountID,
					CASE WHEN (IFNULL(`profile`.`status`,'V') in ('V')) THEN 'Visitor'
						 WHEN (upper(`profile`.`status`) = 'N') THEN 'Pending'
						 WHEN (upper(`profile`.`status`) = 'P') THEN 'Processed'
						 WHEN (upper(`profile`.`status`) = 'O') THEN 'Opened'
						 WHEN (upper(`profile`.`status`) is not null) THEN 'Active'
						 ELSE 'Visitor'
					END as `status`,
					CASE WHEN (IFNULL(`profile`.`managed`,'N') in ('N')) THEN 'Pending'
						 WHEN (upper(`profile`.`managed`) in ('A')) THEN 'Active'
						 ELSE 'Pending'
					END as acctStatus,
					`profile`.tradePreference,
					IFNULL(`profile`.goal,'Retirement') as goal,
					(case when (ext_acct_info.accountType is not null )
                    then ext_acct_info.accountType else
					IFNULL(`profile`.`acctType`,'IRA') end) as accttype,
					IFNULL(`profile`.age,30) as age,
					IFNULL(`profile`.horizon,30) as horizon,
					round(datediff(now(),IFNULL(`profile`.created,now()))/364,0) as yearnum,
					IFNULL(`profile`.riskIndex,0) as riskIndex,
					CAST(IFNULL(`profile`.initialInvestment,5000) as SIGNED) as initialInvestment,
					round(funct_get_actualCapital(`profile`.acctnum),0) as actualCapital,
					IFNULL(`profile`.keepLiquid,0) as keepLiquid,
					IFNULL(`profile`.recurringInvestment,0) as recurringInvestment,
					IFNULL(`profile`.longTermGoal,0) as longTermGoal,
					IFNULL(`profile`.stayInvested,0) as stayInvested,
					`profile`.`taxable`,
					IFNULL(`profile`.calcModel,'A') as calcModel,
					IFNULL(`profile`.assetIndex,0) as assetIndex,
					IFNULL(`profile`.portfolioIndex,0) as portfolioIndex,
					IFNULL(`acct_financial`.`dependent`,0) as dependent,
					DATE_FORMAT(`profile`.created,'%Y%m%d') as dateOpened,

						IFNULL(`acct_financial`.`householdwages`,0) as householdwages,
						IFNULL(`acct_financial`.`householdPayment`,0) as householdPayment,
						IFNULL(`acct_financial`.`miscExpenses`,0) as miscExpenses,
						IFNULL(`acct_financial`.`moneyMarket`,0) as moneyMarket,
						IFNULL(`acct_financial`.`investment`,0) as investment,
						IFNULL(`acct_financial`.`otherDebt`,0) as otherDebt,

					IFNULL(`acct_financial`.`totalIncomeAnnulized`,0) as totalIncomeAnnulized,
					IFNULL(`acct_financial`.`totalExpenseAnnulized`,0) as totalExpenseAnnulized,
					IFNULL(`acct_financial`.`totalAsset`,0) as totalAsset,
					IFNULL(`acct_financial`.`totalDebt`,0) as totalDebt,
					IFNULL(`acct_financial`.`liquidnetworth`,0) as liquidnetworth,
					IFNULL(`acct_financial`.`networth`,0) as networth,
					IFNULL(`user_risk_questions`.`ans1`,0) AS ans1,
					IFNULL(`user_risk_questions`.`ans2`,0) AS ans2,
					IFNULL(`user_risk_questions`.`ans3`,0) AS ans3,
					IFNULL(`user_risk_questions`.`ans4`,0) AS ans4,
					IFNULL(`user_risk_questions`.`ans5`,0) AS ans5,
					IFNULL(`user_risk_questions`.`ans6`,0) AS ans6,
					IFNULL(`user_risk_questions`.`ans7`,0) AS ans7,
					IFNULL(`user_risk_questions`.`ans8`,0) AS ans8,
					IFNULL(`user_risk_questions`.`ans9`,0) AS ans9,
					IFNULL(`user_risk_questions`.`ans10`,0) AS ans10,
					IFNULL(`user_risk_questions`.`ans11`,0) AS ans11,
					IFNULL(`user_risk_questions`.`ans12`,0) AS ans12,
					IFNULL(`user_risk_questions`.`ans13`,0) AS ans13,
					IFNULL(`user_risk_questions`.`ans14`,0) AS ans14,
					IFNULL(`user_risk_questions`.`ans15`,0) AS ans15,
					IFNULL(`profile`.goalAmount,0) as goalDesired,
					DATE_FORMAT(`profile`.created,'%Y-%m-%d') as created
					
					from
						`user_trade_profile` `profile`
						left join user_access_role
						ON (user_access_role.acctnum = `profile`.acctnum
						AND user_access_role.role = 'OWNER' )
						left join user_logon
						ON (user_logon.logonid = user_access_role.logonid)
						left join `acct_financial`
						On ( `profile`.acctnum = `acct_financial`.acctnum)
						left join `user_risk_questions`
						On (`profile`.acctnum = `user_risk_questions`.acctnum)
						left join `ext_acct_info` ext_acct_info
						On (ext_acct_info.acctnum = `profile`.acctnum)
					where
						IFNULL(`profile`.advisor,'Invessence') like tAdvisor
					and IFNULL(`profile`.rep,'000') like tRep
					and `profile`.acctnum = p_acctnum
					order by `profile`.created desc
					;
                ELSE
					select 
					user_logon.logonid,
					`profile`.acctnum,
                    `profile`.managed,
					IFNULL(`profile`.firstname, user_logon.firstname) as `firstname`,
					IFNULL(`profile`.lastname, user_logon.lastname) as `lastname`,
					`profile`.portfolioName,
					IFNULL(`profile`.email, user_logon.email) as `email`,
					user_logon.userid,
					`profile`.advisor,
					`profile`.rep,
					`profile`.theme,
					user_logon.lastname,
					user_logon.firstname,
					user_logon.stateRegistered as state,
					ext_acct_info.clientAccountID as clientAccountID,
					CASE WHEN (IFNULL(`profile`.`status`,'V') in ('V')) THEN 'Visitor'
						 WHEN (upper(`profile`.`status`) = 'N') THEN 'Pending'
						 WHEN (upper(`profile`.`status`) = 'P') THEN 'Processed'
						 WHEN (upper(`profile`.`status`) = 'O') THEN 'Opened'
						 WHEN (upper(`profile`.`status`) is not null) THEN 'Active'
						 ELSE 'Visitor'
					END as `status`,
					CASE WHEN (IFNULL(`profile`.`managed`,'N') in ('N')) THEN 'Pending'
						 WHEN (upper(`profile`.`managed`) in ('A')) THEN 'Active'
						 ELSE 'Pending'
					END as acctStatus,
					`profile`.tradePreference,
					IFNULL(`profile`.goal,'Retirement') as goal,
					 (case when (ext_acct_info.accountType is not null )
                    then ext_acct_info.accountType else
					IFNULL(`profile`.`acctType`,'IRA') end) as accttype,
					IFNULL(`profile`.age,30) as age,
					IFNULL(`profile`.horizon,30) as horizon,
					round(datediff(now(),IFNULL(`profile`.created,now()))/364,0) as yearnum,
					IFNULL(`profile`.riskIndex,0) as riskIndex,
					CAST(IFNULL(`profile`.initialInvestment,5000) as SIGNED) as initialInvestment,
					round(funct_get_actualCapital(`profile`.acctnum),0) as actualCapital,
					IFNULL(`profile`.keepLiquid,0) as keepLiquid,
					IFNULL(`profile`.recurringInvestment,0) as recurringInvestment,
					IFNULL(`profile`.longTermGoal,0) as longTermGoal,
					IFNULL(`profile`.stayInvested,0) as stayInvested,
					`profile`.`taxable`,
					IFNULL(`profile`.calcModel,'A') as calcModel,
					IFNULL(`profile`.assetIndex,0) as assetIndex,
					IFNULL(`profile`.portfolioIndex,0) as portfolioIndex,
					IFNULL(`acct_financial`.`dependent`,0) as dependent,
					DATE_FORMAT(`profile`.created,'%Y%m%d') as dateOpened,

						IFNULL(`acct_financial`.`householdwages`,0) as householdwages,
						IFNULL(`acct_financial`.`householdPayment`,0) as householdPayment,
						IFNULL(`acct_financial`.`miscExpenses`,0) as miscExpenses,
						IFNULL(`acct_financial`.`moneyMarket`,0) as moneyMarket,
						IFNULL(`acct_financial`.`investment`,0) as investment,
						IFNULL(`acct_financial`.`otherDebt`,0) as otherDebt,

					IFNULL(`acct_financial`.`totalIncomeAnnulized`,0) as totalIncomeAnnulized,
					IFNULL(`acct_financial`.`totalExpenseAnnulized`,0) as totalExpenseAnnulized,
					IFNULL(`acct_financial`.`totalAsset`,0) as totalAsset,
					IFNULL(`acct_financial`.`totalDebt`,0) as totalDebt,
					IFNULL(`acct_financial`.`liquidnetworth`,0) as liquidnetworth,
					IFNULL(`acct_financial`.`networth`,0) as networth,
					IFNULL(`user_risk_questions`.`ans1`,0) AS ans1,
					IFNULL(`user_risk_questions`.`ans2`,0) AS ans2,
					IFNULL(`user_risk_questions`.`ans3`,0) AS ans3,
					IFNULL(`user_risk_questions`.`ans4`,0) AS ans4,
					IFNULL(`user_risk_questions`.`ans5`,0) AS ans5,
					IFNULL(`user_risk_questions`.`ans6`,0) AS ans6,
					IFNULL(`user_risk_questions`.`ans7`,0) AS ans7,
					IFNULL(`user_risk_questions`.`ans8`,0) AS ans8,
					IFNULL(`user_risk_questions`.`ans9`,0) AS ans9,
					IFNULL(`user_risk_questions`.`ans10`,0) AS ans10,
					IFNULL(`user_risk_questions`.`ans11`,0) AS ans11,
					IFNULL(`user_risk_questions`.`ans12`,0) AS ans12,
					IFNULL(`user_risk_questions`.`ans13`,0) AS ans13,
					IFNULL(`user_risk_questions`.`ans14`,0) AS ans14,
					IFNULL(`user_risk_questions`.`ans15`,0) AS ans15,
					IFNULL(`profile`.goalAmount,0) as goalDesired,
					DATE_FORMAT(`profile`.created,'%Y-%m-%d') as created
					
					from
						`user_trade_profile` `profile`
						left join user_access_role
						ON (user_access_role.acctnum = `profile`.acctnum
						AND user_access_role.role = 'OWNER' )
						left join user_logon
						ON (user_logon.logonid = user_access_role.logonid)
						left join `acct_financial`
						On ( `profile`.acctnum = `acct_financial`.acctnum)
						left join `user_risk_questions`
						On (`profile`.acctnum = `user_risk_questions`.acctnum)
						left join `ext_acct_info` ext_acct_info
						On (ext_acct_info.acctnum = `profile`.acctnum)
					where
						IFNULL(`profile`.advisor,'Invessence') like tAdvisor
					and IFNULL(`profile`.rep,'000') like tRep
                    AND (IFNULL(`profile`.`created`,now()) >= DATE_ADD(now(),INTERVAL p_days DAY)
					AND `ext_acct_info`.`acctnum` is null)
					order by `profile`.created desc
					;
			END IF;
	END IF;
  END$$
DELIMITER ;
