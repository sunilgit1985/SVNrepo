## Alter Table rbsa.rbsa_daily

DROP TABLE IF EXISTS `rbsa`.``rbsa_daily`;

CREATE TABLE `rbsa`.`rbsa_daily` (
  `dest_currency` varchar(20) NOT NULL,
  `ticker` varchar(20) NOT NULL,
  `businessdate` varchar(10) NOT NULL,
  `open_price` double DEFAULT NULL,
  `close_price` double DEFAULT NULL,
  `high_price` double DEFAULT NULL,
  `low_price` double DEFAULT NULL,
  `adjusted_price` double DEFAULT NULL,
  `converted_adjusted_price` double DEFAULT NULL,
  `volume` bigint(20) DEFAULT NULL,
  `prev_businessdate` date DEFAULT NULL,
  `prev_close_price` double DEFAULT NULL,
  `converted_prev_adjusted` double DEFAULT NULL,
  `daily_return` double DEFAULT NULL,
  `prev_month_businessdate` date DEFAULT NULL,
  `prev_monthly_adjusted` double DEFAULT NULL,
  `converted_prev_monthly_adjusted` double DEFAULT NULL,
  `monthly_return` double DEFAULT NULL,
  PRIMARY KEY (`dest_currency`,`ticker`,`businessdate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

