INSERT INTO `sec_asset_mapping`
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T1'),
    `sec_asset_mapping`.`ticker`,
    `sec_asset_mapping`.`assetclass`,
    `sec_asset_mapping`.`assetName`,
    `sec_asset_mapping`.`assetcolor`,
    `sec_asset_mapping`.`assetsortorder`,
    `sec_asset_mapping`.`subclass`,
    `sec_asset_mapping`.`subclassName`,
    `sec_asset_mapping`.`subclasscolor`,
    `sec_asset_mapping`.`subclasssortorder`,
    `sec_asset_mapping`.`type`,
    `sec_asset_mapping`.`style`,
    `sec_asset_mapping`.`created`,
    `sec_asset_mapping`.`lastUpdated`
FROM `invdb`.`sec_asset_mapping`
where `theme` like '%0.TA%';

INSERT INTO `sec_asset_mapping`
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T2'),
    `sec_asset_mapping`.`ticker`,
    `sec_asset_mapping`.`assetclass`,
    `sec_asset_mapping`.`assetName`,
    `sec_asset_mapping`.`assetcolor`,
    `sec_asset_mapping`.`assetsortorder`,
    `sec_asset_mapping`.`subclass`,
    `sec_asset_mapping`.`subclassName`,
    `sec_asset_mapping`.`subclasscolor`,
    `sec_asset_mapping`.`subclasssortorder`,
    `sec_asset_mapping`.`type`,
    `sec_asset_mapping`.`style`,
    `sec_asset_mapping`.`created`,
    `sec_asset_mapping`.`lastUpdated`
FROM `invdb`.`sec_asset_mapping`
where `theme` like '%0.TA%';


INSERT INTO `sec_asset_mapping`
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T3'),
    `sec_asset_mapping`.`ticker`,
    `sec_asset_mapping`.`assetclass`,
    `sec_asset_mapping`.`assetName`,
    `sec_asset_mapping`.`assetcolor`,
    `sec_asset_mapping`.`assetsortorder`,
    `sec_asset_mapping`.`subclass`,
    `sec_asset_mapping`.`subclassName`,
    `sec_asset_mapping`.`subclasscolor`,
    `sec_asset_mapping`.`subclasssortorder`,
    `sec_asset_mapping`.`type`,
    `sec_asset_mapping`.`style`,
    `sec_asset_mapping`.`created`,
    `sec_asset_mapping`.`lastUpdated`
FROM `invdb`.`sec_asset_mapping`
where `theme` like '%0.TA%';
