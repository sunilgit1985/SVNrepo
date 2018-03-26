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
,('UOB', 105, 'TOTALINVESTMENT', 'Total Invested', '10000','D','0',true,true)
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