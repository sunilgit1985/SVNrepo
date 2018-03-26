DROP PROCEDURE IF EXISTS `invdb`.`sel_collectTradeCustomerProfile`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_collectTradeCustomerProfile`(
	p_acctnum 	BIGINT(20)
)
BEGIN
	begin
        SELECT
			`user_access_role`.`logonid`,
			`trade_process_identifier`.`acctnum`,
            `user_trade_profile`.`clientAccountID`,
            `user_trade_profile`.`advisor`,
            `user_trade_profile`.`theme`,
            `user_trade_profile`.`acctType`,
			`user_trade_profile`.`age`,
            `user_trade_profile`.`horizon`,
            `invdb`.`funct_get_actualCapital`(`trade_process_identifier`.`acctnum`) as `investment`
		FROM `trade_process_identifier`
		INNER JOIN `user_trade_profile`
        ON (`user_trade_profile`.`acctnum` = `trade_process_identifier`.`acctnum`)
        INNER JOIN `user_access_role`
        ON (`trade_process_identifier`.`acctnum` = `user_access_role`.`acctnum`
        AND  `user_access_role`.`role` = 'OWNER')
		WHERE `trade_process_identifier`.`acctnum` = p_acctnum
     	;

    end;
END$$
DELIMITER ;
