DROP PROCEDURE IF EXISTS `invdb`.`sel_user_risk_score`;


DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_user_risk_score`(
    p_acctnum	BIGINT(20)
)
BEGIN

	SELECT 
		`user_risk_score`.`acctnum`,
		`user_risk_score`.`year`,
        `user_risk_score`.`calcFormula`,	
        `user_risk_score`.`allCashFlag`,
		`user_risk_score`.`score`,
		`user_risk_score`.`standardScore`,
		`user_risk_score`.`assetScore`,
		`user_risk_score`.`portfolioScore`,
		`user_risk_score`.`adjustment`
	FROM `invdb`.`user_risk_score`
    WHERE `user_risk_score`.`acctnum` = p_acctnum
    order by 1,2
    ;

END $$
DELIMITER ;