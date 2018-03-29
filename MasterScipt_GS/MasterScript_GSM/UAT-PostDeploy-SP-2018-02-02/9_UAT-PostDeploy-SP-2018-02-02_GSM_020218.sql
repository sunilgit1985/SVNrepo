
/* 0_sp_create_audit_schema.sql020218_sagar*/

CREATE SCHEMA `audit` ;

/* 1_sp_insrt_invdb_notification_message_lookup.sql020218_sagar*/

delete from invdb.notification_message_lookup where advisor='UOB';

INSERT INTO `invdb`.`notification_message_lookup` (`advisor`, `messageType`, `includeAdvisor`, `advisorsubject`, `includeAdvisorEmail`, `emailAdvisorSubject`, `emailAdvisorRecepient`, `includeUser`, `userSubject`, `created`) VALUES ('UOB', 'ACTIVE', 'Y', 'Account Activated and Funded', 'Y', 'Account Activated and Funded', 'operations@uobkh.com', 'Y', 'Account Activated and Funded', '2017-07-27 07:22:24');
INSERT INTO `invdb`.`notification_message_lookup` (`advisor`, `messageType`, `includeAdvisor`, `advisorsubject`, `includeAdvisorEmail`, `emailAdvisorSubject`, `emailAdvisorRecepient`, `includeUser`, `userSubject`, `created`) VALUES ('UOB', 'CHNGADDRS', 'Y', 'Change Address', 'Y', 'Change Address', 'operations@uobkh.com', 'N', 'Change Address', '2017-07-27 07:22:24');
INSERT INTO `invdb`.`notification_message_lookup` (`advisor`, `messageType`, `includeAdvisor`, `advisorsubject`, `includeAdvisorEmail`, `emailAdvisorSubject`, `emailAdvisorRecepient`, `includeUser`, `userSubject`, `created`) VALUES ('UOB', 'FUNDED', 'Y', 'Funded Account', 'Y', 'Funded Account', 'operations@uobkh.com', 'Y', 'Funded Account', '2017-07-27 07:22:24');
INSERT INTO `invdb`.`notification_message_lookup` (`advisor`, `messageType`, `includeAdvisor`, `advisorsubject`, `includeAdvisorEmail`, `emailAdvisorSubject`, `emailAdvisorRecepient`, `includeUser`, `userSubject`, `created`) VALUES ('UOB', 'OPENED', 'Y', 'Application is Opened', 'Y', 'Application is Opened', 'operations@uobkh.com', 'Y', 'Application is Opened', '2017-07-27 07:22:24');
INSERT INTO `invdb`.`notification_message_lookup` (`advisor`, `messageType`, `includeAdvisor`, `advisorsubject`, `includeAdvisorEmail`, `emailAdvisorSubject`, `emailAdvisorRecepient`, `includeUser`, `userSubject`, `created`) VALUES ('UOB', 'PRFLCNFIRMED', 'Y', 'Portfolio Confirmed', 'N', 'Portfolio Confirmed', 'operations@uobkh.com', 'Y', 'Portfolio Confirmed', '2018-01-08 06:44:58');
INSERT INTO `invdb`.`notification_message_lookup` (`advisor`, `messageType`, `includeAdvisor`, `advisorsubject`, `includeAdvisorEmail`, `emailAdvisorSubject`, `emailAdvisorRecepient`, `includeUser`, `userSubject`, `created`) VALUES ('UOB', 'PRFLCNFREQ', 'Y', 'Portfolio Confirmation Request', 'N', 'Portfolio Confirmation Request', 'operations@uobkh.com', 'Y', 'Portfolio Confirmation Request', '2018-01-08 06:44:21');
INSERT INTO `invdb`.`notification_message_lookup` (`advisor`, `messageType`, `includeAdvisor`, `advisorsubject`, `includeAdvisorEmail`, `emailAdvisorSubject`, `emailAdvisorRecepient`, `includeUser`, `userSubject`, `created`) VALUES ('UOB', 'PROCESSED', 'Y', 'Application Submitted', 'Y', 'Application Submitted', 'operations@uobkh.com', 'Y', 'Application Submitted', '2017-07-27 07:22:24');
INSERT INTO `invdb`.`notification_message_lookup` (`advisor`, `messageType`, `includeAdvisor`, `advisorsubject`, `includeAdvisorEmail`, `emailAdvisorSubject`, `emailAdvisorRecepient`, `includeUser`, `userSubject`, `created`) VALUES ('UOB', 'REBALANCE', 'Y', 'Changed Strategy', 'Y', 'Changed Strategy', 'operations@uobkh.com', 'N', 'Changed Strategy', '2017-07-27 07:22:24');

/* 2_sp_insrt_invdb_web_menu.sql020218_sagar*/


INSERT INTO `invdb`.`web_menu` (`url`, `access`, `permission`, `label`, `level`, `sublevel`, `seq`, `status`, `availOnMobile`, `destdir`, `htmlpage`, `created`)
select url, 'User', 'User', 'Alerts', '0', '0', '11', 'A', 'N', 'consumer', 'alert_notification.xhtml', now() from invdb.web_menu group by url;

/* 3_sp_create_sp_user_profile_manage.sql020218_sagar*/

USE `invdb`;
DROP procedure IF EXISTS `sp_user_profile_manage`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sp_user_profile_manage`(
 	IN p_acctnum   BIGINT(20),
     IN p_status   VARCHAR(1),
     IN p_logonid BIGINT(20)
 )
BEGIN
 
   DECLARE tAdvisor, tRep VARCHAR(30);
   DECLARE tLastStatus VARCHAR(1);
   DECLARE tManaged	  VARCHAR(1);
 
 	SELECT 
 		advisor,
         rep,
         status,
         managed
		INTO tAdvisor, tRep, tLastStatus, tManaged
 	FROM invdb.user_trade_profile
     WHERE acctnum = p_acctnum;
     
   BEGIN
   
 	
 	IF (IFNULL(tLastStatus,'Z') != p_status)
     THEN
     
 		
 		IF (IFNULL(tManaged,'Z') != p_status)
 		THEN
 			IF (tAdvisor is not null)
 			THEN
 				 call invdb.sp_send_advisor_notification(
 					p_acctnum, 
 					tAdvisor, 
 					tRep,
 					CASE 
 						WHEN (p_status = 'P') THEN 'PROCESSED'
 						WHEN (p_status = 'O') THEN 'OPENED'
 						WHEN (p_status = 'A') THEN 'ACTIVE'
 						WHEN (p_status = 'R') THEN 'REBALANCE'
 						WHEN (p_status = 'F') THEN 'FUNDED'
 						WHEN (p_status = 'V') THEN 'VISITOR'
 						WHEN (p_status = 'N') THEN 'NEWCLIENT'
 						WHEN (p_status = 'C') THEN 'CLOSED'
						WHEN (p_status = 'S') THEN 'PRFLCNFREQ'
						WHEN (p_status = 'E') THEN 'PRFLCNFIRMED'
 						ELSE 'NOEVENT'
 					END
 				 );
 					
                    call invdb.sp_send_user_notification(p_logonid,
 							p_acctnum, 
 							tAdvisor, 
 							tRep,
 							CASE 
 								WHEN (p_status = 'P') THEN 'PROCESSED'
 								WHEN (p_status = 'O') THEN 'OPENED'
 								WHEN (p_status = 'A') THEN 'ACTIVE'
								WHEN (p_status = 'R') THEN 'REBALANCE'
 								WHEN (p_status = 'F') THEN 'FUNDED'
 								WHEN (p_status = 'C') THEN 'CLOSED'
                                WHEN (p_status = 'S') THEN 'PRFLCNFREQ'
								WHEN (p_status = 'E') THEN 'PRFLCNFIRMED'
 								ELSE 'NOEVENT'
 							END
 						 );
 			END IF;
 		END IF;
         
      
        
         
 		IF (IFNULL(p_status,'V') in ('A', 'O','S','E'))
         THEN
 			
             update user_trade_profile
 				set status = CASE 
 								WHEN (p_status = 'E') THEN 'A' 
                                ELSE p_status END,
 					 managed = 'A'
 			where acctnum = p_acctnum;
         ELSE
 			update user_trade_profile
 				set status = CASE 
 								WHEN (IFNULL(p_status,'V') = 'E') THEN 'A' 
                                ELSE IFNULL(p_status,'V') END 
 			where acctnum = p_acctnum;
         END IF;
 
      END IF;
 
   END;
   
 END$$

DELIMITER ;


/* 4_sp_create_sp_send_user_notification.sql020218_sagar*/

USE `invdb`;
DROP procedure IF EXISTS `sp_send_user_notification`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sp_send_user_notification`(
  	IN p_logonid		BIGINT,
  	IN p_acctnum		BIGINT,
      IN p_advisor		VARCHAR(20),
      IN p_rep			VARCHAR(20),
      IN p_messagetype 	VARCHAR(20)
      )
BEGIN
  
    DECLARE tFound INTEGER;
    DECLARE tName VARCHAR(80);
    DECLARE tAlertTime VARCHAR(30);
    DECLARE tCompanyName VARCHAR(60);
    DECLARE tRepDisplayName VARCHAR(60);
    DECLARE tMessage VARCHAR(2000);
    
    DECLARE 		
  		tincludeAdvisor,
  		tadvisorsubject,
  		tincludeAdvisorEmail,
  		temailAdvisorSubject,
  		temailAdvisorRecepient,
  		tincludeUser,
  		tuserSubject,
  		tincludeUserEmail,
  		temailUserSubject    VARCHAR(60);
          
  	DECLARE
  		ttheme,
  		tfirstname,
  		tlastname,
  		tportfolioName,
  		tgoal,
  		tacctType,
  		tclientAccountID VARCHAR(60);
  
  	DECLARE tinvested DOUBLE;
  
      
  	set tAlertTime = DATE_FORMAT(now(),'%Y-%m-%d %T');
      
      SELECT COUNT(*)
      INTO tFound
      FROM notification_message_lookup
      WHERE notification_message_lookup.messageType = upper(p_messagetype)
      ;
      
      IF (tFound > 0)
      THEN
  		SELECT 
  			notification_message_lookup.includeAdvisor,
  			notification_message_lookup.advisorsubject,
  			notification_message_lookup.includeAdvisorEmail,
  			notification_message_lookup.emailAdvisorSubject,
  			notification_message_lookup.emailAdvisorRecepient,
  			notification_message_lookup.includeUser,
  			notification_message_lookup.userSubject,
  			notification_message_lookup.includeUserEmail,
  			notification_message_lookup.emailUserSubject
  		INTO
  			tincludeAdvisor,
  			tadvisorsubject,
  			tincludeAdvisorEmail,
  			temailAdvisorSubject,
  			temailAdvisorRecepient,
  			tincludeUser,
  			tuserSubject,
  			tincludeUserEmail,
  			temailUserSubject    
  		FROM notification_message_lookup
  		WHERE notification_message_lookup.advisor = upper(p_advisor)
  		AND   notification_message_lookup.messageType = upper(p_messagetype)
  		LIMIT 1;
  	  
  		SELECT 
  			user_trade_profile.theme,
  			IFNULL(ext_acct_info.applicantFName, user_trade_profile.firstname),
  			IFNULL(ext_acct_info.applicantLName, user_trade_profile.lastname),
  			user_trade_profile.portfolioName,
  			user_trade_profile.goal,
  			IFNULL(ext_acct_info.accountType,user_trade_profile.accttype),
  			invdb.funct_get_actualCapital(user_trade_profile.acctnum),
  			IFNULL(ext_acct_info.clientAccountID,user_trade_profile.acctnum)
  		INTO
  			ttheme,
  			tfirstname,
  			tlastname,
  			tportfolioName,
  			tgoal,
  			tacctType,
  			tinvested,
  			tclientAccountID
  		FROM user_trade_profile
  			 LEFT JOIN ext_acct_info
  			 ON (user_trade_profile.acctnum = ext_acct_info.acctnum)
  		WHERE user_trade_profile.acctnum = p_acctnum
  		LIMIT 1;
          
          SELECT
  			companyName, displayName
  		INTO tCompanyName, tRepDisplayName 
  		FROM invdb.user_advisor_info 
          WHERE advisor = p_advisor
          AND   rep     = p_rep;
          
          IF (tCompanyName is NULL and tRepDisplayName is NULL)
          THEN
  			set tCompanyName = FUNCT_WEB_INFO_BY_ADVISOR(p_advisor, 'WEB.COMPANYNAME');
              set tRepDisplayName = 'House Account';
          END IF;
  		
  		set tName = concat(tfirstname,' ',tlastname);
  		IF (tincludeUser='Y')
  		THEN
  			set tMessage = null;
  			IF (p_messageType = 'PROCESSED')
  			THEN
  				SET tMessage=concat('<div>',tuserSubject,'</div><div>Account-',tclientAccountID,'</div>');
  
  			END IF;
  			IF (p_messageType = 'OPENED')
  			THEN
  					
  				SET tMessage=concat('<div>',tuserSubject,'</div><div>Account-',tclientAccountID,'</div>');
  
  			END IF;
  			IF (p_messageType = 'FUNDED')
  			THEN
  				set tInvested = Round(tInvested,2);
  					
  				SET tMessage=concat('<div>',tuserSubject,'</div><div>Account-',tclientAccountID,'</div>');
  
  			END IF;
            
  			IF (p_messageType = 'ACTIVE')
  			THEN
  				set tInvested = Round(tInvested,2);  					
  				SET tMessage=concat('<div>',tuserSubject,'</div><div>Account-',tclientAccountID,'</div>');
  			END IF;		
            
  			IF (p_messageType = 'REBALANCE')
  			THEN
  					
  				SET tMessage=concat('<div>',tuserSubject,'</div><div>Account-',tclientAccountID,'</div>');
  			END IF;
            
  			IF (p_messageType = 'CHNGADDRS')
   			THEN
  				SET tMessage=concat('<div>',tuserSubject,'</div><div>Account-',tclientAccountID,'</div>');
   			END IF;
            
 			IF (p_messageType = 'PRFLCNFREQ')
   			THEN  					
  				SET tMessage=concat('<div>',tuserSubject,'</div><div>Account-',tclientAccountID,'</div>');
   			END IF;
            
             IF (p_messageType = 'PRFLCNFIRMED')
   			THEN
  					
  				SET tMessage=concat('<div>',tuserSubject,'</div><div>Account-',tclientAccountID,'</div>');
   			END IF;
            
   			IF (tMessage is not NULL)
   			THEN
   				CALL invdb.sav_notification_consumer(
   				  null, 
   				  'N', 
   				  p_logonid, 
   				  p_advisor,
   				  p_acctnum, 
   				   CASE 
 								WHEN (p_messageType = 'PRFLCNFREQ') THEN 'H'
 								ELSE 'L'
 							END, 
   				  'Message', 
   				  tAlertTime, 
   				  tMessage, CASE 
 								WHEN (p_messageType = 'PRFLCNFIRMED') THEN 'D'
 								ELSE 'E'
 							END,
                            CASE 
 								WHEN (p_messageType = 'PRFLCNFREQ') THEN concat('cadd.xhtml?app=A&acct=',p_acctnum)
 								ELSE null
 							END
   				);
   			END IF;
   		END IF;
         end if;
  
  
   		
   END$$

DELIMITER ;


/* 5_sp_create_sav_notification_consumer.sql020218_sagar*/

USE `invdb`;
DROP procedure IF EXISTS `sav_notification_consumer`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sav_notification_consumer`(
    p_messageid bigint(20),
    p_status varchar(1),
    p_logonid bigint(20),
    p_advisor varchar(20),
    p_acctnum bigint(20),
    p_noticetype varchar(1),
    p_tagid varchar(20),
    p_alertdatetime varchar(100),
    p_message varchar(120),
    p_flag varchar(1),
    p_link varchar(120)
  )
BEGIN

  if(p_flag='D')
  then 
	update user_notification set status='A',noticetype='L' where logonid=p_logonid and acctnum=p_acctnum and noticetype='H';
  end if;
  
  		INSERT INTO user_notification
  			(messageid,
  			status,
  			logonid,
  			advisor,
  			acctnum,
  			noticetype,
  			tagid,
  			alertdatetime,
  			message,
  			created,
  			lastupdated,link)
  		VALUES
  			(p_messageid,
  			p_status,
  			p_logonid,
  			p_advisor,
  			p_acctnum,
  			p_noticetype,
  			p_tagid,
  			p_alertdatetime,
  			p_message,
  			now(),
  			null,p_link)
  		ON duplicate key update
  			status = p_status,
  			advisor = p_advisor,
  			noticetype = p_noticetype,
  			tagid = p_tagid,
  			lastupdated = now()
  		; 
  END$$

DELIMITER ;


/* 6_sp_create_audit_acct_financial.sql020218_sagar*/

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

/* 7_sp_create_audit_asset_alloc.sql020218_sagar*/

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
-- Table structure for table `asset_alloc`
--

DROP TABLE IF EXISTS `asset_alloc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_alloc` (
  `srno` bigint(20) NOT NULL,
  `acctnum` bigint(20) NOT NULL,
  `assetclass` varchar(40) NOT NULL,
  `themecode` varchar(20) NOT NULL DEFAULT 'ETF',
  `allocationmodel` varchar(1) NOT NULL COMMENT 'Valid Values (In order of preference)\\\\\\\\nD - Default\\\\\\\\nC - Community\\\\\\\\nE - Expert\\\\\\\\nU - User\\\\\\\\n',
  `assetyear` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `active` varchar(1) DEFAULT NULL COMMENT 'Valid Values:\\\\\\\\nY - Active\\\\\\\\nN - Inactive (Data is for storage purpose only)',
  `sortnum` tinyint(4) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `base_currency` varchar(3) DEFAULT 'USD',
  `money` double DEFAULT '0',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `lastupdated` timestamp NULL DEFAULT NULL,
  `auditedBy` varchar(45) DEFAULT NULL,
  `audited` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`srno`,`acctnum`,`assetclass`)
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

/* 8_sp_create_audit_user_risk_profile.sql020218_sagar*/

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
-- Table structure for table `user_risk_profile`
--

DROP TABLE IF EXISTS `user_risk_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_risk_profile` (
  `srno` bigint(20) NOT NULL,
  `acctnum` bigint(20) NOT NULL,
  `key` varchar(30) NOT NULL DEFAULT '',
  `sortorder` int(11) DEFAULT NULL,
  `answer` varchar(30) DEFAULT NULL,
  `answerType` varchar(1) DEFAULT 'T',
  `riskScore` double DEFAULT NULL,
  `created` date DEFAULT NULL,
  `lastUpdated` date DEFAULT NULL,
  `auditedBy` varchar(45) DEFAULT NULL,
  `audited` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`srno`,`acctnum`,`key`)
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

/* 9_sp_create_audit_user_risk_questions.sql020218_sagar*/

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

/* 10_sp_create_audit_user_risk_score.sql020218_sagar*/	

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
-- Table structure for table `user_risk_score`
--

DROP TABLE IF EXISTS `user_risk_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_risk_score` (
  `srno` bigint(20) NOT NULL AUTO_INCREMENT,
  `acctnum` bigint(20) NOT NULL,
  `year` int(11) NOT NULL,
  `calcFormula` varchar(1) DEFAULT 'C',
  `allCashFlag` tinyint(1) DEFAULT '0',
  `score` double NOT NULL,
  `standardScore` double NOT NULL,
  `assetScore` double DEFAULT NULL,
  `portfolioScore` double DEFAULT NULL,
  `adjustment` double DEFAULT NULL,
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

/* 11__sp_create_audit_user_trade_profile.sql020218_sagar*/

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

/* 12_sp_create_audit_virtual_portfolio.sql020218_sagar*/

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

/* 13_sp_create_sp_client_profile_audit.sql020218_sagar*/

USE `audit`;
DROP procedure IF EXISTS `sp_client_profile_audit`;

DELIMITER $$
USE `audit`$$
CREATE PROCEDURE `sp_client_profile_audit`(in p_acctnum bigint)
begin
declare maxsrno bigint;
## audit entry for invdb user_trade_profile
insert into audit.user_trade_profile(acctnum,advisor,rep,theme,firstname,fullname,lastname,portfolioName,goal,acctType,age,horizon,initialInvestment,tradeCurrency,settleCurrency,exchangeRate,
recurringInvestment,experience,longTermGoal,stayInvested,charitablegoals,dependent,riskIndex,tradePreference,keepLiquid,taxable,calcModel,assetIndex,portfolioIndex,
goalAmount,email,ip,created,lastUpdated,managed,clientAccountID,status,customName,auditedBy,audited)
select acctnum,advisor,rep,theme,firstname,fullname,lastname,portfolioName,goal,acctType,age,horizon,initialInvestment,tradeCurrency,settleCurrency,exchangeRate,
recurringInvestment,experience,longTermGoal,stayInvested,charitablegoals,dependent,riskIndex,tradePreference,keepLiquid,taxable,calcModel,assetIndex,portfolioIndex,
goalAmount,email,ip,created,lastUpdated,managed,clientAccountID,status,customName,'SYSTEM',now() 
from invdb.user_trade_profile where acctnum=p_acctnum;

## audit entry for invdb user_risk_profile
select ifnull(max(srno),0)+1 into maxsrno from audit.user_risk_profile ;

insert into audit.user_risk_profile (srno,acctnum,`key`,sortorder,answer,answerType,riskScore,created,lastUpdated,auditedBy,audited)
select maxsrno,acctnum,`key`,sortorder,answer,answerType,riskScore,created,lastUpdated,'SYSTEM',now() 
from invdb.user_risk_profile where acctnum=p_acctnum;

## audit entry for invdb user_risk_score
insert into audit.user_risk_score (acctnum,`year`,calcFormula,allCashFlag,score,standardScore,assetScore,portfolioScore,adjustment,created,lastUpdated,auditedBy,audited)
select acctnum,`year`,calcFormula,allCashFlag,score,standardScore,assetScore,portfolioScore,adjustment,created,lastUpdated,'SYSTEM',now()
from invdb.user_risk_score where acctnum=p_acctnum;

## audit entry for invdb user_risk_questions
insert into audit.user_risk_questions (acctnum,investmentgoal,age,retireage,retired,horizon,ans1,ans2,ans3,ans4,ans5,ans6,ans7,ans8,ans9,ans10,ans11,ans12,ans13,ans14,
ans15,formula,risk1,risk2,risk3,risk4,risk5,risk6,risk7,risk8,risk9,risk10,risk11,risk12,risk13,risk14,risk15,standardRisk,overrideRisk,totalrisk,riskByQuestion,
riskOverride,created,lastUpdated,auditedBy,audited)
select acctnum,investmentgoal,age,retireage,retired,horizon,ans1,ans2,ans3,ans4,ans5,ans6,ans7,ans8,ans9,ans10,ans11,ans12,ans13,ans14,ans15,formula,
risk1,risk2,risk3,risk4,risk5,risk6,risk7,risk8,risk9,risk10,risk11,risk12,risk13,risk14,risk15,standardRisk,overrideRisk,totalrisk,riskByQuestion,riskOverride,created,
lastUpdated,'SYSTEM',now() 
from invdb.user_risk_questions where acctnum=p_acctnum;

## audit entry for invdb acct_financial
insert into audit.acct_financial (acctnum,dependent,estdDependentExpense,householdwages,otherincome,bonusincome,interestincome,dividentincome,rentalIncome,totalIncome,
totalIncomeAnnulized,householdPayment,otherPropertiesPayment,automobilePayment,medicalPayment,federaltaxes,stateTaxes,propertyTax,otherPropertyTax,homeInsurance,lifeInsurance,
autoInsurance,educationPayment,creditCardPayment,miscExpenses,totalExpense,totalExpenseAnnulized,homeEquity,autoValue,moneyMarket,checkingAcct,savingAcct,investment,
equityOtherProperties,retirementInvestement,miscInvestment,totalAsset,mortgageLoan,autoLoan,educationLoan,creditCardDebt,otherPropertiesLoan,medicalDebt,otherDebt,totalDebt,
liquidnetworth,networth,created,lastupdated,auditedBy,audited)
select acctnum,dependent,estdDependentExpense,householdwages,otherincome,bonusincome,interestincome,dividentincome,rentalIncome,totalIncome,totalIncomeAnnulized,
householdPayment,otherPropertiesPayment,automobilePayment,medicalPayment,federaltaxes,stateTaxes,propertyTax,otherPropertyTax,homeInsurance,lifeInsurance,autoInsurance,
educationPayment,creditCardPayment,miscExpenses,totalExpense,totalExpenseAnnulized,homeEquity,autoValue,moneyMarket,checkingAcct,savingAcct,investment,equityOtherProperties,
retirementInvestement,miscInvestment,totalAsset,mortgageLoan,autoLoan,educationLoan,creditCardDebt,otherPropertiesLoan,medicalDebt,otherDebt,totalDebt,liquidnetworth,
networth,created,lastupdated,'SYSTEM',now() from invdb.acct_financial where acctnum=p_acctnum;

## audit entry for invdb asset_alloc
select ifnull(max(srno),0)+1 into maxsrno from audit.asset_alloc;

insert into audit.asset_alloc (srno,acctnum,assetclass,themecode,allocationmodel,assetyear,active,sortnum,weight,base_currency,money,created,lastupdated,auditedBy,audited)
select maxsrno,acctnum,assetclass,themecode,allocationmodel,assetyear,active,sortnum,weight,base_currency,money,created,lastupdated,'SYSTEM',now() from invdb.asset_alloc where acctnum=p_acctnum;

## audit entry for invdb virtual_portfolio
select ifnull(max(srno),0)+1 into maxsrno from audit.virtual_portfolio;

insert into audit.virtual_portfolio (srno,acctnum,itemnum,ticker,active,tradeCurrency,qty,weight,tradeprice,investmentvalue,settleCurrency,exchangeRate,dest_currency,dest_qty,
dest_price,dest_value,settleQty,settlePrice,settleValue,created,lastupdated,auditedBy,audited)
select maxsrno,acctnum,itemnum,ticker,active,tradeCurrency,qty,weight,tradeprice,investmentvalue,settleCurrency,exchangeRate,dest_currency,dest_qty,dest_price,
dest_value,settleQty,settlePrice,settleValue,created,lastupdated,'SYSTEM',now() 
from invdb.virtual_portfolio where acctnum=p_acctnum;

end$$

DELIMITER ;


