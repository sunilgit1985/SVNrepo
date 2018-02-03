DROP PROCEDURE IF EXISTS `invdb`.`sel_user_risk_profile`;


DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_user_risk_profile`(
    p_acctnum	BIGINT(20)
)
BEGIN

	SELECT 
		`user_risk_data`.`acctnum`,
		`user_risk_data`.`key`,
        `user_risk_data`.`sortorder`,
		`user_risk_data`.`answer`,
        `user_risk_data`.`answerType`,
		`user_risk_data`.`riskScore`
	FROM `invdb`.`user_risk_profile`
    WHERE `user_risk_data`.`acctnum` = p_acctnum
    ;

END $$
DELIMITER ;