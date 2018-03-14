USE `invdb`;
DROP procedure IF EXISTS `sel_user_logon`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sel_user_logon`(
	IN p_logonid	BIGINT,
    IN p_userid	    VARCHAR(60),
    IN p_email		VARCHAR(60)
)
BEGIN

	DECLARE whichOne Integer;
    DECLARE tFound   Integer;
    
    IF (IFNULL(p_logonid,0) > 0)
    THEN
		set whichOne = 1;
        
		SELECT count(*)
		INTO tFound
		FROM user_logon
		WHERE user_logon.logonid = p_logonid;
    END IF;
    
     IF ((IFNULL(tFound,0) = 0) and (p_userid is not null))
     THEN
		set whichOne = 2;
        
		SELECT count(*)
		INTO tFound
		FROM user_logon
		WHERE user_logon.userid = p_userid;
     END IF;
     IF ((IFNULL(tFound,0) = 0) and (p_email is not null))
     THEN
		set whichOne = 3;
        
		SELECT count(*)
		INTO tFound
		FROM user_logon
		WHERE user_logon.email = p_email;
    END IF;
    
    IF (IFNULL(tFound,0) > 0)
    THEN
   
	CASE
		WHEN (whichOne = 1)
			THEN
				SELECT user_logon.logonid,
					user_logon.userid,
					user_logon.pwd,
					user_logon.logonstatus,
					user_logon.prefix,
					user_logon.lastname,
					user_logon.firstname,
					user_logon.fullname,
					user_logon.middlename,
					user_logon.suffix,
					user_logon.email,
					user_logon.emailalt,
					user_logon.stateRegistered,
					user_logon.leadSource,
					user_logon.cid,
					user_logon.advisor,
					user_logon.rep,
					user_logon.question1,
					user_logon.answer1,
					user_logon.question2,
					user_logon.answer2,
					user_logon.question3,
					user_logon.answer3,
					user_logon.ip,
					user_logon.resetID,
					user_logon.emailmsgtype,
					user_logon.access,
					user_logon.created,
					user_logon.lastupdated
				FROM user_logon
				WHERE user_logon.logonid = p_logonid
				;
		WHEN (whichOne = 2)
			THEN
				SELECT user_logon.logonid,
					user_logon.userid,
					user_logon.pwd,
					user_logon.logonstatus,
					user_logon.prefix,
					user_logon.lastname,
					user_logon.firstname,
					user_logon.middlename,
					user_logon.fullname,
					user_logon.suffix,
					user_logon.email,
					user_logon.emailalt,
					user_logon.stateRegistered,
					user_logon.leadSource,
					user_logon.cid,
					user_logon.advisor,
					user_logon.rep,
					user_logon.question1,
					user_logon.answer1,
					user_logon.question2,
					user_logon.answer2,
					user_logon.question3,
					user_logon.answer3,
					user_logon.ip,
					user_logon.resetID,
					user_logon.emailmsgtype,
					user_logon.access,
					user_logon.created,
					user_logon.lastupdated
				FROM user_logon
				WHERE user_logon.userid = p_userid
				;
		WHEN (whichOne = 3)
        THEN
				SELECT user_logon.logonid,
					user_logon.userid,
					user_logon.pwd,
					user_logon.logonstatus,
					user_logon.prefix,
					user_logon.lastname,
					user_logon.firstname,
					user_logon.middlename,
					user_logon.fullname,
					user_logon.suffix,
					user_logon.email,
					user_logon.emailalt,
					user_logon.stateRegistered,
					user_logon.leadSource,
					user_logon.cid,
					user_logon.advisor,
					user_logon.rep,
					user_logon.question1,
					user_logon.answer1,
					user_logon.question2,
					user_logon.answer2,
					user_logon.question3,
					user_logon.answer3,
					user_logon.ip,
					user_logon.resetID,
					user_logon.emailmsgtype,
					user_logon.access,
					user_logon.created,
					user_logon.lastupdated
				FROM user_logon
				WHERE user_logon.email = p_email
                LIMIT 1
				;
	END CASE;
    END IF;
    
END$$

DELIMITER ;

