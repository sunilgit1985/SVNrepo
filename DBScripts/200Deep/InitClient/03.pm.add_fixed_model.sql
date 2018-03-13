insert into sec_fixedmodel
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T1'),
    `sec_fixedmodel`.`level`,
    `sec_fixedmodel`.`sortorder`,
    `sec_fixedmodel`.`status`,
    `sec_fixedmodel`.`displayname`,
    `sec_fixedmodel`.`description`,
    `sec_fixedmodel`.`lowRisk`,
    `sec_fixedmodel`.`highRisk`,
    `sec_fixedmodel`.`expectedreturn`,
    `sec_fixedmodel`.`expectedrisk`,
    `sec_fixedmodel`.`created`,
    `sec_fixedmodel`.`updated`
FROM `invdb`.`sec_fixedmodel`
where `theme` like '%0.TA%';

insert into sec_fixedmodel
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T2'),
    `sec_fixedmodel`.`level`,
    `sec_fixedmodel`.`sortorder`,
    `sec_fixedmodel`.`status`,
    `sec_fixedmodel`.`displayname`,
    `sec_fixedmodel`.`description`,
    `sec_fixedmodel`.`lowRisk`,
    `sec_fixedmodel`.`highRisk`,
    `sec_fixedmodel`.`expectedreturn`,
    `sec_fixedmodel`.`expectedrisk`,
    `sec_fixedmodel`.`created`,
    `sec_fixedmodel`.`updated`
FROM `invdb`.`sec_fixedmodel`
where `theme` like '%0.TA%';


insert into sec_fixedmodel
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T3'),
    `sec_fixedmodel`.`level`,
    `sec_fixedmodel`.`sortorder`,
    `sec_fixedmodel`.`status`,
    `sec_fixedmodel`.`displayname`,
    `sec_fixedmodel`.`description`,
    `sec_fixedmodel`.`lowRisk`,
    `sec_fixedmodel`.`highRisk`,
    `sec_fixedmodel`.`expectedreturn`,
    `sec_fixedmodel`.`expectedrisk`,
    `sec_fixedmodel`.`created`,
    `sec_fixedmodel`.`updated`
FROM `invdb`.`sec_fixedmodel`
where `theme` like '%0.TA%';

