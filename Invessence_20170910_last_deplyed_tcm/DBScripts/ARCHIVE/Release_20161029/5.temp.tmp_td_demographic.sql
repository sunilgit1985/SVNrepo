CREATE TABLE `temp`.`tmp_td_demographic` (
  `companyName` varchar(20) DEFAULT NULL,
  `lastName` varchar(20) DEFAULT NULL,
  `firstName` varchar(20) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `address3` varchar(50) DEFAULT NULL,
  `address4` varchar(50) DEFAULT NULL,
  `address5` varchar(50) DEFAULT NULL,
  `address6` varchar(50) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `zipCode` varchar(20) DEFAULT NULL,
  `SSNOrTaxID` varchar(20) DEFAULT NULL,
  `accountNumber` varchar(20) NOT NULL DEFAULT '',
  `advisorID` varchar(20) NOT NULL DEFAULT '',
  `taxable` varchar(20) DEFAULT NULL,
  `phoneNumber` varchar(20) DEFAULT NULL,
  `faxNumber` varchar(20) DEFAULT NULL,
  `accountType` varchar(100) DEFAULT NULL,
  `objective` varchar(20) DEFAULT NULL,
  `billingAccountNumber` varchar(20) DEFAULT NULL,
  `defaultAccount` varchar(20) DEFAULT NULL,
  `stateOfPrimaryResidence` varchar(20) DEFAULT NULL,
  `performanceInceptionDate` varchar(20) DEFAULT NULL,
  `billingInceptionDate` varchar(20) DEFAULT NULL,
  `federalTaxRate` varchar(20) DEFAULT NULL,
  `stateTaxRate` varchar(20) DEFAULT NULL,
  `monthsInShortTermholdingperiod` varchar(20) DEFAULT NULL,
  `fiscalYearEnd` varchar(20) DEFAULT NULL,
  `useAverageCostAccounting` varchar(20) DEFAULT NULL,
  `displayAccruedInterest` varchar(20) DEFAULT NULL,
  `displayAccruedDividends` varchar(20) DEFAULT NULL,
  `displayAccruedGains` varchar(20) DEFAULT NULL,
  `birthDate` varchar(20) DEFAULT NULL,
  `discountRate` varchar(20) DEFAULT NULL,
  `payoutRate` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`accountNumber`,`advisorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
