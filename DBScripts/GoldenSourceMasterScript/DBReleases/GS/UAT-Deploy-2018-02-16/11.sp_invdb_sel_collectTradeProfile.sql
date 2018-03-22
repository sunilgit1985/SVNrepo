USE `invdb`;
DROP procedure IF EXISTS `sel_collectTradeProfile`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sel_collectTradeProfile`(
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
 			trade_process_identifier.acctnum,
             ext_acct_info.clientAccountID,
             ext_acct_info.applicantFName,
             ext_acct_info.applicantLName,
             ext_acct_info.fullname,
 			trade_process_identifier.tradeStatus,
 			trade_process_identifier.processStatus,
 			trade_process_identifier.reason,
             SUM(ext_nav.cash * ext_nav.exchangeRate) as cash,
             SUM((ext_nav.stock * ext_nav.exchangeRate) + (ext_nav.funds * ext_nav.exchangeRate)) +
             SUM((ext_nav.interestAccrual* ext_nav.exchangeRate) + (ext_nav.dividentAccrual* ext_nav.exchangeRate)) as investment,
             user_trade_profile.advisor,
             IFNULL(user_basket_access.displayname,user_trade_profile.theme) as theme,
             user_trade_profile.acctType,
             SUM(ext_nav.total * ext_nav.exchangeRate)  as totalInvestment,
             user_trade_profile.keepLiquid,
             user_trade_profile.longTermGoal,
             user_trade_profile.stayInvested,
 			user_trade_profile.calcModel,
             user_trade_profile.riskIndex,
             user_trade_profile.assetIndex,
             user_trade_profile.portfolioIndex,
             user_trade_profile.age,
             user_trade_profile.horizon,
 			user_trade_profile.taxable
             , max(date_format(user_trade_log.tradedate,'%Y-%m-%d')) as lastTraded             
 		FROM trade_process_identifier
         INNER JOIN user_trade_profile
         ON (user_trade_profile.acctnum = trade_process_identifier.acctnum)
         INNER JOIN ext_acct_info
         ON (ext_acct_info.acctnum = trade_process_identifier.acctnum
 			AND ext_acct_info.status in ('A'))
 		INNER JOIN ext_nav
         ON (ext_nav.clientAccountID = ext_acct_info.clientAccountID
         AND ext_nav.reportDate = FUNCT_GET_SWITCH('BROKER_BDATE'))
         LEFT JOIN user_trade_log
         ON (user_trade_log.acctnum = trade_process_identifier.acctnum)
         LEFT JOIN user_basket_access
         ON (user_trade_profile.theme = user_basket_access.theme)
         WHERE IFNULL(trade_process_identifier.processStatus,'N') like p_filter
         AND   lower(IFNULL(user_trade_profile.advisor,'Invessence')) like lower(tAdvisor)
         AND (user_trade_profile.status ='A' or user_trade_profile.status ='R')
         GROUP BY
 			trade_process_identifier.acctnum,
             ext_acct_info.clientAccountID,
             ext_acct_info.applicantFName,
             ext_acct_info.applicantLName,
             ext_acct_info.fullname,
 			trade_process_identifier.tradeStatus,
 			trade_process_identifier.processStatus,
 			trade_process_identifier.reason,
             user_trade_profile.advisor,
             IFNULL(user_basket_access.displayname,user_trade_profile.theme),
             user_trade_profile.acctType,
             user_trade_profile.keepLiquid,
             user_trade_profile.longTermGoal,
             user_trade_profile.stayInvested,
 			user_trade_profile.calcModel,
             user_trade_profile.riskIndex,
             user_trade_profile.assetIndex,
             user_trade_profile.portfolioIndex,
             user_trade_profile.age,
             user_trade_profile.horizon,
 			user_trade_profile.taxable
     	;
 
     end;
 END$$

DELIMITER ;

