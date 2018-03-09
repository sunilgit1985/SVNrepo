ALTER TABLE `invdb`.`user_advisor_info` 
ADD COLUMN `displayRep` VARCHAR(20) NULL AFTER `companyname`;


UPDATE `invdb`.`user_advisor_info` SET `displayRep`='436', `displayName`='Paul Devierno' WHERE `logonid`='4';




UPDATE `service`.`pdf_file_rules` SET `dbColumn`='displayRepName' WHERE `fileId`='UOB_ACCT_OPEN_EXISTING_USER' and`dataField`='salesPersonName';
UPDATE `service`.`pdf_file_rules` SET `dbColumn`='displayRepName' WHERE `fileId`='UOB_ACCT_OPEN_NEW_USER' and`dataField`='salesPersonName';
UPDATE `service`.`pdf_file_rules` SET `dbColumn`='displayRep' WHERE `fileId`='UOB_ACCT_OPEN_EXISTING_USER' and`dataField`='repId';
UPDATE `service`.`pdf_file_rules` SET `dbColumn`='displayRep' WHERE `fileId`='UOB_ACCT_OPEN_NEW_USER' and`dataField`='repId';



UPDATE `invdb`.`invessence_switch` SET `name`='SETT_CURRENCY', `description`='Settlment Currency' WHERE `name`='SETT_CURRUNCY';





USE `invdb`;
DROP procedure IF EXISTS `spao_uob_fetch_data`;

DELIMITER $$
USE `invdb`$$
CREATE  PROCEDURE `spao_uob_fetch_data`(`p_acctnum` bigint(20))
BEGIN

declare v_acc_deta_count int;

/* select count(1) into v_acc_deta_count from invdb.ao_acct_details where acctnum=p_acctnum;
if(v_acc_deta_count=0)then
	select * from invdb.ao_acct_details where 1=2;
else*/

select acctnum, clientAccountID, repId, uai.displayName displayRepName, ifnull(uai.displayRep,rep)displayRep, caseNumber, advisorId, acctTypeId,
			IF((ISNULL(acctTypeId)
                OR (acctTypeId = '')),
            NULL,
            (SELECT 
                    dc_m_lookup.value
                FROM
                    dc_m_lookup
                WHERE
                    (dc_m_lookup.lookupCode = acctTypeId))) AS acctTypeVal,
                   (select date_format(created,'%d/%m/%Y') from ao_requests where reqId=(select max(reqid) from ao_requests where acctnum=p_acctnum)) as dateOfApplication
                    from invdb.ao_acct_details ao_ad , invdb.user_advisor_info uai where ao_ad.acctnum=p_acctnum and uai.logonid=ao_ad.advisorId;
/*

	select acctnum, clientAccountID, repId, caseNumber, advisorId, acctTypeId,
			IF((ISNULL(acctTypeId)
                OR (acctTypeId = '')),
            NULL,
            (SELECT 
                    dc_m_lookup.value
                FROM
                    dc_m_lookup
                WHERE
                    (dc_m_lookup.lookupCode = acctTypeId))) AS acctTypeVal,
                   (select date_format(created,'%d/%m/%Y') from ao_requests where reqId=(select max(reqid) from ao_requests where acctnum=p_acctnum)) as dateOfApplication
                    from invdb.ao_acct_details where acctnum=p_acctnum;*/
    select acctnum, name, case when(name ='existingTradeAcctNumber') then LPAD(value,7,'0') else value end as value from ao_acct_misc_details where acctnum=p_acctnum;
-- end if;

select acctnum, acctOwnerId, title, firstName, midInitial, lastName, fullName, gender, dob,
date_format(STR_TO_DATE(dob, '%m-%d-%Y'),'%d/%m/%Y') dobDDMMYYYY,
countryOfBirth, emailAddress, physicalAddressStreet1, physicalAddressStreet2, physicalAddressStreet3, physicalAddressStreet4, physicalAddressCity, physicalAddressState, physicalAddressZipCode, physicalAddressCountry, mailingAddressStreet1, mailingAddressStreet2, mailingAddressStreet3, mailingAddressStreet4, mailingAddressCity, mailingAddressState, mailingAddressZipCode, mailingAddressCountry, created, createdBy, updated, updatedBy, ownership 
from invdb.ao_owners_details where acctnum=p_acctnum;

select * from invdb.ao_owners_contact_details where acctnum=p_acctnum;
select * from ao_owners_finacial_details where acctnum=p_acctnum;
select * from ao_owners_regularity_details where acctnum=p_acctnum; 
select * from ao_owners_misc_details where acctnum=p_acctnum; 
select * from ao_owners_indentification_details where acctnum=p_acctnum;
select * from ao_owners_citizenship_details where acctnum=p_acctnum;
select * from ao_owners_employment_details where acctnum=p_acctnum;
select * from ao_owners_sets_misc_details where acctnum=p_acctnum order by acctnum, acctOwnerId, category, id, name;
select * from ao_owners_bank_details where acctnum=p_acctnum;  

END$$

DELIMITER ;


