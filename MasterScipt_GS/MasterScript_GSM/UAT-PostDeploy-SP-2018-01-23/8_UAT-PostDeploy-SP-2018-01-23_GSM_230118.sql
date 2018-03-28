
/* 0_sp_invdb_sp_custody_fund_save.sql230118_sagar*/

drop procedure if exists invdb.sp_custody_fund_save;
delimiter $$
create procedure invdb.sp_custody_fund_save(in p_acctnum bigint,in p_clientAccountID varchar(12),in p_investmentDate varchar(12),in p_netAmount double,in p_status varchar(25))
begin 
insert into invdb.ext_investment(acctnum,clientAccountID,investmentDate,netAmount,status,created)
values(p_acctnum,p_clientAccountID,p_investmentDate,p_netAmount,p_status,now());
end;

/* 1_sp_invdb_save_user_trade_profile.sql230118_sagar*/



################
USE `invdb`;
DROP procedure IF EXISTS `save_user_trade_profile`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_user_trade_profile`(
		IN	p_logonid	bigint(20),
		INOUT	p_acctnum	bigint(20),
		IN  p_portfolioName VARCHAR(60),
		IN  p_advisor    VARCHAR(20),
		IN  p_rep	     VARCHAR(20),
		IN  p_firstname    VARCHAR(40),
		IN  p_lastname    VARCHAR(40),
		IN  p_theme		 VARCHAR(30),
		IN  p_goal       varchar(30),
		IN	p_acctType	varchar(30),
		IN	p_taxable	varchar(1),
		IN	p_age		integer,
		IN	p_horizon	integer,
		IN	p_initialInvestment	integer,
		IN	p_recurringInvestment	integer,
		IN	p_experience	tinyint,
		IN	p_objective		tinyint,
		IN	p_investmentplan	tinyint,
		IN	p_charitablegoals	integer,
		IN  p_keepLiquid 	integer,
		IN  p_riskIndex 	  integer,
		IN  p_riskCalcMethod  VARCHAR(1),
		IN  p_allocIndex 	  integer,
		IN  p_portfolioIndex  integer,
		IN  p_goalDesired 	  double,
		IN p_customName 	varchar(60),
		IN p_tradeCurrency 	varchar(3),
		IN p_settleCurrency varchar(3),
		IN p_exchangeRate DOUBLE
  )
  
BEGIN 
  
  	DECLARE t_found INTEGER;
      DECLARE t_status VARCHAR(1);
  
  	BEGIN
  		IF (IFNULL(p_acctnum,0) > 0)
  			THEN
  				SELECT COUNT(*)
  				INTO t_found
  				FROM user_trade_profile
  				WHERE acctnum = p_acctnum;
  			ELSE 
  				set t_found = 0;
  		END IF;
  	END;
  
     BEGIN
  	   IF (IFNULL(t_found,0) = 0) THEN
  		   BEGIN
             
              set t_status = 
                  CASE 
  					WHEN (p_logonid is null) THEN 'V'
                      WHEN (p_logonid <= 0) THEN 'V'
                      ELSE 'N'
  				END;
  
  			INSERT INTO user_trade_profile (
  				portfolioName,
  			    advisor,
                  rep,
                  firstname,
                  lastname,
  				theme,
  				goal,
  				acctType,
  				age,
  				horizon,
  				initialInvestment,
  				recurringInvestment,
  				keepLiquid,
  				experience,
   				longTermGoal,
  				stayInvested,
  				charitablegoals,
  				riskIndex,
  				taxable,
  				assetIndex,
  				portfolioIndex,
                  goalAmount,
                  managed,
                  status,
  				created,
 				customName,
                tradeCurrency,
                settleCurrency,
                exchangeRate
  			)
  			VALUES (
  				IFNULL(p_portfolioName,IFNULL(p_goal,'Retirement')),
  				IFNULL(p_advisor,'Invessence'),
                  p_rep,
                  p_firstname,
                  p_lastname,
  				p_theme,  
  				IFNULL(p_goal,'Retirement')	,
  				p_acctType,
  				IFNULL(p_age,30)	,
  				IFNULL(p_horizon,35)	,
  				IFNULL(p_initialInvestment,1000000)	,
  				p_recurringInvestment	,
  				IFNULL(p_keepLiquid,0),
  				p_experience	,
  				p_objective	,
  				p_investmentplan	,
  				p_charitablegoals,
  				IFNULL(p_riskIndex,10),
  				IFNULL(p_taxable,'N'),
  				p_allocIndex,
  				p_portfolioIndex,
                  p_goalDesired,
                  'N',
                  t_status,
  				now(),
                p_customName,
                SUBSTRING(p_tradeCurrency,1,3),
                SUBSTRING(p_settleCurrency,1,3),
                p_exchangeRate
  			);
  
  			select last_insert_id() into p_acctnum;
              
  			call invdb.sp_user_profile_manage (p_acctnum, t_status,p_logonid);
  
  		   END;
  	   ELSE
  		   BEGIN
                          
  			 UPDATE  user_trade_profile
  			 SET
  				portfolioName = IFNULL(p_portfolioName,portfolioName),
  				advisor = IFNULL(p_advisor,advisor),
                  rep     = p_rep,
                  firstname = IFNULL(p_firstname,firstname),
                  lastname = IFNULL(p_lastname,lastname),
  				theme = IFNULL(p_theme,theme),
  				goal	 =	IFNULL(p_goal,goal)	,
  				acctType	 =	IFNULL(p_acctType,acctType)	,
  				age	 =	IFNULL(p_age,age)	,
  				horizon	 =	IFNULL(p_horizon,horizon)	,
  				initialInvestment	 =	IFNULL(p_initialInvestment,initialInvestment)	,
  				recurringInvestment	 =	p_recurringInvestment	,
  				experience	 =	p_experience	,
  				longTermGoal	 =	p_objective	,
  				stayInvested	 =	p_investmentplan	,
  				charitablegoals	 =	p_charitablegoals	,
  				riskIndex      =  IFNULL(p_riskIndex,riskIndex),
  				keepLiquid	 =  IFNULL(p_keepLiquid,keepLiquid),
  				taxable        =  IFNULL(p_taxable,taxable),
  				assetIndex	 =  p_allocIndex,
  				portfolioIndex =  p_portfolioIndex,
  				goalAmount	 =  p_goalDesired,
  				lastupdated    = now(),
				customName=p_customName,
                tradeCurrency=p_tradeCurrency,
                settleCurrency=p_settleCurrency,
                exchangeRate=p_exchangeRate
  			 WHERE
  				acctnum = p_acctnum;
  		   END;
  	   END IF;
  	END;
  
  	IF (p_acctnum is null)
  		then set p_acctnum = 0;
  	else
  		if (IFNULL(p_logonid,0) > 0)
          then
  			call sp_login_access_add_mod( p_logonid, p_acctnum, 'OWNER', 'W');
          end if;
  	end if;
      
  
  END$$

DELIMITER ;
##########

/* 2_sp_invdb_altr_user_advisor_info.sql230118_sagar*/


ALTER TABLE `invdb`.`user_advisor_info` 
ADD COLUMN `email` VARCHAR(60) NULL AFTER `advisor_css`,
ADD COLUMN `phone` VARCHAR(15) NULL AFTER `email`,
ADD COLUMN `address` VARCHAR(200) NULL AFTER `phone`;

/* 3_sp_invdb_sel_user_advisor_details.sql230118_sagar*/


USE `invdb`;
DROP procedure IF EXISTS `sel_user_advisor_details`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sel_user_advisor_details`(in p_logonid bigint(10))
begin
 
  select ul.logonid,uai.logonid,ul.userid,ifNull(ul.advisor,'DEMO') as advisor, ifNull(ul.rep,'CATCHALL') as rep,
 uai.accttype,uai.companyname,uai.displayName,uai.logo,uai.advisor_css,uai.email,uai.phone,uai.address 
 from invdb.user_logon ul
 left join invdb.user_advisor_info uai on (ul.advisor=uai.advisor)
 where ul.logonid=p_logonid;
 end$$

DELIMITER ;

/* 4_sp_testing_sp_emulate_step2_openaccount.sql230118_sagar*/

USE `testing`;
DROP procedure IF EXISTS `sp_emulate_step2_openaccount`;

DELIMITER $$
USE `testing`$$
CREATE  PROCEDURE `sp_emulate_step2_openaccount`(
  IN p_acctnum BIGINT,
    IN p_logonid BIGINT(20)
)
BEGIN
    DECLARE tFound1 INTEGER;
    DECLARE tFound2 INTEGER;
    DECLARE tStatus INTEGER;
    DECLARE tClientAccountID VARCHAR(10);

    SELECT count(*)
    INTO tFound1
    FROM invdb.user_trade_profile utp
    WHERE utp.acctnum = p_acctnum;

    SELECT count(*)
    INTO tFound2
    FROM invdb.ext_acct_info eai
    WHERE eai.acctnum = p_acctnum;

    IF (IFNULL(tFound2, 0) != 0)
    THEN
      SELECT 'This account# is already created.' AS msg;
    ELSE
      IF (IFNULL(tFound1, 0) = 0)
      THEN
        SELECT 'This account# found on DB' AS msg;
      ELSE

        SELECT COUNT(*)
        INTO tFound2
        FROM invdb.dc_acct_owners_details daod
        WHERE daod.acctnum = p_acctnum;

        set tClientAccountID = CONCAT('TST', p_acctnum);

		IF (IFNULL(tFound2, 0) > 0)
        THEN
        INSERT INTO invdb.ext_acct_info
		(clientAccountID,
		acctnum,
		status,
		rep,
		email,
		accountType,
		applicantFName,
		applicantMName,
		applicantLName,
		address1,
		address2,
		address3,
		city,
		state,
		zipcode,
		country,
		primaryPhoneNbr,
		secondayPhoneNbr,
		workPhoneNbr,
		faxNbr,
		identification,
		dob,
		idType,
		taxable,
		objective,
		dateOpened,
		created,
		lastUpdated)
            SELECT
              tClientAccountID AS clientAccountID,
               daod.acctnum,
              'P',
              NULL,
              daod.emailAddress,
              dad.acctTypeId,
              daod.firstName,
              NULL,
              daod.lastName,
              daod.physicalAddressStreet,
              NULL,
              NULL,
              daod.physicalAddressCity,
              daod.physicalAddressState,
              daod.physicalAddressZipCode,
              'USA',
              daod.phoneNumber,
              daod.secondPhoneNumber,
              NULL, 
              NULL, 
              daod.ssn,
              invdb.funct_strdate2inv_date(daod.dob, '%m/%d/%Y'),
              dml.displayName,
              NULL, 
              NULL, 
              invdb.funct_date2inv_date(now()) as performanceInceptionDate, 
              now(),
              NULL
            FROM invdb.dc_acct_owners_details AS daod
              , invdb.dc_acct_details dad
              , invdb.dc_m_lookup dml
            WHERE daod.acctnum = p_acctnum
                  AND daod.acctOwnerId = 1
                  AND daod.acctnum = dad.acctnum
                  AND dad.acctTypeId = dml.lookupCode
                  AND dml.lookupSet = 'ACCTTYPE';


          SELECT 'This account# was ADDED to ext_acct_info using TDs data' AS msg;
        ELSE
        INSERT INTO invdb.ext_acct_info
		(clientAccountID,
		acctnum,
		status,
		rep,
		email,
		accountType,
		applicantFName,
		applicantMName,
		applicantLName,
		address1,
		address2,
		address3,
		city,
		state,
		zipcode,
		country,
		primaryPhoneNbr,
		secondayPhoneNbr,
		workPhoneNbr,
		faxNbr,
		identification,
		dob,
		idType,
		taxable,
		objective,
		dateOpened,
		created,
		lastUpdated)
          VALUES (
            tClientAccountID,
            p_acctnum,
            'P',
            NULL, 
            CONCAT('testing', p_acctnum, '@invessence.com'), 
            'Individual', 
            'Testing', 
            NULL, 
            p_acctnum, 
            null, 
            NULL, 
            NULL, 
            null, 
            null, 
            null, 
            null, 
            null, 
            null, 
            NULL, 
            NULL, 
            null, 
            null, 
            null, 
            NULL, 
            NULL, 
            invdb.funct_date2inv_date(now()), 
			now(), 
            NULL 
          );

          SELECT 'This account# was ADDED to ext_acct_info using as sample data' AS msg;

        END IF;
        UPDATE invdb.user_trade_profile utp
			set clientAccountID = tClientAccountID
        WHERE utp.acctnum = p_acctnum;

        CALL invdb.sp_user_profile_manage(p_acctnum, 'O',p_logonid);
      END IF;

    END IF;


  END$$

DELIMITER ;

/* 5_sp_upd_custody_file_master.sql230118_sagar*/


UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Singapore & Singapore PR NRIC (Provide front copy)' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='NRIC' and`seqno`='1';
UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Singapore & Singapore PR NRIC (Provide back copy)' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='NRIC' and`seqno`='2';
UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Malaysian IC (Provide front copy)' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='MYKAD' and`seqno`='1';
UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Malaysian IC (Provide back copy)' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='MYKAD' and`seqno`='2';
UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Passport (For Other Nationalities)' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='Passport' and`seqno`='1';
UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Bank Statement (For Remittance Standing Instruction)' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='BNK_STMT' and`seqno`='3';
UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Bank Statement (For Remittance Standing Instruction)' WHERE `product`='UOB' and`action`='ACCT_OPEN_EXISTING_USER' and`subaction`='BNK_STMT' and`seqno`='1';
UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Proof of Residential address' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='Res_Proof' and`seqno`='4';
UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Proof of Mailing  address' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='Add_Res_Proof' and`seqno`='5';
UPDATE `invdb`.`custody_file_master` SET `fileName`='Declarations.pdf' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='MasterTradeAgreement' and`seqno`='1';

/* 6_sp_altr_ext_investment.sql230118_sagar*/

CREATE TABLE `invdb`.`ext_investment` (
 `acctnum` bigint(20) DEFAULT NULL,
 `clientAccountID` varchar(12) NOT NULL DEFAULT '',
 `ticker` varchar(20) NOT NULL DEFAULT 'Cash',
 `investmentDate` varchar(10) NOT NULL,
 `status` varchar(1) DEFAULT NULL,
 `investmentCurrency` varchar(3) NOT NULL DEFAULT 'USD',
 `netAmount` double DEFAULT NULL,
 `comment` varchar(120) DEFAULT NULL,
 `fxRateToBase` double DEFAULT '1',
 `baseCurrency` varchar(3) DEFAULT 'USD',
 `convertedNetAmount` double DEFAULT NULL,
 `created` datetime NOT NULL,
 PRIMARY KEY (`clientAccountID`,`ticker`,`investmentDate`,`investmentCurrency`),
 KEY `AK1_ext_transaction` (`acctnum`,`investmentDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/* 7_sp_upd_web_site_info.sql230118_sagar*/

/* 8_sp_save_trade_process_identifier.sql230118_sagar*/

USE `invdb`;
DROP procedure IF EXISTS `save_trade_process_identifier`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_trade_process_identifier`(
   `p_acctnum` 		bigint(20)
  ,`p_tradeStatus`	varchar(1) 
  ,`p_processStatus`	varchar(1) 
  ,`p_reason`			varchar(100)
)
BEGIN
	begin
    
		INSERT INTO `invdb`.`trade_process_identifier`
		(`acctnum`,
		`tradeStatus`,
		`processStatus`,
		`reason`,
		`created`,
		`updated`)
		VALUES
		(`p_acctnum`
		,`p_tradeStatus`
		,`p_processStatus`
		,`p_reason`
		,now()
		,null)
        ON duplicate key update
		`tradeStatus`=`p_tradeStatus`,
		`reason`=`p_reason`,
			`processStatus` = `p_processStatus`
            ,`updated` = now()
		;
    
    end;
END$$

DELIMITER ;



