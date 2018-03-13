INSERT INTO `user_basket_access`
SELECT 'BELLROCK',
    REPLACE(`theme`,'0.TA','BELLROCK.T1'),
    `user_basket_access`.`status`,
    `user_basket_access`.`displayname`,
    `user_basket_access`.`sortorder`,
    `user_basket_access`.`primary`,
    `user_basket_access`.`taxable`,
    `user_basket_access`.`model`,
    `user_basket_access`.`tradeCurrency`,
    `user_basket_access`.`created`,
    `user_basket_access`.`lastupdated`
FROM `invdb`.`user_basket_access`
where `theme` like '%0.TA%';


INSERT INTO `user_basket_access`
SELECT 'BELLROCK',
    REPLACE(`theme`,'0.TA','BELLROCK.T2'),
    `user_basket_access`.`status`,
    `user_basket_access`.`displayname`,
    `user_basket_access`.`sortorder`,
    `user_basket_access`.`primary`,
    `user_basket_access`.`taxable`,
    `user_basket_access`.`model`,
    `user_basket_access`.`tradeCurrency`,
    `user_basket_access`.`created`,
    `user_basket_access`.`lastupdated`
FROM `invdb`.`user_basket_access`
where `theme` like '%0.TA%';

INSERT INTO `user_basket_access`
SELECT 'BELLROCK',
    REPLACE(`theme`,'0.TA','BELLROCK.T3'),
    `user_basket_access`.`status`,
    `user_basket_access`.`displayname`,
    `user_basket_access`.`sortorder`,
    `user_basket_access`.`primary`,
    `user_basket_access`.`taxable`,
    `user_basket_access`.`model`,
    `user_basket_access`.`tradeCurrency`,
    `user_basket_access`.`created`,
    `user_basket_access`.`lastupdated`
FROM `invdb`.`user_basket_access`
where `theme` like '%0.TA%';

