USE `temp`;
DROP procedure IF EXISTS `sp_trade_process_both_update`;

DELIMITER $$
USE `temp`$$
CREATE  PROCEDURE `sp_trade_process_both_update`()
BEGIN

update invdb.user_trade_log utl
set utl.tradeStatus='S'
WHERE utl.tradeStatus = 'I';

END$$

DELIMITER ;

