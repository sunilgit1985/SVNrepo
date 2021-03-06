DELETE FROM `invdb`.`sec_assetclass_group` WHERE theme like '%SGWealth%';

INSERT INTO `invdb`.`sec_assetclass_group` 
(`theme`, `status`, `assetclass`, `displayName`, `ticker`, `sortorder`, `lowerBound`, `upperBound`, `color`, `averageReturn`, `riskAdjustment`, `endAllocation`, `created`, `lastupdated`) 
VALUES
('0.SGWealth', 'A', 'Cash', 'Cash', 'BIL.N', '40', '0', '0.0025', '#8E8E8E', '0', '0.75', '0.01', '2017-01-05 18:15:21', null),
('0.SGWealth', 'A', 'Commodity', 'Commodities', 'GLD.N', '30', '0.02', '0.05', '#5E5E5E', '0.06', '0.75', '0.01', '2017-01-05 18:15:21', null),
('0.SGWealth', 'A', 'Equity', 'Equity Securities', 'VUSD.L', '10', '0.1', '0.9', '#333F50', '0.09', '0.75', '0.9', '2017-01-05 18:15:21', null),
('0.SGWealth', 'A', 'Fixed Income', 'Fixed Income Securities', 'IUAG.L', '20', '0', '1', '#47566D', '0.0424', '0.75', '0.8', '2017-01-05 18:15:21', null),
('T.0.SGWealth', 'A', 'Cash', 'Cash', 'BIL.N', '40', '0', '0.01', '#8E8E8E', '0', '0.75', '0.8', '2017-01-05 18:15:21', null),
('T.0.SGWealth', 'A', 'Commodity', 'Commodities', 'GLD.N', '30', '0.02', '0.05', '#5E5E5E', '0.06', '0.75', '0.8', '2017-01-05 18:15:21', null),
('T.0.SGWealth', 'A', 'Equity', 'Equity Securities', 'VUSD.L', '10', '0.1', '0.9', '#333F50', '0.09', '0.75', '0.8', '2017-01-05 18:15:21', null),
('T.0.SGWealth', 'A', 'Fixed Income', 'Fixed Income Securities', 'IUAG.L', '20', '0', '1', '#47566D', '0.0424', '0.75', '0.8', '2017-01-05 18:15:21', null)
;
