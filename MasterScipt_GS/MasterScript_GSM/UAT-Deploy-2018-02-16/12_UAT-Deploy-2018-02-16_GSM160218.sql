
/* 1.pm.Fix_Theme.sql160218_pmehta*/

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


/* 2.jv.model updates sql.sql200218_abahng*/

INSERT INTO `invdb`.`user_basket_access` (`advisor`, `theme`, `status`, `displayname`, `sortorder`, `primary`, `taxable`, `model`, `tradeCurrency`, `created`, `lastupdated`) VALUES ('UOB', 'KayHian.Without.Sing', 'A', 'Global portfolio without Singapore exposure', '4', 'Y', 'N', 'O', 'SGD', '2017-07-30 13:49:12', '');
INSERT INTO `invdb`.`user_basket_access` (`advisor`, `theme`, `status`, `displayname`, `sortorder`, `primary`, `taxable`, `model`, `tradeCurrency`, `created`, `lastupdated`) VALUES ('UOB', 'KayHian.With.Sing', 'A', 'Global portfolio with Singapore exposure', '3', 'Y', 'N', 'O', 'SGD', '2017-07-30 13:49:12', '');


INSERT INTO `invdb`.`sec_assetclass_group` (`theme`, `status`, `assetclass`, `displayName`, `ticker`, `sortorder`, `lowerBound`, `upperBound`, `color`, `averageReturn`, `riskAdjustment`, `endAllocation`, `created`) VALUES ('KayHian.With.Sing', 'A', 'Cash', 'Cash', 'BIL.N', '40', '0', '0.05', '#8E8E8E', '0', '0.75', '0.8', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_assetclass_group` (`theme`, `status`, `assetclass`, `displayName`, `ticker`, `sortorder`, `lowerBound`, `upperBound`, `color`, `averageReturn`, `riskAdjustment`, `endAllocation`, `created`) VALUES ('KayHian.With.Sing', 'A', 'Commodity', 'Commodities', 'IAU.N', '30', '0', '0.05', '#5E5E5E', '0.0225', '0.75', '0.01', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_assetclass_group` (`theme`, `status`, `assetclass`, `displayName`, `ticker`, `sortorder`, `lowerBound`, `upperBound`, `color`, `averageReturn`, `riskAdjustment`, `endAllocation`, `created`) VALUES ('KayHian.With.Sing', 'A', 'Equity', 'Equity Securities', 'VUSD.L', '10', '0', '0.9', '#333F50', '0.0617', '0.75', '0.9', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_assetclass_group` (`theme`, `status`, `assetclass`, `displayName`, `ticker`, `sortorder`, `lowerBound`, `upperBound`, `color`, `averageReturn`, `riskAdjustment`, `endAllocation`, `created`) VALUES ('KayHian.With.Sing', 'A', 'Fixed Income', 'Fixed Income Securities', 'IUAG.L', '20', '0.1', '1', '#47566D', '0.0134', '0.75', '0.8', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_assetclass_group` (`theme`, `status`, `assetclass`, `displayName`, `ticker`, `sortorder`, `lowerBound`, `upperBound`, `color`, `averageReturn`, `riskAdjustment`, `endAllocation`, `created`) VALUES ('KayHian.Without.Sing', 'A', 'Cash', 'Cash', 'BIL.N', '40', '0', '0.05', '#8E8E8E', '0', '0.75', '0.8', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_assetclass_group` (`theme`, `status`, `assetclass`, `displayName`, `ticker`, `sortorder`, `lowerBound`, `upperBound`, `color`, `averageReturn`, `riskAdjustment`, `endAllocation`, `created`) VALUES ('KayHian.Without.Sing', 'A', 'Commodity', 'Commodities', 'IAU.N', '30', '0', '0.05', '#5E5E5E', '0.0225', '0.75', '0.01', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_assetclass_group` (`theme`, `status`, `assetclass`, `displayName`, `ticker`, `sortorder`, `lowerBound`, `upperBound`, `color`, `averageReturn`, `riskAdjustment`, `endAllocation`, `created`) VALUES ('KayHian.Without.Sing', 'A', 'Equity', 'Equity Securities', 'VUSD.L', '0', '0', '0.9', '#333F50', '0.0617', '0.75', '0.9', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_assetclass_group` (`theme`, `status`, `assetclass`, `displayName`, `ticker`, `sortorder`, `lowerBound`, `upperBound`, `color`, `averageReturn`, `riskAdjustment`, `endAllocation`, `created`) VALUES ('KayHian.Without.Sing', 'A', 'Fixed Income', 'Fixed Income Securities', 'IUAG.L', '20', '0.1', '1', '#47566D', '0.0134', '0.75', '0.8', '2017-07-30 13:49:12');


INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.With.Sing', 'Cash', 'Cash', 'Cash', 'A', '99999', '0', '1', '0.001', '0', '0', '2017-07-30 13:49:13');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.With.Sing', 'Commodity', 'Precious Metals', 'IAU.N', 'A', '900', '0', '1', '0.0225', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.With.Sing', 'Equity', 'Emerging Mkt. Equities', 'EIMI.L', 'A', '120', '0.25', '0.50', '0.069', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.With.Sing', 'Equity', 'Singapore Equities', 'EWS.N', 'A', '100', '0.05', '0.10', '0.0722', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.With.Sing', 'Equity', 'U.S. Equities', 'VUSD.L', 'A', '150', '0.5', '0.75', '0.0617', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.With.Sing', 'Fixed Income', 'Corporate Bonds ', 'LQDE.L', 'A', '610', '0.00', '0.60', '0.0206', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.With.Sing', 'Fixed Income', 'E.U. High Yield Bonds', 'IHYG.L', 'A', '500', '0.10', '0.20', '0.0264', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.With.Sing', 'Fixed Income', 'Emerging Market Bonds', 'IEMB.L', 'A', '420', '0.05', '0.50', '0.0334', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.With.Sing', 'Fixed Income', 'Emerging Market Local Bonds', 'IEML.L', 'A', '420', '0.20', '0.50', '0.011', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.With.Sing', 'Fixed Income', 'Singapore Bonds', 'F00000MQNO.MSTA', 'A', '420', '0.25', '0.50', '0.0145', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.With.Sing', 'Fixed Income', 'U.S. Bonds', 'IUAG.L', 'A', '600', '0.05', '0.60', '0.0134', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.With.Sing', 'Fixed Income', 'U.S. High Yield Bonds', 'IHYU.L', 'A', '610', '0.00', '0.50', '0.0334', '0', '0', '2017-07-30 13:49:12');






INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.Without.Sing', 'Cash', 'Cash', 'Cash', 'A', '99999', '0', '1', '0.001', '0', '0', '2017-07-30 13:49:13');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.Without.Sing', 'Commodity', 'Precious Metals', 'IAU.N', 'A', '900', '0', '1', '0.0225', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.Without.Sing', 'Equity', 'Emerging Mkt. Equities', 'EIMI.L', 'A', '120', '0.25', '0.50', '0.069', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.Without.Sing', 'Equity', 'U.S. Equities', 'VUSD.L', 'A', '150', '0.5', '0.75', '0.0617', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.Without.Sing', 'Fixed Income', 'Corporate Bonds ', 'LQDE.L', 'A', '610', '0.00', '0.60', '0.0206', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.Without.Sing', 'Fixed Income', 'E.U. High Yield Bonds', 'IHYG.L', 'A', '500', '0.10', '0.20', '0.0264', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.Without.Sing', 'Fixed Income', 'Emerging Market Bonds', 'IEMB.L', 'A', '420', '0.05', '0.50', '0.0334', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.Without.Sing', 'Fixed Income', 'Emerging Market Local Bonds', 'IEML.L', 'A', '420', '0.20', '0.50', '0.011', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.Without.Sing', 'Fixed Income', 'U.S. Bonds', 'IUAG.L', 'A', '600', '0.05', '0.60', '0.0134', '0', '0', '2017-07-30 13:49:12');
INSERT INTO `invdb`.`sec_prime_asset_group` (`theme`, `assetclass`, `primeassetclass`, `ticker`, `status`, `sortorder`, `lowerBound`, `upperBound`, `expectedReturn`, `risk`, `yield`, `created`) VALUES ('KayHian.Without.Sing', 'Fixed Income', 'U.S. High Yield Bonds', 'IHYU.L', 'A', '610', '0.00', '0.50', '0.0334', '0', '0', '2017-07-30 13:49:12');






INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'Cash', 'Cash', '1', '2018-01-19', 'SGD', 'Cash', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'EIMI.L', 'EIMI.L', '1', '2017-07-30', 'USD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'EWJ.N', 'EWJ.N', '1', '2017-07-30', 'USD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'EWS.N', 'EWS.N', '1', '2017-07-30', 'SGD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'F00000MQNO.MSTA', 'F00000MQNO.MSTA', '1', '2017-07-30', 'SGD', 'Fixed Income', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'F0HKG062UI.MSTA', 'F0HKG062UI.MSTA', '1', '2017-07-30', 'SGD', 'Fixed Income', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'IAU.N', 'IAU.N', '1', '2017-07-30', 'USD', 'Fixed Income', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'IEMB.L', 'IEMB.L', '1', '2017-07-30', 'USD', 'Fixed Income', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'IEML.L', 'IEML.L', '1', '2017-07-30', 'USD', 'Fixed Income', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'IHYG.L', 'IHYG.L', '1', '2017-07-30', 'EUR', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'IHYU.L', 'IHYU.L', '1', '2017-07-30', 'USD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'IMEU.L', 'IMEU.L', '1', '2017-07-30', 'GBX', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'IUAG.L', 'IUAG.L', '1', '2017-07-30', 'USD', 'Fixed Income', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'IVV.N', 'IVV.N', '1', '2017-07-30', 'USD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'KV4.SI', 'KV4.SI', '1', '2017-07-30', 'SGD', 'Fixed Income', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'LQDE.L', 'LQDE.L', '1', '2017-07-30', 'USD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'SPY.N', 'SPY.N', '1', '2017-07-30', 'USD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'VUSD.L', '1306.T', '0.09', '2017-07-30', 'JPY', 'Fixed Income', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'VUSD.L', 'VAS.AX', '0.03', '2017-07-30', 'AUD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'VUSD.L', 'VEUR.L', '0.25', '2017-07-30', 'GBP', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'VUSD.L', 'VUSD.L', '0.6', '2017-07-30', 'USD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.Without.Sing', 'VUSD.L', 'XIC.TO', '0.03', '2017-07-30', 'CAD', 'Equity', 'SGD');




INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'Cash', 'Cash', '1', '2018-01-19', 'SGD', 'Cash', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'EIMI.L', 'EIMI.L', '1', '2017-07-30', 'USD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'EWJ.N', 'EWJ.N', '1', '2017-07-30', 'USD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'EWS.N', 'EWS.N', '1', '2017-07-30', 'SGD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'F00000MQNO.MSTA', 'F00000MQNO.MSTA', '1', '2017-07-30', 'SGD', 'Fixed Income', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'F0HKG062UI.MSTA', 'F0HKG062UI.MSTA', '1', '2017-07-30', 'SGD', 'Fixed Income', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'IAU.N', 'IAU.N', '1', '2017-07-30', 'USD', 'Fixed Income', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'IEMB.L', 'IEMB.L', '1', '2017-07-30', 'USD', 'Fixed Income', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'IEML.L', 'IEML.L', '1', '2017-07-30', 'USD', 'Fixed Income', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'IHYG.L', 'IHYG.L', '1', '2017-07-30', 'EUR', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'IHYU.L', 'IHYU.L', '1', '2017-07-30', 'USD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'IMEU.L', 'IMEU.L', '1', '2017-07-30', 'GBX', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'IUAG.L', 'IUAG.L', '1', '2017-07-30', 'USD', 'Fixed Income', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'IVV.N', 'IVV.N', '1', '2017-07-30', 'USD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'KV4.SI', 'KV4.SI', '1', '2017-07-30', 'SGD', 'Fixed Income', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'LQDE.L', 'LQDE.L', '1', '2017-07-30', 'USD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'SPY.N', 'SPY.N', '1', '2017-07-30', 'USD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'VUSD.L', '1306.T', '0.09', '2017-07-30', 'JPY', 'Fixed Income', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'VUSD.L', 'VAS.AX', '0.03', '2017-07-30', 'AUD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'VUSD.L', 'VEUR.L', '0.25', '2017-07-30', 'GBP', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'VUSD.L', 'VUSD.L', '0.6', '2017-07-30', 'USD', 'Equity', 'SGD');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `base_currency`, `style`, `dest_currency`) VALUES ('KayHian.With.Sing', 'VUSD.L', 'XIC.TO', '0.03', '2017-07-30', 'CAD', 'Equity', 'SGD');







INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.Without.Sing', '1306.T', 'Equity', 'Equity Securities', '#333F50', '10', 'U.S. Equities', 'U.S. Equities', '150', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.Without.Sing', 'Cash', 'Cash', 'Cash', '#8E8E8E', '40', 'Cash', 'Cash', '99999', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.Without.Sing', 'EIMI.L', 'Equity', 'Equity Securities', '#333F50', '10', 'Emerging Mkt. Equities', 'Emerging Mkt. Equities', '120', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.Without.Sing', 'IAU.N', 'Commodity', 'Commodities', '#5E5E5E', '30', 'Precious Metals', 'Precious Metals', '900', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.Without.Sing', 'IEMB.L', 'Fixed Income', 'Fixed Income Securities', '#47566D', '20', 'Emerging Market Bonds', 'Emerging Market Bonds', '420', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.Without.Sing', 'IEML.L', 'Fixed Income', 'Fixed Income Securities', '#47566D', '20', 'Emerging Market Local Bonds', 'Emerging Market Local Bonds', '420', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.Without.Sing', 'IHYG.L', 'Fixed Income', 'Fixed Income Securities', '#47566D', '20', 'E.U. High Yield Bonds', 'E.U. High Yield Bonds', '500', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.Without.Sing', 'IHYU.L', 'Fixed Income', 'Fixed Income Securities', '#47566D', '20', 'U.S. High Yield Bonds', 'U.S. High Yield Bonds', '610', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.Without.Sing', 'IUAG.L', 'Fixed Income', 'Fixed Income Securities', '#47566D', '20', 'U.S. Bonds', 'U.S. Bonds', '600', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.Without.Sing', 'LQDE.L', 'Fixed Income', 'Fixed Income Securities', '#47566D', '20', 'Corporate Bonds ', 'Corporate Bonds ', '610', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.Without.Sing', 'VAS.AX', 'Equity', 'Equity Securities', '#333F50', '10', 'U.S. Equities', 'U.S. Equities', '150', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.Without.Sing', 'VEUR.L', 'Equity', 'Equity Securities', '#333F50', '10', 'U.S. Equities', 'U.S. Equities', '150', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.Without.Sing', 'VUSD.L', 'Equity', 'Equity Securities', '#333F50', '10', 'U.S. Equities', 'U.S. Equities', '150', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.Without.Sing', 'XIC.TO', 'Equity', 'Equity Securities', '#333F50', '10', 'U.S. Equities', 'U.S. Equities', '150', 'OT', '2018-01-19 21:16:15');






INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.With.Sing', '1306.T', 'Equity', 'Equity Securities', '#333F50', '0', 'U.S. Equities', 'U.S. Equities', '150', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.With.Sing', 'Cash', 'Cash', 'Cash', '#8E8E8E', '40', 'Cash', 'Cash', '99999', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.With.Sing', 'EIMI.L', 'Equity', 'Equity Securities', '#333F50', '0', 'Emerging Mkt. Equities', 'Emerging Mkt. Equities', '120', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.With.Sing', 'EWS.N', 'Equity', 'Equity Securities', '#333F50', '0', 'Singapore Equities', 'Singapore Equities', '100', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.With.Sing', 'F00000MQNO.MSTA', 'Fixed Income', 'Fixed Income Securities', '#47566D', '20', 'Singapore Bonds', 'Singapore Bonds', '420', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.With.Sing', 'IAU.N', 'Commodity', 'Commodities', '#5E5E5E', '30', 'Precious Metals', 'Precious Metals', '900', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.With.Sing', 'IEMB.L', 'Fixed Income', 'Fixed Income Securities', '#47566D', '20', 'Emerging Market Bonds', 'Emerging Market Bonds', '420', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.With.Sing', 'IEML.L', 'Fixed Income', 'Fixed Income Securities', '#47566D', '20', 'Emerging Market Local Bonds', 'Emerging Market Local Bonds', '420', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.With.Sing', 'IHYG.L', 'Fixed Income', 'Fixed Income Securities', '#47566D', '20', 'E.U. High Yield Bonds', 'E.U. High Yield Bonds', '500', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.With.Sing', 'IHYU.L', 'Fixed Income', 'Fixed Income Securities', '#47566D', '20', 'U.S. High Yield Bonds', 'U.S. High Yield Bonds', '610', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.With.Sing', 'IUAG.L', 'Fixed Income', 'Fixed Income Securities', '#47566D', '20', 'U.S. Bonds', 'U.S. Bonds', '600', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.With.Sing', 'LQDE.L', 'Fixed Income', 'Fixed Income Securities', '#47566D', '20', 'Corporate Bonds ', 'Corporate Bonds ', '610', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.With.Sing', 'VAS.AX', 'Equity', 'Equity Securities', '#333F50', '0', 'U.S. Equities', 'U.S. Equities', '150', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.With.Sing', 'VEUR.L', 'Equity', 'Equity Securities', '#333F50', '0', 'U.S. Equities', 'U.S. Equities', '150', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.With.Sing', 'VUSD.L', 'Equity', 'Equity Securities', '#333F50', '0', 'U.S. Equities', 'U.S. Equities', '150', 'OT', '2018-01-19 21:16:15');
INSERT INTO `invdb`.`sec_asset_mapping` (`theme`, `ticker`, `assetclass`, `assetName`, `assetcolor`, `assetsortorder`, `subclass`, `subclassName`, `subclasssortorder`, `type`, `created`) VALUES ('KayHian.With.Sing', 'XIC.TO', 'Equity', 'Equity Securities', '#333F50', '0', 'U.S. Equities', 'U.S. Equities', '150', 'OT', '2018-01-19 21:16:15');


/* 3.pm.fix_theme_colors.sql160218_pmehta*/

UPDATE `invdb`.`sec_asset_mapping` SET `assetcolor`='#c90710' WHERE `theme` like 'KayHian%' and `assetclass` = 'Equity';
UPDATE `invdb`.`sec_asset_mapping` SET `assetcolor`='#e97922' WHERE `theme` like 'KayHian%' and `assetclass` = 'Fixed Income';
UPDATE `invdb`.`sec_asset_mapping` SET `assetcolor`='#439b3b' WHERE `theme` like 'KayHian%' and `assetclass` = 'Commodity';
UPDATE `invdb`.`sec_asset_mapping` SET `assetcolor`='#00a9c9' WHERE `theme` like 'KayHian%' and `assetclass` = 'Cash';

UPDATE `invdb`.`sec_assetclass_group` SET `color`='#c90710' WHERE `theme` like 'KayHian%' and `assetclass` = 'Equity';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#e97922' WHERE `theme` like 'KayHian%' and `assetclass` = 'Fixed Income';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#439b3b' WHERE `theme` like 'KayHian%' and `assetclass` = 'Commodity';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#00a9c9' WHERE `theme` like 'KayHian%' and `assetclass` = 'Cash';

/* 4.sp_invdb_create_sel_user_logon.sql180218_sagar*/

USE `invdb`;
DROP procedure IF EXISTS `sel_user_logon`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sel_user_logon`(
	IN p_logonid	BIGINT,
    IN p_userid	    VARCHAR(60),
    IN p_email		VARCHAR(60)
)
BEGIN

	DECLARE whichOne Integer;
    DECLARE tFound   Integer;
    
    IF (IFNULL(p_logonid,0) > 0)
    THEN
		set whichOne = 1;
        
		SELECT count(*)
		INTO tFound
		FROM user_logon
		WHERE user_logon.logonid = p_logonid;
    END IF;
    
     IF ((IFNULL(tFound,0) = 0) and (p_userid is not null))
     THEN
		set whichOne = 2;
        
		SELECT count(*)
		INTO tFound
		FROM user_logon
		WHERE user_logon.userid = p_userid;
     END IF;
     IF ((IFNULL(tFound,0) = 0) and (p_email is not null))
     THEN
		set whichOne = 3;
        
		SELECT count(*)
		INTO tFound
		FROM user_logon
		WHERE user_logon.email = p_email;
    END IF;
    
    IF (IFNULL(tFound,0) > 0)
    THEN
   
	CASE
		WHEN (whichOne = 1)
			THEN
				SELECT user_logon.logonid,
					user_logon.userid,
					user_logon.pwd,
					user_logon.logonstatus,
					user_logon.prefix,
					user_logon.lastname,
					user_logon.firstname,
					user_logon.fullname,
					user_logon.middlename,
					user_logon.suffix,
					user_logon.email,
					user_logon.emailalt,
					user_logon.stateRegistered,
					user_logon.leadSource,
					user_logon.cid,
					user_logon.advisor,
					user_logon.rep,
					user_logon.question1,
					user_logon.answer1,
					user_logon.question2,
					user_logon.answer2,
					user_logon.question3,
					user_logon.answer3,
					user_logon.ip,
					user_logon.resetID,
					user_logon.emailmsgtype,
					user_logon.access,
					user_logon.created,
					user_logon.lastupdated
				FROM user_logon
				WHERE user_logon.logonid = p_logonid
				;
		WHEN (whichOne = 2)
			THEN
				SELECT user_logon.logonid,
					user_logon.userid,
					user_logon.pwd,
					user_logon.logonstatus,
					user_logon.prefix,
					user_logon.lastname,
					user_logon.firstname,
					user_logon.middlename,
					user_logon.fullname,
					user_logon.suffix,
					user_logon.email,
					user_logon.emailalt,
					user_logon.stateRegistered,
					user_logon.leadSource,
					user_logon.cid,
					user_logon.advisor,
					user_logon.rep,
					user_logon.question1,
					user_logon.answer1,
					user_logon.question2,
					user_logon.answer2,
					user_logon.question3,
					user_logon.answer3,
					user_logon.ip,
					user_logon.resetID,
					user_logon.emailmsgtype,
					user_logon.access,
					user_logon.created,
					user_logon.lastupdated
				FROM user_logon
				WHERE user_logon.userid = p_userid
				;
		WHEN (whichOne = 3)
        THEN
				SELECT user_logon.logonid,
					user_logon.userid,
					user_logon.pwd,
					user_logon.logonstatus,
					user_logon.prefix,
					user_logon.lastname,
					user_logon.firstname,
					user_logon.middlename,
					user_logon.fullname,
					user_logon.suffix,
					user_logon.email,
					user_logon.emailalt,
					user_logon.stateRegistered,
					user_logon.leadSource,
					user_logon.cid,
					user_logon.advisor,
					user_logon.rep,
					user_logon.question1,
					user_logon.answer1,
					user_logon.question2,
					user_logon.answer2,
					user_logon.question3,
					user_logon.answer3,
					user_logon.ip,
					user_logon.resetID,
					user_logon.emailmsgtype,
					user_logon.access,
					user_logon.created,
					user_logon.lastupdated
				FROM user_logon
				WHERE user_logon.email = p_email
                LIMIT 1
				;
	END CASE;
    END IF;
    
END$$

DELIMITER ;


/* 5.sp_invdb_create_sel_ClientProfileData.sql180218_sagar*/

USE `invdb`;
DROP procedure IF EXISTS `sel_ClientProfileData`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sel_ClientProfileData`(
    	IN p_logonid BIGINT,
    	IN p_acctnum BIGINT,
    	IN p_days	 INTEGER,
        IN p_advisor VARCHAR(20),
        IN p_rep VARCHAR(20)
    )
BEGIN
    
    	DECLARE consumerView Boolean;
    	DECLARE singleAcct  Boolean;
    	DECLARE tAdvisor VARCHAR(25);
    	DECLARE  tRep     VARCHAR(25);
        DECLARE vAdvisor VARCHAR(25);
    
    	
        
        
    	IF (IFNULL(p_acctnum,0) = 0)
    		THEN SET singleAcct = FALSE;   
    		ELSE set singleAcct = TRUE;
    	END IF;
        
    	SELECT advisor, rep
    	INTO tAdvisor, tRep
    	FROM user_advisor_access
    	WHERE logonid = p_logonid
    	LIMIT 1;
    	
        
        
        
    	IF (tAdvisor is NULL)
    		THEN set consumerView = TRUE;  
    		ELSE set consumerView = FALSE;
    	END IF;
        
        IF (tAdvisor is NOT NULL) THEN
    	select advisor into vAdvisor  from user_logon where logonid=p_logonid;
            if(vAdvisor='DEMO') then
    			 set tAdvisor = IFNULL(p_advisor,'');
                 set tRep = IFNULL(p_rep,'');
    		end if;
    	END IF;
    	
    	
        
    	IF (p_days is null)
    		THEN	set p_days = -36500;
    		ELSE	IF (p_days > 0)
    					THEN set p_days = -1 * p_days;
    				END IF;
    	END IF;
        
        IF (consumerView)
    		THEN
    			IF (singleAcct)
    				THEN
    					select 
    					user_logon.logonid,
    					profile.acctnum,
                        profile.managed,
    					IFNULL(profile.firstname, user_logon.firstname) as firstname,
    					IFNULL(profile.lastname, user_logon.lastname) as lastname,
    					profile.portfolioName,
    					IFNULL(profile.email, user_logon.email) as email,
    					user_logon.userid,
    					profile.advisor,
    					profile.rep,
    					profile.theme,
    					user_logon.stateRegistered as state,
    					ext_acct_info.clientAccountID as clientAccountID,profile.status as'a1',
    					CASE WHEN (IFNULL(profile.managed,'N') = 'N' and IFNULL(profile.status,'V') in ('V')) THEN 'Visitor'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) = 'N') THEN 'Pending'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) = 'P') THEN 'Processing'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) is not null) THEN 'Pending'
    						 WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'O') THEN 'Opened'
                             WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'S') THEN 'Confirmation'
                             WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'P') THEN 'Processing'
    						 WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) is not null) THEN 'Active'
    						 ELSE 'Visitor'
    					END as status,
    					CASE WHEN (IFNULL(profile.managed,'N') in ('N')) THEN 'Pending'
    						 WHEN (upper(profile.managed) in ('A')) THEN 'Active'
    						 ELSE 'Pending'
    					END as acctStatus,
    					profile.tradePreference,
    					IFNULL(profile.goal,'Retirement') as goal,
    					profile.acctType as accttype,
    					IFNULL(profile.age,30) as age,
    					IFNULL(profile.horizon,30) as horizon,
    					round(datediff(now(),IFNULL(profile.created,now()))/364,0) as yearnum,
    					IFNULL(profile.riskIndex,0) as riskIndex,
    					CAST(IFNULL(profile.initialInvestment,5000) as SIGNED) as initialInvestment,
    					round(funct_get_actualCapital(profile.acctnum),0) as actualCapital,
    					IFNULL(profile.keepLiquid,0) as keepLiquid,
    					IFNULL(profile.recurringInvestment,0) as recurringInvestment,
    					IFNULL(profile.longTermGoal,0) as longTermGoal,
    					IFNULL(profile.stayInvested,0) as stayInvested,
    					profile.taxable,
    					IFNULL(profile.calcModel,'A') as calcModel,
    					IFNULL(profile.assetIndex,0) as assetIndex,
    					IFNULL(profile.portfolioIndex,0) as portfolioIndex,
    					DATE_FORMAT(profile.created,'%Y%m%d') as dateOpened,
    
    					IFNULL(user_risk_questions.retireage,0) AS retireage,
    					IFNULL(user_risk_questions.ans1,0) AS ans1,
    					IFNULL(user_risk_questions.ans2,0) AS ans2,
    					IFNULL(user_risk_questions.ans3,0) AS ans3,
    					IFNULL(user_risk_questions.ans4,0) AS ans4,
    					IFNULL(user_risk_questions.ans5,0) AS ans5,
    					IFNULL(user_risk_questions.ans6,0) AS ans6,
    					IFNULL(user_risk_questions.ans7,0) AS ans7,
    					IFNULL(user_risk_questions.ans8,0) AS ans8,
    					IFNULL(user_risk_questions.ans9,0) AS ans9,
    					IFNULL(user_risk_questions.ans10,0) AS ans10,
    					IFNULL(user_risk_questions.ans11,0) AS ans11,
    					IFNULL(user_risk_questions.ans12,0) AS ans12,
    					IFNULL(user_risk_questions.ans13,0) AS ans13,
    					IFNULL(user_risk_questions.ans14,0) AS ans14,
    					IFNULL(user_risk_questions.ans15,0) AS ans15,
                        
    						acct_financial.dependent,
    						acct_financial.estdDependentExpense,
    						acct_financial.householdwages,
    						acct_financial.otherincome,
    						acct_financial.bonusincome,
    						acct_financial.interestincome,
    						acct_financial.dividentincome,
    						acct_financial.rentalIncome,
    						acct_financial.totalIncome,
    						acct_financial.totalIncomeAnnulized,
    						acct_financial.householdPayment,
    						acct_financial.otherPropertiesPayment,
    						acct_financial.automobilePayment,
    						acct_financial.medicalPayment,
    						acct_financial.federaltaxes,
    						acct_financial.stateTaxes,
    						acct_financial.propertyTax,
    						acct_financial.otherPropertyTax,
    						acct_financial.homeInsurance,
    						acct_financial.lifeInsurance,
    						acct_financial.autoInsurance,
    						acct_financial.educationPayment,
    						acct_financial.creditCardPayment,
    						acct_financial.miscExpenses,
    						acct_financial.totalExpense,
    						acct_financial.totalExpenseAnnulized,
    						acct_financial.homeEquity,
    						acct_financial.autoValue,
    						acct_financial.moneyMarket,
    						acct_financial.checkingAcct,
    						acct_financial.savingAcct,
    						acct_financial.investment,
    						acct_financial.equityOtherProperties,
    						acct_financial.retirementInvestement,
    						acct_financial.miscInvestment,
    						acct_financial.totalAsset,
    						acct_financial.mortgageLoan,
    						acct_financial.autoLoan,
    						acct_financial.educationLoan,
    						acct_financial.creditCardDebt,
    						acct_financial.otherPropertiesLoan,
    						acct_financial.medicalDebt,
    						acct_financial.otherDebt,
    						acct_financial.totalDebt,
    						acct_financial.liquidnetworth,
    						acct_financial.networth,
							user_access_role.role,
							user_access_role.privileges,
    
    
    					IFNULL(profile.goalAmount,0) as goalDesired,
    					DATE_FORMAT(profile.created,'%Y-%m-%d') as created,
                        IFNULL(profile.customName,'') as customName,tradeCurrency,settleCurrency,exchangeRate
    					
    					from
    						user_logon,
    						user_access_role,
    						user_trade_profile profile
    						left join acct_financial
    						On ( profile.acctnum = acct_financial.acctnum)
    						left join user_risk_questions
    						On (profile.acctnum = user_risk_questions.acctnum)
    						left join ext_acct_info ext_acct_info
    						On (ext_acct_info.acctnum = profile.acctnum)
    					where
    						user_logon.logonid = user_access_role.logonid
    					and user_access_role.acctnum = profile.acctnum
    					and user_access_role.role in ('OWNER')
    					and profile.acctnum = p_acctnum
    					and user_logon.logonid = p_logonid
    					and profile.advisor= p_advisor
    					and profile.rep= p_rep
    					order by profile.acctnum
    					LIMIT 1
    					;
    				ELSE
    					select 
    					user_logon.logonid,
    					profile.acctnum,
                        profile.managed,
    					IFNULL(profile.firstname, user_logon.firstname) as firstname,
    					IFNULL(profile.lastname, user_logon.lastname) as lastname,
    					profile.portfolioName,
    					IFNULL(profile.email, user_logon.email) as email,
    					user_logon.userid,
    					profile.advisor,
    					profile.rep,
    					profile.theme,
    					user_logon.stateRegistered as state,
    					ext_acct_info.clientAccountID as clientAccountID,profile.status as'a1',
    					CASE WHEN (IFNULL(profile.managed,'N') = 'N' and IFNULL(profile.status,'V') in ('V')) THEN 'Visitor'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) = 'N') THEN 'Pending'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) = 'P') THEN 'Processing'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) is not null) THEN 'Pending'
    						 WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'O') THEN 'Opened'
                             WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'S') THEN 'Confirmation'
                             WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'P') THEN 'Processing'
    						 WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) is not null) THEN 'Active'
    						 ELSE 'Visitor'
    					END as status,
    					CASE WHEN (IFNULL(profile.managed,'N') in ('N')) THEN 'Pending'
    						 WHEN (upper(profile.managed) in ('A')) THEN 'Active'
    						 ELSE 'Pending'
    					END as acctStatus,
    					profile.tradePreference,
    					IFNULL(profile.goal,'Retirement') as goal,
    					profile.acctType as accttype,
    					IFNULL(profile.age,30) as age,
    					IFNULL(profile.horizon,30) as horizon,
    					round(datediff(now(),IFNULL(profile.created,now()))/364,0) as yearnum,
    					IFNULL(profile.riskIndex,0) as riskIndex,
    					CAST(IFNULL(profile.initialInvestment,5000) as SIGNED) as initialInvestment,
    					round(funct_get_actualCapital(profile.acctnum),0) as actualCapital,
    					IFNULL(profile.keepLiquid,0) as keepLiquid,
    					IFNULL(profile.recurringInvestment,0) as recurringInvestment,
    					IFNULL(profile.longTermGoal,0) as longTermGoal,
    					IFNULL(profile.stayInvested,0) as stayInvested,
    					profile.taxable,
    					IFNULL(profile.calcModel,'A') as calcModel,
    					IFNULL(profile.assetIndex,0) as assetIndex,
    					IFNULL(profile.portfolioIndex,0) as portfolioIndex,
    					DATE_FORMAT(profile.created,'%Y%m%d') as dateOpened,
    
    					IFNULL(user_risk_questions.retireage,0) AS retireage,
    					IFNULL(user_risk_questions.ans1,0) AS ans1,
    					IFNULL(user_risk_questions.ans2,0) AS ans2,
    					IFNULL(user_risk_questions.ans3,0) AS ans3,
    					IFNULL(user_risk_questions.ans4,0) AS ans4,
    					IFNULL(user_risk_questions.ans5,0) AS ans5,
    					IFNULL(user_risk_questions.ans6,0) AS ans6,
    					IFNULL(user_risk_questions.ans7,0) AS ans7,
    					IFNULL(user_risk_questions.ans8,0) AS ans8,
    					IFNULL(user_risk_questions.ans9,0) AS ans9,
    					IFNULL(user_risk_questions.ans10,0) AS ans10,
    					IFNULL(user_risk_questions.ans11,0) AS ans11,
    					IFNULL(user_risk_questions.ans12,0) AS ans12,
    					IFNULL(user_risk_questions.ans13,0) AS ans13,
    					IFNULL(user_risk_questions.ans14,0) AS ans14,
    					IFNULL(user_risk_questions.ans15,0) AS ans15,
                        
    						acct_financial.dependent,
    						acct_financial.estdDependentExpense,
    						acct_financial.householdwages,
    						acct_financial.otherincome,
    						acct_financial.bonusincome,
    						acct_financial.interestincome,
    						acct_financial.dividentincome,
    						acct_financial.rentalIncome,
    						acct_financial.totalIncome,
    						acct_financial.totalIncomeAnnulized,
    						acct_financial.householdPayment,
    						acct_financial.otherPropertiesPayment,
    						acct_financial.automobilePayment,
    						acct_financial.medicalPayment,
    						acct_financial.federaltaxes,
    						acct_financial.stateTaxes,
    						acct_financial.propertyTax,
    						acct_financial.otherPropertyTax,
    						acct_financial.homeInsurance,
    						acct_financial.lifeInsurance,
    						acct_financial.autoInsurance,
    						acct_financial.educationPayment,
    						acct_financial.creditCardPayment,
    						acct_financial.miscExpenses,
    						acct_financial.totalExpense,
    						acct_financial.totalExpenseAnnulized,
    						acct_financial.homeEquity,
    						acct_financial.autoValue,
    						acct_financial.moneyMarket,
    						acct_financial.checkingAcct,
    						acct_financial.savingAcct,
    						acct_financial.investment,
    						acct_financial.equityOtherProperties,
    						acct_financial.retirementInvestement,
    						acct_financial.miscInvestment,
    						acct_financial.totalAsset,
    						acct_financial.mortgageLoan,
    						acct_financial.autoLoan,
    						acct_financial.educationLoan,
    						acct_financial.creditCardDebt,
    						acct_financial.otherPropertiesLoan,
    						acct_financial.medicalDebt,
    						acct_financial.otherDebt,
    						acct_financial.totalDebt,
    						acct_financial.liquidnetworth,
    						acct_financial.networth,
							user_access_role.role,
							user_access_role.privileges,
    
    					IFNULL(profile.goalAmount,0) as goalDesired,
    					DATE_FORMAT(profile.created,'%Y-%m-%d') as created,
                        IFNULL(profile.customName,'') as customName,tradeCurrency,settleCurrency,exchangeRate
    					
    					from
    						user_logon,
    						user_access_role,
    						user_trade_profile profile
    						left join acct_financial
    						On ( profile.acctnum = acct_financial.acctnum)
    						left join user_risk_questions
    						On (profile.acctnum = user_risk_questions.acctnum)
    						left join ext_acct_info ext_acct_info
    						On (ext_acct_info.acctnum = profile.acctnum)
    					where
    						user_logon.logonid = user_access_role.logonid
    					and user_access_role.acctnum = profile.acctnum
    					and user_access_role.role in ('OWNER', 'USER')
    					and user_logon.logonid = p_logonid
    					and profile.advisor= p_advisor
    					and profile.rep= p_rep
    					order by profile.acctnum
    					;
    			END IF;
            ELSE
    			IF (singleAcct)
    				THEN
    					select 
    					user_logon.logonid,
    					profile.acctnum,
                        profile.managed,
    					IFNULL(profile.firstname, user_logon.firstname) as firstname,
    					IFNULL(profile.lastname, user_logon.lastname) as lastname,
    					profile.portfolioName,
    					IFNULL(profile.email, user_logon.email) as email,
    					user_logon.userid,
    					profile.advisor,
    					profile.rep,
    					profile.theme,
    					user_logon.stateRegistered as state,
    					ext_acct_info.clientAccountID as clientAccountID,profile.status as'a1',
    					CASE WHEN (IFNULL(profile.managed,'N') = 'N' and IFNULL(profile.status,'V') in ('V')) THEN 'Visitor'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) = 'N') THEN 'Pending'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) = 'P') THEN 'Processing'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) is not null) THEN 'Pending'
    						 WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'O') THEN 'Opened'
                             WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'S') THEN 'Confirmation'
                             WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'P') THEN 'Processing'
    						 WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) is not null) THEN 'Active'
    						 ELSE 'Visitor'
    					END as status,
    					CASE WHEN (IFNULL(profile.managed,'N') in ('N')) THEN 'Pending'
    						 WHEN (upper(profile.managed) in ('A')) THEN 'Active'
    						 ELSE 'Pending'
    					END as acctStatus,
    					profile.tradePreference,
    					IFNULL(profile.goal,'Retirement') as goal,
    					(case when (ext_acct_info.accountType is not null )
    								then ext_acct_info.accountType 
    						  else profile.acctType 
    					end) as accttype,
    					IFNULL(profile.age,30) as age,
    					IFNULL(profile.horizon,30) as horizon,
    					round(datediff(now(),IFNULL(profile.created,now()))/364,0) as yearnum,
    					IFNULL(profile.riskIndex,0) as riskIndex,
    					CAST(IFNULL(profile.initialInvestment,5000) as SIGNED) as initialInvestment,
    					round(funct_get_actualCapital(profile.acctnum),0) as actualCapital,
    					IFNULL(profile.keepLiquid,0) as keepLiquid,
    					IFNULL(profile.recurringInvestment,0) as recurringInvestment,
    					IFNULL(profile.longTermGoal,0) as longTermGoal,
    					IFNULL(profile.stayInvested,0) as stayInvested,
    					profile.taxable,
    					IFNULL(profile.calcModel,'A') as calcModel,
    					IFNULL(profile.assetIndex,0) as assetIndex,
    					IFNULL(profile.portfolioIndex,0) as portfolioIndex,
    					DATE_FORMAT(profile.created,'%Y%m%d') as dateOpened,
    
    					IFNULL(user_risk_questions.retireage,0) AS retireage,
    					IFNULL(user_risk_questions.ans1,0) AS ans1,
    					IFNULL(user_risk_questions.ans2,0) AS ans2,
    					IFNULL(user_risk_questions.ans3,0) AS ans3,
    					IFNULL(user_risk_questions.ans4,0) AS ans4,
    					IFNULL(user_risk_questions.ans5,0) AS ans5,
    					IFNULL(user_risk_questions.ans6,0) AS ans6,
    					IFNULL(user_risk_questions.ans7,0) AS ans7,
    					IFNULL(user_risk_questions.ans8,0) AS ans8,
    					IFNULL(user_risk_questions.ans9,0) AS ans9,
    					IFNULL(user_risk_questions.ans10,0) AS ans10,
    					IFNULL(user_risk_questions.ans11,0) AS ans11,
    					IFNULL(user_risk_questions.ans12,0) AS ans12,
    					IFNULL(user_risk_questions.ans13,0) AS ans13,
    					IFNULL(user_risk_questions.ans14,0) AS ans14,
    					IFNULL(user_risk_questions.ans15,0) AS ans15,
                        
    						acct_financial.dependent,
    						acct_financial.estdDependentExpense,
    						acct_financial.householdwages,
    						acct_financial.otherincome,
    						acct_financial.bonusincome,
    						acct_financial.interestincome,
    						acct_financial.dividentincome,
    						acct_financial.rentalIncome,
    						acct_financial.totalIncome,
    						acct_financial.totalIncomeAnnulized,
    						acct_financial.householdPayment,
    						acct_financial.otherPropertiesPayment,
    						acct_financial.automobilePayment,
    						acct_financial.medicalPayment,
    						acct_financial.federaltaxes,
    						acct_financial.stateTaxes,
    						acct_financial.propertyTax,
    						acct_financial.otherPropertyTax,
    						acct_financial.homeInsurance,
    						acct_financial.lifeInsurance,
    						acct_financial.autoInsurance,
    						acct_financial.educationPayment,
    						acct_financial.creditCardPayment,
    						acct_financial.miscExpenses,
    						acct_financial.totalExpense,
    						acct_financial.totalExpenseAnnulized,
    						acct_financial.homeEquity,
    						acct_financial.autoValue,
    						acct_financial.moneyMarket,
    						acct_financial.checkingAcct,
    						acct_financial.savingAcct,
    						acct_financial.investment,
    						acct_financial.equityOtherProperties,
    						acct_financial.retirementInvestement,
    						acct_financial.miscInvestment,
    						acct_financial.totalAsset,
    						acct_financial.mortgageLoan,
    						acct_financial.autoLoan,
    						acct_financial.educationLoan,
    						acct_financial.creditCardDebt,
    						acct_financial.otherPropertiesLoan,
    						acct_financial.medicalDebt,
    						acct_financial.otherDebt,
    						acct_financial.totalDebt,
    						acct_financial.liquidnetworth,
    						acct_financial.networth,
							user_access_role.role,
							user_access_role.privileges,
    
    					IFNULL(profile.goalAmount,0) as goalDesired,
    					DATE_FORMAT(profile.created,'%Y-%m-%d') as created,
                        IFNULL(profile.customName,'') as customName,tradeCurrency,settleCurrency,exchangeRate
    					
    					from
    						user_trade_profile profile
    						left join user_access_role
    						ON (user_access_role.acctnum = profile.acctnum
    						AND user_access_role.role = 'OWNER' )
    						left join user_logon
    						ON (user_logon.logonid = user_access_role.logonid)
    						left join acct_financial
    						On ( profile.acctnum = acct_financial.acctnum)
    						left join user_risk_questions
    						On (profile.acctnum = user_risk_questions.acctnum)
    						left join ext_acct_info ext_acct_info
    						On (ext_acct_info.acctnum = profile.acctnum)
    					where
    						IFNULL(profile.advisor,'Invessence') like tAdvisor
    					and IFNULL(profile.rep,'000') like tRep
    					and profile.acctnum = p_acctnum
    					order by profile.acctnum
    					;
                    ELSE
    					select 
    					user_logon.logonid,
    					profile.acctnum,
                        profile.managed,
    					IFNULL(profile.firstname, user_logon.firstname) as firstname,
    					IFNULL(profile.lastname, user_logon.lastname) as lastname,
    					profile.portfolioName,
    					IFNULL(profile.email, user_logon.email) as email,
    					user_logon.userid,
    					profile.advisor,
    					profile.rep,
    					profile.theme,
    					user_logon.stateRegistered as state,
    					ext_acct_info.clientAccountID as clientAccountID,profile.status as'a1',
    					CASE WHEN (IFNULL(profile.managed,'N') = 'N' and IFNULL(profile.status,'V') in ('V')) THEN 'Visitor'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) = 'N') THEN 'Pending'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) = 'P') THEN 'Processing'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) is not null) THEN 'Pending'
    						 WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'O') THEN 'Opened'
                             WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'S') THEN 'Confirmation'
                             WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'P') THEN 'Processing'
    						 WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) is not null) THEN 'Active'
    						 ELSE 'Visitor'
    					END as status,
    					CASE WHEN (IFNULL(profile.managed,'N') in ('N')) THEN 'Pending'
    						 WHEN (upper(profile.managed) in ('A')) THEN 'Active'
    						 ELSE 'Pending'
    					END as acctStatus,
    					profile.tradePreference,
    					IFNULL(profile.goal,'Retirement') as goal,
    					 (case when (ext_acct_info.accountType is not null )
    								then ext_acct_info.accountType 
    							else profile.acctType 
    					 end) as accttype,
    					IFNULL(profile.age,30) as age,
    					IFNULL(profile.horizon,30) as horizon,
    					round(datediff(now(),IFNULL(profile.created,now()))/364,0) as yearnum,
    					IFNULL(profile.riskIndex,0) as riskIndex,
    					CAST(IFNULL(profile.initialInvestment,5000) as SIGNED) as initialInvestment,
    					round(funct_get_actualCapital(profile.acctnum),0) as actualCapital,
    					IFNULL(profile.keepLiquid,0) as keepLiquid,
    					IFNULL(profile.recurringInvestment,0) as recurringInvestment,
    					IFNULL(profile.longTermGoal,0) as longTermGoal,
    					IFNULL(profile.stayInvested,0) as stayInvested,
    					profile.taxable,
    					IFNULL(profile.calcModel,'A') as calcModel,
    					IFNULL(profile.assetIndex,0) as assetIndex,
    					IFNULL(profile.portfolioIndex,0) as portfolioIndex,
    					DATE_FORMAT(profile.created,'%Y%m%d') as dateOpened,
    
    					IFNULL(user_risk_questions.retireage,0) AS retireage,
    					IFNULL(user_risk_questions.ans1,0) AS ans1,
    					IFNULL(user_risk_questions.ans2,0) AS ans2,
    					IFNULL(user_risk_questions.ans3,0) AS ans3,
    					IFNULL(user_risk_questions.ans4,0) AS ans4,
    					IFNULL(user_risk_questions.ans5,0) AS ans5,
    					IFNULL(user_risk_questions.ans6,0) AS ans6,
    					IFNULL(user_risk_questions.ans7,0) AS ans7,
    					IFNULL(user_risk_questions.ans8,0) AS ans8,
    					IFNULL(user_risk_questions.ans9,0) AS ans9,
    					IFNULL(user_risk_questions.ans10,0) AS ans10,
    					IFNULL(user_risk_questions.ans11,0) AS ans11,
    					IFNULL(user_risk_questions.ans12,0) AS ans12,
    					IFNULL(user_risk_questions.ans13,0) AS ans13,
    					IFNULL(user_risk_questions.ans14,0) AS ans14,
    					IFNULL(user_risk_questions.ans15,0) AS ans15,
                        
                        
    						acct_financial.dependent,
    						acct_financial.estdDependentExpense,
    						acct_financial.householdwages,
    						acct_financial.otherincome,
    						acct_financial.bonusincome,
    						acct_financial.interestincome,
    						acct_financial.dividentincome,
    						acct_financial.rentalIncome,
    						acct_financial.totalIncome,
    						acct_financial.totalIncomeAnnulized,
    						acct_financial.householdPayment,
    						acct_financial.otherPropertiesPayment,
    						acct_financial.automobilePayment,
    						acct_financial.medicalPayment,
    						acct_financial.federaltaxes,
    						acct_financial.stateTaxes,
    						acct_financial.propertyTax,
    						acct_financial.otherPropertyTax,
    						acct_financial.homeInsurance,
    						acct_financial.lifeInsurance,
    						acct_financial.autoInsurance,
    						acct_financial.educationPayment,
    						acct_financial.creditCardPayment,
    						acct_financial.miscExpenses,
    						acct_financial.totalExpense,
    						acct_financial.totalExpenseAnnulized,
    						acct_financial.homeEquity,
    						acct_financial.autoValue,
    						acct_financial.moneyMarket,
    						acct_financial.checkingAcct,
    						acct_financial.savingAcct,
    						acct_financial.investment,
    						acct_financial.equityOtherProperties,
    						acct_financial.retirementInvestement,
    						acct_financial.miscInvestment,
    						acct_financial.totalAsset,
    						acct_financial.mortgageLoan,
    						acct_financial.autoLoan,
    						acct_financial.educationLoan,
    						acct_financial.creditCardDebt,
    						acct_financial.otherPropertiesLoan,
    						acct_financial.medicalDebt,
    						acct_financial.otherDebt,
    						acct_financial.totalDebt,
    						acct_financial.liquidnetworth,
    						acct_financial.networth,
							user_access_role.role,
							user_access_role.privileges,
    
    					IFNULL(profile.goalAmount,0) as goalDesired,
    					DATE_FORMAT(profile.created,'%Y-%m-%d') as created,
                        IFNULL(profile.customName,'') as customName,tradeCurrency,settleCurrency,exchangeRate
    					
    					from
    						user_trade_profile profile
    						left join user_access_role
    						ON (user_access_role.acctnum = profile.acctnum
    						AND user_access_role.role = 'OWNER' )
    						left join user_logon
    						ON (user_logon.logonid = user_access_role.logonid)
    						left join acct_financial
    						On ( profile.acctnum = acct_financial.acctnum)
    						left join user_risk_questions
    						On (profile.acctnum = user_risk_questions.acctnum)
    						left join ext_acct_info ext_acct_info
    						On (ext_acct_info.acctnum = profile.acctnum)
    					where
    						IFNULL(profile.advisor,'Invessence') like tAdvisor
    					and IFNULL(profile.rep,'000') like tRep
                        AND (IFNULL(profile.created,now()) >= DATE_ADD(now(),INTERVAL p_days DAY)
    					AND ext_acct_info.acctnum is null)
    					order by profile.acctnum
    					;
    			END IF;
    	END IF;
      END$$

DELIMITER ;

/* 6.sp_invdb_create_sel_exchange_rate.sql180218_sagar*/

USE `invdb`;
DROP procedure IF EXISTS `sel_exchange_rate`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sel_exchange_rate`(in p_from_currency varchar(20),in p_to_currency varchar(20))
begin
    declare p_frstcd,p_scndcd,p_fromCurrency,p_toCurrency,baseCrncy,p_symbol varchar(10);
    declare p_exchngavailable int;
    declare p_multiplying_factor double;
    declare p_businessdate,exhangeStatus varchar(20);
    declare retExchangeRate double;
  
    set p_exchngavailable=0;
    set p_symbol=concat(p_from_currency,p_to_currency);   
    set exhangeStatus='Failed';
    
    select isw.value into p_businessdate from invdb.invessence_switch isw where isw.name='PRICE_DATE';  
    select count(*) into p_exchngavailable from invdb.sec_exchangerate_master where symbol=p_symbol;
    -- select p_businessdate,p_exchngavailable;
    
  
    if(p_exchngavailable>0) then
             select sed.exchangeRate into retExchangeRate from rbsa.sec_exchangerate_data sed where sed.symbol=p_symbol and sed.exchangeDate=DATE_FORMAT(p_businessdate, '%Y-%m-%d');
             set exhangeStatus='Success';
        else
  
    	set p_exchngavailable=0;
        SELECT SUBSTRING(p_symbol,1,3) into p_frstcd;
        SELECT SUBSTRING(p_symbol,4,6) into p_scndcd;
        set p_symbol=concat(p_scndcd,p_frstcd);
    	select count(*) into p_exchngavailable from invdb.sec_exchangerate_master where symbol=p_symbol;
  
    		if(p_exchngavailable>0) then
               select sed.reverseExchangeRate into retExchangeRate from rbsa.sec_exchangerate_data sed where sed.symbol=p_symbol and sed.exchangeDate=DATE_FORMAT(p_businessdate, '%Y-%m-%d');
               set exhangeStatus='Success';
    		end if;
    end if;
    select exhangeStatus,retExchangeRate;
  
    end$$

DELIMITER ;

/* 7.sp_invdb_update_web_site_info.sql200218_sagar*/

UPDATE `invdb`.`web_site_info` SET `value`='UOBKH-Forgot.html' WHERE `url`='utraderobo' and`name`='HTML.FORGOT';
UPDATE `invdb`.`web_site_info` SET `value`='UOBKH-Locked.html' WHERE `url`='utraderobo' and`name`='HTML.LOCKED';
UPDATE `invdb`.`web_site_info` SET `value`='UOBKH-Reset.html' WHERE `url`='utraderobo' and`name`='HTML.RESET';
UPDATE `invdb`.`web_site_info` SET `value`='UOBKH-Welcome.html' WHERE `url`='utraderobo' and`name`='HTML.WELCOME';
UPDATE `invdb`.`web_site_info` SET `value`='UOBKH-Welcome.html' WHERE `url`='utraderobo' and`name`='HTML.WELCOME.ADV';


/* 8.sp_invdb_altr_ao_owners_employment_details.sql260218_sagar*/

ALTER TABLE `invdb`.`ao_owners_employment_details` 
CHANGE COLUMN `emplId` `emplId` INT(2) NULL ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`acctnum`, `acctOwnerId`);

/* 9.sp_invdb_update_web_menu.sql260218_sagar*/


UPDATE `invdb`.`web_menu` SET `status`='N' WHERE `url`='utraderobo' and`access`='Advisor' and`permission`='Operations' and`label`='Model';
UPDATE `invdb`.`web_menu` SET `status`='N' WHERE `url`='uwealth' and`access`='Advisor' and`permission`='Operations' and`label`='Model';

/* 10.sp_invdb_update_advisor_risk_master.sql260218_sagar*/

UPDATE `invdb`.`advisor_risk_master` SET `defaultValue`=NULL WHERE `advisor`='UOB' and`sortorder`='80' and`key`='WITHDRAWALPERIOD';

/* 11.sp_invdb_sel_collectTradeProfile.sql260218_sagar*/

USE `invdb`;
DROP procedure IF EXISTS `sel_collectTradeProfile`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sel_collectTradeProfile`(
 	p_logonid	BIGINT(20),
     p_advisor	VARCHAR(20),
 	p_filter 	varchar(20)
 )
BEGIN
 	begin
     
      	DECLARE tAdvisor VARCHAR(25);
 		DECLARE tfilterType   VARCHAR(1);
      
 		DECLARE vAdvisor VARCHAR(25);
  
 		select advisor 
         into vAdvisor  
         from user_logon where logonid=p_logonid;
 		if (vAdvisor='DEMO') then
  			 set tAdvisor = IFNULL(p_advisor,'%');
 		else
 			SELECT 
 			  advisor
 			INTO tAdvisor 
 			FROM user_advisor_access
 			WHERE logonid = p_logonid;
      
      end if;
 
     
        SELECT 
 			trade_process_identifier.acctnum,
             ext_acct_info.clientAccountID,
             ext_acct_info.applicantFName,
             ext_acct_info.applicantLName,
             ext_acct_info.fullname,
 			trade_process_identifier.tradeStatus,
 			trade_process_identifier.processStatus,
 			trade_process_identifier.reason,
             SUM(ext_nav.cash * ext_nav.exchangeRate) as cash,
             SUM((ext_nav.stock * ext_nav.exchangeRate) + (ext_nav.funds * ext_nav.exchangeRate)) +
             SUM((ext_nav.interestAccrual* ext_nav.exchangeRate) + (ext_nav.dividentAccrual* ext_nav.exchangeRate)) as investment,
             user_trade_profile.advisor,
             IFNULL(user_basket_access.displayname,user_trade_profile.theme) as theme,
             user_trade_profile.acctType,
             SUM(ext_nav.total * ext_nav.exchangeRate)  as totalInvestment,
             user_trade_profile.keepLiquid,
             user_trade_profile.longTermGoal,
             user_trade_profile.stayInvested,
 			user_trade_profile.calcModel,
             user_trade_profile.riskIndex,
             user_trade_profile.assetIndex,
             user_trade_profile.portfolioIndex,
             user_trade_profile.age,
             user_trade_profile.horizon,
 			user_trade_profile.taxable
             , max(date_format(user_trade_log.tradedate,'%Y-%m-%d')) as lastTraded             
 		FROM trade_process_identifier
         INNER JOIN user_trade_profile
         ON (user_trade_profile.acctnum = trade_process_identifier.acctnum)
         INNER JOIN ext_acct_info
         ON (ext_acct_info.acctnum = trade_process_identifier.acctnum
 			AND ext_acct_info.status in ('A'))
 		INNER JOIN ext_nav
         ON (ext_nav.clientAccountID = ext_acct_info.clientAccountID
         AND ext_nav.reportDate = FUNCT_GET_SWITCH('BROKER_BDATE'))
         LEFT JOIN user_trade_log
         ON (user_trade_log.acctnum = trade_process_identifier.acctnum)
         LEFT JOIN user_basket_access
         ON (user_trade_profile.theme = user_basket_access.theme)
         WHERE IFNULL(trade_process_identifier.processStatus,'N') like p_filter
         AND   lower(IFNULL(user_trade_profile.advisor,'Invessence')) like lower(tAdvisor)
         AND (user_trade_profile.status ='A' or user_trade_profile.status ='R')
         GROUP BY
 			trade_process_identifier.acctnum,
             ext_acct_info.clientAccountID,
             ext_acct_info.applicantFName,
             ext_acct_info.applicantLName,
             ext_acct_info.fullname,
 			trade_process_identifier.tradeStatus,
 			trade_process_identifier.processStatus,
 			trade_process_identifier.reason,
             user_trade_profile.advisor,
             IFNULL(user_basket_access.displayname,user_trade_profile.theme),
             user_trade_profile.acctType,
             user_trade_profile.keepLiquid,
             user_trade_profile.longTermGoal,
             user_trade_profile.stayInvested,
 			user_trade_profile.calcModel,
             user_trade_profile.riskIndex,
             user_trade_profile.assetIndex,
             user_trade_profile.portfolioIndex,
             user_trade_profile.age,
             user_trade_profile.horizon,
 			user_trade_profile.taxable
     	;
 
     end;
 END$$

DELIMITER ;


