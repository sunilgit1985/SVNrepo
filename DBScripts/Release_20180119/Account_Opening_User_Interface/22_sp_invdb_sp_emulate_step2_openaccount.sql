USE `testing`;
DROP procedure IF EXISTS `sp_emulate_step2_openaccount`;

DELIMITER $$
USE `testing`$$
CREATE PROCEDURE `sp_emulate_step2_openaccount`(
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
		ssn,
		dob,
		acctType,
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
              NULL, -- worknumber
              NULL, -- faxnum
              daod.ssn,
              invdb.funct_strdate2inv_date(daod.dob, '%m/%d/%Y'),
              dml.displayName,-- acctType,
              NULL, -- taxable
              NULL, -- objective
              invdb.funct_date2inv_date(now()) as performanceInceptionDate, -- dateOpened
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
		ssn,
		dob,
		acctType,
		taxable,
		objective,
		dateOpened,
		created,
		lastUpdated)
          VALUES (
            tClientAccountID,
            p_acctnum,
            'P',
            NULL, -- rep
            CONCAT('testing', p_acctnum, '@invessence.com'), -- email
            'Individual', -- accountType
            'Testing', -- firstname
            NULL, -- middleI
            p_acctnum, -- lastname
            null, -- address1,
            NULL, -- address2
            NULL, -- address3
            null, -- city,
            null, -- state,
            null, -- zip,
            null, -- country,
            null, -- primary phone,
            null, -- secondary phone,
            NULL, -- work phone
            NULL, -- fax number
            null, -- ssnum
            null, -- DOB,
            null, -- acctType
            NULL, -- taxable
            NULL, -- objective
            invdb.funct_date2inv_date(now()), -- date opened
			now(), -- created
            NULL -- last updated
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

