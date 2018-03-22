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

