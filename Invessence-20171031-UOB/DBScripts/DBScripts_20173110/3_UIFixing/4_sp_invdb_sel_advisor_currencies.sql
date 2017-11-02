drop procedure if exists invdb.sel_advisor_currencies;
delimiter $$
CREATE PROCEDURE invdb.sel_advisor_currencies(in p_advisor varchar(20),in p_from_currency varchar(20))
 begin
   declare p_businessdate varchar(20);
   select isw.value into p_businessdate from invdb.invessence_switch isw where isw.name='BUSINESS_DATE'; 
   select supportCurrency,invdb.get_exchange_rate(p_from_currency , supportCurrency,p_businessdate) as exchangeRate 
   from invdb.advisor_currency where advisor= ( CASE
                            WHEN p_advisor IS NULL
                                  OR p_advisor = '' THEN 'CATCHALL'
                            ELSE p_advisor
                          end );
   end