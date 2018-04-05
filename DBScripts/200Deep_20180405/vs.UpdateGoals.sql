UPDATE `invdb`.`webpage_menu_items` SET `key`='COLLEGE', `displayname`='College' WHERE `advisor`='BELLROCK' and`group`='GOAL' and`key`='EDUCATION';
UPDATE `invdb`.`webpage_menu_items` SET `key`='OTHER', `displayname`='Other', `description`='Other' WHERE `advisor`='BELLROCK' and`group`='GOAL' and`key`='LEGACY';
DELETE FROM `invdb`.`webpage_menu_items` WHERE `advisor`='BELLROCK' and`group`='GOAL' and`key`='PROPERTY';
