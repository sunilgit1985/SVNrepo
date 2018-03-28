
/* 0.pm.Rename_FixedThemes.sql130318_pmehta*/

UPDATE `invdb`.`user_basket_access` SET `model`='F' WHERE `advisor`='BB' and`theme`='0.BB' and`primary`='Y';
UPDATE `invdb`.`user_basket_access` SET `model`='F' WHERE `advisor`='BB' and`theme`='T.0.BB' and`primary`='Y';
UPDATE `invdb`.`user_basket_access` SET `model`='F' WHERE `advisor`='BB-TCM' and`theme`='0.TA' and`primary`='Y';
UPDATE `invdb`.`user_basket_access` SET `model`='F' WHERE `advisor`='BB-TCM' and`theme`='T.0.TA' and`primary`='Y';

/* 500.pm.sel_daily_prime_historical_returns.sql130318_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`sel_daily_prime_historical_returns`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_daily_prime_historical_returns`()
BEGIN

	DROP TEMPORARY TABLE IF EXISTS tmp_historical_dates;
	CREATE TEMPORARY TABLE tmp_historical_dates
	(
		ticker VARCHAR(20),
        tradeCurrency VARCHAR(3),
	    min_businessdate VARCHAR(10),
	    max_businessdate VARCHAR(10)
	);

	DROP TEMPORARY TABLE IF EXISTS tmp_ticker_list;
	CREATE TEMPORARY TABLE tmp_ticker_list
	(
		ticker VARCHAR(20),
        tradeCurrency VARCHAR(3)
	);

	INSERT INTO tmp_ticker_list
	SELECT DISTINCT 
			sec_assetclass_group.ticker,
            user_basket_access.tradeCurrency
	FROM invdb.sec_assetclass_group,
		 invdb.user_basket_access
	WHERE user_basket_access.theme = sec_assetclass_group.theme
    AND   user_basket_access.`status` in ('A')
    AND   sec_assetclass_group.`status` in ('A')
    ;

	INSERT INTO tmp_ticker_list
	SELECT DISTINCT 
			sec_rbsa.ticker,
           user_basket_access.tradeCurrency
	FROM invdb.sec_rbsa,
		 invdb.sec_prime_asset_group,
		 invdb.user_basket_access
	WHERE user_basket_access.theme = sec_prime_asset_group.theme
    AND   user_basket_access.`status` in ('A')
    AND   sec_prime_asset_group.`status` in ('A')
	AND   sec_rbsa.ticker not in (
			SELECT DISTINCT 
				sag.ticker
			FROM invdb.sec_assetclass_group sag
			WHERE user_basket_access.theme = sag.theme
			AND   sag.`status` in ('A')
        )
    AND   user_basket_access.theme = sec_rbsa.theme
    AND   sec_rbsa.primeasset_ticker = sec_prime_asset_group.ticker;

 
	DELETE FROM tmp_ticker_list
	WHERE upper(ticker) = 'CASH';

	INSERT INTO tmp_historical_dates
	SELECT `daily`.`ticker`,
		   `tmp_ticker_list`.`tradeCurrency` as `tradeCurrency`,
		   min(businessdate) as min_businessdate, 
		   max(businessdate) as max_businessdate
	FROM `rbsa`.`rbsa_daily` daily,
		 tmp_ticker_list
	WHERE daily.ticker = tmp_ticker_list.ticker
    AND   daily.dest_currency = tmp_ticker_list.tradeCurrency
	group by daily.ticker, daily.dest_currency;

	SELECT  `daily`.`ticker`,
		   `tmp_ticker_list`.`tradeCurrency` as `tradeCurrency`, 
            count(*) as maxrows
	FROM 
		 tmp_ticker_list,
		 `rbsa`.`rbsa_daily` daily,
		 (SELECT max(min_businessdate) as min_date, min(max_businessdate) as max_date from tmp_historical_dates) as tmp
	WHERE businessdate >= tmp.min_date
	AND   businessdate <= tmp.max_date
	AND   daily.ticker = tmp_ticker_list.ticker
    AND   daily.dest_currency = tmp_ticker_list.tradeCurrency
	AND   businessdate in (select businessdate from invdb.inv_date_table)
	GROUP BY daily.ticker, daily.dest_currency; 
	
	SELECT daily.ticker,
		   tmp_ticker_list.tradeCurrency,
           daily.base_currency as settleCurrency,
		   businessdate,
		   IFNULL(daily_return,0) as daily_return
	FROM 
		 tmp_ticker_list,
		 `rbsa`.`rbsa_daily` daily,
		 (SELECT max(min_businessdate) as min_date, min(max_businessdate) as max_date from tmp_historical_dates) as tmp
	WHERE businessdate >= tmp.min_date
	AND   businessdate <= tmp.max_date
	AND   daily.ticker = tmp_ticker_list.ticker
    AND   daily.dest_currency = tmp_ticker_list.tradeCurrency
	AND   businessdate in (select businessdate from invdb.inv_date_table)
	ORDER BY 1, 2, 3, 4 desc;
	

END$$
DELIMITER ;

/* 501.pm.sel_sec_volatility.sql130318_pmehta*/

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
