DELETE FROM `invdb`.`sec_source_mapping` WHERE `sec_ticker`='C.N';

UPDATE `invdb`.`sec_source_mapping` SET `currency_exchange_cd`='USDSGD' WHERE `sec_ticker`='EIMI.L' and`ticker_source_name`='EIMI.L' and`dest_currency`='SGD';
UPDATE `invdb`.`sec_source_mapping` SET `currency_exchange_cd`='USDSGD' WHERE `sec_ticker`='2821.HK' and`ticker_source_name`='2821.HK' and`dest_currency`='SGD';
UPDATE `invdb`.`sec_source_mapping` SET `currency_exchange_cd`='USDSGD' WHERE `sec_ticker`='IPXJ.L' and`ticker_source_name`='IPXJ.L' and`dest_currency`='SGD';
UPDATE `invdb`.`sec_source_mapping` SET `currency_exchange_cd`='USDSGD' WHERE `sec_ticker`='IUAG.L' and`ticker_source_name`='IUAG.L' and`dest_currency`='SGD';

DELETE FROM `invdb`.`sec_source_mapping` WHERE `sec_ticker`='C.N';
DELETE FROM `invdb`.`sec_source_mapping` WHERE `sec_ticker`='TOL.N' and`ticker_source_name`='TOL.N' and`dest_currency`='SGD';
DELETE FROM `invdb`.`sec_source_mapping` WHERE `sec_ticker`='UL.N' and`ticker_source_name`='UL.N' and`dest_currency`='SGD';
DELETE FROM `invdb`.`sec_source_mapping` WHERE `sec_ticker`='MRK.N' and`ticker_source_name`='MRK.N' and`dest_currency`='SGD';
DELETE FROM `invdb`.`sec_source_mapping` WHERE `sec_ticker`='DAL.N' and`ticker_source_name`='DAL.N' and`dest_currency`='SGD';


UPDATE `invdb`.`sec_exchangerate_master` SET `status`='A' WHERE `symbol`='EURSGD';
UPDATE `invdb`.`sec_exchangerate_master` SET `status`='A' WHERE `symbol`='GBPSGD';
UPDATE `invdb`.`sec_exchangerate_master` SET `status`='A' WHERE `symbol`='HKDUSD';
UPDATE `invdb`.`sec_exchangerate_master` SET `status`='A' WHERE `symbol`='SGDUSD';
UPDATE `invdb`.`sec_exchangerate_master` SET `status`='A' WHERE `symbol`='USDEUR';

UPDATE `invdb`.`user_basket_access` SET `sortorder`='2' WHERE `advisor`='UOB' and`theme`='0.SGWealthSGD.Un' and`primary`='Y';
UPDATE `invdb`.`user_basket_access` SET `sortorder`='5' WHERE `advisor`='UOB' and`theme`='T.8.UOB.UnCons' and`primary`='Y';
UPDATE `invdb`.`user_basket_access` SET `sortorder`='3' WHERE `advisor`='UOB' and`theme`='8.UOB.UnCons' and`primary`='Y';
UPDATE `invdb`.`user_basket_access` SET `sortorder`='4' WHERE `advisor`='UOB' and`theme`='8.UOB' and`primary`='Y';
UPDATE `invdb`.`user_basket_access` SET `sortorder`='6' WHERE `advisor`='UOB' and`theme`='T.8.UOB' and`primary`='Y';


DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='0.CITI' and`assetclass`='Cash';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='0.CITI' and`assetclass`='Commodity';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='0.CITI' and`assetclass`='Equity';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='0.CITI' and`assetclass`='Fixed Income';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='0.TRowe' and`assetclass`='Alternative';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='0.TRowe' and`assetclass`='Bond';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='0.TRowe' and`assetclass`='Cash';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='0.TRowe' and`assetclass`='Commodity';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='0.TRowe' and`assetclass`='Domestic';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='0.TRowe' and`assetclass`='HighYield';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='0.TRowe' and`assetclass`='International';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='T.0.CITI' and`assetclass`='Cash';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='T.0.CITI' and`assetclass`='Commodity';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='T.0.CITI' and`assetclass`='Equity';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='T.0.CITI' and`assetclass`='Fixed Income';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='T.0.TRowe' and`assetclass`='Alternative';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='T.0.TRowe' and`assetclass`='Bond';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='T.0.TRowe' and`assetclass`='Cash';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='T.0.TRowe' and`assetclass`='Commodity';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='T.0.TRowe' and`assetclass`='Domestic';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='T.0.TRowe' and`assetclass`='HighYield';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='T.0.TRowe' and`assetclass`='International';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='0.Mfs' and`assetclass`='Bond';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='0.Mfs' and`assetclass`='Cash';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='0.Mfs' and`assetclass`='Commodity';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='0.Mfs' and`assetclass`='Domestic';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='0.Mfs' and`assetclass`='HighYield';
DELETE FROM `invdb`.`sec_assetclass_group` WHERE `theme`='0.Mfs' and`assetclass`='International';
