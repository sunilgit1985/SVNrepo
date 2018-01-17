INSERT INTO `invdb`.`user_risk_score`
(`acctnum`,`year`,`calcFormula`,`allCashFlag`,`score`,`standardScore`,`assetScore`,`portfolioScore`,`adjustment`,`created`)
VALUES 
 ('1', '0', 'C', False, '50', '50', '50', '50', '0', now())
,('1', '1', 'C', False, '49', '49', '49', '49', '0', now())
,('2', '0', 'C', False, '80', '50', '80', '80', '0', now())
;

