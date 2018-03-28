
/* 101.pm.advisor_risk_mapping.sql170118_pmehta*/

DROP TABLE IF EXISTS `invdb`.`advisor_risk_mapping`;

CREATE TABLE `invdb`.`advisor_risk_mapping` (
  `advisor` 		varchar(20) NOT NULL,
  `riskQuestion` 	tinyint(3) DEFAULT NULL,
  `numOfWeights`    tinyint(3) DEFAULT NULL,
  `knockoutQuestion` tinyint(3) DEFAULT NULL,
  `weight1`    		tinyint(3) DEFAULT NULL,
  `weight2`    		tinyint(3) DEFAULT NULL,
  `weight3`    		tinyint(3) DEFAULT NULL,
  `weight4`    		tinyint(3) DEFAULT NULL,
  `weight5`    		tinyint(3) DEFAULT NULL,
  `weight6`    		tinyint(3) DEFAULT NULL,
  `weight7`    		tinyint(3) DEFAULT NULL,
  `weight8`    		tinyint(3) DEFAULT NULL,
  `weight9`    		tinyint(3) DEFAULT NULL,
  `defaultWeight`   Double DEFAULT NULL,
  `created` 		date DEFAULT NULL,
  `lastUpdated` 	date DEFAULT NULL,
  PRIMARY KEY `PK1_advisor_risk_mapping` (`advisor`,`riskQuestion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELETE FROM `invdb`.`advisor_risk_mapping`;
-- Question#1 is used for Legecy
INSERT INTO `invdb`.`advisor_risk_mapping`
(`advisor`,`riskQuestion`,`numOfWeights`,`knockoutQuestion`,`weight1`,`weight2`,`weight3`,`weight4`,`weight5`,`weight6`,`weight7`,`weight8`,`weight9`,`defaultWeight`,`created`)
VALUES
 ('UOB',1, 4, 4, 0, 30, 70, 0, 0, 0, 0, 0, 0, 0.0, current_date())
,('UOB',2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.0, current_date())
,('UOB',3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.0, current_date())
,('UOB',4, 4, 4, 0, 30, 70, 0, 0, 0, 0, 0, 0, 0.0, current_date())
,('UOB',5, 4, 4, 0, 30, 70, 0, 0, 0, 0, 0, 0, 0.0, current_date())
,('UOB',6, 4, 0, 0, 20, 50, 75, 0, 0, 0, 0, 0, 0.0, current_date())
,('UOB',7, 3, 0, 30, 70, 0, 0, 0, 0, 0, 0, 0, 0.0, current_date())
,('UOB',8, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.0, current_date())
;

/* 102.pm.user_risk_profile.sql170118_pmehta*/

DROP TABLE IF EXISTS `invdb`.`user_risk_profile`;

CREATE TABLE `invdb`.`user_risk_profile` (
  `acctnum` 	bigint(20) NOT NULL,
  `key` 		varchar(30) DEFAULT NULL,
  `sortorder`	INTEGER,
  `answer`    	varchar(30) DEFAULT NULL,
  `answerType`  varchar(1) DEFAULT 'T',
  `riskScore`   Double DEFAULT NULL,
  `created` date DEFAULT NULL,
  `lastUpdated` date DEFAULT NULL,
  PRIMARY KEY `PK1_user_risk_data` (`acctnum`,`key`),
  KEY `AK1_user_risk_data` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `invdb`.`user_risk_score`;

CREATE TABLE `invdb`.`user_risk_score` (
  `acctnum` 		bigint(20) NOT NULL,
  `year` 			Integer NOT NULL,
  `calcFormula`		VARCHAR(1) DEFAULT 'C',
  `allCashFlag`		Boolean DEFAULT False,
  `score`    		Double NOT NULL,
  `standardScore`   Double NOT NULL,
  `assetScore`   	Double DEFAULT NULL,
  `portfolioScore`  Double DEFAULT NULL,
  `adjustment`  	Double DEFAULT NULL,
  `created` 		date DEFAULT NULL,
  `lastUpdated` 	date DEFAULT NULL,
  PRIMARY KEY `PK1_user_risks` (`acctnum`,`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* 502.pm.sel_user_risk.sql170118_pmehta*/

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

/* 503.pm.sel_user_risk_data.sql170118_pmehta*/

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

/* 504.pm.sel_advisor_risk_mapping.sql170118_pmehta*/

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


/* 505.pm.del_all_riskData.sql170118_pmehta*/

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

/* 506.pm.save_user_risk_scores.sql170118_pmehta*/

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

/* 507.pm.save_user_risk_profile.sql170118_pmehta*/

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

/* Sampledata user_risk_score.sql170118_pmehta*/

INSERT INTO `invdb`.`user_risk_score`
(`acctnum`,`year`,`calcFormula`,`allCashFlag`,`score`,`standardScore`,`assetScore`,`portfolioScore`,`adjustment`,`created`)
VALUES 
 ('1', '0', 'C', False, '50', '50', '50', '50', '0', now())
,('1', '1', 'C', False, '49', '49', '49', '49', '0', now())
,('2', '0', 'C', False, '80', '50', '80', '80', '0', now())
;



/* 100.pm.advisor_risk_master.sql030218_pmehta*/

DROP TABLE IF EXISTS `invdb`.`advisor_risk_master`;

CREATE TABLE `invdb`.`advisor_risk_master` (
  `advisor` 		varchar(20) NOT NULL,
  `sortorder`		Integer DEFAULT 1,
  `key` 			varchar(30) DEFAULT NULL,
  `displayName`		varchar(60) DEFAULT NULL,
  `defaultValue`    varchar(30) DEFAULT NULL,
  `dataType`		varchar(1)	DEFAULT "T",
  `displayOnStart`  varchar(30) DEFAULT 0,
  `displayAdvisor`  Boolean DEFAULT false,
  `saveforUser`  	Boolean DEFAULT false,
  `created` 		date DEFAULT NULL,
  `lastUpdated` 	date DEFAULT NULL,
  PRIMARY KEY `PK1_advisor_risk_master` (`advisor`,`sortorder`, `key`),
  KEY `AK1_advisor_risk_master` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELETE FROM `invdb`.`advisor_risk_master` ;

INSERT INTO `invdb`.`advisor_risk_master` (`advisor`, `sortorder`,`key`, `displayName`, `defaultValue`,`dataType`
, `displayOnStart`,`displayAdvisor`,`saveforUser`) 
VALUES 
 ('UOB', 10, 'RISKQUESTIONS', null, '8','I','0',false,true)
,('UOB', 15, 'THEME', 'Investment Model','8.UOB','T','0',true,true)
,('UOB', 20, 'CALCMETHOD', null,'AGETIME','T','0',false,true)
,('UOB', 30, 'CALFORMULA', 'Calculation Process','C','T','0',true,true)
,('UOB', 40, 'GOAL', 'Goal', 'RETIREMENT','T','0',true,true)
,('UOB', 45, 'RETIRED', 'Retired', 'false','B','0',true,true)
,('UOB', 60, 'AGE', 'Age', '35','I','0',true,true)
,('UOB', 70, 'HORIZON', 'Horizon', '35','I','0',true,true)
,('UOB', 80, 'WITHDRAWALPERIOD', 'Withdrawl Period', '0','I','0',true,true)
,('UOB', 90, 'TRADECURRENCY', null, 'SGD','T','0',false,true)
,('UOB', 95, 'SETTLEMENTCURRENCY', null,'SGD','T','0',false,true)
,('UOB', 100, 'INITIALINVESTMENT', 'Investment', '10000','D','0',true,true)
,('UOB', 110, 'RECURRINGINVESTMENT', 'Recurring Investment', '1000','D','0',true,true)
,('UOB', 120, 'RECURRINGTERM', null, 'YEARLY','T','0',false,true)
,('UOB', 130, 'RECURRINGPERIOD', 'Recurring Period', '10','I','0',true,true)
,('UOB', 140, 'KEEPLIQUID', null, '0','D','0',false,true)
,('UOB', 150, 'TAXABLE', null, 'FALSE','B','0',false,true)
,('UOB', 160, 'TAXRATE', null, '0','D','0',false,true)
,('UOB', 170, 'EXPERIENCE', null, '0','I','0',false,true)
,('UOB', 180, 'RETIREMENTAGE', null, '65','I','100',false,true)
,('UOB', 190, 'WITHDRAWLAGE', null, '95','I','100',false,true)

,('UOB', 500, 'AGEPOWERVALUE', null,'1.7','D','1.0',false,false)
,('UOB', 510, 'AGEWEIGHT', null,'1.0','D','1.0',false,false)
,('UOB', 530, 'MAXDURATION', null,'15.0','D','15.0',false,false)
,('UOB', 530, 'MAXSCORE', null,'100','I','100',false,false)
,('UOB', 540, 'WITHDRAWLRATE', null,'0.04','D','100',false,false)
,('UOB', 550, 'KNOCKOUT',null,'TRUE','B','0',false,false)
,('UOB', 600, 'MININTITIALRQMT',null,'10000','I','0',false,false)
,('UOB', 610, 'MIN2NDINTIALRQMT',null,'1000','I','0',false,false)
,('UOB', 650, 'MINRECCURRINGRQMT',null,'1000','I','0',false,false)
;

/* 500.pm.sel_advisor_risk_master.sql030218_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`sel_advisor_risk_master`;


DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_advisor_risk_master`(
	p_advisor VARCHAR(30) 
)
BEGIN


	SELECT `advisor_risk_master`.`advisor`,
		`advisor_risk_master`.`sortorder`,
		`advisor_risk_master`.`key`,
		`advisor_risk_master`.`displayName`,
		`advisor_risk_master`.`defaultValue`,
		`advisor_risk_master`.`dataType`,
		`advisor_risk_master`.`displayOnStart`,
		`advisor_risk_master`.`displayAdvisor`,
		`advisor_risk_master`.`saveforUser`
	FROM `invdb`.`advisor_risk_master`
	WHERE `advisor_risk_master`.`advisor` = `p_advisor`
	;

END $$
DELIMITER ;


