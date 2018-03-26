USE `invdb`;



CREATE TABLE `ext_exchange_rate` (
  `reportDate` varchar(10) NOT NULL,
  `tradeCurrency` varchar(3) NOT NULL,
  `settleCurrency` varchar(3) NOT NULL,
  `exchangeRate` double DEFAULT NULL,
  PRIMARY KEY (`reportDate`,`tradeCurrency`,`settleCurrency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `holiday_master` (
  `hdate` varchar(10) NOT NULL,
  `country` varchar(20) NOT NULL,
  `hdaycomment` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`hdate`,`country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `invdb`.`holiday_master` (`hdate`, `country`, `hdaycomment`) VALUES ('20180204', 'SGD', 'Testing');
INSERT INTO `invdb`.`holiday_master` (`hdate`, `country`, `hdaycomment`) VALUES ('20180206', 'SGD', 'Test Holiday');
INSERT INTO `invdb`.`holiday_master` (`hdate`, `country`, `hdaycomment`) VALUES ('20180207', 'SGD', 'Test2 Holiday');
INSERT INTO `invdb`.`holiday_master` (`hdate`, `country`, `hdaycomment`) VALUES ('20180216', 'SGD', 'Chienese New Year');



USE `invdb`;
DROP function IF EXISTS `get_exchange_rate`;

DELIMITER $$
USE `invdb`$$
CREATE  FUNCTION `get_exchange_rate`( p_from_currency varchar(20), p_to_currency varchar(20)) RETURNS double
    DETERMINISTIC
begin
    declare p_frstcd,p_scndcd,p_fromCurrency,p_toCurrency,baseCrncy,p_symbol varchar(10);
    declare p_exchngGiven, p_exchngavailable int;
    declare p_multiplying_factor double;
    declare p_priceDate,exhangeStatus, p_businessdate varchar(20);
    declare retExchangeRate double;
	set p_exchngGiven=0;
    set p_exchngavailable=0;
    set p_symbol=concat(p_from_currency,p_to_currency);   
    set exhangeStatus='Failed';
		
	set p_priceDate = `invdb`.`FUNCT_GET_SWITCH`('PRICE_DATE');
    set p_businessdate = `invdb`.`FUNCT_GET_SWITCH`('BUSINESS_DATE');
    
    select count(*) into p_exchngGiven from invdb.ext_exchange_rate  
    where reportDate= p_businessdate and settleCurrency=p_from_currency and tradeCurrency=p_to_currency;
    
   if(p_exchngGiven>0) then
   select 1/exchangeRate into retExchangeRate from invdb.ext_exchange_rate  
   where reportDate= p_businessdate and settleCurrency=p_from_currency and tradeCurrency=p_to_currency;
             set exhangeStatus='Success';
   
   else
    select count(*) into p_exchngavailable from invdb.sec_exchangerate_master where symbol=p_symbol;
    -- select p_priceDate,p_exchngavailable;
    
  
    if(p_exchngavailable>0) then
             select sed.exchangeRate into retExchangeRate from rbsa.sec_exchangerate_data sed where sed.symbol=p_symbol and sed.exchangeDate=DATE_FORMAT(p_priceDate, '%Y-%m-%d');
             set exhangeStatus='Success';
        else
  
    	set p_exchngavailable=0;
        SELECT SUBSTRING(p_symbol,1,3) into p_frstcd;
        SELECT SUBSTRING(p_symbol,4,6) into p_scndcd;
        set p_symbol=concat(p_scndcd,p_frstcd);
    	select count(*) into p_exchngavailable from invdb.sec_exchangerate_master where symbol=p_symbol;
  
    		if(p_exchngavailable>0) then
               select sed.reverseExchangeRate into retExchangeRate from rbsa.sec_exchangerate_data sed where sed.symbol=p_symbol and sed.exchangeDate=DATE_FORMAT(p_priceDate, '%Y-%m-%d');
               set exhangeStatus='Success';
    		end if;
    end if;
    
    end if;
   -- select exhangeStatus,retExchangeRate;
return retExchangeRate;
END$$

DELIMITER ;



ALTER TABLE `invdb`.`ext_acct_info` 
ADD COLUMN `ssn` VARCHAR(50) NULL DEFAULT NULL AFTER `faxNbr`;


ALTER TABLE `invdb`.`ext_position` ADD COLUMN `settleValue` DOUBLE NULL DEFAULT NULL  AFTER `settleMarkPrice` 
, DROP PRIMARY KEY 
, ADD PRIMARY KEY (`clientAccountID`, `symbol`, `reportDate`, `purchaseDate`, `costBasisPrice`, `levelOfDetail`, `settleCurrency`) ;


ALTER TABLE `invdb`.`ext_investment` 
CHANGE COLUMN `investmentCurrency` `investmentCurrency` VARCHAR(3) NOT NULL DEFAULT 'USD' ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`clientAccountID`, `ticker`, `investmentDate`, `investmentCurrency`);


ALTER TABLE `invdb`.`ext_position` 
CHANGE COLUMN `settleCurrency` `settleCurrency` VARCHAR(3) NOT NULL DEFAULT 'USD' ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`clientAccountID`, `reportDate`, `purchaseDate`, `symbol`, `costBasisPrice`, `levelOfDetail`, `settleCurrency`);

ALTER TABLE `invdb`.`registration_audit` 
CHANGE COLUMN `ip` `ip` VARCHAR(45) NULL DEFAULT NULL ;



USE `invdb`;
DROP procedure IF EXISTS `sp_user_advisor_info`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sp_user_advisor_info`(
    IN p_logonid  bigint(20)    ,
IN p_advisor varchar(20)   ,
IN p_rep  varchar(20)   ,
IN p_accttype varchar(20)   ,
IN p_companyname varchar(60)   ,
IN p_displayName varchar(60)   ,
IN p_logo  varchar(60)   ,
IN p_advisor_css varchar(30)
 )
BEGIN 
 
    DECLARE v_req_count INTEGER;
 
	select count(*) into v_req_count from invdb.user_advisor_info WHERE `logonid` = p_logonid;    
    
    if(v_req_count>0)then
    BEGIN
 		UPDATE `invdb`.`user_advisor_info`
		SET
		`advisor` = p_advisor,
		`rep` = p_rep,
		`accttype` = p_accttype,
		`companyname` = p_companyname,
		`displayName` = p_displayName,
		`logo` = p_logo,
		`advisor_css` = p_advisor_css,
		`lastupdated` = now()
		WHERE `logonid` = p_logonid;         
    END;
    else
	BEGIN
		INSERT INTO `invdb`.`user_advisor_info`
		(`logonid`,
		`advisor`,
		`rep`,
		`accttype`,
		`companyname`,
		`displayName`,
		`logo`,
		`advisor_css`,
		`created`)
		VALUES
		(p_logonid,
		p_advisor,
		p_rep,
		p_accttype,
		p_companyname,
		p_displayName,
		p_logo,
		p_advisor_css,
		now());
    END;     
    end if;
 END$$

DELIMITER ;





UPDATE `invdb`.`notification_message_lookup` 
SET 
    `emailAdvisorRecepient` = 'prathamesh.hule@invessence.com'
WHERE
    `advisor` = 'UOB'
        and `messageType` = 'FUNDED';
INSERT INTO `invdb`.`notification_message_lookup` (`advisor`, `messageType`, `includeAdvisor`, `advisorsubject`, `includeAdvisorEmail`, `emailAdvisorSubject`, `emailAdvisorRecepient`, `includeUser`, `userSubject`) VALUES ('UOB', 'TRADEEXECUTED', 'N', 'Trade Executed', 'Y', 'Trade Executed', 'abhangp@invessence.com', 'N', 'Trade Executed');
UPDATE `invdb`.`notification_message_lookup` 
SET 
    `emailAdvisorRecepient` = 'sagar.patil@invessence.com'
WHERE
    `advisor` = 'UOB'
        and `messageType` = 'OPENED';



ALTER TABLE `invdb`.`email_messages` ADD COLUMN `acctnum` BIGINT NULL DEFAULT NULL  AFTER `attachments` , ADD COLUMN `templateId` VARCHAR(45) NULL DEFAULT NULL  AFTER `acctnum` ;
ALTER TABLE `invdb`.`email_alerts` ADD COLUMN `acctnum` BIGINT NULL DEFAULT NULL  AFTER `attachments` , ADD COLUMN `templateId` VARCHAR(45) NULL DEFAULT NULL  AFTER `acctnum` ;


ALTER TABLE `invdb`.`notification_message_lookup` ADD COLUMN `notificationTempIdUser` VARCHAR(45) NULL DEFAULT NULL  AFTER `updated` , ADD COLUMN `emailTempIdUser` VARCHAR(45) NULL DEFAULT NULL  AFTER `notificationTempIdUser` , ADD COLUMN `notificationTempIdAdvisor` VARCHAR(45) NULL DEFAULT NULL  AFTER `emailTempIdUser` , ADD COLUMN `emailTempIdAdvisor` VARCHAR(45) NULL DEFAULT NULL  AFTER `notificationTempIdAdvisor` , ADD COLUMN `ccUserSalesRep` VARCHAR(1) NULL DEFAULT NULL  AFTER `emailTempIdAdvisor` , ADD COLUMN `ccAdvisorSalesRep` VARCHAR(1) NULL DEFAULT NULL COMMENT 'Sending Advisor\'s email CC to Sales Rep associated to User.'  AFTER `ccUserSalesRep` ;


CREATE  TABLE `invdb`.`notofication_email_templates` (
  `advisor` VARCHAR(20) NOT NULL ,
  `messageType` VARCHAR(20) NOT NULL ,
  `templateId` VARCHAR(45) NOT NULL ,
  `contentType` VARCHAR(10) NULL DEFAULT NULL ,
  `userType` VARCHAR(10) NULL DEFAULT NULL ,
  `emailSubject` VARCHAR(45) NULL DEFAULT NULL ,
  `templateContent` BLOB NULL DEFAULT NULL ,
  `created` DATETIME NULL DEFAULT NULL ,
  `updated` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`advisor`, `messageType`, `templateId`) );


INSERT INTO `invdb`.`web_site_info`
(`url`,
`name`,
`status`,
`value`,
`encrFlag`,
`created`,
`updated`)
VALUES
(
'utraderobo', 'SERVICE.FILEPROCESS.MODE', 'A', 'PROD', 'N', '2017-05-30 07:03:12', NULL
);




USE `invdb`;
DROP function IF EXISTS `get_exchange_rate_date_wise`;

DELIMITER $$
USE `invdb`$$
CREATE  FUNCTION `get_exchange_rate_date_wise`( p_from_currency varchar(20), p_to_currency varchar(20),p_businessdate varchar(20)) RETURNS double
    DETERMINISTIC
BEGIN
 	 declare p_frstcd,p_scndcd,p_fromCurrency,p_toCurrency,baseCrncy,p_symbol varchar(10);
     declare p_exchngavailable int;
     declare p_multiplying_factor double;
     declare retExchangeRate double;
   
     set p_exchngavailable=0;
     set p_symbol=concat(p_from_currency,p_to_currency);   
     set retExchangeRate=0.0;
     set p_multiplying_factor=1;
     
     
     if(p_from_currency=p_to_currency) then 
      set retExchangeRate=1;
     else 
     select count(*),multiplyFactor into p_exchngavailable,p_multiplying_factor from invdb.sec_exchangerate_master where symbol=p_symbol;
     
     
   
     if(p_exchngavailable>0) then
              select sed.exchangeRate*p_multiplying_factor into retExchangeRate 
              from rbsa.sec_exchangerate_data sed where sed.symbol=p_symbol and sed.exchangeDate=DATE_FORMAT(p_businessdate, '%Y-%m-%d');
         else
   
     	set p_exchngavailable=0;
         SELECT SUBSTRING(p_symbol,1,3) into p_frstcd;
         SELECT SUBSTRING(p_symbol,4,6) into p_scndcd;
         set p_symbol=concat(p_scndcd,p_frstcd);
     	select count(*),multiplyFactor into p_exchngavailable,p_multiplying_factor from invdb.sec_exchangerate_master where symbol=p_symbol;
   
     		if(p_exchngavailable>0) then
                select sed.reverseExchangeRate*p_multiplying_factor into retExchangeRate
                from rbsa.sec_exchangerate_data sed where sed.symbol=p_symbol and sed.exchangeDate=DATE_FORMAT(p_businessdate, '%Y-%m-%d');               
     		end if;
     end if;
     end if;
     
     
 		RETURN retExchangeRate;
 END$$

DELIMITER ;




USE `invdb`;
DROP procedure IF EXISTS `sel_advisor_currencies`;

DELIMITER $$
USE `invdb`$$
CREATE  PROCEDURE `sel_advisor_currencies`(in p_advisor varchar(20),in p_from_currency varchar(20))
begin
   declare p_businessdate varchar(20);
   select isw.value into p_businessdate from invdb.invessence_switch isw where isw.name='BUSINESS_DATE'; 
   select supportCurrency,invdb.get_exchange_rate_date_wise(p_from_currency , supportCurrency,p_businessdate) as exchangeRate 
   from invdb.advisor_currency where advisor= ( CASE
                            WHEN p_advisor IS NULL
                                  OR p_advisor = '' THEN 'CATCHALL'
                            ELSE p_advisor
                          end );
   end$$

DELIMITER ;