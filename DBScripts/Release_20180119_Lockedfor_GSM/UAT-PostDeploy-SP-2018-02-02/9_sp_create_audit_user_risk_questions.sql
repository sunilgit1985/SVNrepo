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
-- Table structure for table `user_risk_questions`
--

DROP TABLE IF EXISTS `user_risk_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_risk_questions` (
  `srno` bigint(20) NOT NULL AUTO_INCREMENT,
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
  `standardRisk` tinyint(4) DEFAULT NULL,
  `overrideRisk` tinyint(4) DEFAULT NULL,
  `totalrisk` tinyint(4) DEFAULT NULL,
  `riskByQuestion` tinyint(4) DEFAULT NULL,
  `riskOverride` tinyint(4) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `lastUpdated` date DEFAULT NULL,
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
