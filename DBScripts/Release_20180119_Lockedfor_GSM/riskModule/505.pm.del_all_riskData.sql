DROP PROCEDURE IF EXISTS `invdb`.`del_all_riskData`;
DROP PROCEDURE IF EXISTS `invdb`.`del_user_risk_profile`;


DELIMITER $$
CREATE PROCEDURE `invdb`.`del_user_risk_profile`(
    p_acctnum	BIGINT(20)
)
BEGIN

	DELETE 
	FROM `invdb`.`user_risk_profile`
    WHERE `acctnum` = p_acctnum
    ;
    
    

END $$
DELIMITER ;