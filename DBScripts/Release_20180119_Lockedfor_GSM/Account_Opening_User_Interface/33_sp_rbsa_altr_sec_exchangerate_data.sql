ALTER TABLE `rbsa`.`sec_exchangerate_data` 
ADD COLUMN `marketSymbol` VARCHAR(20) NULL AFTER `symbol`;

ALTER TABLE `rbsa`.`sec_exchangerate_data` 
CHANGE COLUMN `marketSymbol` `marketSymbol` VARCHAR(20) Default NULL ;