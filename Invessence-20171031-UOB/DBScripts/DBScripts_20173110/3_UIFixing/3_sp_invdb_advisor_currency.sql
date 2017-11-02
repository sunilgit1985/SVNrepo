use invdb;
drop table if exists advisor_currency;
CREATE TABLE advisor_currency (
   advisor varchar(20) NOT NULL,
   supportCurrency varchar(20) NOT NULL,
   PRIMARY KEY (advisor,supportCurrency)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO invdb.advisor_currency (advisor, supportCurrency) VALUES ('UOB', 'USD');
INSERT INTO invdb.advisor_currency (advisor, supportCurrency) VALUES ('UOB', 'SGD');

INSERT INTO invdb.advisor_currency (advisor, supportCurrency) VALUES ('CATCHALL', 'USD');
INSERT INTO invdb.advisor_currency (advisor, supportCurrency) VALUES ('CATCHALL', 'SGD');