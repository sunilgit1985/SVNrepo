DROP PROCEDURE IF EXISTS `invdb`.`sel_NewAccountProfile`;


DELIMITER $$
CREATE PROCEDURE `sel_NewAccountProfile`(
	IN p_advisor VARCHAR(20),
    IN p_rep	 VARCHAR(20),
    In p_logonid BIGINT(20)
)
BEGIN

	IF (p_logonid is not null)
    THEN
			select 
				IFNULL(`user`.`advisor`,'Invessence') `advisor`,
				`user`.`rep` `rep`,
                IFNULL(`basket`.`displayName`,`user`.`advisor`)  `displayname`,
                IFNULL(`basket`.`theme`,'0.Core') `theme`
			from
				`user_logon` `user`
                LEFT JOIN `user_basket_access` `basket`
                ON (IFNULL(`p_advisor`, `user`.advisor ) = `basket`.advisor
					AND `basket`.`sortorder` = 0
					AND `basket`.`primary` = 'Y')
			where
				`user`.logonid = p_logonid
			;
	ELSE
		IF (p_advisor is not null)
        THEN 
			IF (p_rep is null) 
			THEN
					select 
					`advisor`.`advisor` `advisor`,
					`advisor`.`rep` `rep`,
					IFNULL(`basket`.`displayName`,`advisor`.`displayname`) `displayname`,
					IFNULL(`basket`.`theme`,'0.Core') `theme`
					from
						`user_advisor_info` `advisor`
						LEFT JOIN `user_basket_access` `basket`
						ON (`advisor`.advisor = `basket`.advisor
							AND `basket`.`sortorder` = 0
							AND `basket`.`primary` = 'Y')
					where
						`advisor`.advisor = p_advisor
						LIMIT 1;
			ELSE
				select 
				`advisor`.`advisor` `advisor`,
				`advisor`.`rep` `rep`,
                IFNULL(`basket`.`displayName`,`advisor`.`displayname`) `displayname`,
                IFNULL(`basket`.`theme`,'0.Core') `theme`
				from
					`user_advisor_info` `advisor`
					LEFT JOIN `user_basket_access` `basket`
					ON (`advisor`.advisor = `basket`.advisor
						AND `basket`.`sortorder` = 0
						AND `basket`.`primary` = 'Y')
				where
					`advisor`.advisor = p_advisor
				and `advisor`.rep     = p_rep;
			END IF;
		ELSE
				select 
					FUNCT_GET_SWITCH('DefaultAdvisor') `advisor`,
					FUNCT_GET_SWITCH('DefaultRep') `rep`,
					FUNCT_GET_SWITCH('Company') `displayname`,
					'0.Core' `theme`
				;
		END IF;
   END IF;
	
END$$
DELIMITER ;
