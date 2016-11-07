DROP PROCEDURE IF EXISTS `invdb`.`sel_position`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_position`(
 	IN p_logonid  bigint(20),
 	IN p_acctnum  bigint(20)
)
BEGIN

	DECLARE tAdvisorType VARCHAR(25);
    DECLARE tfilterType   VARCHAR(1);

	SELECT 
    MIN(advisor)
	INTO tAdvisorType FROM
    user_advisor_info
	WHERE logonid = p_logonid;
        
	IF (tAdvisorType is NOT NULL)
		THEN set tfilterType = 'A';
		ELSE set tfilterType = 'O';  
	END IF;

	IF (tfilterType = 'O')
		THEN
			select
				 IFNULL(`sec_asset_master`.`sortorder`,9999) as `sortorder`
				,`ext_position`.`clientAccountID`
				,`ext_position`.`symbol`
				,`ext_position`.`reportDate`
				,`ext_position`.`side`
				,`ext_position`.`quantity` as `quantity`
				,`ext_position`.`costBasisPrice`
				,`ext_position`.`costBasisMoney` as `costBasisMoney`
				,`ext_position`.`markPrice`
				,`ext_position`.`positionValue` as `positionValue`
				, `ext_acct_info`.`acctnum`
                , IFNULL(`ext_acct_info`.`applicantFName`,`user_logon`.`firstname`) as firstname
                , IFNULL(`ext_acct_info`.`applicantLName`,`user_logon`.`lastname`) as lastname
				,`ext_acct_info`.`rep`
				,`ext_acct_info`.`dateOpened`
				,`sec_master`.`name` as `description`
				,`sec_master`.`assetclass`
				,`sec_master`.`subclass`
                ,`sec_asset_master`.`assetcolor` as color
                ,`user_trade_profile`.`theme`
				,`user_trade_profile`.`portfolioName` as accountAlias
			FROM `ext_position`
				 INNER JOIN `ext_acct_info`
				 ON (`ext_position`.`clientAccountID` = `ext_acct_info`.`clientAccountID`)
				 INNER JOIN `user_trade_profile`
				 ON (`ext_acct_info`.`acctnum` = `user_trade_profile`.`acctnum`)
				 INNER JOIN `user_access_role`
				 ON (`ext_acct_info`.`acctnum` = `user_access_role`.`acctnum`
				 AND  `user_access_role`.`role` in ('OWNER', 'USER'))
				 INNER JOIN `user_logon`
				 ON (`user_access_role`.`logonid` = `user_logon`.`logonid`)
				 LEFT JOIN `sec_master`
				 ON (`ext_position`.`symbol`= `sec_master`.`ticker`)
				 LEFT JOIN `sec_asset_master`
				 ON (`sec_master`.`assetclass`= `sec_asset_master`.`assetclass`
				 AND `sec_asset_master`.`theme` = `user_trade_profile`.`theme`)
			WHERE `ext_acct_info`.`acctnum` = p_acctnum
			AND   `user_logon`.`logonid`    = p_logonid
			AND   `ext_position`.`reportDate` = ( select max(`pos`.`reportDate`) from `ext_position` `pos`)
			ORDER BY 1, `sec_master`.`assetclass`, `ext_position`.`symbol`
			;
        ELSE
			select
				 IFNULL(`sec_asset_master`.`sortorder`,9999) as `sortorder`
				,`ext_position`.`clientAccountID`
				,`ext_position`.`symbol`
				,`ext_position`.`reportDate`
				,`ext_position`.`side`
				,`ext_position`.`quantity` as `quantity`
				,`ext_position`.`costBasisPrice`
				,`ext_position`.`costBasisMoney` as `costBasisMoney`
				,`ext_position`.`markPrice`
				,`ext_position`.`positionValue` as `positionValue`
                ,`ext_position`.`pnlUnrealized` as fifoPnlUnrealized
				, `ext_acct_info`.`acctnum`
                , IFNULL(`ext_acct_info`.`applicantFName`,`user_logon`.`firstname`) as firstname
                , IFNULL(`ext_acct_info`.`applicantLName`,`user_logon`.`lastname`) as lastname
				,`ext_acct_info`.`rep`
				,`ext_acct_info`.`dateOpened`
				,`sec_master`.`name` as `description`
				,`sec_master`.`assetclass`
				,`sec_master`.`subclass`
                ,`sec_asset_master`.`assetcolor` as color
                ,`user_trade_profile`.`theme`
				,`user_trade_profile`.`portfolioName` as accountAlias
		FROM `ext_position`
				 INNER JOIN `ext_acct_info`
				 ON (`ext_position`.`clientAccountID` = `ext_acct_info`.`clientAccountID`)
				 INNER JOIN `user_trade_profile`
				 ON (`ext_acct_info`.`acctnum` = `user_trade_profile`.`acctnum`)
				 INNER JOIN `user_access_role`
				 ON (`ext_acct_info`.`acctnum` = `user_access_role`.`acctnum`
				 AND  `user_access_role`.`role` in ('OWNER'))
				 INNER JOIN `user_logon`
				 ON (`user_access_role`.`logonid` = `user_logon`.`logonid`)
				 LEFT JOIN `sec_master`
				 ON (`ext_position`.`symbol`= `sec_master`.`ticker`)
				 LEFT JOIN `sec_asset_master`
				 ON (`sec_master`.`assetclass`= `sec_asset_master`.`assetclass`
				 AND `sec_asset_master`.`theme` = `user_trade_profile`.`theme`)
			WHERE `ext_acct_info`.`acctnum` = p_acctnum
			AND   `user_logon`.`advisor` = tAdvisorType
			AND   `ext_position`.`reportDate` = ( select max(`pos`.`reportDate`) from `ext_position` `pos`)
			ORDER BY 1, `sec_master`.`assetclass`, `ext_position`.`symbol`
			;
	END IF;



END$$
DELIMITER ;