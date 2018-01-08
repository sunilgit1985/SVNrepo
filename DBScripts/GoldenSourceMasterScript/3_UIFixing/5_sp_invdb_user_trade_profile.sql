
ALTER TABLE invdb.user_trade_profile 
ADD COLUMN tradeCurrency VARCHAR(20) NULL AFTER initialInvestment,
ADD COLUMN settleCurrency VARCHAR(20) NULL AFTER tradeCurrency,
ADD COLUMN exchangeRate DOUBLE NULL AFTER settleCurrency;