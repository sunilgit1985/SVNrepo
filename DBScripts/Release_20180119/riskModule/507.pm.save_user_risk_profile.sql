DROP PROCEDURE IF EXISTS `invdb`.`save_user_risk_profile`;


DELIMITER $$
CREATE PROCEDURE `invdb`.`save_user_risk_profile`(
	 `p_acctnum`		BIGINT(20)
	,`p_key`   			VARCHAR(30)
    ,`p_sortorder` 		INTEGER	
    ,`p_ans`			VARCHAR(30)
	,`p_answerType`		VARCHAR(1)
	,`p_riskScore`		DOUBLE
)
BEGIN

	

	INSERT INTO `invdb`.`user_risk_profile`
	(
		`acctnum`,
		`key`,
		`sortorder`,
		`answer`,
		`answerType`,
		`riskScore`,
		`created`,
		`lastUpdated`
    )
	VALUES
	(
		 `p_acctnum`
		,`p_key`
		,`p_sortorder`	
		,`p_ans`
		,`p_answerType`
		,`p_riskScore`
		,CURRENT_DATE()
		,NULL
	)
    ON DUPLICATE KEY UPDATE
		`sortorder` = `p_sortorder`,
		`answer` = `p_ans`,
		`answerType` = `p_answerType`,
		`riskScore` = `p_riskScore`,    
        `lastUpdated` = CURRENT_DATE()
    ;

END $$
DELIMITER ;