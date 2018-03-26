UPDATE `invdb`.`sec_rbsa` SET `base_currency`='JPY', `style`='Fixed Income'
WHERE `theme`like '%UOB%' and`primeasset_ticker`='VUSD.L' and`ticker`='1306.T';
UPDATE `invdb`.`sec_rbsa` SET `base_currency`='SGD' 
WHERE `theme`like '%UOB%' and`primeasset_ticker`='Cash' and`ticker`='Cash';
UPDATE `invdb`.`sec_rbsa` SET `base_currency`='SGD'
WHERE `theme`like '%UOB%' and`primeasset_ticker`='EWS.N' and`ticker`='EWS.N';
UPDATE `invdb`.`sec_rbsa` SET `base_currency`='SGD', `style`='Fixed Income'
WHERE `theme`like '%UOB%' and`primeasset_ticker`='F00000MQNO.MSTA' and`ticker`='F00000MQNO.MSTA';
UPDATE `invdb`.`sec_rbsa` SET `base_currency`='SGD', `style`='Fixed Income'
WHERE `theme`like '%UOB%' and`primeasset_ticker`='F0HKG062UI.MSTA' and`ticker`='F0HKG062UI.MSTA';
UPDATE `invdb`.`sec_rbsa` SET `style`='Fixed Income'
WHERE `theme`like '%UOB%' and`primeasset_ticker`='IEMB.L' and`ticker`='IEMB.L';
UPDATE `invdb`.`sec_rbsa` SET `style`='Fixed Income'
WHERE `theme`like '%UOB%' and`primeasset_ticker`='IEML.L' and`ticker`='IEML.L';
UPDATE `invdb`.`sec_rbsa` SET `base_currency`='EUR' 
WHERE `theme`like '%UOB%' and`primeasset_ticker`='IHYG.L' and`ticker`='IHYG.L';
UPDATE `invdb`.`sec_rbsa` SET `base_currency`='GBX' 
WHERE `theme`like '%UOB%' and`primeasset_ticker`='IMEU.L' and`ticker`='IMEU.L';
UPDATE `invdb`.`sec_rbsa` SET `base_currency`='SGD' 
WHERE `theme`like '%UOB%' and`primeasset_ticker`='KV4.SI' and`ticker`='KV4.SI';
UPDATE `invdb`.`sec_rbsa` SET `base_currency`='GBX', `style`='Equity' 
WHERE `theme`like '%UOB%' and`primeasset_ticker`='VUSD.L' and`ticker`='VAS.AX';
UPDATE `invdb`.`sec_rbsa` SET `base_currency`='GBP', `style`='Equity' 
WHERE `theme`like '%UOB%' and`primeasset_ticker`='VUSD.L' and`ticker`='VEUR.L';
UPDATE `invdb`.`sec_rbsa` SET `base_currency`='CAD', `style`='Equity' 
WHERE `theme`like '%UOB%' and`primeasset_ticker`='VUSD.L' and`ticker`='XIC.TO';
UPDATE `invdb`.`sec_rbsa` SET `style`='Equity' 
WHERE `theme`like '%UOB%' and`primeasset_ticker`='LQDE.L' and`ticker`='LQDE.L';

UPDATE `invdb`.`sec_rbsa` SET `base_currency`='AUD', `style`='Equity' 
WHERE `theme`like '%UOB%' and`primeasset_ticker`='VUSD.L' and`ticker`='VAS.AX';

UPDATE `invdb`.`sec_rbsa` SET  dest_currency = 'SGD'
where `theme`like '%UOB%'