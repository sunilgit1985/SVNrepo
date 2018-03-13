INSERT INTO `sec_fixed_projectionchart`
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T1'),
    `sec_fixed_projectionchart`.`model`,
    `sec_fixed_projectionchart`.`year`,
    `sec_fixed_projectionchart`.`5percent`,
    `sec_fixed_projectionchart`.`25percent`,
    `sec_fixed_projectionchart`.`50percent`,
    `sec_fixed_projectionchart`.`75percent`,
    `sec_fixed_projectionchart`.`95percent`
FROM `invdb`.`sec_fixed_projectionchart`
where `theme` like '%0.TA%';

INSERT INTO `sec_fixed_projectionchart`
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T2'),
    `sec_fixed_projectionchart`.`model`,
    `sec_fixed_projectionchart`.`year`,
    `sec_fixed_projectionchart`.`5percent`,
    `sec_fixed_projectionchart`.`25percent`,
    `sec_fixed_projectionchart`.`50percent`,
    `sec_fixed_projectionchart`.`75percent`,
    `sec_fixed_projectionchart`.`95percent`
FROM `invdb`.`sec_fixed_projectionchart`
where `theme` like '%0.TA%';


INSERT INTO `sec_fixed_projectionchart`
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T3'),
    `sec_fixed_projectionchart`.`model`,
    `sec_fixed_projectionchart`.`year`,
    `sec_fixed_projectionchart`.`5percent`,
    `sec_fixed_projectionchart`.`25percent`,
    `sec_fixed_projectionchart`.`50percent`,
    `sec_fixed_projectionchart`.`75percent`,
    `sec_fixed_projectionchart`.`95percent`
FROM `invdb`.`sec_fixed_projectionchart`
where `theme` like '%0.TA%';


