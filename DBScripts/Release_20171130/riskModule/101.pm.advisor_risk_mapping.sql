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
,('UOB',3, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.0, current_date())
,('UOB',4, 4, 4, 0, 30, 70, 0, 0, 0, 0, 0, 0, 0.0, current_date())
,('UOB',5, 4, 4, 0, 30, 70, 0, 0, 0, 0, 0, 0, 0.0, current_date())
,('UOB',6, 4, 0, 0, 20, 50, 75, 0, 0, 0, 0, 0, 0.0, current_date())
,('UOB',7, 3, 0, 30, 70, 0, 0, 0, 0, 0, 0, 0, 0.0, current_date())
,('UOB',8, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.0, current_date())
;
