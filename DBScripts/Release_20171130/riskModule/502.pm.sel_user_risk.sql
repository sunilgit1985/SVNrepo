DROP PROCEDURE IF EXISTS `invdb`.`sel_user_risk_score`;


DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_user_risk_score`(
    p_acctnum	BIGINT(20)
)
BEGIN

	SELECT 
		`user_risks`.`acctnum`,
		`user_risks`.`year`,
        `user_risks`.`calcFormula`,	
        `user_risks`.`allCashFlag`,
		`user_risks`.`score`,
		`user_risks`.`standardScore`,
		`user_risks`.`assetScore`,
		`user_risks`.`portfolioScore`,
		`user_risks`.`adjustment`
	FROM `invdb`.`user_risks`
    WHERE `user_risks`.`acctnum` = p_acctnum
    order by 1,2
    ;

END $$
DELIMITER ;