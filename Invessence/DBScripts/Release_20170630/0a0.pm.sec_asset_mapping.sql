DROP TABLE IF EXISTS `invdb`.`sec_asset_mapping`;

CREATE TABLE `invdb`.`sec_asset_mapping` (
  `theme`			varchar(20) NOT NULL,
  `ticker`			varchar(40) NOT NULL,
  `assetclass`		varchar(40) NOT NULL,
  `assetName`		varchar(60) DEFAULT NULL,
  `assetcolor`		varchar(9) DEFAULT NULL,
  `assetsortorder`		int(11) NOT NULL DEFAULT '0',
  `subclass`		varchar(40) NOT NULL,
  `subclassName`	varchar(60) DEFAULT NULL,
  `subclasscolor`	varchar(9) DEFAULT NULL,
  `subclasssortorder` int(11) NOT NULL DEFAULT '0',
  `created` 		datetime DEFAULT NULL,
  `lastUpdated`		datetime DEFAULT NULL,
  PRIMARY KEY (`theme`,`ticker`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `invdb`.`sec_asset_mapping`
(`theme`,`ticker`
,`assetclass`,`assetName`,`assetcolor`,`assetsortorder`
,`subclass`,`subclassName`, `subclasscolor`, `subclasssortorder` 
,`created`,`lastUpdated`)
SELECT `assetclass`.`theme`, `subclass`.`ticker`
, `assetclass`.`assetclass`, `assetclass`.`displayName`,`assetclass`.`color`, `assetclass`.`sortorder`
,`subclass`.`primeassetclass`, `subclass`.`primeassetclass`,`subclass`.`color`, `subclass`.`sortorder`
, now(), null
FROM `invdb`.`sec_assetclass_group` as `assetclass` 
INNER JOIN `invdb`.`sec_prime_asset_group` as `subclass`
ON (`subclass`.`theme` = `assetclass`.`theme`
	AND `subclass`.`assetclass` = `assetclass`.`assetclass`)
UNION
SELECT distinct `assetclass`.`theme`, `subclass`.`keyname`
, `assetclass`.`asset`, `assetclass`.`assetname`, `assetclass`.`color`, `assetclass`.`sortorder`
, `subclass`.`keyname`, `subclass`.`keydescription`, null, `subclass`.`sortorder`
, now(), null
FROM `invdb`.`sec_fixedmodel_asset` as `assetclass` 
INNER JOIN `invdb`.`sec_fixedmodel_subasset` as `subclass`
ON (`subclass`.`theme` = `assetclass`.`theme`
	AND `subclass`.`asset` = `assetclass`.`asset`)
and CONCAT(`subclass`.`theme`, `subclass`.`level`, `subclass`.`keyname`) in 
	(SELECT DISTINCT CONCAT(`mastersub`.`theme`, `mastersub`.`level`, `mastersub`.`keyname`) 
	 FROM `invdb`.`sec_fixedmodel_subasset` as `mastersub`)
order by 1,2,3,6;

select * from `invdb`.`sec_asset_mapping`;

