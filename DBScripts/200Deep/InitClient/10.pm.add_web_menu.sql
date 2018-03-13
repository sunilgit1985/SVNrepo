INSERT INTO `web_menu`
SELECT '200deep',
    `web_menu`.`access`,
    `web_menu`.`permission`,
    `web_menu`.`label`,
    `web_menu`.`icon`,
    `web_menu`.`level`,
    `web_menu`.`sublevel`,
    `web_menu`.`seq`,
    `web_menu`.`status`,
    `web_menu`.`availOnMobile`,
    `web_menu`.`destdir`,
    `web_menu`.`htmlpage`,
    `web_menu`.`command`,
    `web_menu`.`created`,
    `web_menu`.`updated`
FROM `invdb`.`web_menu`
where `web_menu`.`url` = 'traditionadvisers';
