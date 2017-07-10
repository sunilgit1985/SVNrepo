insert into invdb.sec_assetclass_group
SELECT REPLACE(`sec_assetclass_group`.`theme`,'SGWealth','CITI'),
    `sec_assetclass_group`.`status`,
    `sec_assetclass_group`.`assetclass`,
    `sec_assetclass_group`.`displayName`,
    `sec_assetclass_group`.`ticker`,
    `sec_assetclass_group`.`sortorder`,
    `sec_assetclass_group`.`lowerBound`,
    `sec_assetclass_group`.`upperBound`,
    `sec_assetclass_group`.`color`,
    `sec_assetclass_group`.`averageReturn`,
    `sec_assetclass_group`.`riskAdjustment`,
    `sec_assetclass_group`.`endAllocation`,
    `sec_assetclass_group`.`created`,
    `sec_assetclass_group`.`lastupdated`
FROM `invdb`.`sec_assetclass_group`
where `sec_assetclass_group`.`theme` like '%SGWealth';

insert into `invdb`.`sec_prime_asset_group`
SELECT REPLACE(`sec_prime_asset_group`.`theme`,'SGWealth','CITI'),
    `sec_prime_asset_group`.`assetclass`,
    `sec_prime_asset_group`.`ticker`,
    `sec_prime_asset_group`.`status`,
    `sec_prime_asset_group`.`sortorder`,
    `sec_prime_asset_group`.`color`,
    `sec_prime_asset_group`.`lowerBound`,
    `sec_prime_asset_group`.`upperBound`,
    `sec_prime_asset_group`.`expectedReturn`,
    `sec_prime_asset_group`.`risk`,
    `sec_prime_asset_group`.`yield`,
    `sec_prime_asset_group`.`created`,
    `sec_prime_asset_group`.`lastUpdated`
FROM `invdb`.`sec_prime_asset_group`
where `sec_prime_asset_group`.`theme` like '%SGWealth';

insert into `invdb`.`sec_rbsa`
SELECT REPLACE(`sec_rbsa`.`theme`,'SGWealth','CITI'),
    `sec_rbsa`.`primeasset_ticker`,
    `sec_rbsa`.`ticker`,
    `sec_rbsa`.`weight`,
    `sec_rbsa`.`created`
FROM `invdb`.`sec_rbsa`
where `sec_rbsa`.`theme` like '%SGWealth';

UPDATE `invdb`.`sec_assetclass_group` SET `color`='#0076C0' WHERE `theme`='0.CITI' and`assetclass`='Equity';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#0076C0' WHERE `theme`='T.0.CITI' and`assetclass`='Equity';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#00B0B9' WHERE `theme`='0.CITI' and`assetclass`='Fixed Income';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#00B0B9' WHERE `theme`='T.0.CITI' and`assetclass`='Fixed Income';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#007377' WHERE `theme`='0.CITI' and`assetclass`='Commodity';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#007377' WHERE `theme`='T.0.CITI' and`assetclass`='Commodity';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#002D72' WHERE `theme`='0.CITI' and`assetclass`='Cash';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#002D72' WHERE `theme`='T.0.CITI' and`assetclass`='Cash';

