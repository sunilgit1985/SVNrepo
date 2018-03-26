use invdb;

ALTER TABLE `invdb`.`ext_nav` 
RENAME TO  `invdb`.`ext_nav_2018_02_01` ;


CREATE TABLE ext_nav (
  clientAccountID varchar(15) NOT NULL DEFAULT '',
  tradeCurrency varchar(3) NOT NULL DEFAULT 'USD',
  reportDate varchar(10) NOT NULL DEFAULT '',
  exchangeRate double DEFAULT '1',
  settleCurrency varchar(3) NOT NULL DEFAULT 'USD',
  cash double DEFAULT '0',
  stock double DEFAULT NULL,
  funds double DEFAULT NULL,
  interestAccrual double DEFAULT NULL,
  dividentAccrual double DEFAULT NULL,
  total double DEFAULT NULL,
  PRIMARY KEY (clientAccountID,tradeCurrency,reportDate,settleCurrency)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



insert into invdb.ext_nav (clientAccountID,reportDate,cash,stock,funds,interestAccrual,dividentAccrual,total)
select clientAccountID,reportDate,cash,stock,funds,interestAccrual,dividentAccrual,total from invdb.ext_nav_2018_02_01;




