ALTER TABLE `invdb`.`user_trade_profile` 
CHANGE COLUMN `lastname` `lastname` VARCHAR(40) NULL DEFAULT NULL AFTER `firstname`;
