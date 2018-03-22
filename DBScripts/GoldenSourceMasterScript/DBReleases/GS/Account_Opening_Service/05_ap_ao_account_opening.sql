CREATE DATABASE  IF NOT EXISTS `invdb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `invdb`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: invdb
-- ------------------------------------------------------
-- Server version	5.5.57

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
-- Table structure for table `ao_acct_details`
--

DROP TABLE IF EXISTS `ao_acct_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_acct_details` (
  `acctnum` bigint(20) NOT NULL,
  `clientAccountID` varchar(45) DEFAULT NULL,
  `repId` varchar(45) DEFAULT NULL,
  `caseNumber` varchar(45) DEFAULT NULL,
  `advisorId` bigint(20) DEFAULT NULL,
  `acctTypeId` varchar(45) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `createdBy` varchar(45) DEFAULT NULL,
  `updated` date DEFAULT NULL,
  `updatedBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_acct_misc_details`
--

DROP TABLE IF EXISTS `ao_acct_misc_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_acct_misc_details` (
  `acctnum` bigint(20) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_citizenship_details`
--

DROP TABLE IF EXISTS `ao_citizenship_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_citizenship_details` (
  `acctnum` bigint(20) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  `recId` int(2) NOT NULL,
  PRIMARY KEY (`acctnum`,`name`,`recId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_column_lookup`
--

DROP TABLE IF EXISTS `ao_column_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_column_lookup` (
  `product` varchar(45) DEFAULT NULL,
  `lookupSet` varchar(45) NOT NULL,
  `lookupCode` varchar(45) NOT NULL,
  `displayName` varchar(500) DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  `tableName` varchar(45) DEFAULT NULL,
  `parentLookupId` varchar(45) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`lookupSet`,`lookupCode`),
  UNIQUE KEY `lookupCode_UNIQUE` (`lookupCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_bank_details`
--

DROP TABLE IF EXISTS `ao_owners_bank_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_bank_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `bankName` varchar(100) DEFAULT NULL,
  `bankAccountNo` varchar(45) DEFAULT NULL,
  `bankAccountHolderName` varchar(60) DEFAULT NULL,
  `bankAddressStreet1` varchar(100) DEFAULT NULL,
  `bankAddressStreet2` varchar(100) DEFAULT NULL,
  `bankAddressStreet3` varchar(100) DEFAULT NULL,
  `bankAddressStreet4` varchar(100) DEFAULT NULL,
  `bankAddressCity` varchar(45) DEFAULT NULL,
  `bankAddressState` varchar(45) DEFAULT NULL,
  `bankAddressZipCode` varchar(45) DEFAULT NULL,
  `bankAddressCountry` varchar(45) DEFAULT NULL,
  `swiftBic` varchar(45) DEFAULT NULL,
  `correspondentBank` varchar(100) DEFAULT NULL,
  `correspondentBankSwiftBic` varchar(45) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `createdBy` varchar(45) DEFAULT NULL,
  `updated` date DEFAULT NULL,
  `updatedBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`acctOwnerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_citizenship_details`
--

DROP TABLE IF EXISTS `ao_owners_citizenship_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_citizenship_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`name`,`acctOwnerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_contact_details`
--

DROP TABLE IF EXISTS `ao_owners_contact_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_contact_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`name`,`acctOwnerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_details`
--

DROP TABLE IF EXISTS `ao_owners_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `title` varchar(45) DEFAULT NULL,
  `firstName` varchar(45) DEFAULT NULL,
  `midInitial` varchar(45) DEFAULT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `fullName` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `dob` varchar(45) DEFAULT NULL,
  `countryOfBirth` varchar(45) DEFAULT NULL,
  `emailAddress` varchar(45) DEFAULT NULL,
  `physicalAddressStreet1` varchar(100) DEFAULT NULL,
  `physicalAddressStreet2` varchar(100) DEFAULT NULL,
  `physicalAddressStreet3` varchar(100) DEFAULT NULL,
  `physicalAddressStreet4` varchar(100) DEFAULT NULL,
  `physicalAddressCity` varchar(45) DEFAULT NULL,
  `physicalAddressState` varchar(45) DEFAULT NULL,
  `physicalAddressZipCode` varchar(45) DEFAULT NULL,
  `physicalAddressCountry` varchar(45) DEFAULT NULL,
  `mailingAddressStreet1` varchar(100) DEFAULT NULL,
  `mailingAddressStreet2` varchar(100) DEFAULT NULL,
  `mailingAddressStreet3` varchar(100) DEFAULT NULL,
  `mailingAddressStreet4` varchar(100) DEFAULT NULL,
  `mailingAddressCity` varchar(45) DEFAULT NULL,
  `mailingAddressState` varchar(45) DEFAULT NULL,
  `mailingAddressZipCode` varchar(45) DEFAULT NULL,
  `mailingAddressCountry` varchar(45) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `createdBy` varchar(45) DEFAULT NULL,
  `updated` date DEFAULT NULL,
  `updatedBy` varchar(45) DEFAULT NULL,
  `ownership` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`acctOwnerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_employment_details`
--

DROP TABLE IF EXISTS `ao_owners_employment_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_employment_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `emplId` int(2) NOT NULL,
  `emplTypeId` varchar(45) NOT NULL,
  `sourceOfIncome` varchar(100) DEFAULT NULL,
  `employerName` varchar(45) DEFAULT NULL,
  `occupation` varchar(45) DEFAULT NULL,
  `typeOfBusiness` varchar(45) DEFAULT NULL,
  `employerStreetAddress1` varchar(100) DEFAULT NULL,
  `employerStreetAddress2` varchar(100) DEFAULT NULL,
  `employerStreetAddress3` varchar(100) DEFAULT NULL,
  `employerStreetAddress4` varchar(100) DEFAULT NULL,
  `employerCity` varchar(45) DEFAULT NULL,
  `employerState` varchar(45) DEFAULT NULL,
  `employerZipCode` varchar(45) DEFAULT NULL,
  `employerZipCountry` varchar(45) DEFAULT NULL,
  `fromDate` varchar(10) DEFAULT NULL,
  `toDate` varchar(10) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `createdBy` varchar(45) DEFAULT NULL,
  `updated` date DEFAULT NULL,
  `updatedBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`acctOwnerId`,`emplId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_finacial_details`
--

DROP TABLE IF EXISTS `ao_owners_finacial_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_finacial_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`name`,`acctOwnerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_indentification_details`
--

DROP TABLE IF EXISTS `ao_owners_indentification_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_indentification_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`name`,`acctOwnerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_misc_details`
--

DROP TABLE IF EXISTS `ao_owners_misc_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_misc_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`name`,`acctOwnerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_regularity_details`
--

DROP TABLE IF EXISTS `ao_owners_regularity_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_regularity_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`name`,`acctOwnerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_sets_misc_details`
--

DROP TABLE IF EXISTS `ao_owners_sets_misc_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_sets_misc_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `category` varchar(45) NOT NULL,
  `id` int(2) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`acctOwnerId`,`category`,`id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_request_audit`
--

DROP TABLE IF EXISTS `ao_request_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_request_audit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product` varchar(50) DEFAULT NULL,
  `mode` varchar(20) DEFAULT NULL,
  `requestIds` varchar(100) DEFAULT NULL,
  `eventNum` int(11) DEFAULT NULL,
  `acctnum` bigint(20) DEFAULT NULL,
  `aoRequest` varchar(5000) DEFAULT NULL,
  `aoResponce` varchar(1000) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  `reqTime` datetime DEFAULT NULL,
  `resTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_requests`
--

DROP TABLE IF EXISTS `ao_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_requests` (
  `reqId` bigint(20) NOT NULL AUTO_INCREMENT,
  `product` varchar(50) DEFAULT NULL,
  `acctnum` bigint(20) NOT NULL,
  `advisorid` int(11) NOT NULL,
  `eventNum` int(11) NOT NULL,
  `reqType` varchar(45) NOT NULL,
  `reqHeading` varchar(100) DEFAULT NULL,
  `reqAckwNum` varchar(45) DEFAULT NULL,
  `status` varchar(45) NOT NULL COMMENT 'I = Init, S = Sent, C = Completed, E= Error',
  `aoRequestFor` varchar(45) DEFAULT NULL,
  `action` varchar(45) DEFAULT NULL,
  `subaction` varchar(45) DEFAULT NULL,
  `terminalDetails` varchar(100) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `updated` date DEFAULT NULL,
  PRIMARY KEY (`reqId`),
  KEY `ak1_ao_request` (`acctnum`,`reqType`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_requests_final`
--

DROP TABLE IF EXISTS `ao_requests_final`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_requests_final` (
  `reqId` bigint(20) NOT NULL AUTO_INCREMENT,
  `refReqId` bigint(20) NOT NULL,
  `product` varchar(50) DEFAULT NULL,
  `acctnum` bigint(20) NOT NULL,
  `advisorid` int(11) NOT NULL,
  `eventNum` int(11) NOT NULL,
  `reqType` varchar(45) NOT NULL,
  `seqno` int(11) NOT NULL,
  `reqHeading` varchar(100) DEFAULT NULL,
  `reqAckwNum` varchar(45) DEFAULT NULL,
  `status` varchar(45) NOT NULL COMMENT 'I = Init, S = Sent, C = Completed, E= Error',
  `formType` varchar(45) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `updated` date DEFAULT NULL,
  PRIMARY KEY (`reqId`),
  KEY `ak1_ao_request` (`acctnum`,`reqType`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-12  5:45:46
