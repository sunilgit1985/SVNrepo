DROP TABLE IF EXISTS `invdb`.`sec_rbsa`;

CREATE TABLE `invdb`.`sec_rbsa` (
  `theme` varchar(20) NOT NULL,
  `primeasset_ticker` varchar(30) NOT NULL,
  `ticker` varchar(20) NOT NULL,
  `weight` double DEFAULT NULL,
  `created` date DEFAULT NULL,
  PRIMARY KEY (`theme`,`primeasset_ticker`,`ticker`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', '2821.HK', '2821.HK', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'C.N', 'C.N', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'Cash', 'Cash', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'DAL.N', 'DAL.N', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'EIMI.L', 'EIMI.L', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'ES3.SI', 'ES3.SI', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'GLD.N', 'GLD.N', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'IBM.N', 'IBM.N', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'IHYG.L', 'IHYG.L', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'IHYU.L', 'IHYU.L', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'IMEU.L', 'IMEU.L', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'IPXJ.L', 'IPXJ.L', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'IUAG.L', 'IUAG.L', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'KV4.SI', 'KV4.SI', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'MRK.N', 'MRK.N', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'SJPA.L', 'SJPA.L', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'TOL.N', 'TOL.N', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'UL.N', 'UL.N', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.CITI', 'VUSD.L', 'VUSD.L', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealth', '2821.HK', '2821.HK', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealth', 'BIL.N', 'BIL.N', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealth', 'EIMI.L', 'EIMI.L', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealth', 'ES3.SI', 'ES3.SI', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealth', 'EWS.L', 'EWS.L', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealth', 'GLD.N', 'GLD.N', '1', '2017-03-15');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealth', 'IAU.N', 'IAU.N', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealth', 'IHYG.L', 'IHYG.L', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealth', 'IHYU.L', 'IHYU.L', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealth', 'IMEU.L', 'IMEU.L', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealth', 'IPXJ.L', 'IPXJ.L', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealth', 'IUAG.L', 'IUAG.L', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealth', 'KV4.SI', 'KV4.SI', '1', '2017-03-21');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealth', 'SJPA.L', 'SJPA.L', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealth', 'VUSD.L', 'VUSD.L', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealthSGD', '2821.HK-SGD', '2821.HK-SGD', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealthSGD', 'BIL', 'BIL', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealthSGD', 'EIMI-L-SGD', 'EIMI-L-SGD', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealthSGD', 'ES3-SI-SGD', 'ES3-SI-SGD', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealthSGD', 'GLD-SGD', 'GLD-SGD', '1', '2017-03-15');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealthSGD', 'IHYG-L-SGD', 'IHYG-L-SGD', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealthSGD', 'IHYU-L-SGD', 'IHYU-L-SGD', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealthSGD', 'IMEU-L-SGD', 'IMEU-L-SGD', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealthSGD', 'IPXJ-L-SGD', 'IPXJ-L-SGD', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealthSGD', 'IUAG-L-SGD', 'IUAG-L-SGD', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealthSGD', 'KV4-SI-SGD', 'KV4-SI-SGD', '1', '2017-03-21');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealthSGD', 'SJPA-L-SGD', 'SJPA-L-SGD', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('0.SGWealthSGD', 'VUSD-L-SGD', 'VUSD-L-SGD', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.CITI', '2821.HK', '2821.HK', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.CITI', 'C.N', 'C.N', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.CITI', 'Cash', 'Cash', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.CITI', 'EIMI.L', 'EIMI.L', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.CITI', 'ES3.SI', 'ES3.SI', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.CITI', 'GLD.N', 'GLD.N', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.CITI', 'IBM.N', 'IBM.N', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.CITI', 'IHYG.L', 'IHYG.L', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.CITI', 'IHYU.L', 'IHYU.L', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.CITI', 'IMEU.L', 'IMEU.L', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.CITI', 'IPXJ.L', 'IPXJ.L', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.CITI', 'IUAG.L', 'IUAG.L', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.CITI', 'KV4.SI', 'KV4.SI', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.CITI', 'SJPA.L', 'SJPA.L', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.CITI', 'VUSD.L', 'VUSD.L', '1', '2017-04-28');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.SGWealth', '2821.HK', '2821.HK', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.SGWealth', 'BIL.N', 'BIL.N', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.SGWealth', 'EIMI.L', 'EIMI.L', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.SGWealth', 'ES3.SI', 'ES3.SI', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.SGWealth', 'EWS.N', 'EWS.N', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.SGWealth', 'GLD.N', 'GLD.N', '1', '2017-03-15');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.SGWealth', 'IAU.N', 'IAU.N', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.SGWealth', 'IHYG.L', 'IHYG.L', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.SGWealth', 'IHYU.L', 'IHYU.L', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.SGWealth', 'IMEU.L', 'IMEU.L', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.SGWealth', 'IPXJ.L', 'IPXJ.L', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.SGWealth', 'IUAG.L', 'IUAG.L', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.SGWealth', 'KV4.SI', 'KV4.SI', '1', '2017-03-21');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.SGWealth', 'SJPA.L', 'SJPA.L', '1', '2017-01-30');
INSERT INTO `invdb`.`sec_rbsa` (`theme`, `primeasset_ticker`, `ticker`, `weight`, `created`) VALUES ('T.0.SGWealth', 'VUSD.L', 'VUSD.L', '1', '2017-01-30');
