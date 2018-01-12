DROP PROCEDURE IF EXISTS `invdb`.`sel_taxHarvestingSecurities`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_taxHarvestingSecurities`()
BEGIN
	SELECT 
		`tlh`.`ticker`,
		`tlh`.`tlhticker`,
		`tlh`.`active`,
		`tlh`.`weight`,
        IFNULL(`mapping`.`type`,`sec_master`.`type`) AS `type`,
        IFNULL(`mapping`.`style`,`sec_master`.`style`) AS `style`,
        IFNULL(`mapping`.`assetclass`,`sec_master`.`assetclass`) AS `assetclass`,
        IFNULL(`mapping`.`subclass`,`sec_master`.`subclass`) AS `subclass`,
        `sec_master`.`expenseRatio` AS `expenseRatio`,
        (case
            when (ucase(`tlh`.`ticker`) = ucase('Cash')) then 1.00
            else ifnull(`sd`.`converted_adjusted_price`, 0.00)
        end) AS `tradePrice`,
        (case
            when (ucase(`tlh`.`ticker`) = ucase('Cash')) then 1.00
            else ifnull(`sd`.`exchangeRate`, 0.00)
        end) AS `exchangeRate`,
        (case
            when (ucase(`tlh`.`ticker`) = ucase('Cash')) then 1.00
            else ifnull(`sd`.`adjusted_price`, 0.00)
        end) AS `settlePrice`,
 		DATE_FORMAT(`tlh`.`created`,'%Y%m%d') as created
	FROM `sec_tax_loss_harvesting` as `tlh`
		INNER JOIN `sec_master` as `sec_master`
        ON (`tlh`.`ticker` = `sec_master`.`ticker`)
        INNER JOIN  `sec_asset_mapping` as `mapping`
        ON (`tlh`.`tlhticker` = `mapping`.`ticker`
        AND `tlh`.`theme` = `mapping`.`theme`)
         LEFT JOIN `sec_daily_info` as `sd`
         ON (`tlh`.`tlhticker` = `sd`.`ticker`
			AND    date_format(`sd`.`businessdate`, '%Y%m%d') = funct_get_switch('PRICE_DATE'))
 	where `tlh`.`active` = 'A'
    ;
END$$
DELIMITER ;
