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
-- Table structure for table `virtual_portfolio`
--

DROP TABLE IF EXISTS `virtual_portfolio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtual_portfolio` (
  `srno` bigint(20) NOT NULL,
  `acctnum` bigint(20) NOT NULL,
  `itemnum` int(10) unsigned NOT NULL,
  `ticker` varchar(20) NOT NULL,
  `active` varchar(1) NOT NULL COMMENT 'Valid\\\\\\\\nA - Active\\\\\\\\nI - Inactive\\\\\\\\n',
  `tradeCurrency` varchar(3) NOT NULL DEFAULT 'USD',
  `qty` int(11) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `tradeprice` float DEFAULT NULL,
  `investmentvalue` double DEFAULT NULL,
  `settleCurrency` varchar(3) DEFAULT 'USD',
  `exchangeRate` double DEFAULT '1',
  `dest_currency` varchar(3) DEFAULT 'USD',
  `dest_qty` double DEFAULT NULL,
  `dest_price` double DEFAULT NULL,
  `dest_value` double DEFAULT NULL,
  `settleQty` double DEFAULT NULL,
  `settlePrice` double DEFAULT NULL,
  `settleValue` double DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `lastupdated` timestamp NULL DEFAULT NULL,
  `auditedBy` varchar(45) DEFAULT NULL,
  `audited` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`srno`,`acctnum`,`itemnum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
