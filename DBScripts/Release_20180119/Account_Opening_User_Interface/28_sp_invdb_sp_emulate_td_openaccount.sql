USE `testing`;
DROP procedure IF EXISTS `sp_emulate_td_openaccount`;

DELIMITER $$
USE `testing`$$
CREATE PROCEDURE `sp_emulate_td_openaccount`(
	IN p_acctnum	BIGINT,
    IN p_logonid BIGINT(20)
)
BEGIN
	DECLARE tFound1 INTEGER;
    DECLARE tFound2	INTEGER;
	DECLARE tStatus	INTEGER;
    
    SELECT count(*)
    INTO tFound1
    FROM `invdb`.`dc_requests`
    WHERE `dc_requests`.`reqType` like '%NEW'
    AND `dc_requests`.`acctnum` = `p_acctnum`
    ;
    
    SELECT count(*)
    INTO tFound2
    FROM `invdb`.`ext_acct_info`
    WHERE `ext_acct_info`.`acctnum` = `p_acctnum`
    ;
    
    IF (IFNULL(tFound2,0) != 0)
    THEN
		SELECT 'This account# is already created.' as msg;
	ELSE
        IF (IFNULL(tFound1,0) = 0)
		THEN
			SELECT 'This account# NOT yet processed to TD' as msg;
		ELSE
        
			SELECT COUNT(*)
            INTO tFound2
            FROM `invdb`.`dc_acct_owners_details`
            WHERE `dc_acct_owners_details`.`acctnum` = `p_acctnum`
            ;
            
            IF (IFNULL(tFound2,0) > 0)
            THEN
				INSERT INTO `invdb`.`ext_acct_info`
				(
					`clientAccountID`,
					`acctnum`,
					`status`,
					`rep`,
					`email`,
					`accountType`,
					`applicantFName`,
					`applicantMName`,
					`applicantLName`,
					`address1`,
					`address2`,
					`address3`,
					`city`,
					`state`,
					`zipcode`,
					`country`,
					`primaryPhoneNbr`,
					`secondayPhoneNbr`,
					`workPhoneNbr`,
					`faxNbr`,
					`ssn`,
					`dob`,
					`acctType`,
					`taxable`,
					`objective`,
					`dateOpened`,
					`created`,
					`lastUpdated`
				)
				SELECT
					CONCAT('TST',`dc_acct_owners_details`.`acctnum`) as clientAccountID, 
					`dc_acct_owners_details`.`acctnum`, 
					'P', 
					null , 
					`dc_acct_owners_details`.`emailAddress` , 
					`dc_acct_details`.`acctTypeId`, 
					`dc_acct_owners_details`.`firstName`, 
					null, 
					`dc_acct_owners_details`.`lastName`, 
					`dc_acct_owners_details`.`physicalAddressStreet`, 
					null, 
					null, 
					`dc_acct_owners_details`.`physicalAddressCity`, 
					`dc_acct_owners_details`.`physicalAddressState`, 
					`dc_acct_owners_details`.`physicalAddressZipCode`, 
					'USA',  
					`dc_acct_owners_details`.`phoneNumber`,  
					`dc_acct_owners_details`.`secondPhoneNumber`,  
					null, 
					null, 
					`dc_acct_owners_details`.`ssn`, 
					`invdb`.`funct_strdate2inv_date`(`dc_acct_owners_details`.`dob`,'%m/%d/%Y'), 
					`dc_m_lookup`.`displayName`,
					null, 
					null, 
					`invdb`.`funct_date2inv_date`(now()) `performanceInceptionDate`, 
					now(), 
					null 
				FROM `invdb`.`dc_acct_owners_details` as `dc_acct_owners_details`
					,`invdb`.`dc_acct_details`
					,`invdb`.`dc_m_lookup`
				WHERE `dc_acct_owners_details`.`acctnum` = `p_acctnum`
				AND   `dc_acct_owners_details`.`acctOwnerId` = 1
				AND   `dc_acct_owners_details`.`acctnum`  = `dc_acct_details`.`acctnum`
				AND   `dc_acct_details`.`acctTypeId` = `dc_m_lookup`.`lookupCode`
				AND   `dc_m_lookup`.`lookupSet` = 'ACCTTYPE'
				;
                
				call `invdb`.`sp_user_profile_manage`(`p_acctnum`, 'O',p_logonid);
 
				SELECT 'This account# was ADDED to ext_acct_info' as msg;
			ELSE
				SELECT 'This account# was NOT FOUND to dc_acct_owners_details' as msg;
            END IF;
		END IF;

	END IF;
    
    

END$$

DELIMITER ;

