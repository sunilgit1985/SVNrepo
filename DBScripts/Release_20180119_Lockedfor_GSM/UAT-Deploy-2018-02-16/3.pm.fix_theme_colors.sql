UPDATE `invdb`.`sec_asset_mapping` SET `assetcolor`='#c90710' WHERE `theme` like 'KayHian%' and `assetclass` = 'Equity';
UPDATE `invdb`.`sec_asset_mapping` SET `assetcolor`='#e97922' WHERE `theme` like 'KayHian%' and `assetclass` = 'Fixed Income';
UPDATE `invdb`.`sec_asset_mapping` SET `assetcolor`='#439b3b' WHERE `theme` like 'KayHian%' and `assetclass` = 'Commodity';
UPDATE `invdb`.`sec_asset_mapping` SET `assetcolor`='#00a9c9' WHERE `theme` like 'KayHian%' and `assetclass` = 'Cash';

UPDATE `invdb`.`sec_assetclass_group` SET `color`='#c90710' WHERE `theme` like 'KayHian%' and `assetclass` = 'Equity';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#e97922' WHERE `theme` like 'KayHian%' and `assetclass` = 'Fixed Income';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#439b3b' WHERE `theme` like 'KayHian%' and `assetclass` = 'Commodity';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#00a9c9' WHERE `theme` like 'KayHian%' and `assetclass` = 'Cash';