DROP PROCEDURE IF EXISTS `testing`.`invite_advisor`;

DELIMITER $$
CREATE PROCEDURE `testing`.`invite_advisor`(
   p_logonid		BIGINT(20)  -- Optional  (If provided, then it created advisor ID on that logonid)
  ,p_userid			VARCHAR(60)
  ,p_email			VARCHAR(60)
  ,p_firstname		VARCHAR(25)
  ,p_lastname		VARCHAR(25)
  ,p_advisor		VARCHAR(20)
  ,p_rep			VARCHAR(20)
  ,p_companyName	VARCHAR(60)
  ,p_displayName	VARCHAR(60)
  ,p_accttype		VARCHAR(20)
  ,p_ops_email		VARCHAR(60)
  ,p_td_advisorCode VARCHAR(20)
)
BEGIN

	DECLARE tAdvisorFound	INTEGER;
    DECLARE tLogonID		BIGINT(20);
    
    IF (p_logonid is not null)
		THEN
			set tLogonID = p_logonid;

            
		ELSE
			SELECT `logonid`
			INTO tLogonID
			FROM `invdb`.`user_logon`
			WHERE `user_logon`.`email` = p_email;
			
	END IF;
        
	DELETE FROM `invdb`.`user_logon`
	WHERE `user_logon`.`email` = p_email;
	
	DELETE FROM `invdb`.`user_logon`
	WHERE `logonid` = tLogonID;
    
	INSERT INTO `invdb`.`user_logon`
		(`logonid`, `userid`, `pwd`, `logonstatus`, `firstname`,`lastname`,  `email`, `advisor`, `rep`, `emailmsgtype`,`access`,`atstart`)
	VALUES
		(tLogonID, p_userid, 'Default', 'T', p_firstname, p_lastname, p_email, p_advisor, p_rep, 'HTML', 'advisor', 'setting');
		
	select p_logonid into tLogonID;

    
    SELECT COUNT(*)
    INTO tAdvisorFound
    FROM `invdb`.`user_advisor_info`
    WHERE `user_advisor_info`.`logonid` = tLogonID;
    
    IF (IFNULL(tAdvisorFound,0) = 0)
		THEN
        
			DELETE FROM `invdb`.`user_advisor_info`
            WHERE `advisor` = p_advisor and `rep` = p_rep;
            
			INSERT INTO `invdb`.`user_advisor_info`
				(`logonid`,	`advisor`,	`rep`, `accttype`, `companyName`, `displayName`,`logo`,`advisor_css`,`created`)
			VALUES
				(tLogonID, p_advisor, p_rep, p_accttype, p_companyName, p_displayName, null, null, now());
		ELSE
			UPDATE `invdb`.`user_advisor_info`
				set `advisor` = p_advisor
                ,	`rep` = p_rep
                , 	`accttype` = p_accttype
                ,	`companyName` = p_companyName
                ,	`displayName` = p_displayName
			WHERE 	`user_advisor_info`.`logonid` = tLogonID;
	END IF;
    
    SELECT COUNT(*)
    INTO tAdvisorFound
    FROM `invdb`.`user_advisor_access`
    WHERE `user_advisor_access`.`logonid` = tLogonID;
    
    IF (IFNULL(tAdvisorFound,0) = 0)
		THEN
			INSERT INTO `invdb`.`user_advisor_access`
				(`logonid`,	`advisor`,	`rep`, `privileges` ,`created`)
			VALUES
				(tLogonID, p_advisor, p_rep, 'V', now());
		ELSE
			UPDATE `invdb`.`user_advisor_access`
				set `advisor` = p_advisor
                ,	`rep` = p_rep
			WHERE 	`user_advisor_access`.`logonid` = tLogonID;
	END IF;
 
	CALL `invdb`.`dctd_add_template_id`(
		   p_accttype -- p_templateID		VARCHAR(20)
		  ,p_td_advisorCode -- p_advisorCode	VARCHAR(20)
		  ,p_advisor	-- , p_advisor	VARCHAR(20)
		  ,p_rep		-- , p_rep VARCHAR(20)
		  ,p_companyName -- p_firmname		VARCHAR(60)
		  ,CONCAT(p_firstname, ' ', p_lastname) -- . p_primaryContact VARCHAR(60)
		  ,p_ops_email -- , p_ops_email		VARCHAR(60)
		);
	
    /*
    CALL `invdb`.`sp_email_messages_add_mod`
    ('A'
    , 'User'
    , null
    , 'no-reply@invessence.com'
    , p_email
    , p_ops_email
    , null
    , 'Advisor ID Setup'
    , 0
    , 0
    , 0
    , null
    , null
    , CONCAT('Your userid: ', p_userid ,' is setuo.\n Please visit the site')
    , null
    , null
    , 'TEXT'
    );
    */

	
 
    
END$$
DELIMITER ;
