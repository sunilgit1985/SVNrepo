INSERT INTO `sec_fixedmodel_subasset`
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T1'),
    `sec_fixedmodel_subasset`.`level`,
    `sec_fixedmodel_subasset`.`asset`,
    `sec_fixedmodel_subasset`.`keyname`,
    `sec_fixedmodel_subasset`.`keydescription`,
    `sec_fixedmodel_subasset`.`status`,
    `sec_fixedmodel_subasset`.`allocation`,
    `sec_fixedmodel_subasset`.`sortorder`,
    `sec_fixedmodel_subasset`.`created`,
    `sec_fixedmodel_subasset`.`updated`
FROM `invdb`.`sec_fixedmodel_subasset`
where `theme` like '%0.TA%';

INSERT INTO `sec_fixedmodel_subasset`
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T2'),
    `sec_fixedmodel_subasset`.`level`,
    `sec_fixedmodel_subasset`.`asset`,
    `sec_fixedmodel_subasset`.`keyname`,
    `sec_fixedmodel_subasset`.`keydescription`,
    `sec_fixedmodel_subasset`.`status`,
    `sec_fixedmodel_subasset`.`allocation`,
    `sec_fixedmodel_subasset`.`sortorder`,
    `sec_fixedmodel_subasset`.`created`,
    `sec_fixedmodel_subasset`.`updated`
FROM `invdb`.`sec_fixedmodel_subasset`
where `theme` like '%0.TA%';

INSERT INTO `sec_fixedmodel_subasset`
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T3'),
    `sec_fixedmodel_subasset`.`level`,
    `sec_fixedmodel_subasset`.`asset`,
    `sec_fixedmodel_subasset`.`keyname`,
    `sec_fixedmodel_subasset`.`keydescription`,
    `sec_fixedmodel_subasset`.`status`,
    `sec_fixedmodel_subasset`.`allocation`,
    `sec_fixedmodel_subasset`.`sortorder`,
    `sec_fixedmodel_subasset`.`created`,
    `sec_fixedmodel_subasset`.`updated`
FROM `invdb`.`sec_fixedmodel_subasset`
where `theme` like '%0.TA%';