
ALTER TABLE invdb.user_logon_exception 
ADD COLUMN fullname VARCHAR(45) NULL DEFAULT NULL AFTER firstname;

ALTER TABLE invdb.user_logon
ADD COLUMN fullname VARCHAR(45) NULL DEFAULT NULL AFTER firstname;

ALTER TABLE invdb.user_trade_profile 
ADD COLUMN fullname VARCHAR(45) NULL DEFAULT NULL AFTER firstname;