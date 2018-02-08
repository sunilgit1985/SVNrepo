select * from invdb.sec_rbsa

INSERT INTO `invdb`.`sec_rbsa` 
(`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`, `settlecurrency`, `style`, `tradeCurrency`) 
VALUES 
 ('8.UOB', 'Cash', 'Cash', '1', '2018-01-19', 'USD', 'Cash', 'SGD')
,('8.UOB.Sing', 'Cash', 'Cash', '1', '2018-01-19', 'USD', 'Cash', 'SGD')
,('T.8.UOB.Sing', 'Cash', 'Cash', '1', '2018-01-19', 'USD', 'Cash', 'SGD')
;

UPDATE `invdb`.`sec_rbsa` 
SET `tradeCurrency`='SGD' 
WHERE `theme`='T.8.UOB' and`primeasset_ticker`='Cash' and`ticker`='Cash';
UPDATE `invdb`.`sec_rbsa` 
SET `tradeCurrency`='SGD' 
WHERE `theme`='0.SGWealthSGD.Un' and`primeasset_ticker`='Cash' and`ticker`='Cash';

CALL `invdb`.`sp_upload_sec_asset_mapping`('8.UOB');
CALL `invdb`.`sp_upload_sec_asset_mapping`('T.8.UOB');
CALL `invdb`.`sp_upload_sec_asset_mapping`('8.UOB.Sing');
CALL `invdb`.`sp_upload_sec_asset_mapping`('T.8.UOB.Sing');
