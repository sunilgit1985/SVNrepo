DROP PROCEDURE IF EXISTS `invdb`.`sp_is_email_taken`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sp_is_email_taken`(
    IN p_email 			varchar(60)
 )
BEGIN 
 
	BEGIN
		SELECT 'PROD' as src
        FROM 	user_logon
        WHERE 	user_logon.email = p_email
        AND     user_logon.logonstatus not in  ('T')
        UNION
		SELECT 'INVITED' as src
        FROM 	user_invited
        WHERE 	user_invited.email = p_email
        AND     user_invited.logonstatus in ('T')
        ;
    END;
END$$
DELIMITER ;
