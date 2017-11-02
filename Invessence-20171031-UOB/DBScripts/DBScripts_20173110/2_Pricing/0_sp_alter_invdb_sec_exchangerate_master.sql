
ALTER TABLE invdb.sec_exchangerate_master 
ADD COLUMN multiplyFactor DOUBLE NOT NULL DEFAULT 1 AFTER status;

ALTER TABLE invdb.sec_exchangerate_master 
ADD COLUMN marketSymbol varchar(20) NOT NULL  AFTER symbol;