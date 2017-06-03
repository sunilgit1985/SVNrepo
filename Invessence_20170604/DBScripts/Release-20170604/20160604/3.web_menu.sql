DROP TABLE IF EXISTS `invdb`.`web_menu`;

CREATE TABLE `invdb`.`web_menu` (
  `product` 	varchar(45) NOT NULL,
  `access` 		varchar(20) DEFAULT NULL,
  `permission`  varchar(20) DEFAULT NULL,
  `label` 		varchar(30) NOT NULL,
  `icon`		varchar(40) DEFAULT NULL,
  `level` 		INTEGER DEFAULT 1,
  `sublevel` 	INTEGER DEFAULT 1,
  `seq`     	INTEGER,
  `status` 		varchar(1) DEFAULT NULL,
  `destdir`  	varchar(20) NULL,
  `htmlpage` 	varchar(60) NULL,
  `command` 	varchar(60) NULL,
  `created` 	datetime DEFAULT NULL,
  `updated` 	datetime DEFAULT NULL,
  PRIMARY KEY (`product`, `access`, `permission`, `label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `invdb`.`web_menu` 
( `product`, `access`, `permission`, `label`, `icon`, `level`, `sublevel`, `seq`, `status`, `destdir`, `htmlpage`, `command`, `created`)
VALUES 
 ('uwealth', 'User',      '', 		'Account',		null, 1, null, 1, 'A', 'consumer',	 'cadd.xhtml?app=N',	 null, now())
,('uwealth', 'User',      '', 		'Aggregation',	null, 1, null, 2, 'A', 'consumer',	 'aggregration.xhtml',	 null, now())
,('uwealth', 'User',      '', 		'Help Desk',	null, 1, null, 3, 'A', null,		  'http://www.teamviewer.com/link/?url=505374&amp;id=35279493', null, now())
,('uwealth', 'Advisor',   '', 		'Marketing',	null, 1, null, 1, 'A', 'advisor',	 'marketing.xhtml',		 null, now())
,('uwealth', 'Advisor',   'Operations', 'Trade',		null, 1, null, 2, 'A', 'advisor',	 'trade.xhtml',			 null, now())
,('uwealth', 'Advisor',   'Operations', 'Model',		null, 1, null, 3, 'A', 'advisor' ,	 'assetworkflow.xhtml',	 null, now())
;


