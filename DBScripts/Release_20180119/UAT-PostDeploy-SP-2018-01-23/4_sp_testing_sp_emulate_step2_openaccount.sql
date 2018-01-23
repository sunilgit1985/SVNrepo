USE `testing`;
DROP procedure IF EXISTS `sp_emulate_step2_openaccount`;

DELIMITER $$
USE `testing`$$
CREATE  PROCEDURE `sp_emulate_step2_openaccount`(
  IN p_acctnum BIGINT,
    IN p_logonid BIGINT(20)
)
BEGIN
    DECLARE tFound1 INTEGER;
    DECLARE tFound2 INTEGER;
    DECLARE tStatus INTEGER;
    DECLARE tClientAccountID VARCHAR(10);

    SELECT count(*)
    INTO tFound1
    FROM invdb.user_trade_profile utp
    WHERE utp.acctnum = p_acctnum;

    SELECT count(*)
    INTO tFound2
    FROM invdb.ext_acct_info eai
    WHERE eai.acctnum = p_acctnum;

    IF (IFNULL(tFound2, 0) != 0)
    THEN
      SELECT 'This account# is already created.' AS msg;
    ELSE
      IF (IFNULL(tFound1, 0) = 0)
      THEN
        SELECT 'This account# found on DB' AS msg;
      ELSE

        SELECT COUNT(*)
        INTO tFound2
        FROM invdb.dc_acct_owners_details daod
        WHERE daod.acctnum = p_acctnum;

        set tClientAccountID = CONCAT('TST', p_acctnum);

		IF (IFNULL(tFound2, 0) > 0)
        THEN
        INSERT INTO invdb.ext_acct_info
		(clientAccountID,
		acctnum,
		status,
		rep,
		email,
		accountType,
		applicantFName,
		applicantMName,
		applicantLName,
		address1,
		address2,
		address3,
		city,
		state,
		zipcode,
		country,
		primaryPhoneNbr,
		secondayPhoneNbr,
		workPhoneNbr,
		faxNbr,
		identification,
		dob,
		idType,
		taxable,
		objective,
		dateOpened,
		created,
		lastUpdated)
            SELECT
              tClientAccountID AS clientAccountID,
               daod.acctnum,
              'P',
              NULL,
              daod.emailAddress,
              dad.acctTypeId,
              daod.firstName,
              NULL,
              daod.lastName,
              daod.physicalAddressStreet,
              NULL,
              NULL,
              daod.physicalAddressCity,
              daod.physicalAddressState,
              daod.physicalAddressZipCode,
              'USA',
              daod.phoneNumber,
              daod.secondPhoneNumber,
              NULL, 
              NULL, 
              daod.ssn,
              invdb.funct_strdate2inv_date(daod.dob, '%m/%d/%Y'),
              dml.displayName,
              NULL, 
              NULL, 
              invdb.funct_date2inv_date(now()) as performanceInceptionDate, 
              now(),
              NULL
            FROM invdb.dc_acct_owners_details AS daod
              , invdb.dc_acct_details dad
              , invdb.dc_m_lookup dml
            WHERE daod.acctnum = p_acctnum
                  AND daod.acctOwnerId = 1
                  AND daod.acctnum = dad.acctnum
                  AND dad.acctTypeId = dml.lookupCode
                  AND dml.lookupSet = 'ACCTTYPE';


          SELECT 'This account# was ADDED to ext_acct_info using TDs data' AS msg;
        ELSE
        INSERT INTO invdb.ext_acct_info
		(clientAccountID,
		acctnum,
		status,
		rep,
		email,
		accountType,
		applicantFName,
		applicantMName,
		applicantLName,
		address1,
		address2,
		address3,
		city,
		state,
		zipcode,
		country,
		primaryPhoneNbr,
		secondayPhoneNbr,
		workPhoneNbr,
		faxNbr,
		identification,
		dob,
		idType,
		taxable,
		objective,
		dateOpened,
		created,
		lastUpdated)
          VALUES (
            tClientAccountID,
            p_acctnum,
            'P',
            NULL, 
            CONCAT('testing', p_acctnum, '@invessence.com'), 
            'Individual', 
            'Testing', 
            NULL, 
            p_acctnum, 
            null, 
            NULL, 
            NULL, 
            null, 
            null, 
            null, 
            null, 
            null, 
            null, 
            NULL, 
            NULL, 
            null, 
            null, 
            null, 
            NULL, 
            NULL, 
            invdb.funct_date2inv_date(now()), 
			now(), 
            NULL 
          );

          SELECT 'This account# was ADDED to ext_acct_info using as sample data' AS msg;

        END IF;
        UPDATE invdb.user_trade_profile utp
			set clientAccountID = tClientAccountID
        WHERE utp.acctnum = p_acctnum;

        CALL invdb.sp_user_profile_manage(p_acctnum, 'O',p_logonid);
      END IF;

    END IF;


  END$$

DELIMITER ;