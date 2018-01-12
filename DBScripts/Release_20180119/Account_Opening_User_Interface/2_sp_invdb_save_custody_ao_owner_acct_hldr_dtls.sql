USE `invdb`;
DROP procedure IF EXISTS `save_custody_ao_owner_acct_hldr_dtls`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_custody_ao_owner_acct_hldr_dtls`(
in p_acctnum bigint,
in p_acctOwnerId int,
in p_title varchar(45),
in p_fullName varchar(100),
in p_gender varchar(10),
in p_dob varchar(45),
in p_countryOfBirth varchar(45),
in p_emailAddress varchar(45),
in p_ownership varchar(45),
in p_logonId varchar(45))
begin

insert into invdb.ao_owners_details(
	acctnum,
	acctOwnerId,
	title,
	fullName,
	gender,
	dob,
	countryOfBirth,
	emailAddress,
	created,
	createdBy,
	ownership)
select 
	p_acctnum,
	p_acctOwnerId,
	p_title,
	p_fullName,
	p_gender,
	p_dob,
	p_countryOfBirth,
	p_emailAddress,
	now(),
	p_logonId,
	p_ownership
ON DUPLICATE KEY UPDATE 
	acctnum=p_acctnum,
	acctOwnerId=p_acctOwnerId,
	title=p_title,
	fullName=p_fullName,
	gender=p_gender,
	dob=p_dob,
	countryOfBirth=p_countryOfBirth,
	emailAddress=p_emailAddress,
	updated=now(),
	updatedBy=p_logonId,
	ownership=p_ownership;
end$$

DELIMITER ;

