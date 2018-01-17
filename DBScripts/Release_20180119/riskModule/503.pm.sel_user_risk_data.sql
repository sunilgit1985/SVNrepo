DROP PROCEDURE IF EXISTS `invdb`.`sel_user_risk_profile`;


DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_user_risk_profile`(
    p_acctnum	BIGINT(20)
)
BEGIN

	SELECT 
		`user_risk_profile`.`acctnum`,
		`user_risk_profile`.`key`,
        `user_risk_profile`.`sortorder`,
		`user_risk_profile`.`answer`,
        `user_risk_profile`.`answerType`,
		`user_risk_profile`.`riskScore`
	FROM `invdb`.`user_risk_profile`
    WHERE `user_risk_profile`.`acctnum` = p_acctnum
    ;

END $$
DELIMITER ;