CREATE TABLE `invdb`.`ext_investment` (
 `acctnum` bigint(20) DEFAULT NULL,
 `clientAccountID` varchar(12) NOT NULL DEFAULT '',
 `ticker` varchar(20) NOT NULL DEFAULT 'Cash',
 `investmentDate` varchar(10) NOT NULL,
 `status` varchar(1) DEFAULT NULL,
 `investmentCurrency` varchar(3) NOT NULL DEFAULT 'USD',
 `netAmount` double DEFAULT NULL,
 `comment` varchar(120) DEFAULT NULL,
 `fxRateToBase` double DEFAULT '1',
 `baseCurrency` varchar(3) DEFAULT 'USD',
 `convertedNetAmount` double DEFAULT NULL,
 `created` datetime NOT NULL,
 PRIMARY KEY (`clientAccountID`,`ticker`,`investmentDate`,`investmentCurrency`),
 KEY `AK1_ext_transaction` (`acctnum`,`investmentDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
