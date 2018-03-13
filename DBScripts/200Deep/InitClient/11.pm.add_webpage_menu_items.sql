INSERT INTO `webpage_menu_items`
SELECT 'BELLROCK',
    `webpage_menu_items`.`group`,
    `webpage_menu_items`.`sortorder`,
    `webpage_menu_items`.`key`,
    `webpage_menu_items`.`displayname`,
    `webpage_menu_items`.`image`,
    `webpage_menu_items`.`shortname`,
    `webpage_menu_items`.`description`,
    `webpage_menu_items`.`otherinfo`,
    `webpage_menu_items`.`created`,
    `webpage_menu_items`.`lastUpdated`
FROM `invdb`.`webpage_menu_items`
WHERE `webpage_menu_items`.`advisor` = 'UOB'
