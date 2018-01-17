DROP TABLE IF EXISTS `invdb`.`webpage_menu_items`;

CREATE TABLE `webpage_menu_items` (
  `advisor` 	varchar(20) NOT NULL,
  `group` 		varchar(30) NOT NULL DEFAULT '',
  `sortorder` 	int(11) NOT NULL DEFAULT '1',
  `key` 		varchar(30) NOT NULL DEFAULT '',
  `displayname` varchar(40) DEFAULT NULL,
  `image` 		varchar(100) DEFAULT NULL,
  `shortname` 	varchar(5) DEFAULT NULL,
  `description` varchar(120) DEFAULT NULL,
  `otherinfo`   varchar(20) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `lastUpdated` date DEFAULT NULL,
  PRIMARY KEY (`advisor`,`group`,`key`),
  KEY `AK1_web_pages_info` (`advisor`,`group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `invdb`.`webpage_menu_items` 
(`advisor`, `group`, `sortorder`, `key`, `displayname`, `image`, `shortname`, `description`, `otherinfo`) 
VALUES 
 ('UOB', 'CURRENCY', '10', 'SGD', 'SGD', null, 'S$', 'Singapore',null)
,('UOB', 'CURRENCY', '20', 'USD', 'USD', null, '$', 'Unted States Dollar',null)

,('UOB', 'GOAL', '10', 'RETIREMENT',  'Retirement',   'images/portfolio/retirement.png', null, 'Saving for Retirement',null)
,('UOB', 'GOAL', '20', 'PROPERTY',    'Property',     'images/portfolio/property.png',  null, 'Saving to purchase a property',null)
,('UOB', 'GOAL', '30', 'EDUCATION',   'Education',    'images/portfolio/education.png',  null, 'Saving for a child\'s university/college education',null)
,('UOB', 'GOAL', '40', 'LEGACY',      'Legacy',       'images/portfolio/legacy.png',  null, 'Legacy',null)
,('UOB', 'GOAL', '50', 'BUILDWEALTH', 'Build Wealth', 'images/portfolio/income.png',  null, 'General investing and wealth building',null)
;
