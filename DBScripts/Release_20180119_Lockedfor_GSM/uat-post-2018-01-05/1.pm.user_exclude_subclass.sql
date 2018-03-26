CREATE TABLE `user_exclude_subclass` (
  `acctnum` bigint(20) NOT NULL,
  `assetclass` varchar(30) NOT NULL DEFAULT '',
  `subclass` varchar(30) NOT NULL DEFAULT '',
  `created` date DEFAULT NULL,
  `lastUpdated` date DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`assetclass`,`subclass`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
