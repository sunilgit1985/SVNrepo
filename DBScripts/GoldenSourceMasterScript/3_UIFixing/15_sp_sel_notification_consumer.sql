drop procedure if exists invdb.sel_notification_consumer;
delimiter $$
CREATE PROCEDURE invdb.sel_notification_consumer(IN p_logonid BIGINT,IN p_messagetype VARCHAR(1),IN p_archive VARCHAR(1))
 BEGIN 
  IF (p_archive is null)
  	THEN set p_archive = 'N';
  END IF;
   
  IF (p_archive <> 'N')THEN 		
 	select un.messageid,un.status,un.logonid, un.advisor, un.acctnum,eai.clientAccountID, un.noticetype, un.tagid, un.alertdatetime, un.message, un.link, un.created
 	from invdb.user_notification un
 	left join invdb.ext_acct_info eai on (un.acctnum=eai.clientAccountID)
 	WHERE un.logonid = p_logonid
  		AND IFNULL(un.status,'N') <> 'N'
  		and  un.alertdatetime <= now()
  		and  un.alertdatetime >= DATE_ADD(now(),INTERVAL -45 DAY)
 		and  IFNULL(un.tagid,'M') like concat(IFNULL(p_messagetype,'M'),'%');
  	ELSE
  		select un.messageid,un.status,un.logonid, un.advisor, un.acctnum,eai.clientAccountID, un.noticetype, un.tagid, un.alertdatetime, un.message, un.link, un.created
 	from invdb.user_notification un
 	left join invdb.ext_acct_info eai on (un.acctnum=eai.clientAccountID)
  		WHERE un.logonid= p_logonid
          AND  IFNULL(un.status,'N') = 'N'
  		and un.alertdatetime <= now()
          and  IFNULL(un.tagid,'M') like concat(IFNULL(p_messagetype,'M'),'%');     
  END IF;
  
  END