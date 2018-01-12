DROP PROCEDURE IF EXISTS `invdb`.`save_user_risk_score`;


DELIMITER $$
CREATE PROCEDURE `invdb`.`save_user_risk_score`(
	 `p_acctnum`		BIGINT(20)
	,`p_year`   		INTEGER
    ,`p_calcFormula` 	VARCHAR(10)	
    ,`p_allCashFlag`	BOOLEAN
	,`p_score`			DOUBLE
	,`p_standardScore`	DOUBLE
	,`p_assetScore`		DOUBLE
	,`p_portfolioScore`	DOUBLE
	,`p_adjustment`		DOUBLE

)
BEGIN

	

	INSERT INTO `invdb`.`user_risk_score`
    (
		`acctnum`,
		`year`,
        `calcFormula`,	
        `allCashFlag`,
		`score`,
		`standardScore`,
		`assetScore`,
		`portfolioScore`,
		`adjustment`,
        `created`,
        `lastUpdated`
	)
    VALUES (
    	 `p_acctnum`
		,`p_year`
		,`p_calcFormula`
		,`p_allCashFlag`
		,`p_score`
		,`p_standardScore`
		,`p_assetScore`
		,`p_portfolioScore`
		,`p_adjustment`
		, CURRENT_DATE()
        , NULL
        )
    ON DUPLICATE KEY UPDATE
		`year` = `p_year`,
        `calcFormula` = `p_calcFormula`,	
        `allCashFlag` = `p_allCashFlag`,
		`score` = `p_score`,
		`standardScore` = `p_standardScore`,
		`assetScore` = `p_assetScore`,
		`portfolioScore` = `p_portfolioScore`,
		`adjustment` = `p_adjustment`,
        `lastUpdated` = CURRENT_DATE()
    ;

END $$
DELIMITER ;