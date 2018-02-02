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

