DROP PROCEDURE IF EXISTS `invdb`.`save_virtual_portfolio`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`save_virtual_portfolio`(
      IN p_addmodflag      VARCHAR(1),
  	IN p_acctnum bigint(20),
  	IN p_itemnum int(10) unsigned,
  	IN p_ticker varchar(20),
  	IN p_active varchar(1),
      IN p_tradeCurrency varchar(3),
  	IN p_qty double,
  	IN p_weight double,
  	IN p_tradeprice double,
  	IN p_investmentvalue double,
      IN p_settleCurrency varchar(3),
      IN p_exchangeRate double,
      IN p_settleQty double,
      IN p_settlePrice double,
      IN p_settleValue double
  )
BEGIN 
  
      INSERT INTO virtual_portfolio
           (
  		acctnum,
  		itemnum,
  		ticker,
  		active,
          tradeCurrency,
  		qty,
  		weight,
  		tradeprice,
  		investmentvalue,
          settleCurrency,
          exchangeRate,
          settleQty,
          settlePrice,
          settleValue,
  		created,
  		lastupdated
           )
      VALUES 
           ( 
  		p_acctnum,
  		p_itemnum,
  		p_ticker,
  		p_active,
          ifnull(p_tradeCurrency,'USD'),
  		p_qty,
  		p_weight,
  		p_tradeprice,
  		p_investmentvalue,
          ifnull(p_settleCurrency,'USD'),
          ifnull(p_exchangeRate,1.0),
          p_settleQty,
          p_settlePrice,
          p_settleValue,
  		now(),
  		NULL
           )
  	ON DUPLICATE key update
  		itemnum = p_itemnum,
  		active = p_active,
          tradeCurrency = ifnull(p_tradeCurrency,'USD'),
  		qty = p_qty,
  		weight = p_weight,
  		tradeprice = p_tradeprice,
  		investmentvalue = p_investmentvalue,
          settleCurrency = p_settleCurrency,
          exchangeRate = p_exchangeRate,
          settleQty = p_settleQty,
          settlePrice = p_settlePrice,
          settleValue = p_settleValue,
  		lastupdated = now()
          ;
  END$$
DELIMITER ;
