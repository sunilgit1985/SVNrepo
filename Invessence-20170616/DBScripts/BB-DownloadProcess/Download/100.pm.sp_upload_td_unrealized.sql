USE temp;
DROP procedure IF EXISTS sp_upload_td_unrealized;

DELIMITER $$
USE temp$$
CREATE PROCEDURE sp_upload_td_unrealized(
)
BEGIN

	DECLARE tReportDate	VARCHAR(10);

	SET SQL_SAFE_UPDATES = 0;
    SELECT MAX(invdb.funct_strdate2inv_date(tmp_td_unrealized.businessDate, '%m/%d/%Y'))
    INTO tReportDate
    FROM temp.tmp_td_unrealized;

    -- First delete all position for this business date
	DELETE FROM invdb.ext_position
    where reportDate in (select distinct invdb.funct_strdate2inv_date(tmp_td_unrealized.businessDate, '%m/%d/%Y')
					     from temp.tmp_td_unrealized)
    ;

	INSERT INTO invdb.ext_position
	(acctnum,
	clientAccountID,
	currencyPrimary,
	fxRateToBase,
	symbol,
	reportDate,
    purchaseDate,
	side,
	quantity,
	costBasisPrice,
	costBasisMoney,
	markPrice,
	positionValue,
	pnlUnrealized,
	levelOfDetail,
	created)
    SELECT ext_acct_info.acctnum
		 , ext_acct_info.clientAccountID
         , 'USD' as currencyPrimary
         , 1.0 as fxRateToBase
         , tmp_td_unrealized.symbolCUSIP
         , invdb.funct_strdate2inv_date(tmp_td_unrealized.businessDate, '%m/%d/%Y') as businessdate
         , invdb.funct_strdate2inv_date(tmp_td_unrealized.originalPurchaseDate, '%m/%d/%Y') as originalPurchaseDate
         , 'Long' as side
		 , tmp_td_unrealized.currentQuantity
		 , CASE WHEN (tmp_td_unrealized.currentQuantity is null) THEN 1
				WHEN (tmp_td_unrealized.currentQuantity = 0) THEN 1
                ELSE (tmp_td_unrealized.bookCost / tmp_td_unrealized.currentQuantity)
			END costBasisPrice
		 , tmp_td_unrealized.bookCost as costBasisMoney
		 , IFNULL(tmp_td_price.price,
				CASE WHEN (tmp_td_unrealized.currentQuantity is null) THEN 1
				WHEN (tmp_td_unrealized.currentQuantity = 0) THEN 1
                ELSE (tmp_td_unrealized.bookCost / tmp_td_unrealized.currentQuantity)
				END) as markPrice
		 ,  (IFNULL(tmp_td_price.price,1) * IFNULL(tmp_td_unrealized.currentQuantity,1)) as positionValue
		 ,  (IFNULL(tmp_td_price.price,1) * IFNULL(tmp_td_unrealized.currentQuantity,1)) - tmp_td_unrealized.bookCost as pnlUnrealized
		 , tmp_td_unrealized.ID as levelOfDetail
		 , now() as created
    FROM invdb.ext_acct_info
		 INNER JOIN temp.tmp_td_unrealized
         ON (ext_acct_info.clientAccountID = tmp_td_unrealized.accountNumber)
		 LEFT JOIN temp.tmp_td_price
         ON (tmp_td_unrealized.symbolCUSIP = tmp_td_price.symbolCUSIP)
	;

    -- Now Add Cash Position.  NOTE:  We deleted all records at top.
	INSERT INTO invdb.ext_position
		(acctnum,
		clientAccountID,
		currencyPrimary,
		fxRateToBase,
		symbol,
		reportDate,
		purchaseDate,
		side,
		quantity,
		costBasisPrice,
		costBasisMoney,
		markPrice,
		positionValue,
		pnlUnrealized,
		levelOfDetail,
		created)
    SELECT ext_acct_info.acctnum
		 , ext_acct_info.clientAccountID
         , 'USD' as currencyPrimary
         , 1.0 as fxRateToBase
         , 'Cash' as Symbol
         , tReportDate as businessdate
         , tReportDate as originalPurchaseDate
         , 'Long' as side
		 , SUM(tmp_td_position.amount) as currentQuantity
		 , 1 as costBasisPrice
		 , SUM(tmp_td_position.amount) as costBasisMoney
		 , 1 as markPrice
		 , SUM(tmp_td_position.amount) as positionValue
		 , 0 as pnlUnrealized
		 , 'Cash' as levelOfDetail
		 , now() as created
    FROM invdb.ext_acct_info as ext_acct_info, temp.tmp_td_position as tmp_td_position
    WHERE ext_acct_info.clientAccountID = tmp_td_position.accountNumber
    AND   tmp_td_position.securityType in ('Cash', 'MF', 'Money')
    GROUP BY
			ext_acct_info.acctnum
		 , ext_acct_info.clientAccountID

	;

	-- Now load the NAV data from ext_position
	CALL temp.sp_upload_td_nav();

	SET SQL_SAFE_UPDATES = 1;
END$$

DELIMITER ;

