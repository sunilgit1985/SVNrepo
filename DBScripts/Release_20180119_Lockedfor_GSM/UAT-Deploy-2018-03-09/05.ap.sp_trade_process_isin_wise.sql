USE `temp`;
DROP procedure IF EXISTS `sp_trade_process_isin_wise`;

DELIMITER $$
USE `temp`$$
CREATE  PROCEDURE `sp_trade_process_isin_wise`()
BEGIN

declare v_tradeDate varchar(10);
select value into v_tradeDate from invdb.invessence_switch where name='BUSINESS_DATE';

select ifnull(sm.ISIN,a.ticker)ticker,
    ifnull(sm.sedol,a.ticker)sedol,
    -- utl.ticker,
    ifnull(sm.ric,a.ticker) ric, sum(a.buyQty)buyQty, sum(a.sellQty)sellQty, sum(a.buyQty-a.sellQty)netQty, v_tradeDate tradeDate from 
(SELECT  utl.ticker,
   -- DATE_FORMAT(utl.tradedate,'%Y%m%d')tradedate,
    ABS(sum(utl.qty))buyQty, ''sellQty
FROM
    invdb.user_trade_log utl,
    invdb.ext_acct_info daod
WHERE
    utl.acctnum = daod.acctnum
        AND utl.tradeStatus in( 'P', 'I')
        AND utl.action = 'BUY'
        and utl.qty<>0
        AND utl.investmentamount<>0
        group by ticker -- , tradedate
        
        union all
        SELECT  
    utl.ticker,
    -- DATE_FORMAT(utl.tradedate,'%Y%m%d')tradedate,
    ''buyQty, ABS(sum(utl.qty))sellQty
FROM
    invdb.user_trade_log utl,
    invdb.ext_acct_info daod
WHERE
    utl.acctnum = daod.acctnum
        AND utl.tradeStatus in( 'P', 'I')
        AND utl.action = 'SELL'
        and utl.qty<>0
        AND utl.investmentamount<>0
        group by ticker -- , tradedate
        )a, invdb.sec_master sm
        where sm.ticker=a.ticker
        and a.ticker not in('Cash')
        group by a.ticker
	ORDER BY a.ticker;


END$$

DELIMITER ;

