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
