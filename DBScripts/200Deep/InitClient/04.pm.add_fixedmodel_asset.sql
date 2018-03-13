insert into sec_fixedmodel_asset
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T1'),
    `sec_fixedmodel_asset`.`level`,
    `sec_fixedmodel_asset`.`asset`,
    `sec_fixedmodel_asset`.`assetname`,
    `sec_fixedmodel_asset`.`status`,
    `sec_fixedmodel_asset`.`allocation`,
    `sec_fixedmodel_asset`.`color`,
    `sec_fixedmodel_asset`.`sortorder`,
    `sec_fixedmodel_asset`.`created`,
    `sec_fixedmodel_asset`.`updated`
FROM `invdb`.`sec_fixedmodel_asset`
where `theme` like '%0.TA%';

insert into sec_fixedmodel_asset
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T2'),
    `sec_fixedmodel_asset`.`level`,
    `sec_fixedmodel_asset`.`asset`,
    `sec_fixedmodel_asset`.`assetname`,
    `sec_fixedmodel_asset`.`status`,
    `sec_fixedmodel_asset`.`allocation`,
    `sec_fixedmodel_asset`.`color`,
    `sec_fixedmodel_asset`.`sortorder`,
    `sec_fixedmodel_asset`.`created`,
    `sec_fixedmodel_asset`.`updated`
FROM `invdb`.`sec_fixedmodel_asset`
where `theme` like '%0.TA%';

insert into sec_fixedmodel_asset
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T3'),
    `sec_fixedmodel_asset`.`level`,
    `sec_fixedmodel_asset`.`asset`,
    `sec_fixedmodel_asset`.`assetname`,
    `sec_fixedmodel_asset`.`status`,
    `sec_fixedmodel_asset`.`allocation`,
    `sec_fixedmodel_asset`.`color`,
    `sec_fixedmodel_asset`.`sortorder`,
    `sec_fixedmodel_asset`.`created`,
    `sec_fixedmodel_asset`.`updated`
FROM `invdb`.`sec_fixedmodel_asset`
where `theme` like '%0.TA%';