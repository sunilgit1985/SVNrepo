ALTER TABLE `invdb`.`ext_investment` 
ADD COLUMN `status` VARCHAR(1) NULL AFTER `investmentDate`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`clientAccountID`, `ticker`, `investmentDate`);
