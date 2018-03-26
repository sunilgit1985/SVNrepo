USE `invdb`;
DROP procedure IF EXISTS `save_trade_process_identifier`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_trade_process_identifier`(
   `p_acctnum` 		bigint(20)
  ,`p_tradeStatus`	varchar(1) 
  ,`p_processStatus`	varchar(1) 
  ,`p_reason`			varchar(100)
)
BEGIN
	begin
    
		INSERT INTO `invdb`.`trade_process_identifier`
		(`acctnum`,
		`tradeStatus`,
		`processStatus`,
		`reason`,
		`created`,
		`updated`)
		VALUES
		(`p_acctnum`
		,`p_tradeStatus`
		,`p_processStatus`
		,`p_reason`
		,now()
		,null)
        ON duplicate key update
		`tradeStatus`=`p_tradeStatus`,
		`reason`=`p_reason`,
			`processStatus` = `p_processStatus`
            ,`updated` = now()
		;
    
    end;
END$$

DELIMITER ;

