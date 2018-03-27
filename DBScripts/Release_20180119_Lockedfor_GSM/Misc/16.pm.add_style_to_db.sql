CREATE TABLE `invdb`.`sec_rbsa_20180326`
as
select * from `invdb`.`sec_rbsa`;

DROP TABLE IF EXISTS `invdb`.`sec_rbsa`;

CREATE TABLE `invdb`.`sec_rbsa` (
 `theme` varchar(20) NOT NULL,
 `primeasset_ticker` varchar(30) NOT NULL,
 `ticker` varchar(20) NOT NULL,
 `weight` double DEFAULT NULL,
 `created` date DEFAULT NULL,
 `base_currency` varchar(3) DEFAULT 'USD',
 `style` varchar(30) DEFAULT 'EQUITY',
 `dest_currency` varchar(3) DEFAULT 'USD',
 PRIMARY KEY (`theme`,`primeasset_ticker`,`ticker`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `invdb`.`sec_rbsa`
SELECT 
   `sec_rbsa`.`theme`,
   `sec_rbsa`.`primeasset_ticker`,
   `sec_rbsa`.`ticker`,
   `sec_rbsa`.`weight`,
   `sec_master`.`base_currency`,
   `sec_rbsa`.`created`,
   `sec_master`.`style`,
   'USD'
FROM `invdb`.`sec_rbsa_20180326` as `sec_rbsa`
,  `invdb`.`sec_master`
where `sec_rbsa`.`primeasset_ticker` = `sec_master`.`ticker`;

ALTER TABLE `invdb`.`sec_tax_loss_harvesting` 
ADD COLUMN `theme` VARCHAR(20) NOT NULL FIRST,
ADD COLUMN `tradeCurrency` VARCHAR(3) NULL DEFAULT 'USD' AFTER `weight`,
ADD COLUMN `style` VARCHAR(20) NULL DEFAULT 'Equity' AFTER `tradeCurrency`,
ADD COLUMN `settleCurrency` VARCHAR(3) NULL DEFAULT 'USD' AFTER `style`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`theme`, `ticker`, `tlhticker`);

UPDATE `invdb`.`sec_master` SET `style`='Cash' WHERE `instrumentid`='1';
UPDATE `invdb`.`sec_master` SET `style`='Cash' WHERE `instrumentid`='2';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='3';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='4';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='5';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='6';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='7';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='8';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='9';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='10';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='12';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='13';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='14';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='15';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='16';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='17';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='18';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='19';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='20';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='21';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='22';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='23';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='24';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='25';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='26';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='27';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='28';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='29';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='30';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='31';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='32';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='33';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='34';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='35';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='36';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='37';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='38';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='39';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='40';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='42';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='43';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='44';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='45';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='47';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='65';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='66';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='67';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='68';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='69';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='70';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='71';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='72';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='73';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='74';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='75';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='76';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='77';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='78';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='79';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='80';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='81';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='82';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='83';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='84';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='85';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='86';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='90';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='91';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='93';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='94';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='96';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='97';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='99';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='100';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='101';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='102';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='103';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='104';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='107';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='116';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='119';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='133';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='132';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='135';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='147';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='1000';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='1001';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='1002';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='1003';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='1004';
UPDATE `invdb`.`sec_master` SET `style`='Fixed Income' WHERE `instrumentid`='1005';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='152';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='146';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='145';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='144';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='143';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='142';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='141';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='140';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='139';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='138';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='137';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='136';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='134';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='117';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='118';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='115';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='114';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='113';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='112';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='111';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='106';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='105';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='148';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='149';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='150';
UPDATE `invdb`.`sec_master` SET `style`='Equity' WHERE `instrumentid`='151';

SET SQL_SAFE_UPDATES = 0;
update `invdb`.`sec_master` 
set `type` = `style`
;

update `invdb`.`sec_master` 
set `type` = 'Fixed Income'
, `style` = 'Fixed Income'
where `style`= 'Fix Income' or `type` = 'Fixed Income';

update `invdb`.`sec_rbsa`, `invdb`.`sec_master`
set `sec_rbsa`.`style` = `sec_master`.`style`
where `sec_rbsa`.`ticker` = `sec_master`.`ticker`
;


update `invdb`.`sec_tax_loss_harvesting` 
set `theme` = '0.Wealth';

update `invdb`.`sec_tax_loss_harvesting`, `invdb`.`sec_master`
set `sec_tax_loss_harvesting`.`ticker` = `sec_master`.`ticker`
WHERE `sec_tax_loss_harvesting`.`ticker` = LEFT(`sec_master`.ticker,INSTR(`sec_master`.ticker,'.')-1)
AND `sec_master`.ticker like '%.%';

update `invdb`.`sec_tax_loss_harvesting`, `invdb`.`sec_master`
set `sec_tax_loss_harvesting`.`tlhticker` = `sec_master`.`ticker`
WHERE `sec_tax_loss_harvesting`.`tlhticker` = LEFT(`sec_master`.ticker,INSTR(`sec_master`.ticker,'.')-1)
AND `sec_master`.ticker like '%.%';

			 
