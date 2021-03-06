DROP PROCEDURE IF EXISTS `testing`.`sp_emulate_td_activateaccount`;

DELIMITER $$
CREATE PROCEDURE `testing`.`sp_emulate_td_activateaccount` (
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
			INSERT INTO `invdb`.`ext_position`
				(`acctnum`,
				`clientAccountID`,
				`currencyPrimary`,
				`fxRateToBase`,
				`symbol`,
				`reportDate`,
				`purchaseDate`,
				`side`,
				`quantity`,
				`costBasisPrice`,
				`costBasisMoney`,
				`markPrice`,
				`positionValue`,
				`pnlUnrealized`,
				`levelOfDetail`,
				`created`
				)
			SELECT
				`ext_acct_info`.`acctnum` -- `acctnum`,
				, `ext_acct_info`.`clientAccountID` as clientAccountID -- `clientAccountID`,
				, 'USD' as currencyPrimary -- `currencyPrimary`,
				, '1.0' as fxRateToBase-- `fxRateToBase`,
				, 'Cash' as symbol -- `symbol`,
				, `invdb`.`FUNCT_GET_SWITCH`('BROKER_BDATE') as reportDate -- `reportDate`,
				, `invdb`.`FUNCT_GET_SWITCH`('BROKER_BDATE') as purchaseDate -- `purchaseDate`,
				, 'Long' as `side`
				, `p_amount` as `quantity`
				, 1 as costBasisPrice
				, `p_amount` as `costBasisMoney`
				, 1 as markPrice
				, `p_amount` as `positionValue`
				, 0 as pnlUnrealized
				, 'Cash' as `levelOfDetail`
				, now() as created
			FROM `invdb`.`ext_acct_info` as `ext_acct_info`
			WHERE `ext_acct_info`.`acctnum` = `p_acctnum`
            ON duplicate key update
				  `quantity` = `quantity` + `p_amount`
                , `costBasisMoney` = `costBasisMoney` + `p_amount`
                , `positionValue` = `positionValue` + `p_amount`
                , `levelOfDetail` = 'Funded'
			;
                

		   INSERT INTO `invdb`.`ext_nav`
				(`clientAccountID`,
				`reportDate`,
				`cash`,
				`stock`,
				`funds`,
				`interestAccrual`,
				`dividentAccrual`,
				`total`)
			VALUES
			(tClientAccountID,
			`invdb`.`FUNCT_GET_SWITCH`('BROKER_BDATE'),
			`p_amount`,
			0,
			0,
			0,
			0,
			`p_amount`)
            ON duplicate key update
				 `cash` = `cash` + `p_amount`
                , `total` = `total` + `p_amount`
			;

                
			UPDATE `invdb`.`ext_acct_info`
				set `ext_acct_info`.`status` = 'A'
			WHERE `ext_acct_info`.`acctnum` = `p_acctnum`;
			
			call `invdb`.`sp_user_profile_manage`(`p_acctnum`, 'A');
                
			SELECT 'This account# was ACTIVATED and POSITION created' as msg;
		ELSE
			SELECT 'This account# was NOT FOUND to ext_acct_info' as msg;
 		END IF;

	END IF;
    
    

END$$
DELIMITER ;
