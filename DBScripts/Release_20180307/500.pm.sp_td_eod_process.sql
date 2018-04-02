DROP PROCEDURE IF EXISTS `temp`.`sp_td_eod_process`;

DELIMITER $$
CREATE PROCEDURE `temp`.`sp_td_eod_process`(
)
BEGIN
	DECLARE tDate	varchar(10);

	SELECT 
		MAX(`tmp_nav`.`reportDate`)
		INTO tDate FROM
	`temp`.`tmp_nav`;

	IF (tDate is not null)
	THEN
		CALL `temp`.`sp_updt_ext_acct_flag`();

		update invdb.user_trade_profile utp, invdb.ext_acct_info eai  
			set utp.status='S'
		where  eai.status = 'O' 
		and utp.acctnum=eai.acctnum
		and eai.clientAccountID in ( select distinct(tmpNav.clientAccountID)
		from temp.tmp_nav tmpNav) ;


		UPDATE invdb.ext_acct_info 
		SET 
		status = 'A'
		WHERE invdb.ext_acct_info.status = 'O'
		AND invdb.ext_acct_info.clientAccountID IN 
			(SELECT DISTINCT(tmpNav.clientAccountID) FROM temp.tmp_nav tmpNav);
	END IF;

	CALL `temp`.`sp_inv_switch_eod`(NULL);


END$$
DELIMITER ;
