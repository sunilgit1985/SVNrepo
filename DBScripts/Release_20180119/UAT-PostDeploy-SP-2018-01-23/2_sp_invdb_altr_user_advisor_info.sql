
ALTER TABLE `invdb`.`user_advisor_info` 
ADD COLUMN `email` VARCHAR(60) NULL AFTER `advisor_css`,
ADD COLUMN `phone` VARCHAR(15) NULL AFTER `email`,
ADD COLUMN `address` VARCHAR(200) NULL AFTER `phone`;