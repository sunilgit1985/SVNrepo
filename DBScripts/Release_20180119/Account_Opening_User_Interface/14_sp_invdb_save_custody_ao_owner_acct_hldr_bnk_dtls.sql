USE `invdb`;
DROP procedure IF EXISTS `save_custody_ao_owner_acct_hldr_bnk_dtls`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_custody_ao_owner_acct_hldr_bnk_dtls`(
in p_acctnum bigint,
in p_acctOwnerId int,
in p_bankAccountHolderName varchar(60),
in p_bankName varchar(100),
in p_bankAccountNo varchar(45),
in p_bankAddressStreet1  varchar(100),
in p_bankAddressStreet2  varchar(100),
in p_bankAddressStreet3  varchar(100),
in p_bankAddressStreet4  varchar(100),
in p_bankAddressCity varchar(45) ,
in p_bankAddressState varchar(45) ,
in p_bankAddressZipCode varchar(45) ,
in p_bankAddressCountry varchar(45) ,
in p_swiftBic  varchar(45),
in p_correspondentBank  varchar(100),
in p_correspondentBankSwiftBic  varchar(45),
in p_logonId varchar(45))
begin

insert into invdb.ao_owners_bank_details(
	acctnum,
	acctOwnerId,
    bankAccountHolderName,
	bankName,
	bankAccountNo,
	bankAddressStreet1,
	bankAddressStreet2,
	bankAddressStreet3,
	bankAddressStreet4,
    bankAddressCity,
	bankAddressState,
	bankAddressZipCode,
	bankAddressCountry,
	swiftBic,
	correspondentBank,
	correspondentBankSwiftBic,
	created,
	createdBy)
select 
	p_acctnum,
	p_acctOwnerId,
    p_bankAccountHolderName,
	p_bankName,
	p_bankAccountNo,
	p_bankAddressStreet1,
	p_bankAddressStreet2,
	p_bankAddressStreet3,
	p_bankAddressStreet4,
    p_bankAddressCity,
	p_bankAddressState,
	p_bankAddressZipCode,
	p_bankAddressCountry,
	p_swiftBic,
	p_correspondentBank,
	p_correspondentBankSwiftBic,
	now(),
	p_logonId
ON DUPLICATE KEY UPDATE 
	acctnum=p_acctnum,
	acctOwnerId=p_acctOwnerId,
    bankAccountHolderName=p_bankAccountHolderName,
	bankName=p_bankName,
	bankAccountNo=p_bankAccountNo,
	bankAddressStreet1=p_bankAddressStreet1,
	bankAddressStreet2=p_bankAddressStreet2,
	bankAddressStreet3=p_bankAddressStreet3,
	bankAddressStreet4=p_bankAddressStreet4,
    bankAddressCity=p_bankAddressCity,
	bankAddressState=p_bankAddressState,
	bankAddressZipCode=p_bankAddressZipCode,
	bankAddressCountry=p_bankAddressCountry,
	swiftBic=p_swiftBic,
	correspondentBank=p_correspondentBank,
	correspondentBankSwiftBic=p_correspondentBankSwiftBic,
	updated=now(),
	updatedBy=p_logonId;
end$$

DELIMITER ;

