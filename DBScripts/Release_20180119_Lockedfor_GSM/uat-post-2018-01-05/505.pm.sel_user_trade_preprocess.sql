DROP PROCEDURE IF EXISTS `invdb`.`sel_user_trade_preprocess`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_user_trade_preprocess`(
	p_acctnum BIGINT(20)
)
BEGIN
	IF (p_acctnum is not null)
		then
			begin
            
				SELECT 
					 IFNULL(`sec_asset_mapping`.`assetsortorder`*10000+`sec_asset_mapping`.`subclasssortorder`,999999999) as `sortorder`,
					 IFNULL(TRIM(`user_trade_preprocess`.`holdingTicker`),`user_trade_preprocess`.`newTicker`) as `sortTicker`,					
					`user_trade_preprocess`.`curQty` as `sortQty`,
					`user_trade_preprocess`.`advisor`,
					`user_trade_preprocess`.`clientAccountID`,
					`user_trade_preprocess`.`acctnum`,
					`user_trade_preprocess`.`processed`,
					`user_trade_preprocess`.`tradeDate`,
					`user_trade_preprocess`.`tradeCurrency`,
					IFNULL(`sec_asset_mapping`.`assetName`,`user_trade_preprocess`.`assetclass`) as `assetclass`,
					IFNULL(`sec_asset_mapping`.`subclassName`,`user_trade_preprocess`.`subclass`) as `subclass`,
					IFNULL(`sec_asset_mapping`.`assetcolor`,`user_trade_preprocess`.`color`) as `assetcolor`,
                    `user_trade_preprocess`.`holdingTicker`,
					`user_trade_preprocess`.`curQty`,
					`user_trade_preprocess`.`curPrice`,
					`user_trade_preprocess`.`curValue`,
					`user_trade_preprocess`.`newTicker`,
					`user_trade_preprocess`.`newQty`,
					`user_trade_preprocess`.`newPrice`,
					`user_trade_preprocess`.`newValue`,
					`user_trade_preprocess`.`exchangeRate`,
					`user_trade_preprocess`.`settleCurrency`,
					`user_trade_preprocess`.`settleQty`,
					`user_trade_preprocess`.`settlePrice`,
					`user_trade_preprocess`.`settleValue`,
					`user_trade_preprocess`.`settleNewQty`,
					`user_trade_preprocess`.`settleNewPrice`,
					`user_trade_preprocess`.`settleNewValue`,
					`user_trade_preprocess`.`tradetype`,
					`user_trade_preprocess`.`reason`,
                    `sec_master`.`name`,
					`ext_acct_info`.`applicantLName` as `lastName`,
					`ext_acct_info`.`applicantFName` as `firstName`,
					`ext_acct_info`.`fullname` as `fullname`,
					`user_trade_profile`.`taxable`,
					`user_trade_profile`.`goal`
				FROM `user_trade_preprocess`
				INNER JOIN `user_trade_profile` 
					ON (`user_trade_preprocess`.`acctnum` = `user_trade_profile`.`acctnum`)
				INNER JOIN `ext_acct_info`
					ON (`user_trade_preprocess`.`acctnum` = `ext_acct_info`.`acctnum`)
 				LEFT JOIN `sec_master`
					ON (`user_trade_preprocess`.`newTicker` = `sec_master`.`ticker`)
 				LEFT JOIN `sec_asset_mapping`
 					ON (`user_trade_preprocess`.`newTicker` = `sec_asset_mapping`.`ticker`
 					AND `user_trade_profile`.`theme` = `sec_asset_mapping`.`theme`)
				WHERE `user_trade_preprocess`.`processed` = 'N'
				AND  `user_trade_preprocess`.`acctnum` = p_acctnum
				ORDER BY 1,2,3
                ;
			end;
	END IF;
END$$
DELIMITER ;
