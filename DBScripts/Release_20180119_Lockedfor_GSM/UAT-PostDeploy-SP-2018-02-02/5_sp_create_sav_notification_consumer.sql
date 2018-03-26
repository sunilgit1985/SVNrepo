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

