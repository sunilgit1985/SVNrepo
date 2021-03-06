## Procedure created for daily & monthly procedure calls
USE rbsa;
DROP procedure IF EXISTS price_processor;

DELIMITER $$
USE rbsa$$
CREATE PROCEDURE price_processor(in p_process varchar(20),in p_businessDate varchar(20),in p_ticker varchar(20) ,out msg varchar(20),out dailymsg varchar(20),in p_dest_currency varchar(20) )
BEGIN

if p_process='DAILY' THEN
call daily_price_processor(p_businessDate,dailymsg,p_dest_currency);
SELECT 'DAILY' INTO msg;
end if;
if p_process='MONTHLY' THEN
call monthly_price_processor(p_businessDate,p_ticker,p_dest_currency);
SELECT 'MONTHLY' INTO msg;
end if;
if p_process='ONDEMAND' THEN
SELECT 'ONDEMAND' INTO msg;

call monthly_price_processor(p_businessDate,p_ticker,p_dest_currency);
end if;
END$$

DELIMITER ;

