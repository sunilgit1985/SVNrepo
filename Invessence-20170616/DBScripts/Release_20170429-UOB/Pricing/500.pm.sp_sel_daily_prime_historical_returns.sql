DROP PROCEDURE IF EXISTS `invdb`.`sel_daily_prime_historical_returns`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_daily_prime_historical_returns`(
)
BEGIN

	DROP TEMPORARY TABLE IF EXISTS tmp_historical_dates;
	CREATE TEMPORARY TABLE tmp_historical_dates
	(
		ticker VARCHAR(20),
	    min_businessdate VARCHAR(10),
	    max_businessdate VARCHAR(10)
	);

	DROP TEMPORARY TABLE IF EXISTS tmp_ticker_list;
	CREATE TEMPORARY TABLE tmp_ticker_list
	(
		ticker VARCHAR(20)
	);

	INSERT INTO tmp_ticker_list
	SELECT DISTINCT 
			sec_assetclass_group.ticker 
	FROM invdb.sec_assetclass_group,
		 invdb.user_basket_access
	WHERE user_basket_access.theme = sec_assetclass_group.theme
    AND   user_basket_access.`status` in ('A')
    AND   sec_assetclass_group.`status` in ('A');
 
	INSERT INTO tmp_ticker_list
	SELECT DISTINCT 
		   ticker 
	FROM invdb.sec_prime_asset_group,
		 invdb.user_basket_access
	WHERE user_basket_access.theme = sec_prime_asset_group.theme
    AND   user_basket_access.`status` in ('A')
    AND   sec_prime_asset_group.`status` in ('A')
	AND   sec_prime_asset_group.ticker not in (select ticker FROM invdb.sec_assetclass_group);

	DELETE FROM tmp_ticker_list
	WHERE upper(ticker) = 'CASH';

	INSERT INTO tmp_historical_dates
	SELECT daily.ticker, 
		   min(businessdate) as min_businessdate, 
		   max(businessdate) as max_businessdate
	FROM `rbsa`.`rbsa_daily` daily,
		 tmp_ticker_list
	WHERE daily.ticker = tmp_ticker_list.ticker
	group by daily.ticker;

	SELECT daily.ticker, count(*) as maxrows
	FROM 
		 tmp_ticker_list,
		 `rbsa`.`rbsa_daily` daily,
		 (SELECT max(min_businessdate) as min_date, min(max_businessdate) as max_date from tmp_historical_dates) as tmp
	WHERE businessdate >= tmp.min_date
	AND   businessdate <= tmp.max_date
	AND   daily.ticker = tmp_ticker_list.ticker
	AND   businessdate in (select businessdate from invdb.inv_date_table)
	GROUP BY daily.ticker; 
	
	SELECT daily.ticker, 
		   businessdate,
		   IFNULL(daily_return,0) as daily_return
	FROM 
		 tmp_ticker_list,
		 `rbsa`.`rbsa_daily` daily,
		 (SELECT max(min_businessdate) as min_date, min(max_businessdate) as max_date from tmp_historical_dates) as tmp
	WHERE businessdate >= tmp.min_date
	AND   businessdate <= tmp.max_date
	AND   daily.ticker = tmp_ticker_list.ticker
	AND   businessdate in (select businessdate from invdb.inv_date_table)
	ORDER BY 1, 2 desc;
	

END$$
DELIMITER ;
