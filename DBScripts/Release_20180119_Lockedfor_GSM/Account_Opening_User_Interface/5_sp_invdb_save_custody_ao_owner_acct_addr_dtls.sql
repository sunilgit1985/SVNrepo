USE `invdb`;
DROP procedure IF EXISTS `save_custody_ao_owner_acct_addr_dtls`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_custody_ao_owner_acct_addr_dtls`(
 in p_acctnum bigint,
 in p_acctOwnerId int,
 in p_physicalAddressStreet1 varchar(100) ,
 in p_physicalAddressStreet2 varchar(100) ,
 in p_physicalAddressStreet3 varchar(100) ,
 in p_physicalAddressStreet4 varchar(100) ,
 in p_physicalAddressCity varchar(45) ,
 in p_physicalAddressState varchar(45) ,
 in p_physicalAddressZipCode varchar(45) ,
 in p_physicalAddressCountry varchar(45) ,
 in p_mailingAddressStreet1 varchar(100) ,
 in p_mailingAddressStreet2 varchar(100) ,
 in p_mailingAddressStreet3 varchar(100) ,
 in p_mailingAddressStreet4 varchar(100) ,
 in p_mailingAddressCity varchar(45) ,
 in p_mailingAddressState varchar(45) ,
 in p_mailingAddressZipCode varchar(45) ,
 in p_mailingAddressCountry varchar(45) ,
 in p_logonId varchar(45))
begin
 update invdb.ao_owners_details set
 physicalAddressStreet1 = p_physicalAddressStreet1,
 physicalAddressStreet2 = p_physicalAddressStreet2,
 physicalAddressStreet3 = p_physicalAddressStreet3,
 physicalAddressStreet4 = p_physicalAddressStreet4,
 physicalAddressCity = p_physicalAddressCity,
 physicalAddressState = p_physicalAddressState,
 physicalAddressZipCode = p_physicalAddressZipCode,
 physicalAddressCountry = p_physicalAddressCountry,
 mailingAddressStreet1 = p_mailingAddressStreet1,
 mailingAddressStreet2 = p_mailingAddressStreet2,
 mailingAddressStreet3 = p_mailingAddressStreet3,
 mailingAddressStreet4 = p_mailingAddressStreet4,
 mailingAddressCity = p_mailingAddressCity,
 mailingAddressState = p_mailingAddressState,
 mailingAddressZipCode = p_mailingAddressZipCode,
 mailingAddressCountry = p_mailingAddressCountry,
 updatedBy=p_logonId,
 updated=now()
 where 
 acctnum=p_acctnum and 
 acctOwnerId=p_acctOwnerId;
 end$$

DELIMITER ;

