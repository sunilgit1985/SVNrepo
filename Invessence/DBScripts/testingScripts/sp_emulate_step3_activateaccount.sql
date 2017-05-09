DROP PROCEDURE IF EXISTS `testing`.`sp_emulate_td_activateaccount`;
DROP PROCEDURE IF EXISTS `testing`.`sp_emulate_step3_activateaccount`;

DELIMITER $$
CREATE PROCEDURE `testing`.`sp_emulate_step3_activateaccount` (
	IN p_acctnum	BIGINT,
  IN p_amount		DOUBLE
)
BEGIN
	DECLARE tFound1 INTEGER;
  DECLARE tFound2	INTEGER;
	DECLARE tStatus	INTEGER;
  DECLARE tClientAccountID VARCHAR(20);
    
    SELECT count(*)
    INTO tFound1
    FROM `invdb`.`ext_acct_info`
    WHERE `ext_acct_info`.`acctnum` = `p_acctnum`
    ;
    
	IF (IFNULL(tFound1,0) = 0)
	THEN
		SELECT 'This account# NOT YET OPENED' as msg;
	ELSE
		SELECT `clientAccountID`
		INTO tClientAccountID
		FROM `invdb`.`ext_acct_info`
		WHERE `ext_acct_info`.`acctnum` = `p_acctnum`
        ;

		IF (IFNULL(tClientAccountID,'XXX') != 'XXX')
		THEN

			UPDATE `invdb`.`ext_acct_info`
				set `ext_acct_info`.`managed` = 'A',
					  `ext_acct_info`.`status` = 'A'
			WHERE `ext_acct_info`.`acctnum` = `p_acctnum`;

			CALL `testing`.`sp_fund_account`(`p_acctnum`, `p_amount`);
			call `invdb`.`sp_user_profile_manage`(`p_acctnum`, 'A');
                
			SELECT 'This account# was ACTIVATED and POSITION created' as msg;
		ELSE
			SELECT 'This account# was NOT FOUND to ext_acct_info' as msg;
 		END IF;

	END IF;
    
    

END$$
DELIMITER ;
