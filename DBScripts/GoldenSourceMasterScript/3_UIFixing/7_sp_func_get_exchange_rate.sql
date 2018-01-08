drop function if exists invdb.get_exchange_rate;
delimiter $$
CREATE  FUNCTION invdb.get_exchange_rate( p_from_currency varchar(20), p_to_currency varchar(20),p_businessdate varchar(20)) RETURNS double
     DETERMINISTIC
 BEGIN
 	 declare p_frstcd,p_scndcd,p_fromCurrency,p_toCurrency,baseCrncy,p_symbol varchar(10);
     declare p_exchngavailable int;
     declare p_multiplying_factor double;
     declare retExchangeRate double;
   
     set p_exchngavailable=0;
     set p_symbol=concat(p_from_currency,p_to_currency);   
     set retExchangeRate=0.0;
     set p_multiplying_factor=1;
     
     -- select isw.value into p_businessdate from invdb.invessence_switch isw where isw.name='BUSINESS_DATE'; 
     if(p_from_currency=p_to_currency) then 
      set retExchangeRate=1;
     else 
     select count(*),multiplyFactor into p_exchngavailable,p_multiplying_factor from invdb.sec_exchangerate_master where symbol=p_symbol;
     -- select p_businessdate,p_exchngavailable;
     
   
     if(p_exchngavailable>0) then
              select sed.exchangeRate*p_multiplying_factor into retExchangeRate 
              from rbsa.sec_exchangerate_data sed where sed.symbol=p_symbol and sed.exchangeDate=DATE_FORMAT(p_businessdate, '%Y-%m-%d');
         else
   
     	set p_exchngavailable=0;
         SELECT SUBSTRING(p_symbol,1,3) into p_frstcd;
         SELECT SUBSTRING(p_symbol,4,6) into p_scndcd;
         set p_symbol=concat(p_scndcd,p_frstcd);
     	select count(*),multiplyFactor into p_exchngavailable,p_multiplying_factor from invdb.sec_exchangerate_master where symbol=p_symbol;
   
     		if(p_exchngavailable>0) then
                select sed.reverseExchangeRate*p_multiplying_factor into retExchangeRate
                from rbsa.sec_exchangerate_data sed where sed.symbol=p_symbol and sed.exchangeDate=DATE_FORMAT(p_businessdate, '%Y-%m-%d');               
     		end if;
     end if;
     end if;
     -- select exhangeStatus,retExchangeRate;
     -- set retExchangeRate=retExchangeRate*p_multiplying_factor;
 		RETURN retExchangeRate;
 END