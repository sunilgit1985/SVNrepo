ALTER TABLE `invdb`.`advisor_risk_master` 
ADD COLUMN `remarks` VARCHAR(60) NULL DEFAULT NULL AFTER `saveforUser`;

UPDATE `invdb`.`web_site_info` SET `value`='KayHian.With.Sing' WHERE `url`='utraderobo' and`name`='DEFAULT.MODEL';
UPDATE `invdb`.`advisor_risk_master` SET `defaultValue`='KayHian.With.Sing' WHERE `advisor`='UOB' and`sortorder`='15' and`key`='THEME';

INSERT INTO `invdb`.`advisor_risk_master` (`advisor`, `sortorder`, `key`, `displayName`, `defaultValue`, `dataType`, `displayOnStart`, `displayAdvisor`, `saveforUser`) VALUES ('UOB', '801', 'THEME-1', 'Theme#1', 'KayHian.Without.Sing', 'T', '0', '0', '0');

UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Number of Risk Questons' WHERE `advisor`='UOB' and`sortorder`='10' and`key`='RISKQUESTIONS';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Investment Model-DEFAULT' WHERE `advisor`='UOB' and`sortorder`='15' and`key`='THEME';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Calculation Method' WHERE `advisor`='UOB' and`sortorder`='20' and`key`='CALCMETHOD';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Calculation Formula' WHERE `advisor`='UOB' and`sortorder`='30' and`key`='CALFORMULA';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Starting Investment Goal' WHERE `advisor`='UOB' and`sortorder`='40' and`key`='GOAL';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Retired Flag' WHERE `advisor`='UOB' and`sortorder`='45' and`key`='RETIRED';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Age-Default' WHERE `advisor`='UOB' and`sortorder`='60' and`key`='AGE';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Horizon-Default' WHERE `advisor`='UOB' and`sortorder`='70' and`key`='HORIZON';
UPDATE `invdb`.`advisor_risk_master` SET `defaultValue`='30', `displayOnStart`='0', `remarks`='Withdrawl-Default' WHERE `advisor`='UOB' and`sortorder`='80' and`key`='WITHDRAWALPERIOD';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Trade Currency' WHERE `advisor`='UOB' and`sortorder`='90' and`key`='TRADECURRENCY';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Settlement Currency' WHERE `advisor`='UOB' and`sortorder`='95' and`key`='SETTLEMENTCURRENCY';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Initial Investent' WHERE `advisor`='UOB' and`sortorder`='100' and`key`='INITIALINVESTMENT';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='For display purpose' WHERE `advisor`='UOB' and`sortorder`='105' and`key`='TOTALINVESTMENT';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Recurring Investment' WHERE `advisor`='UOB' and`sortorder`='110' and`key`='RECURRINGINVESTMENT';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Terms of Recurrng' WHERE `advisor`='UOB' and`sortorder`='120' and`key`='RECURRINGTERM';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Recurring Period' WHERE `advisor`='UOB' and`sortorder`='130' and`key`='RECURRINGPERIOD';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Keep Liquid' WHERE `advisor`='UOB' and`sortorder`='140' and`key`='KEEPLIQUID';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Taxable Flag' WHERE `advisor`='UOB' and`sortorder`='150' and`key`='TAXABLE';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Tax Rate' WHERE `advisor`='UOB' and`sortorder`='160' and`key`='TAXRATE';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Experience' WHERE `advisor`='UOB' and`sortorder`='170' and`key`='EXPERIENCE';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Retirement Age' WHERE `advisor`='UOB' and`sortorder`='180' and`key`='RETIREMENTAGE';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Withdrawl Age' WHERE `advisor`='UOB' and`sortorder`='190' and`key`='WITHDRAWLAGE';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Internal-Age Multiplier' WHERE `advisor`='UOB' and`sortorder`='500' and`key`='AGEPOWERVALUE';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Internal-AgeWeight' WHERE `advisor`='UOB' and`sortorder`='510' and`key`='AGEWEIGHT';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Internal-Max Duration' WHERE `advisor`='UOB' and`sortorder`='530' and`key`='MAXDURATION';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Internal-Max Score' WHERE `advisor`='UOB' and`sortorder`='530' and`key`='MAXSCORE';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Internal-Withdrawl Rate' WHERE `advisor`='UOB' and`sortorder`='540' and`key`='WITHDRAWLRATE';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Has Knockout Questions' WHERE `advisor`='UOB' and`sortorder`='550' and`key`='KNOCKOUT';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Initital Min Investment' WHERE `advisor`='UOB' and`sortorder`='600' and`key`='MININTITIALRQMT';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Second-Min Investment' WHERE `advisor`='UOB' and`sortorder`='610' and`key`='MIN2NDINTIALRQMT';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Min Recurring' WHERE `advisor`='UOB' and`sortorder`='650' and`key`='MINRECCURRINGRQMT';
UPDATE `invdb`.`advisor_risk_master` SET `remarks`='Second- Min Recurring' WHERE `advisor`='UOB' and`sortorder`='801' and`key`='THEME-1';
