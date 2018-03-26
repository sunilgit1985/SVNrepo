USE `invdb`;
DROP procedure IF EXISTS `sel_exchange_rate`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sel_exchange_rate`(in p_from_currency varchar(20),in p_to_currency varchar(20))
begin
    declare p_frstcd,p_scndcd,p_fromCurrency,p_toCurrency,baseCrncy,p_symbol varchar(10);
    declare p_exchngavailable int;
    declare p_multiplying_factor double;
    declare p_businessdate,exhangeStatus varchar(20);
    declare retExchangeRate double;
  
    set p_exchngavailable=0;
    set p_symbol=concat(p_from_currency,p_to_currency);   
    set exhangeStatus='Failed';
    
    select isw.value into p_businessdate from invdb.invessence_switch isw where isw.name='PRICE_DATE';  
    select count(*) into p_exchngavailable from invdb.sec_exchangerate_master where symbol=p_symbol;
    -- select p_businessdate,p_exchngavailable;
    
  
    if(p_exchngavailable>0) then
             select sed.exchangeRate into retExchangeRate from rbsa.sec_exchangerate_data sed where sed.symbol=p_symbol and sed.exchangeDate=DATE_FORMAT(p_businessdate, '%Y-%m-%d');
             set exhangeStatus='Success';
        else
  
    	set p_exchngavailable=0;
        SELECT SUBSTRING(p_symbol,1,3) into p_frstcd;
        SELECT SUBSTRING(p_symbol,4,6) into p_scndcd;
        set p_symbol=concat(p_scndcd,p_frstcd);
    	select count(*) into p_exchngavailable from invdb.sec_exchangerate_master where symbol=p_symbol;
  
    		if(p_exchngavailable>0) then
               select sed.reverseExchangeRate into retExchangeRate from rbsa.sec_exchangerate_data sed where sed.symbol=p_symbol and sed.exchangeDate=DATE_FORMAT(p_businessdate, '%Y-%m-%d');
               set exhangeStatus='Success';
    		end if;
    end if;
    select exhangeStatus,retExchangeRate;
  
    end$$

DELIMITER ;

