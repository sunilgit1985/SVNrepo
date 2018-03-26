UPDATE `invdb`.`sec_assetclass_group` SET `color`='#e97922' WHERE `theme`='KayHian.With.Sing' and`assetclass`='Commodity';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#e97922' WHERE `theme`='KayHian.Without.Sing' and`assetclass`='Commodity';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#439b3b' WHERE `theme`='KayHian.With.Sing' and`assetclass`='Fixed Income';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#439b3b' WHERE `theme`='KayHian.Without.Sing' and`assetclass`='Fixed Income';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#f7eb31' WHERE `theme`='KayHian.Without.Sing' and`assetclass`='Cash';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#f7eb31' WHERE `theme`='KayHian.With.Sing' and`assetclass`='Cash';


CALL `invdb`.`sp_upload_sec_asset_mapping`('KayHian.With.Sing');
CALL `invdb`.`sp_upload_sec_asset_mapping`('KayHian.Without.Sing');
