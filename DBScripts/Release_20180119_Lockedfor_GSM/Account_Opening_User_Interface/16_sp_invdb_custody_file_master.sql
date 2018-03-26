-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 192.168.100.92    Database: invdb
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
-- Table structure for table `custody_file_master`
--

DROP TABLE IF EXISTS `custody_file_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custody_file_master` (
  `product` varchar(45) NOT NULL,
  `action` varchar(45) NOT NULL,
  `subaction` varchar(45) NOT NULL,
  `requestFor` varchar(10) NOT NULL COMMENT 'Upload/Download',
  `seqno` int(11) NOT NULL,
  `fileName` varchar(45) DEFAULT NULL,
  `fileLabel` varchar(255) DEFAULT NULL,
  `reqType` varchar(45) DEFAULT NULL,
  `fileExtensions` varchar(100) DEFAULT NULL,
  `isActive` varchar(5) NOT NULL COMMENT 'Y = Yes, N= No',
  PRIMARY KEY (`product`,`action`,`subaction`,`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custody_file_master`
--

LOCK TABLES `custody_file_master` WRITE;
/*!40000 ALTER TABLE `custody_file_master` DISABLE KEYS */;
INSERT INTO `custody_file_master` (`product`, `action`, `subaction`, `requestFor`, `seqno`, `fileName`, `fileLabel`, `reqType`, `fileExtensions`, `isActive`) VALUES ('UOB','ACCT_OPEN_EXISTING_USER','BNK_STMT','Upload',1,'Bank Statement','Bank Statement','BNK_STMT','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','Add_Res_Proof','Upload',5,'Mailing Resendential Proof','Proof of mailing residential address Examples: Bank Statement, Utilities Bill, Income Tax Statement, Property Tax Statement or Document issued by the Government Agency','ADD_RES_PRF','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','BNK_STMT','Upload',3,'Bank Statement','Bank Statement','BNK_STMT','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','Disclosure','Download',1,'Disclosure.pdf','Disclosure','ACCT_DSCL','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','Guide','Download',1,'Guide.pdf','Guide','ACCT_GUD','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','MasterTradeAgreement','Download',1,'MasterTradeAgreement.pdf','MasterTradeAgreement','ACCT_MSTR_AGGR','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','MYKAD','Upload',1,'Malaysian IC Front','Malaysian Identity Card(provide front copy)','NTN_PRF_FRST','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','MYKAD','Upload',2,'Malaysian IC Back','Malaysian Identity Card(provide back copy)','NTN_PRF_BCK','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','NRIC','Upload',1,'NRIC  Front','Singapore NRIC(provide front copy)','NTN_PRF_FRST','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','NRIC','Upload',2,'NRIC Back','Singapore NRIC(provide back copy)','NTN_PRF_BCK','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','Passport','Upload',1,'Passport','Passport','NTN_PRF','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','Res_Proof','Upload',4,'Resendential Proof','Proof of residential address Examples: Bank Statement, Utilities Bill, Income Tax Statement, Property Tax Statement or Document issued by the Government Agency','RES_PRF','.jpg','Y');
/*!40000 ALTER TABLE `custody_file_master` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-12  6:08:51
