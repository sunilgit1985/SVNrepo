ALTER TABLE `invdb`.`ao_owners_employment_details` 
CHANGE COLUMN `emplId` `emplId` INT(2) NULL ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`acctnum`, `acctOwnerId`);
