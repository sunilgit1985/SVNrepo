DROP PROCEDURE IF EXISTS `testing`.`sp_emulate_step4_funding`;

DELIMITER $$
CREATE PROCEDURE `testing`.`sp_emulate_step4_funding`(
  IN p_acctnum BIGINT,
  IN p_amount  DOUBLE,
  IN p_logonid BIGINT(20),
  IN p_currency VARCHAR(3)
)
BEGIN
    DECLARE tFound1 INTEGER;
    DECLARE tFound2 INTEGER;
    DECLARE tStatus INTEGER;
    DECLARE tClientAccountID VARCHAR(20);

    SELECT count(*)
    INTO tFound1
    FROM invdb.ext_acct_info eai
    WHERE eai.acctnum = p_acctnum;

    IF (IFNULL(tFound1, 0) = 0)
    THEN
      SELECT 'This account# NOT YET OPENED' AS msg;
    ELSE
      SELECT clientAccountID
      INTO tClientAccountID
      FROM invdb.ext_acct_info eai
      WHERE eai.acctnum = p_acctnum;

      IF (IFNULL(tClientAccountID, 'XXX') != 'XXX')
      THEN
        CALL testing.sp_fund_account(p_acctnum, p_amount, p_currency);
        CALL invdb.sp_user_profile_manage(p_acctnum, 'F',p_logonid);

        SELECT 'This account# was ACTIVATED and POSITION created' AS msg;
      ELSE
        SELECT 'This account# was NOT FOUND to ext_acct_info' AS msg;
      END IF;

    END IF;


  END$$
DELIMITER ;
