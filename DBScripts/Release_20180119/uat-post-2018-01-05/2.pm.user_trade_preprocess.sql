DROP TABLE IF EXISTS `invdb`.`user_trade_preprocess`;

CREATE TABLE `invdb`.`user_trade_preprocess` (
  `advisor` varchar(20) NOT NULL,
  `clientAccountID` varchar(20) NOT NULL,
  `acctnum` bigint(20) NOT NULL,
  `processed` varchar(1) DEFAULT NULL,
  `tradeDate` varchar(8) DEFAULT NULL,
  `tradeCurrency` varchar(3) DEFAULT 'USD',
  `assetclass` varchar(40) DEFAULT NULL,
  `subclass` varchar(40) DEFAULT NULL,
  `color` varchar(10) DEFAULT NULL,
  `holdingTicker` varchar(25) DEFAULT NULL,
  `curQty` double DEFAULT NULL,
  `curPrice` double DEFAULT NULL,
  `curValue` double DEFAULT NULL,
  `newTicker` varchar(25) DEFAULT NULL,
  `newQty` int(11) DEFAULT NULL,
  `newPrice` double DEFAULT NULL,
  `newValue` double DEFAULT NULL,
  `settleCurrency` varchar(3) DEFAULT 'USD',
  `settleQty` double DEFAULT NULL,
  `settlePrice` double DEFAULT NULL,
  `settleValue` double DEFAULT NULL,
  `exchangeRate` double DEFAULT '1',
  `settleNewQty` double DEFAULT NULL,
  `settleNewPrice` double DEFAULT NULL,
  `settleNewValue` double DEFAULT NULL,
  `tradetype` varchar(20) DEFAULT NULL,
  `reason` varchar(40) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY `user_trade_preprocess_advisor` (`advisor`,`clientAccountID`,`tradeDate`,`newTicker`),
  KEY `user_trade_preprocess_acctnum` (`acctnum`,`processed`,`tradeDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

