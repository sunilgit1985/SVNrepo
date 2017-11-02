
ALTER TABLE rbsa.sec_exchangerate_data 
ADD COLUMN marketSymbol VARCHAR(20) NOT NULL AFTER symbol;