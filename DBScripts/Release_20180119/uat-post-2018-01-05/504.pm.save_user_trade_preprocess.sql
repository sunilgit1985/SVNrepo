DROP PROCEDURE IF EXISTS `invdb`.`save_user_trade_preprocess`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`save_user_trade_preprocess`(
		IN	`p_advisor`	varchar(20)
	,	IN	`p_clientAccountID`	varchar(20)
	,	IN	`p_acctnum`	bigint(20)
	,	IN	`p_processed`	varchar(1)
	,	IN	`p_tradeDate`	varchar(8)
	,	IN	`p_tradeCurrency`	varchar(3)
	,	IN	`p_assetclass`	varchar(40)
	,	IN	`p_subclass`	varchar(40)
	,	IN	`p_color`	varchar(10)
	,	IN	`p_holdingTicker`	varchar(25)
	,	IN	`p_curQty`	double
	,	IN	`p_curPrice`	double
	,	IN	`p_curValue`	double
	,	IN	`p_newTicker`	varchar(25)
	,	IN	`p_newQty`	double
	,	IN	`p_newPrice`	double
	,	IN	`p_newValue`	double
	,	IN	`p_settleCurrency`	varchar(3)
	,	IN	`p_setleCurQty`	double
	,	IN	`p_settleCurPrice`	double
	,	IN	`p_settleCurValue`	double
	,	IN	`p_exchangeRate`	double
	,	IN	`p_settleNewQty`	double
	,	IN	`p_settleNewPrice`	double
	,	IN	`p_settleNewValue`	double
	,	IN	`p_tradeType`	varchar(40)
	,	IN	`p_reason`	varchar(40)
)
BEGIN

			INSERT INTO `invdb`.`user_trade_preprocess`
			(
            `advisor`,
			`clientAccountID`,
			`acctnum`,
			`processed`,
			`tradeDate`,
			`tradeCurrency`,
			`assetclass`,
			`subclass`,
			`color`,
			`holdingTicker`,
			`curQty`,
			`curPrice`,
			`curValue`,
			`newTicker`,
			`newQty`,
			`newPrice`,
			`newValue`,
			`settleCurrency`,
			`settleQty`,
			`settlePrice`,
			`settleValue`,
			`exchangeRate`,
			`settleNewQty`,
			`settleNewPrice`,
			`settleNewValue`,
			`tradetype`,
			`reason`,
			`created`
            )
		VALUES
        (
				`p_advisor`
			,	`p_clientAccountID`
			,	`p_acctnum`
			,	`p_processed`
			,	IFNULL(`p_tradeDate`,DATE_FORMAT(now(),'%Y%m%d'))
			,	`p_tradeCurrency`
			,	`p_assetclass`
			,	`p_subclass`
			,	`p_color`
			,	`p_holdingTicker`
			,	`p_curQty`
			,	`p_curPrice`
			,	`p_curValue`
			,	`p_newTicker`
			,	`p_newQty`
			,	`p_newPrice`
			,	`p_newValue`
			,	`p_settleCurrency`
			,	`p_setleCurQty`
			,	`p_settleCurPrice`
			,	`p_settleCurValue`
			,	`p_exchangeRate`
			,	`p_settleNewQty`
			,	`p_settleNewPrice`
			,	`p_settleNewValue`
			,	`p_tradeType`
			,	`p_reason`
            , 	now()
        )
            ON DUPLICATE KEY UPDATE
			`advisor`	=	`p_advisor`
		,	`clientAccountID`	=	`p_clientAccountID`
		,	`acctnum`	=	`p_acctnum`
		,	`processed`	=	`p_processed`
		,	`tradeDate`	=	IFNULL(`p_tradeDate`,DATE_FORMAT(now(),'%Y%m%d'))
		,	`tradeCurrency`	=	`p_tradeCurrency`
		,	`assetclass`	=	`p_assetclass`
		,	`subclass`	=	`p_subclass`
		,	`color`	=	`p_color`
		,	`holdingTicker`	=	`p_holdingTicker`
		,	`curQty`	=	`p_curQty`
		,	`curPrice`	=	`p_curPrice`
		,	`curValue`	=	`p_curValue`
		,	`newTicker`	=	`p_newTicker`
		,	`newQty`	=	`p_newQty`
		,	`newPrice`	=	`p_newPrice`
		,	`newValue`	=	`p_newValue`
		,	`settleCurrency`	=	`p_settleCurrency`
		,	`settleQty`	=	`p_setleCurQty`
		,	`settlePrice`	=	`p_settleCurPrice`
		,	`settleValue`	=	`p_settleCurValue`
		,	`exchangeRate`	=	`p_exchangeRate`
		,	`settleNewQty`	=	`p_settleNewQty`
		,	`settleNewPrice`	=	`p_settleNewPrice`
		,	`settleNewValue`	=	`p_settleNewValue`
		,	`tradeType`	=	`p_tradeType`
		,	`reason`	=	`p_reason`
        ;

END$$
DELIMITER ;
