DROP TABLE IF EXISTS `temp`.`tmp_td_transaction`;

CREATE TABLE `temp`.`tmp_td_transaction` (
  `brokerAccount` varchar(20) NOT NULL DEFAULT '',
  `fileDate` varchar(20) DEFAULT NULL,
  `accountNumber` varchar(20) NOT NULL DEFAULT '',
  `transactionCode` varchar(20) NOT NULL DEFAULT '',
  `cancelStatusFlag` varchar(20) DEFAULT NULL,
  `symbolCUSIP` varchar(20) NOT NULL DEFAULT '',
  `securityCode` varchar(20) DEFAULT NULL,
  `tradeDatePayDate` varchar(20) DEFAULT NULL,
  `quantity` varchar(20) DEFAULT NULL,
  `netAmount` varchar(20) DEFAULT NULL,
  `principalGrossAmount` varchar(20) DEFAULT NULL,
  `brokerFee` varchar(20) DEFAULT NULL,
  `otherFees` varchar(20) DEFAULT NULL,
  `settleDateExDate` varchar(20) DEFAULT NULL,
  `fromToAccount` varchar(20) DEFAULT NULL,
  `accountType` varchar(250) DEFAULT NULL,
  `accruedInterest` varchar(20) DEFAULT NULL,
  `closingAccountingMethod` varchar(20) DEFAULT NULL,
  `comments` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`brokerAccount`,`accountNumber`,`transactionCode`,`symbolCUSIP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
