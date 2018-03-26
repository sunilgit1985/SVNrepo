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
-- Table structure for table `user_trade_profile`
--

DROP TABLE IF EXISTS `user_trade_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_trade_profile` (
  `srno` bigint(20) NOT NULL AUTO_INCREMENT,
  `acctnum` bigint(20) NOT NULL,
  `advisor` varchar(20) DEFAULT NULL,
  `rep` varchar(20) DEFAULT NULL,
  `theme` varchar(30) DEFAULT NULL,
  `firstname` varchar(40) DEFAULT NULL,
  `fullname` varchar(45) DEFAULT NULL,
  `lastname` varchar(40) DEFAULT NULL,
  `portfolioName` varchar(60) DEFAULT NULL,
  `goal` varchar(30) DEFAULT NULL,
  `acctType` varchar(30) DEFAULT NULL,
  `age` int(5) DEFAULT NULL,
  `horizon` int(5) DEFAULT NULL,
  `initialInvestment` int(11) DEFAULT NULL,
  `tradeCurrency` varchar(20) DEFAULT NULL,
  `settleCurrency` varchar(20) DEFAULT NULL,
  `exchangeRate` double DEFAULT NULL,
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
  `lastUpdated` date DEFAULT NULL,
  `auditedBy` varchar(45) DEFAULT NULL,
  `audited` timestamp NULL DEFAULT NULL,
  `managed` varchar(1) NOT NULL DEFAULT 'N',
  `clientAccountID` varchar(15) DEFAULT NULL,
  `status` varchar(1) DEFAULT 'N',
  `customName` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`srno`,`acctnum`)
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
