DROP PROCEDURE IF EXISTS `invdb`.`sel_webpages_menu_items`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_webpages_menu_items`(
	IN p_advisor	VARCHAR(20)
)
BEGIN

    SELECT 
		`webpage_menu_items`.`advisor`,
		`webpage_menu_items`.`group`,
		`webpage_menu_items`.`sortorder`,
		`webpage_menu_items`.`key`,
		`webpage_menu_items`.`displayname`,
		`webpage_menu_items`.`image`,
		`webpage_menu_items`.`shortname`,
		`webpage_menu_items`.`description`,
		`webpage_menu_items`.`otherinfo`
	FROM `invdb`.`webpage_menu_items`
    WHERE upper(`webpage_menu_items`.`advisor`) = upper(IFNULL(p_advisor,'INVESSENCE'))
    ORDER BY 1, 2, 3
    ;

END$$
DELIMITER ;
