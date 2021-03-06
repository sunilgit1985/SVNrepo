CREATE SCHEMA `invdbaudit` 
DEFAULT CHARACTER SET utf8 ;

use `invdbaudit`;

CREATE TABLE `user_trade_profile` (
  `auditid` bigint(20) NOT NULL AUTO_INCREMENT,
  `acctnum` bigint(20) NOT NULL,
  `advisor` varchar(20) DEFAULT NULL,
  `rep` varchar(20) DEFAULT NULL,
  `theme` varchar(30) DEFAULT NULL,
  `firstname` varchar(40) DEFAULT NULL,
  `lastname` varchar(40) DEFAULT NULL,
  `portfolioName` varchar(60) DEFAULT NULL,
  `goal` varchar(30) DEFAULT NULL,
  `acctType` varchar(30) DEFAULT NULL,
  `age` int(5) DEFAULT NULL,
  `horizon` int(5) DEFAULT NULL,
  `initialInvestment` int(11) DEFAULT NULL,
  `recurringInvestment` int(11) DEFAULT NULL,
  `experience` tinyint(4) DEFAULT NULL,
  `longTermGoal` tinyint(4) DEFAULT NULL,
  `stayInvested` tinyint(4) DEFAULT NULL,
  `charitablegoals` int(11) DEFAULT NULL,
  `dependent` int(11) DEFAULT NULL,
  `riskIndex` double DEFAULT NULL,
  `tradePreference` varchar(1) DEFAULT 'A',
  `keepLiquid` int(11) DEFAULT NULL,
  `taxable` varchar(1) DEFAULT NULL,
  `calcModel` varchar(1) DEFAULT NULL,
  `assetIndex` int(3) DEFAULT NULL,
  `portfolioIndex` int(3) DEFAULT NULL,
  `goalAmount` double DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `lastUpdated` datetime DEFAULT NULL,
  `managed` varchar(1) NOT NULL DEFAULT 'N',
  `clientAccountID` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`auditid`),
  KEY `AK1_user_trade_profile` (`acctnum`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

CREATE TABLE `user_risk_questions` (
  `auditid` bigint(20) NOT NULL AUTO_INCREMENT,
  `acctnum` bigint(20) NOT NULL,
  `investmentgoal` varchar(20) DEFAULT NULL,
  `age` tinyint(4) DEFAULT NULL,
  `retireage` tinyint(4) DEFAULT NULL,
  `retired` tinyint(4) DEFAULT NULL,
  `horizon` tinyint(4) DEFAULT NULL,
  `ans1` tinyint(4) DEFAULT NULL,
  `ans2` tinyint(4) DEFAULT NULL,
  `ans3` tinyint(4) DEFAULT NULL,
  `ans4` tinyint(4) DEFAULT NULL,
  `ans5` tinyint(4) DEFAULT NULL,
  `ans6` tinyint(4) DEFAULT NULL,
  `ans7` tinyint(4) DEFAULT NULL,
  `ans8` tinyint(4) DEFAULT NULL,
  `ans9` tinyint(4) DEFAULT NULL,
  `ans10` tinyint(4) DEFAULT NULL,
  `ans11` tinyint(4) DEFAULT NULL,
  `ans12` tinyint(4) DEFAULT NULL,
  `ans13` tinyint(4) DEFAULT NULL,
  `ans14` tinyint(4) DEFAULT NULL,
  `ans15` tinyint(4) DEFAULT NULL,
  `formula` varchar(1) DEFAULT NULL,
  `risk1` tinyint(4) DEFAULT NULL,
  `risk2` tinyint(4) DEFAULT NULL,
  `risk3` tinyint(4) DEFAULT NULL,
  `risk4` tinyint(4) DEFAULT NULL,
  `risk5` tinyint(4) DEFAULT NULL,
  `risk6` tinyint(4) DEFAULT NULL,
  `risk7` tinyint(4) DEFAULT NULL,
  `risk8` tinyint(4) DEFAULT NULL,
  `risk9` tinyint(4) DEFAULT NULL,
  `risk10` tinyint(4) DEFAULT NULL,
  `risk11` tinyint(4) DEFAULT NULL,
  `risk12` tinyint(4) DEFAULT NULL,
  `risk13` tinyint(4) DEFAULT NULL,
  `risk14` tinyint(4) DEFAULT NULL,
  `risk15` tinyint(4) DEFAULT NULL,
  `totalrisk` tinyint(4) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `lastUpdated` datetime DEFAULT NULL,
  PRIMARY KEY (`auditid`),
  KEY `AK1_user_risk_questions` (`acctnum`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

CREATE TABLE `acct_financial` (
  `auditid` bigint(20) NOT NULL AUTO_INCREMENT,
  `acctnum` bigint(20) NOT NULL,
  `dependent` tinyint(4) DEFAULT '0',
  `estdDependentExpense` bigint(20) DEFAULT '0',
  `householdwages` bigint(20) DEFAULT '0',
  `otherincome` bigint(20) DEFAULT '0',
  `bonusincome` bigint(20) DEFAULT '0',
  `interestincome` bigint(20) DEFAULT '0',
  `dividentincome` bigint(20) DEFAULT '0',
  `rentalIncome` bigint(20) DEFAULT '0',
  `totalIncome` bigint(20) DEFAULT '0',
  `totalIncomeAnnulized` bigint(20) DEFAULT '0',
  `householdPayment` bigint(20) DEFAULT '0',
  `otherPropertiesPayment` bigint(20) DEFAULT '0',
  `automobilePayment` bigint(20) DEFAULT '0',
  `medicalPayment` bigint(20) DEFAULT '0',
  `federaltaxes` bigint(20) DEFAULT '0',
  `stateTaxes` bigint(20) DEFAULT '0',
  `propertyTax` bigint(20) DEFAULT '0',
  `otherPropertyTax` bigint(20) DEFAULT '0',
  `homeInsurance` bigint(20) DEFAULT '0',
  `lifeInsurance` bigint(20) DEFAULT '0',
  `autoInsurance` bigint(20) DEFAULT '0',
  `educationPayment` bigint(20) DEFAULT '0',
  `creditCardPayment` bigint(20) DEFAULT '0',
  `miscExpenses` bigint(20) DEFAULT '0',
  `totalExpense` bigint(20) DEFAULT '0',
  `totalExpenseAnnulized` bigint(20) DEFAULT '0',
  `homeEquity` bigint(20) DEFAULT '0',
  `autoValue` bigint(20) DEFAULT '0',
  `moneyMarket` bigint(20) DEFAULT '0',
  `checkingAcct` bigint(20) DEFAULT '0',
  `savingAcct` bigint(20) DEFAULT '0',
  `investment` bigint(20) DEFAULT '0',
  `equityOtherProperties` bigint(20) DEFAULT '0',
  `retirementInvestement` bigint(20) DEFAULT '0',
  `miscInvestment` bigint(20) DEFAULT '0',
  `totalAsset` bigint(20) DEFAULT '0',
  `mortgageLoan` bigint(20) DEFAULT '0',
  `autoLoan` bigint(20) DEFAULT '0',
  `educationLoan` bigint(20) DEFAULT '0',
  `creditCardDebt` bigint(20) DEFAULT '0',
  `otherPropertiesLoan` bigint(20) DEFAULT '0',
  `medicalDebt` bigint(20) DEFAULT '0',
  `otherDebt` bigint(20) DEFAULT '0',
  `totalDebt` bigint(20) DEFAULT '0',
  `liquidnetworth` bigint(20) DEFAULT '0',
  `networth` bigint(20) DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastupdated` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`auditid`),
  KEY `AK1_ACCT_FINANCIAL` (`acctnum`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

CREATE TABLE `asset_alloc` (
  `auditid` bigint(20) NOT NULL AUTO_INCREMENT,
  `acctnum` bigint(20) NOT NULL,
  `assetclass` varchar(40) NOT NULL,
  `themecode` varchar(20) NOT NULL DEFAULT 'ETF',
  `allocationmodel` varchar(1) NOT NULL COMMENT 'Valid Values: D - Default, C - Community, E - Expert, U - User',
  `assetyear` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `active` varchar(1) DEFAULT NULL COMMENT 'Valid Values: Y - Active, N - Inactive (Data is for storage purpose only)',
  `sortnum` tinyint(4) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `lastupdated` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`auditid`),  
  KEY `AK1_asset_alloc` (`acctnum`,`assetclass`,`themecode`,`allocationmodel`,`assetyear`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

CREATE TABLE `virtual_portfolio` (
  `auditid` bigint(20) NOT NULL AUTO_INCREMENT,
  `acctnum` bigint(20) NOT NULL,
  `itemnum` int(10) unsigned NOT NULL,
  `instrumentid` bigint(20) NOT NULL,
  `ticker` varchar(20) NOT NULL,
  `active` varchar(1) NOT NULL COMMENT 'Valid: A - Active, I - Inactive',
  `qty` int(11) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `tradeprice` float DEFAULT NULL,
  `investmentvalue` double DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `lastupdated` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`auditid`),
  KEY `AK1_virtual_portfolio` (`acctnum`, `itemnum`, `ticker`)  
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

CREATE TABLE `user_logon_access` (
  `auditid` bigint(20) NOT NULL AUTO_INCREMENT,
  `logonid` bigint(20) NOT NULL,
  `created`  timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`auditid`),
  KEY `AK1_user_logon_access` (`logonid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;


  
