DROP PROCEDURE IF EXISTS `invdb`.`sp_invite_user`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sp_invite_user`(
    IN p_email 			varchar(60),
    IN p_logonstatus	varchar(1),
    IN p_accessmode		varchar(1),
	IN p_prefix			varchar(25),
    IN p_firstname		varchar(25),
	IN p_middlename		varchar(25),
    IN p_lastname		varchar(25),
	IN p_suffix			varchar(25),
    IN p_fullname		varchar(60),
    IN p_emailalt		varchar(60),
	IN p_stateRegistered varchar(6),
	IN p_leadSource		varchar(25),
    IN p_advisor		varchar(20),
    IN p_rep			varchar(20),
    IN p_ip				varchar(20),
    IN p_resetID		varchar(8)
 )
BEGIN 
 
    BEGIN
    INSERT INTO `invdb`.`user_invited`
		(`email`,
		`logonstatus`,
		`accessmode`,
        `prefix`,
		`lastname`,
		`firstname`,
		`middlename`,
		`suffix`,
		`fullname`,
		`emailalt`,
		`stateRegistered`,
		`leadSource`,
		`advisor`,
		`rep`,
		`ip`,
		`resetID`,
		`created`,
		`lastupdated`)
	VALUES (
         p_email
		,p_logonstatus
        ,p_accessmode
        ,p_prefix
		,p_lastname
		,p_firstname
        ,p_middlename
        ,p_suffix
        ,p_fullname
		,p_emailalt
        ,p_stateRegistered
        ,p_leadSource
		,p_advisor
		,p_rep
		,p_ip
		,p_resetID
        ,now()
        ,null
    );
    
    END;
END$$
DELIMITER ;
