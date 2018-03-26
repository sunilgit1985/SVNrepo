-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: uat.invessence.com    Database: audit
-- ------------------------------------------------------
-- Server version	5.5.56-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acct_financial`
--

DROP TABLE IF EXISTS `acct_financial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acct_financial` (
  `srno` bigint(20) NOT NULL AUTO_INCREMENT,
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
  `auditedBy` varchar(45) DEFAULT NULL,
  `audited` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`srno`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-02  7:21:54
