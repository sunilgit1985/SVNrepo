USE `temp`;
DROP procedure IF EXISTS `sp_trade_process_both`;

DELIMITER $$
USE `temp`$$
CREATE  PROCEDURE `sp_trade_process_both`()
BEGIN

declare v_tradeDate varchar(10);
select value into v_tradeDate from invdb.invessence_switch where name='BUSINESS_DATE';

/*update invdb.user_trade_log utl
  set utl.tradeStatus='P'
  WHERE utl.tradeStatus = 'S'
  and utl.qty<>0
  AND utl.investmentamount<>0;*/

SELECT 
    utl.acctnum,
    utl.clientAccountID,
    utl.tradeStatus,
    -- DATE_FORMAT(utl.tradedate,'%Y%m%d')tradedate,
    v_tradeDate tradedate,
    ifnull(sm.ISIN,utl.ticker)ticker,
    ifnull(sm.sedol,utl.ticker)sedol,
    -- utl.ticker,
    ifnull(sm.ric,utl.ticker) ric,
    case utl.action when 'BUY' then 'B'
    when 'SELL' then 'S'
    else 'N'
    end action,
    utl.sectype,
    -- utl.exchange,
    'SGX' exchange,
    utl.currency,
    utl.timeinforce,
    ABS(utl.qty)qty,
    utl.tradeprice,
    abs(utl.investmentamount)investmentamount,
    utl.tradeID,
    utl.ordertype,
    utl.confirmationID,
    utl.firmAccount,
    utl.created,
    utl.lastupdated,
    daod.email
FROM
    invdb.user_trade_log utl,
    invdb.ext_acct_info daod,
    invdb.sec_master sm
WHERE
    utl.acctnum = daod.acctnum
        AND utl.tradeStatus in( 'P', 'I')
        AND utl.ticker not in('Cash')
        AND daod.acctnum = daod.acctnum
        and utl.qty<>0
        AND utl.investmentamount<>0
        and sm.ticker=utl.ticker
	ORDER BY acctnum,ticker,action;
	update invdb.user_trade_log utl
  set utl.tradeStatus='I'
  WHERE utl.tradeStatus = 'P'
  and utl.qty<>0
  AND utl.investmentamount<>0;

END$$

DELIMITER ;

