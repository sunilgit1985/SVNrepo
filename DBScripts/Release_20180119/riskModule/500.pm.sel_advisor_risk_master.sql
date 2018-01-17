DROP PROCEDURE IF EXISTS `invdb`.`sel_advisor_risk_master`;


DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_advisor_risk_master`(
	p_advisor VARCHAR(30)
)
BEGIN

	SELECT 
		`advisor_risk_master`.`advisor`,
		`advisor_risk_master`.`sortorder`,
		`advisor_risk_master`.`key`,
		`advisor_risk_master`.`defaultValue`,
		`advisor_risk_master`.`dataType`,
		`advisor_risk_master`.`displayOnStart`,
        `advisor_risk_master`.`saveforUser`
	FROM `invdb`.`advisor_risk_master`
	WHERE `advisor_risk_master`.`advisor` = `p_advisor`
	;

END $$
DELIMITER ;

