insert into invdb.web_site_info
SELECT '200deep',
    `web_site_info`.`name`,
    `web_site_info`.`status`,
    `web_site_info`.`value`,
    `web_site_info`.`encrFlag`,
    now(),
    null
FROM `invdb`.`web_site_info`
where `web_site_info`.`url` = 'traditionadvisers';

INSERT INTO `invdb`.`web_menu`
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


