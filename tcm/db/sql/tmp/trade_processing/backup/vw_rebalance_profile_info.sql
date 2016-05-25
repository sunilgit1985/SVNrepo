DROP VIEW IF EXISTS `vw_rebalance_profile_info`;

CREATE VIEW `vw_rebalance_profile_info`
as
		select 
			profile.acctnum,
			IB.IB_acctnum,
			IB.lastname,
			IB.firstname,
			IFNULL(profile.goal,0) as goal,
			profile.`acctType` as accttype,
			IFNULL(profile.age,30) as age,
			IFNULL(profile.horizon,0) as horizon,
			round(datediff(now(),IFNULL(profile.created,now()))/364,0) as yearnum,
			IFNULL(profile.riskIndex,0) as riskIndex,
			round(IFNULL(nav.total,IFNULL(profile.initialInvestment,0)),2) as initialInvestment,
			round(IFNULL(profile.recurringInvestment,0),2) as recurringInvestment,
			IFNULL(profile.longTermGoal,0) as longTermGoal,
			IFNULL(profile.stayInvested,0) as stayInvested,
			IFNULL(`acct_financial`.`dependent`,0) as dependent,
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
			profile.created,
			profile.lastUpdated
		from
			user_trade_profile profile,
			`IB_Accounts` IB,
			`acct_financial`,
			`user_risk_questions`,
			`nav_daily` nav
		where
			profile.acctnum in (select ri.acctnum from `rebalance_info` ri
								where ri.processStatus = 'P')
		and profile.acctnum = IB.acctnum
		and profile.acctnum = `acct_financial`.acctnum
		and profile.acctnum = `user_risk_questions`.acctnum
		and nav.clientAccountID = IB.IB_acctnum
		and nav.reportDate = (select value from invessence_switch where name = 'BROKER_BDATE')
		;
