DROP PROCEDURE IF EXISTS `invdb`.`sel_advisor_risk_mapping`;


DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_advisor_risk_mapping`(
	p_advisor VARCHAR(30)
)
BEGIN

	SELECT 
	  `advisor`
	  ,`riskQuestion`
	  ,`numOfWeights`
	  ,`knockoutQuestion`
	  ,`weight1`
	  ,`weight2`
	  ,`weight3`
	  ,`weight4`
	  ,`weight5`
	  ,`weight6`
	  ,`weight7`
	  ,`weight8`
	  ,`weight9`
	  ,`defaultWeight`
	FROM `invdb`.`advisor_risk_mapping`
	WHERE `advisor_risk_mapping`.`advisor` = `p_advisor`
    ORDER BY 1,2
	;

END $$
DELIMITER ;