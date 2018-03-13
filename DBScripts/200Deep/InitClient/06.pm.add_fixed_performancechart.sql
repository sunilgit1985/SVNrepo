INSERT INTO `sec_fixed_performancechart`
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T1'),
    `sec_fixed_performancechart`.`level`,
    `sec_fixed_performancechart`.`year`,
    `sec_fixed_performancechart`.`5percent`,
    `sec_fixed_performancechart`.`25percent`,
    `sec_fixed_performancechart`.`50percent`,
    `sec_fixed_performancechart`.`75percent`,
    `sec_fixed_performancechart`.`95percent`
FROM `invdb`.`sec_fixed_performancechart`
where `theme` like '%0.TA%';

INSERT INTO `sec_fixed_performancechart`
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T2'),
    `sec_fixed_performancechart`.`level`,
    `sec_fixed_performancechart`.`year`,
    `sec_fixed_performancechart`.`5percent`,
    `sec_fixed_performancechart`.`25percent`,
    `sec_fixed_performancechart`.`50percent`,
    `sec_fixed_performancechart`.`75percent`,
    `sec_fixed_performancechart`.`95percent`
FROM `invdb`.`sec_fixed_performancechart`
where `theme` like '%0.TA%';

INSERT INTO `sec_fixed_performancechart`
SELECT REPLACE(`theme`,'0.TA','BELLROCK.T3'),
    `sec_fixed_performancechart`.`level`,
    `sec_fixed_performancechart`.`year`,
    `sec_fixed_performancechart`.`5percent`,
    `sec_fixed_performancechart`.`25percent`,
    `sec_fixed_performancechart`.`50percent`,
    `sec_fixed_performancechart`.`75percent`,
    `sec_fixed_performancechart`.`95percent`
FROM `invdb`.`sec_fixed_performancechart`
where `theme` like '%0.TA%';