USE `invdb`;
DROP procedure IF EXISTS `save_custody_ao_owner_emp_dtls`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_custody_ao_owner_emp_dtls`(
 in p_acctnum int ,
 in p_acctOwnerId int ,
 in p_emplId int ,
 in p_emplTypeId varchar(45) ,
 in p_sourceOfIncome varchar(100) ,
 in p_employerName varchar(45) ,
 in p_occupation varchar(45) ,
 in p_typeOfBusiness varchar(45) ,
 in p_employerStreetAddress1 varchar(100) ,
 in p_employerStreetAddress2 varchar(100) ,
 in p_employerStreetAddress3 varchar(100) ,
 in p_employerStreetAddress4 varchar(100) ,
 in p_employerCity varchar(45) ,
 in p_employerState varchar(45) ,
 in p_employerZipCode varchar(45) ,
 in p_employerZipCountry varchar(45) ,
 in p_fromDate varchar(10) ,
 in p_toDate varchar(10) ,
 in p_logonId varchar(45) )
begin
 
 insert into invdb.ao_owners_employment_details(
 	acctnum,
 	acctOwnerId,
 	emplId,
 	emplTypeId,
 	sourceOfIncome,
 	employerName,
 	occupation,
 	typeOfBusiness,
 	employerStreetAddress1,
 	employerStreetAddress2,
 	employerStreetAddress3,
 	employerStreetAddress4,
 	employerCity,
 	employerState,
 	employerZipCode,
 	employerZipCountry,
 	fromDate,
 	toDate,
 	createdBy,
 	created
 )
 select 
 	p_acctnum ,
 	p_acctOwnerId ,
 	p_emplId ,
 	p_emplTypeId ,
 	p_sourceOfIncome ,
 	p_employerName ,
 	p_occupation ,
 	p_typeOfBusiness ,
 	p_employerStreetAddress1 ,
 	p_employerStreetAddress2 ,
 	p_employerStreetAddress3 ,
 	p_employerStreetAddress4 ,
 	p_employerCity ,
 	p_employerState ,
 	p_employerZipCode ,
 	p_employerZipCountry ,
 	p_fromDate ,
 	p_toDate ,
 	p_logonId,
 	now()
 ON DUPLICATE KEY UPDATE 
 	acctnum = p_acctnum,
 	acctOwnerId = p_acctOwnerId,
 	emplId = p_emplId,
 	emplTypeId = p_emplTypeId,
 	sourceOfIncome = p_sourceOfIncome,
 	employerName = p_employerName,
 	occupation = p_occupation,
 	typeOfBusiness = p_typeOfBusiness,
 	employerStreetAddress1 = p_employerStreetAddress1,
 	employerStreetAddress2 = p_employerStreetAddress2,
 	employerStreetAddress3 = p_employerStreetAddress3,
 	employerStreetAddress4 = p_employerStreetAddress4,
 	employerCity = p_employerCity,
 	employerState = p_employerState,
 	employerZipCode = p_employerZipCode,
 	employerZipCountry = p_employerZipCountry,
 	fromDate = p_fromDate,
 	toDate = p_toDate,
 	updated=now(),
 	updatedBy=p_logonId;
 end$$

DELIMITER ;

