DROP PROCEDURE IF EXISTS `invdb`.`sel_sec_volatility`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_sec_volatility`(
	  IN p_theme	VARCHAR(50)
)
BEGIN

    SELECT DISTINCT
        IFNULL(`user_basket_access`.`theme`, 'Unused') AS `theme`,
        `sec_asset_mapping`.`assetclass` AS `assetclass`,
        IFNULL(`sec_rbsa`.`primeasset_ticker`,`sec_asset_mapping`.`ticker`) AS `primeassetclass`,
        `sec_asset_mapping`.`subclassName` AS `subassetName`,
        IFNULL(`sec_rbsa`.`ticker`,
                `sec_asset_mapping`.`ticker`) AS `ticker`,
        `sec_master`.`name` AS `name`,
        `sec_master`.`type` AS `type`,
        `sec_master`.`style` AS `style`,
        `sec_master`.`status` AS `status`,
		`sec_rbsa`.`base_currency`  AS `tradeCurrency`,
		`sec_rbsa`.`dest_currency`  AS `settleCurrency`,
        `sec_asset_mapping`.`assetcolor` AS `assetcolor`,
        `sec_asset_mapping`.`subclasscolor` AS `primeassetcolor`,
        `sec_master`.`assetclass` AS `secAssetClass`,
        `sec_master`.`subclass` AS `secSubAssetClass`,
        `sec_master`.`isin` AS `isin`,
        `sec_master`.`cusip` AS `cusip`,
        `sec_master`.`ric` AS `ric`
    FROM `user_basket_access`
        JOIN `sec_asset_mapping` ON (`user_basket_access`.`theme` = `sec_asset_mapping`.`theme`)
        JOIN `sec_master` ON (`sec_asset_mapping`.`ticker` = `sec_master`.`ticker`)
        LEFT JOIN `sec_rbsa` ON ((`sec_asset_mapping`.`theme` = `sec_rbsa`.`theme`)
            AND (`sec_asset_mapping`.`ticker` = `sec_rbsa`.`ticker`))
	WHERE `user_basket_access`.`theme` like IFNULL(p_theme,'%')
    AND	  `user_basket_access`.`model`in ('O')
    AND   `user_basket_access`.`status` in ('A')
    ;
END$$
DELIMITER ;
