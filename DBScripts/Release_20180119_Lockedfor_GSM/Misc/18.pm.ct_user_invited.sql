DROP TABLE IF EXISTS `invdb`.`user_invited`;

CREATE TABLE `invdb`.`user_invited` (
  `email` 		varchar(60) NOT NULL,
  `logonstatus` varchar(1) NOT NULL DEFAULT 'T',
  `accessmode`	VARCHAR(1) NOT NULL COMMENT 'A - Advisor U - User',
  `prefix` 		varchar(25) DEFAULT NULL,
  `firstname` 	varchar(25) DEFAULT NULL,
  `middlename`	varchar(25) DEFAULT NULL,
  `lastname`	varchar(25) DEFAULT NULL,
  `suffix`		varchar(25) DEFAULT NULL,
  `fullname`	varchar(60) DEFAULT NULL,
  `emailalt` 	varchar(60) DEFAULT NULL,
  `stateRegistered` varchar(6) DEFAULT NULL,
  `leadSource`	varchar(25) DEFAULT NULL,
  `advisor`		varchar(20) DEFAULT NULL,
  `rep`			varchar(20) DEFAULT NULL,
  `ip`			varchar(20) DEFAULT NULL,
  `resetID`		varchar(8) DEFAULT NULL,
  `created`		timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastupdated` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
