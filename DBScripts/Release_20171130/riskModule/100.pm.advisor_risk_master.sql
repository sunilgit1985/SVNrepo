DROP TABLE IF EXISTS `invdb`.`advisor_risk_master`;

CREATE TABLE `invdb`.`advisor_risk_master` (
  `advisor` 		varchar(20) NOT NULL,
  `sortorder`		Integer DEFAULT 1,
  `key` 			varchar(30) DEFAULT NULL,
  `defaultValue`    varchar(30) DEFAULT NULL,
  `dataType`		varchar(1)	DEFAULT "T",
  `displayOnStart`  varchar(30) DEFAULT 0,
  `saveforUser`  	Boolean DEFAULT false,
  `created` 		date DEFAULT NULL,
  `lastUpdated` 	date DEFAULT NULL,
  PRIMARY KEY `PK1_advisor_risk_master` (`advisor`,`sortorder`, `key`),
  KEY `AK1_advisor_risk_master` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELETE FROM `invdb`.`advisor_risk_master` ;

INSERT INTO `invdb`.`advisor_risk_master` (`advisor`, `sortorder`,`key`, `defaultValue`,`dataType`, `displayOnStart`,`saveforUser`) 
VALUES 
 ('UOB', 10, 'RISKQUESTIONS', '8','I','0',true)
,('UOB', 15, 'THEME', '8.UOB','T','0',true)
,('UOB', 20, 'CALCMETHOD', 'AGETIME','T','0',true)
,('UOB', 30, 'CALFORMULA', 'C','T','0',false)
,('UOB', 40, 'GOAL', 'RETIREMENT','T','0',true)
,('UOB', 45, 'RETIRED', 'false','B','0',true)
,('UOB', 50, 'KNOCKOUT','TRUE','B','0',false)
,('UOB', 60, 'AGE', '35','I','0',true)
-- ,('UOB', 70, 'HORIZON', '35','I','0',true)
,('UOB', 80, 'WITHDRAWALPERIOD', '0','I','0',true)
,('UOB', 90, 'TRADECURRENCY', 'SGD','T','0',true)
,('UOB', 90, 'INITIALINVESTMENT', '10000','D','0',true)
,('UOB', 90, 'SETTLEMENTCURRENCY', 'SGD','T','0',true)
,('UOB', 100, 'RECURRINGINVESTMENT', '1000','D','0',true)
,('UOB', 110, 'RECURRINGTERM', 'YEARLY','T','0',true)
,('UOB', 120, 'RECURRINGPERIOD', '10','I','0',true)
,('UOB', 130, 'KEEPLIQUID', '0','D','0',true)
,('UOB', 140, 'TAXABLE', 'FALSE','B','0',true)
,('UOB', 150, 'TAXRATE', '0','D','0',true)
,('UOB', 160, 'EXPERIENCE', '0','I','0',true)
,('UOB', 200, 'AGEPOWERVALUE', '1.7','D','1.0',false)
,('UOB', 210, 'AGEWEIGHT', '1.0','D','1.0',false)
,('UOB', 230, 'MAXDURATION', '15.0','D','15.0',false)
,('UOB', 230, 'MAXSCORE', '100','I','100',false)
,('UOB', 240, 'WITHDRAWLRATE', '0.04','D','100',false)
,('UOB', 250, 'RETIREMENTAGE', '65','I','100',true)
,('UOB', 260, 'WITHDRAWLAGE', '95','I','100',true)
;