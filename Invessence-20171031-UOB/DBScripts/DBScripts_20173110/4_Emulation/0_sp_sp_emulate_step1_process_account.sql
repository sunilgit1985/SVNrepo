drop procedure if exists testing.sp_emulate_step1_process_account;
delimiter $$
CREATE PROCEDURE testing.sp_emulate_step1_process_account(
  IN p_acctnum BIGINT
)
BEGIN
    DECLARE tFound1 INTEGER;
    DECLARE tFound2 INTEGER;
    DECLARE tStatus VARCHAR(2);
    DECLARE tManaged VARCHAR(2);

    SELECT count(*)
    INTO tFound1
    FROM invdb.ext_acct_info eai
    WHERE eai.acctnum = p_acctnum;

    IF (IFNULL(tFound1, 0) > 0)
    THEN
      SELECT 'This account is already active!' AS msg;
    ELSE
      SELECT
        managed,
        status
      INTO tManaged, tStatus
      FROM invdb.user_trade_profile utp
      WHERE utp.acctnum = p_acctnum;

      IF (IFNULL(tManaged, 'N') != 'N')
      THEN
        SELECT 'This account is marked active but has not external account details.  Cannot proceed!' AS msg;
      ELSE
        UPDATE invdb.user_trade_profile utp
        SET managed = 'N', status = 'P'
        WHERE utp.acctnum = p_acctnum;

        SELECT 'This account is process!' AS msg;
      END IF;

    END IF;

  END