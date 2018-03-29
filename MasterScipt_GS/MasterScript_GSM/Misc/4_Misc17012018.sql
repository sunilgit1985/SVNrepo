/* 16.pm.add_style_to_db.sql17012018_pmehta*/

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

/* 17.pm.webpage_menu_item.sql17012018_pmehta*/

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

/* 18.pm.ct_user_invited.sql17012018_pmehta*/

DROP TABLE IF EXISTS `invdb`.`user_invited`;

CREATE TABLE `invdb`.`user_invited` (
  `email` 		varchar(60) NOT NULL,
  `logonstatus` varchar(1) NOT NULL DEFAULT 'T',
  `accessmode`	VARCHAR(1) NOT NULL COMMENT 'A - Advisor U - User',
  `prefix` 		varchar(25) DEFAULT NULL,
  `firstname` 	varchar(25) DEFAULT NULL,
  `middlename`	varchar(25) DEFAULT NULL,
  `lastname`	varchar(25) DEFAULT NULL,
  `suffix`		varchar(25) DEFAULT NULL,
  `fullname`	varchar(60) DEFAULT NULL,
  `emailalt` 	varchar(60) DEFAULT NULL,
  `stateRegistered` varchar(6) DEFAULT NULL,
  `leadSource`	varchar(25) DEFAULT NULL,
  `advisor`		varchar(20) DEFAULT NULL,
  `rep`			varchar(20) DEFAULT NULL,
  `ip`			varchar(20) DEFAULT NULL,
  `resetID`		varchar(8) DEFAULT NULL,
  `created`		timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastupdated` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* 507.pm.sel_taxHarvestingSecurities.sql17012018_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`sel_taxHarvestingSecurities`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_taxHarvestingSecurities`()
BEGIN
	SELECT 
		`tlh`.`ticker`,
		`tlh`.`tlhticker`,
		`tlh`.`active`,
		`tlh`.`weight`,
        IFNULL(`mapping`.`type`,`sec_master`.`type`) AS `type`,
        IFNULL(`mapping`.`style`,`sec_master`.`style`) AS `style`,
        IFNULL(`mapping`.`assetclass`,`sec_master`.`assetclass`) AS `assetclass`,
        IFNULL(`mapping`.`subclass`,`sec_master`.`subclass`) AS `subclass`,
        `sec_master`.`expenseRatio` AS `expenseRatio`,
        (case
            when (ucase(`tlh`.`ticker`) = ucase('Cash')) then 1.00
            else ifnull(`sd`.`converted_adjusted_price`, 0.00)
        end) AS `tradePrice`,
        (case
            when (ucase(`tlh`.`ticker`) = ucase('Cash')) then 1.00
            else ifnull(`sd`.`exchangeRate`, 0.00)
        end) AS `exchangeRate`,
        (case
            when (ucase(`tlh`.`ticker`) = ucase('Cash')) then 1.00
            else ifnull(`sd`.`adjusted_price`, 0.00)
        end) AS `settlePrice`,
 		DATE_FORMAT(`tlh`.`created`,'%Y%m%d') as created
	FROM `sec_tax_loss_harvesting` as `tlh`
		INNER JOIN `sec_master` as `sec_master`
        ON (`tlh`.`ticker` = `sec_master`.`ticker`)
        INNER JOIN  `sec_asset_mapping` as `mapping`
        ON (`tlh`.`tlhticker` = `mapping`.`ticker`
        AND `tlh`.`theme` = `mapping`.`theme`)
         LEFT JOIN `sec_daily_info` as `sd`
         ON (`tlh`.`tlhticker` = `sd`.`ticker`
			AND    date_format(`sd`.`businessdate`, '%Y%m%d') = funct_get_switch('PRICE_DATE'))
 	where `tlh`.`active` = 'A'
    ;
END$$
DELIMITER ;

/* 509.pm.sel_webpages_menu_items.sql17012018_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`sel_webpages_menu_items`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_webpages_menu_items`(
	IN p_advisor	VARCHAR(20)
)
BEGIN

    SELECT 
		`webpage_menu_items`.`advisor`,
		`webpage_menu_items`.`group`,
		`webpage_menu_items`.`sortorder`,
		`webpage_menu_items`.`key`,
		`webpage_menu_items`.`displayname`,
		`webpage_menu_items`.`image`,
		`webpage_menu_items`.`shortname`,
		`webpage_menu_items`.`description`,
		`webpage_menu_items`.`otherinfo`
	FROM `invdb`.`webpage_menu_items`
    WHERE upper(`webpage_menu_items`.`advisor`) = upper(IFNULL(p_advisor,'INVESSENCE'))
    ORDER BY 1, 2, 3
    ;

END$$
DELIMITER ;

/* 510.pm.save_user_trade_profile.sql17012018_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`save_user_trade_profile`;

DELIMITER $$

CREATE PROCEDURE `invdb`.`save_user_trade_profile`(
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
		IN p_customName varchar(60),
		IN p_tradeCurrency varchar(20),
		IN p_settleCurrency varchar(20),
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
              
  			call invdb.sp_user_profile_manage (p_acctnum, t_status);
  
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
                tradeCurrency=SUBSTRING(p_tradeCurrency,1,3),
                settleCurrency=SUBSTRING(p_settleCurrency,1,3),
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

/* 550.pm.sp_upload_sec_optimized_validate_by_theme.sql17012018_pmehta*/

DROP PROCEDURE IF EXISTS `temp`.`sp_upload_sec_optimized_validate_by_theme`;

DELIMITER $$
CREATE PROCEDURE `temp`.`sp_upload_sec_optimized_validate_by_theme`(
	in p_new_theme varchar(50)
    ,in p_crnt_theme varchar(50)
    )
BEGIN

	-- Check for Theme Name consistency (Already in production)
	SELECT DISTINCT 
		concat('Theme is already in production environment') as validate
        , chk. theme, null as assetclass, null as primeassetclass, count(*) as value
	FROM temp.tmp_sec_assetclass_group chk
	WHERE chk.theme=p_new_theme
    AND chk.`status` in ('A')
	AND chk.theme in (select distinct t.theme from invdb.sec_assetclass_group t where t.`status` = 'A')
    GROUP BY
		chk.theme
	HAVING count(*) > 0
	UNION ALL

	-- Is this Theme defined in our asssetclass table 
	SELECT DISTINCT 
		concat('Theme is NOT defined on Asset Class table') as validate
        , chk. theme, null as assetclass, null as primeassetclass, count(*) as value
	FROM temp.tmp_sec_assetclass_group chk
	WHERE chk.theme not in (p_new_theme)
    AND chk.`status` in ('A')
    GROUP BY
		chk.theme
	HAVING count(*) > 0
	UNION ALL

	-- Is this Theme defined in our asssetclass table 
	SELECT DISTINCT 
		concat('Theme is NOT defined Prime Asset Class table') as validate
        , chk. theme, null as assetclass, null as primeassetclass, count(*) as value
	FROM temp.tmp_sec_prime_asset_group chk
	WHERE chk.theme not in (p_new_theme)
    AND chk.`status` in ('A')
    GROUP BY
		chk. theme
	HAVING count(*) = 0
	UNION ALL

	-- Check for Theme Name consistency
	SELECT DISTINCT 
		concat('Asset Class and Prime Asset Class entries for theme do not match!') as validate
        , chk. theme, null as assetclass, null as primeassetclass, count(*) as value
	FROM temp.tmp_sec_assetclass_group chk
	WHERE chk.theme=p_new_theme
    AND chk.`status` in ('A')
	AND chk.theme not in (select distinct t.theme from temp.tmp_sec_prime_asset_group t where t.`status` = 'A')
    GROUP BY
		chk.theme
	HAVING count(*) > 0
	UNION ALL
    
	-- Check for Rever match using Primeasset as primary and Assetclass as secondary
	SELECT DISTINCT 
		concat('Asset Class and Prime Asset Class entries for theme do not match!') as validate
        , chk. theme, null as assetclass, null as primeassetclass, count(*) as value
	FROM temp.tmp_sec_prime_asset_group chk
	WHERE chk.theme=p_new_theme
    AND chk.`status` in ('A')
	AND chk.theme not in (select distinct t.theme from temp.tmp_sec_assetclass_group t where t.`status` = 'A')
    GROUP BY
		chk.theme
	HAVING count(*) > 0
	UNION ALL

	-- Check for Asset Class consistency
   	SELECT 
		concat('Asset Class and Prime Asset Class entries for asset class [', chk.assetclass,' ] do not match!') as validate
        , chk. theme, null as assetclass, null as primeassetclass, count(*) as value
	FROM temp.tmp_sec_assetclass_group chk
	WHERE chk.theme=p_new_theme 
	AND chk.`status` in ('A')
	and concat(chk.theme,chk.assetclass) not in (select concat(t.theme,t.assetclass) from temp.tmp_sec_prime_asset_group t where t.`status` = 'A')
    GROUP BY
		chk. theme
	HAVING count(*) > 0
    UNION ALL
    
	-- Check for New Security in Asset class consistency
   	SELECT 
		concat('Security used in Asset class for optimization [', chk.ticker,' ] not on system!') as validate
        , chk. theme, null as assetclass, null as primeassetclass, count(*) as value
	FROM temp.tmp_sec_assetclass_group chk
	WHERE theme=p_new_theme 
	AND chk.`status` in ('A')
    and chk.ticker not in (select t.ticker from invdb.sec_master t where t.`status` = 'A')
    GROUP BY
		chk.theme
	HAVING count(*) > 0
    UNION ALL
    
	-- Check for New Security in Prime assetclass consistency
   	SELECT 
		concat('Security used in Prime assetclass for optimization [', chk.ticker,' ] not on system!') as validate
        , chk. theme, null as assetclass, null as primeassetclass, count(*) as value
	FROM temp.tmp_sec_prime_asset_group chk
	WHERE theme=p_new_theme 
	AND chk.`status` in ('A')
    and chk.ticker not in (select t.ticker from invdb.sec_master t where t.`status` = 'A')
    GROUP BY
		chk.theme
	HAVING count(*) > 0
    UNION
    
    
	-- Check for Asset Class lowerbound
   	SELECT 
		concat('SUM of ALL Assetclass lower bound [', chk.theme,' ] has to be less then 1!') as validate
        , chk. theme, null as assetclass, null as primeassetclass, sum(lowerbound) as value
	FROM temp.tmp_sec_assetclass_group chk
	WHERE theme=p_new_theme 
	AND chk.`status` in ('A')
    GROUP BY
		chk.theme
	HAVING sum(lowerbound) >= 1
    UNION
    
	-- Check for Asset Class upperbound
   	SELECT 
		concat('SUM of ALL Assetclass upper bound [', chk.theme,' ] has to be greater then 1!') as validate
        , chk. theme, null as assetclass, null as primeassetclass, sum(upperbound) as value
	FROM temp.tmp_sec_assetclass_group chk
	WHERE theme=p_new_theme 
	AND chk.`status` in ('A')
    GROUP BY
		chk.theme
	HAVING sum(upperbound) < 1
    UNION
    
 	-- Check for Prime Asset Class upperbound
   	SELECT 
		concat('For this Prime Asset class SUM of this lower bound [', chk.theme, '->', chk.assetclass, ' ] has to less then 1!') as validate
        , chk. theme, chk.assetclass as assetclass, null as primeassetclass, sum(chk.lowerbound) as value
	FROM temp.tmp_sec_prime_asset_group chk
	WHERE theme=p_new_theme 
	AND chk.`status` in ('A')
    GROUP BY
		chk.theme, chk.assetclass
	HAVING sum(lowerbound) >= 1
    UNION
 	-- Check for Prime Asset Class upperbound
   	SELECT 
		concat('For this Prime Asset class SUM of this  upper bound [', chk.theme, '->', chk.assetclass, ' ] has to greater then 1!') as validate
        , chk. theme, chk.assetclass as assetclass, null as primeassetclass, sum(chk.upperbound) as value
	FROM temp.tmp_sec_prime_asset_group chk
	WHERE theme=p_new_theme 
	AND chk.`status` in ('A')
    GROUP BY
		chk.theme, chk.assetclass
	HAVING sum(upperbound) < 1
    ;
    
    

END$$
DELIMITER ;

/* 551.pm.sp_upload_sec_assetclass_group.sql17012018_pmehta*/

DROP PROCEDURE IF EXISTS `temp`.`sp_upload_sec_assetclass_group`;

DELIMITER $$
CREATE PROCEDURE `temp`.`sp_upload_sec_assetclass_group`(
	  IN p_logon			BIGINT(20)
	, IN p_new_theme		VARCHAR(50)
    , IN p_current_theme	VARCHAR(50)
	)
BEGIN

	DECLARE tAccess	VARCHAR(20);
    
	DELETE FROM `invdb`.`sec_assetclass_group`
    WHERE concat(theme) in (p_new_theme);
    
	SELECT `access`
    INTO tAccess
    from `invdb`.`user_logon`
    where logonid = tAccess;
    
    -- If the individual is Admin then they can replace all data.
    If (lower(IFNULL(tAccess,'XXX')) = 'admin')
		THEN
			INSERT INTO `invdb`.`sec_assetclass_group`
			(`theme`,
			`status`,
			`assetclass`,
			`displayName`,
			`ticker`,
			`sortorder`,
			`lowerBound`,
			`upperBound`,
			`color`,
			`averageReturn`,
			`riskAdjustment`,
			`endAllocation`,
			`created`,
			`lastupdated`)
			SELECT 
            p_new_theme,
			`tmp`.`status`,
			`tmp`.`assetclass`,
			`tmp`.`displayName`,
			`tmp`.`ticker`,
			`tmp`.`sortorder`,
			`tmp`.`lowerBound`,
			`tmp`.`upperBound`,
			`tmp`.`color`,
			`tmp`.`averageReturn`,
			`tmp`.`riskAdjustment`,
			`tmp`.`endAllocation`,
			`tmp`.`created`,
			now()
            FROM `temp`.`tmp_sec_assetclass_group` as `tmp`
            WHERE `tmp`.`theme` = p_new_theme;
		ELSE
			-- Else allow only limited access.
			INSERT INTO `invdb`.`sec_assetclass_group`
			(`theme`,
			`status`,
			`assetclass`,
			`displayName`,
			`ticker`,
			`sortorder`,
			`lowerBound`,
			`upperBound`,
			`color`,
			`averageReturn`,
			`riskAdjustment`,
			`endAllocation`,
			`created`,
			`lastupdated`)
			SELECT 
            p_new_theme,
			`sec_assetclass_group`.`status`,
			`sec_assetclass_group`.`assetclass`,
			`sec_assetclass_group`.`displayName`,
			`sec_assetclass_group`.`ticker`,
			`sec_assetclass_group`.`sortorder`,
			`sec_assetclass_group`.`lowerBound`,
			`sec_assetclass_group`.`upperBound`,
			`sec_assetclass_group`.`color`,
			`tmp`.`averageReturn`,
			`tmp`.`riskAdjustment`,
			`tmp`.`endAllocation`,
			`sec_assetclass_group`.`created`,
			now()
            FROM `temp`.`tmp_sec_assetclass_group` as `tmp`
            INNER JOIN `invdb`.`sec_assetclass_group`
            ON (`sec_assetclass_group`.`theme` = p_current_theme
			AND  `sec_assetclass_group`.`assetclass` = `tmp`.`assetclass`
            AND  `sec_assetclass_group`.`ticker` = `tmp`.`ticker`
            )
            WHERE `tmp`.`theme` = p_new_theme;
	END IF;
    
END$$
DELIMITER ;

/* 552.pm.sp_upload_sec_prime_asset_group.sql17012018_pmehta*/

DROP PROCEDURE IF EXISTS `temp`.`sp_upload_sec_prime_asset_group`;

DELIMITER $$
CREATE PROCEDURE `temp`.`sp_upload_sec_prime_asset_group`(
	  IN p_logon			BIGINT(20)
	, IN p_new_theme		VARCHAR(50)
    , IN p_current_theme	VARCHAR(50)
	)
BEGIN

	DECLARE tAccess	VARCHAR(20);
    
	DELETE FROM `invdb`.`sec_prime_asset_group`
    WHERE concat(theme) in (p_new_theme);
    
	SELECT `access`
    INTO tAccess
    from `invdb`.`user_logon`
    where logonid = tAccess;
    
    -- If the individual is Admin then they can replace all data.
    If (lower(IFNULL(tAccess,'XXX')) = 'admin')
		THEN
			INSERT INTO `invdb`.`sec_prime_asset_group`
			(`theme`,
			`assetclass`,
			`primeassetclass`,
			`ticker`,
			`status`,
			`sortorder`,
			`color`,
			`lowerBound`,
			`upperBound`,
			`expectedReturn`,
			`risk`,
			`yield`,
			`created`,
			`lastUpdated`)
			SELECT
				p_new_theme,
				`tmp`.`assetclass`,
				`tmp`.`primeassetclass`,
				`tmp`.`ticker`,
				`tmp`.`status`,
				`tmp`.`sortorder`,
				`tmp`.`color`,
				`tmp`.`lowerBound`,
				`tmp`.`upperBound`,
				`tmp`.`expectedReturn`,
				`tmp`.`risk`,
				`tmp`.`yield`,
				`tmp`.`created`,
				now()        
            FROM `temp`.`tmp_sec_prime_asset_group` as `tmp`
            WHERE `tmp`.`theme` = p_new_theme;
		ELSE
			-- Else allow only limited access.
			INSERT INTO `invdb`.`sec_prime_asset_group`
			(`theme`,
			`assetclass`,
			`primeassetclass`,
			`ticker`,
			`status`,
			`sortorder`,
			`color`,
			`lowerBound`,
			`upperBound`,
			`expectedReturn`,
			`risk`,
			`yield`,
			`created`,
			`lastUpdated`)
			SELECT
				p_new_theme,
				`sec_prime_asset_group`.`assetclass`,
				`sec_prime_asset_group`.`primeassetclass`,
				`sec_prime_asset_group`.`ticker`,
				`sec_prime_asset_group`.`status`,
				`sec_prime_asset_group`.`sortorder`,
				`sec_prime_asset_group`.`color`,
				`sec_prime_asset_group`.`lowerBound`,
				`sec_prime_asset_group`.`upperBound`,
				`temp`.`expectedReturn`,
				`temp`.`risk`,
				`temp`.`yield`,
				`temp`.`created`,
				now()        
            FROM `temp`.`tmp_sec_prime_asset_group` as `tmp`
            INNER JOIN `invdb`.`sec_prime_asset_group`
            ON (`sec_prime_asset_group`.`theme` = p_current_theme
			AND  `sec_prime_asset_group`.`assetclass` = `tmp`.`assetclass`
			AND  `sec_prime_asset_group`.`primeassetclass` = `tmp`.`primeassetclass`
            AND  `sec_prime_asset_group`.`ticker` = `tmp`.`ticker`
            )
            WHERE `tmp`.`theme` = p_new_theme;
            
	END IF;

	-- Make sure that both numbers match.
	UPDATE `invdb`.`sec_assetclass_group`, `temp`.`tmp_sec_prime_asset_group` 
		set `tmp`.`averageReturn` = `tmp_sec_prime_asset_group`.`expectedReturn`,
			`tmp`.`riskAdjustment` = `tmp_sec_prime_asset_group`.`risk`
	WHERE `sec_assetclass_group`.`ticker` = `tmp_sec_prime_asset_group`.`ticker`
	AND   `sec_assetclass_group`.`theme` = `tmp_sec_prime_asset_group`.`theme`
	AND   `sec_assetclass_group`.`theme` = p_new_theme;

    
END$$
DELIMITER ;

/* 553.pm.sp_upload_transaction.sql17012018_pmehta*/

DROP PROCEDURE IF EXISTS `temp`.`sp_upload_trades`;

DELIMITER $$
CREATE PROCEDURE `temp`.`sp_upload_trades`(
)
BEGIN 

   begin
		delete from `invdb`.`ext_transaction`
		where concat(`clientAccountID`,`tradeDate`) 
				in (select distinct concat(`tmp_transaction`.`clientAccountID`,replace(`tmp_transaction`.`tradeDate`,'-',''))
					from `temp`.`tmp_transaction`)
		;

		insert into `invdb`.`ext_transaction` (
				`acctnum`
			,	`clientAccountID`
			,	`tickerISIN`
			,	`confirmNumber`
			,	`transactionSource`
			,	`transactionType`
			,	`transactionStatus`
			,	`controlNumber`
			,	`quantity`
			,	`price`
			,	`netAmount`
			,	`commission`
			,	`otherFees`
			,	`tradeDate`
			,	`settDate`
			,	`voidDate`
			,	`comment`
			,	`tradedCurrency`
			,	`fxRateToBase`
			,	`baseCurrency`
			,	`convertedNetAmount`
			,	`created`
          )
		SELECT
				`ext_acct_info`.`acctnum`
			,	`tmp_transaction`.`clientAccountID`
			,	`tmp_transaction`.`symbolSIN` 			-- `tickerISIN`
            ,	IFNULL(`tmp_transaction`.`confirmNumber`,concat(`tmp_transaction`.`clientAccountID`,'-',`tmp_transaction`.`tradeDate`))	-- `confirmNumber`
            ,	'EOD' 									-- `transactionSource`
			,	SUBSTR(`tmp_transaction`.`transactionType`,1,1)	-- `transactionType` (Buy,Sell, etc.)
            ,	'P'										-- `transactionStatus` ('P' = Pending Settlement)
            ,	null									-- `controlNumber`
			,	`tmp_transaction`.`quantity`			-- `quantity`
			,	`tmp_transaction`.`price`				-- `price`
			,	`tmp_transaction`.`netAmount`			-- `netAmount`
			,	`tmp_transaction`.`brokerFee`			-- `commission`
			,	`tmp_transaction`.`otherFees`			-- `otherFees`
			,	`tmp_transaction`.`tradeDate`			-- `tradeDate`
			,	`tmp_transaction`.`settleDate`			-- `settDate`
			,	null									-- `voidDate`
			,	`tmp_transaction`.`comments`			-- `comment`
			,	`tmp_transaction`.`executionCurrency` 	-- `tradedCurrency`
			,	`tmp_transaction`.`exchangeRate`		-- `fxRateToBase`
			,	`tmp_transaction`.`localCurrency`		-- `baseCurrency`
            ,	(IFNULL(`tmp_transaction`.`netAmount`,0) * IFNULL(`tmp_transaction`.`exchangeRate`,1)) -- `convertedNetAmount`
            ,	now()								-- `created`
		FROM `temp`.`tmp_transaction`
        INNER JOIN `invdb`.`ext_acct_info`
        ON (`ext_acct_info`.`clientAccountID` = `tmp_transaction`.`clientAccountID`)
        ;

   end;

END$$
DELIMITER ;


			 
/* 554.pm.sp_invite_user.sql17012018_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`sp_invite_user`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sp_invite_user`(
    IN p_email 			varchar(60),
    IN p_logonstatus	varchar(1),
    IN p_accessmode		varchar(1),
	IN p_prefix			varchar(25),
    IN p_firstname		varchar(25),
	IN p_middlename		varchar(25),
    IN p_lastname		varchar(25),
	IN p_suffix			varchar(25),
    IN p_fullname		varchar(60),
    IN p_emailalt		varchar(60),
	IN p_stateRegistered varchar(6),
	IN p_leadSource		varchar(25),
    IN p_advisor		varchar(20),
    IN p_rep			varchar(20),
    IN p_ip				varchar(20),
    IN p_resetID		varchar(8)
 )
BEGIN 
 
    BEGIN
    INSERT INTO `invdb`.`user_invited`
		(`email`,
		`logonstatus`,
		`accessmode`,
        `prefix`,
		`lastname`,
		`firstname`,
		`middlename`,
		`suffix`,
		`fullname`,
		`emailalt`,
		`stateRegistered`,
		`leadSource`,
		`advisor`,
		`rep`,
		`ip`,
		`resetID`,
		`created`,
		`lastupdated`)
	VALUES (
         p_email
		,p_logonstatus
        ,p_accessmode
        ,p_prefix
		,p_lastname
		,p_firstname
        ,p_middlename
        ,p_suffix
        ,p_fullname
		,p_emailalt
        ,p_stateRegistered
        ,p_leadSource
		,p_advisor
		,p_rep
		,p_ip
		,p_resetID
        ,now()
        ,null
    );
    
    END;
END$$
DELIMITER ;

/* 555.pm.sp_is_email_taken.sql17012018_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`sp_is_email_taken`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sp_is_email_taken`(
    IN p_email 			varchar(60)
 )
BEGIN 
 
	BEGIN
		SELECT 'PROD' as src
        FROM 	user_logon
        WHERE 	user_logon.email = p_email
        AND     user_logon.logonstatus not in  ('T')
        UNION
		SELECT 'INVITED' as src
        FROM 	user_invited
        WHERE 	user_invited.email = p_email
        AND     user_invited.logonstatus in ('T')
        ;
    END;
END$$
DELIMITER ;

/* 601.pm.save_user_trade_preprocess.sql17012018_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`save_rebalanced_trades`;
DROP PROCEDURE IF EXISTS `invdb`.`save_user_trade_preprocess`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`save_user_trade_preprocess`(
		IN	`p_advisor`	varchar(20)
	,	IN	`p_clientAccountID`	varchar(20)
	,	IN	`p_acctnum`	bigint(20)
	,	IN	`p_processed`	varchar(1)
	,	IN	`p_tradeDate`	varchar(8)
	,	IN	`p_tradeCurrency`	varchar(3)
	,	IN	`p_assetclass`	varchar(40)
	,	IN	`p_subclass`	varchar(40)
	,	IN	`p_color`	varchar(10)
	,	IN	`p_holdingTicker`	varchar(25)
	,	IN	`p_curQty`	double
	,	IN	`p_curPrice`	double
	,	IN	`p_curValue`	double
	,	IN	`p_newTicker`	varchar(25)
	,	IN	`p_newQty`	double
	,	IN	`p_newPrice`	double
	,	IN	`p_newValue`	double
	,	IN	`p_settleCurrency`	varchar(3)
	,	IN	`p_setleCurQty`	double
	,	IN	`p_settleCurPrice`	double
	,	IN	`p_settleCurValue`	double
	,	IN	`p_exchangeRate`	double
	,	IN	`p_settleNewQty`	double
	,	IN	`p_settleNewPrice`	double
	,	IN	`p_settleNewValue`	double
	,	IN	`p_tradeType`	varchar(40)
	,	IN	`p_reason`	varchar(40)
)
BEGIN
		INSERT INTO `invdb`.`user_trade_preprocess`
		(
			`advisor`,
			`clientAccountID`,
			`acctnum`,
			`processed`,
			`tradeDate`,
			`tradeCurrency`,
			`assetclass`,
			`subclass`,
			`color`,
			`holdingTicker`,
			`curQty`,
			`curPrice`,
			`curValue`,
			`newTicker`,
			`newQty`,
			`newPrice`,
			`newValue`,
			`settleCurrency`,
			`setleCurQty`,
			`settleCurPrice`,
			`settleCurValue`,
			`exchangeRate`,
			`settleNewQty`,
			`settleNewPrice`,
			`settleNewValue`,
			`tradeType`,
			`reason`,
			`created`
		)
		VALUES
        (
				`p_advisor`
			,	`p_clientAccountID`
			,	`p_acctnum`
			,	`p_processed`
			,	`p_tradeDate`
			,	`p_tradeCurrency`
			,	`p_assetclass`
			,	`p_subclass`
			,	`p_color`
			,	`p_holdingTicker`
			,	`p_curQty`
			,	`p_curPrice`
			,	`p_curValue`
			,	`p_newTicker`
			,	`p_newQty`
			,	`p_newPrice`
			,	`p_newValue`
			,	`p_settleCurrency`
			,	`p_setleCurQty`
			,	`p_settleCurPrice`
			,	`p_settleCurValue`
			,	`p_exchangeRate`
			,	`p_settleNewQty`
			,	`p_settleNewPrice`
			,	`p_settleNewValue`
			,	`p_tradeType`
			,	`p_reason`
            , 	now()
        )
            ON DUPLICATE KEY UPDATE
			`advisor`	=	`p_advisor`
		,	`clientAccountID`	=	`p_clientAccountID`
		,	`acctnum`	=	`p_acctnum`
		,	`processed`	=	`p_processed`
		,	`tradeDate`	=	`p_tradeDate`
		,	`tradeCurrency`	=	`p_tradeCurrency`
		,	`assetclass`	=	`p_assetclass`
		,	`subclass`	=	`p_subclass`
		,	`color`	=	`p_color`
		,	`holdingTicker`	=	`p_holdingTicker`
		,	`curQty`	=	`p_curQty`
		,	`curPrice`	=	`p_curPrice`
		,	`curValue`	=	`p_curValue`
		,	`newTicker`	=	`p_newTicker`
		,	`newQty`	=	`p_newQty`
		,	`newPrice`	=	`p_newPrice`
		,	`newValue`	=	`p_newValue`
		,	`settleCurrency`	=	`p_settleCurrency`
		,	`setleCurQty`	=	`p_setleCurQty`
		,	`settleCurPrice`	=	`p_settleCurPrice`
		,	`settleCurValue`	=	`p_settleCurValue`
		,	`exchangeRate`	=	`p_exchangeRate`
		,	`settleNewQty`	=	`p_settleNewQty`
		,	`settleNewPrice`	=	`p_settleNewPrice`
		,	`settleNewValue`	=	`p_settleNewValue`
		,	`tradeType`	=	`p_tradeType`
		,	`reason`	=	`p_reason`
        ;

END$$
DELIMITER ;

/* 700.pm.sp_login_add_mod.sql17012018_pmehta*/

DROP PROCEDURE `invdb`.`sp_login_add_mod`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sp_login_add_mod`(
    IN p_addmod varchar(1),
    INOUT p_logonid bigint(20),
    IN p_acctnum bigint(20),
    IN p_userid varchar(60),
    IN p_email varchar(60),
    IN p_pwd varchar(60),
    IN p_logonstatus varchar(1),
    IN p_lastname varchar(25),
    IN p_firstname varchar(25),
    IN p_stateRegistered varchar(20),
    IN p_emailalt varchar(60),
    IN p_question1 varchar(60),
    IN p_answer1 varchar(40),
    IN p_question2 varchar(60),
    IN p_answer2 varchar(40),
    IN p_question3 varchar(60),
    IN p_answer3 varchar(40),
    IN p_ip varchar(20),
    IN p_resetID varchar(8),
    IN p_emailmsgtype varchar(45),
    IN p_leadsource varchar(25),
    IN p_cid varchar(3),
    IN p_advisor varchar(20),
    IN p_rep varchar(20),
    IN p_access varchar(20),
    IN p_fullname varchar(45)
 )
BEGIN 
 
    DECLARE t_logonID bigint(20);
    DECLARE t_status  varchar(2);
    DECLARE t_NumOfAcct INTEGER;
 
 	INSERT INTO user_logon_exception
 		(logonid, acctnum, userid, pwd, logonstatus, lastname, firstname, email, created, lastupdated,fullname)
 	VALUES (p_logonid, p_acctnum, p_userid, p_pwd, p_logonstatus, p_lastname, p_firstname, p_email, now(), null,p_fullname);
    
    
    if (p_logonid is not null and p_logonid > 0)
    then
    BEGIN
 		set t_logonID = p_logonid;
 		UPDATE user_logon
 		set		userid = IFNULL(p_userid,userid),
 				pwd = IFNULL(p_pwd,pwd),
 				logonstatus = IFNULL(p_logonstatus,'T'),
 				lastname = IFNULL(p_lastname,lastname),
 				firstname = IFNULL(p_firstname,firstname),
 				email = IFNULL(p_email,email),
 				emailalt = IFNULL(p_emailalt,emailalt),
 				cid = IFNULL(p_cid,cid),
 				advisor = IFNULL(p_advisor,advisor),
 				rep = IFNULL(p_rep,rep),
 				resetID = p_resetID,
 				access = IFNULL(p_access,access),
				lastupdated = current_timestamp(),
				fullname=p_fullname
 		WHERE logonid = p_logonid
         ;
         
    END;
    else
    BEGIN
		set t_logonID = null;
 		INSERT INTO user_logon
 				(
 				userid,
 				pwd,
 				logonstatus,
 				firstname,
 				lastname,
 				email,
 				emailalt,
 				stateRegistered,
 				leadSource,
 				cid,
 				advisor,
 				rep,
 				question1,
 				answer1,
 				question2,
 				answer2,
 				question3,
 				answer3,
 				ip,
 				resetID,
 				emailmsgtype,
 				access,
 				created,
 				lastupdated,
                fullname)
 		VALUES (
 					IFNULL(p_userid,p_email),
 					IFNULL(p_pwd,"Default123"),
 					IFNULL(p_logonstatus,'T'),
 					p_firstname,
 					p_lastname,
 					p_email,
 					p_emailalt,
 					p_stateRegistered,
 					p_leadSource,
 					p_cid,
 					p_advisor,
 					p_rep,
 					p_question1,
 					p_answer1,
 					p_question2,
 					p_answer2,
 					p_question3,
 					p_answer3,
 					p_ip,
 					p_resetID,
 					p_emailmsgtype,
 					IFNULL(p_access,'User'),
 					now(),
 					now(),p_fullname
 				)
                 ;
 		   select last_insert_id() into p_logonid;
 		   set t_logonID = p_logonid;
            
		   call sp_registration_audit(null,p_logonid, p_ip);
           
           call `invdb`.`sp_invite_user`(
					 p_email
					,p_logonstatus
					,'U'
					, null -- ,p_prefix
					,p_firstname
					, null -- ,p_middlename
					,p_lastname
					,null -- ,p_suffix
					,p_fullname
					,p_emailalt
					,p_stateRegistered
					,p_leadSource
					,p_advisor
					,p_rep
					,p_ip
					,p_resetID
                    );
    END;     
    end if;
     	
 	call sp_login_access_add_mod( t_logonID, p_acctnum, 'OWNER', 'W');
     
 	CALL invdb.sp_user_profile_manage(p_acctnum, 'N',t_logonID);
 
 	set p_logonid = t_logonID;
 END$$
DELIMITER ;

/* 900.pm.sel_securities_by_theme.sql17012018_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`sel_securities_by_theme`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_securities_by_theme`(
	  IN p_advisor	VARCHAR(20)
    , IN p_theme	VARCHAR(50)
)
BEGIN

    SELECT DISTINCT
        IFNULL(`user_basket_access`.`advisor`,
                'Invessence') AS `advisor`,
        IFNULL(`user_basket_access`.`model`, 'F') AS `model`,
        IFNULL(`user_basket_access`.`theme`, 'Unused') AS `theme`,
        `sec_asset_mapping`.`assetclass` AS `assetclass`,
        IFNULL(`sec_rbsa`.`primeasset_ticker`,`sec_asset_mapping`.`ticker`) AS `primeassetclass`,
        `sec_asset_mapping`.`subclassName` AS `subassetName`,
        IFNULL(`sec_rbsa`.`ticker`,
                `sec_asset_mapping`.`ticker`) AS `ticker`,
        `sec_master`.`name` AS `name`,
        `sec_master`.`type` AS `type`,
        `sec_master`.`style` AS `style`,
        `sec_master`.`status` AS `status`,
		`sec_rbsa`.`base_currency`  AS `baseCurrency`,
        (CASE
            WHEN (UCASE(`sec_master`.`ticker`) = UCASE('Cash')) THEN 1.00
            ELSE IFNULL(IFNULL(`sd`.`converted_adjusted_price`,`sd`.`adjusted_price`), 0.00)
        END) AS `price`,
        IFNULL(`sec_rbsa`.`dest_currency`, `user_basket_access`.`tradeCurrency`) AS `destCurrency`,
        (CASE
            WHEN (UCASE(`sec_master`.`ticker`) = UCASE('Cash')) THEN 1.00
            ELSE IFNULL(`sd`.`adjusted_price`, 0.00)
        END) AS `localprice`,
        (CASE
            WHEN (UCASE(`sec_master`.`ticker`) = UCASE('Cash')) THEN 1.00
            -- ELSE IFNULL(`sd`.`adjusted_price`, 0.00)
            ELSE 1.00
        END) AS `exchangeRate`,
        IFNULL(`sec_rbsa`.`weight`, 1.0) AS `rbsaweight`,
        ((`sec_asset_mapping`.`assetsortorder` * 10000) + `sec_asset_mapping`.`subclasssortorder`) AS `sortorder`,
        `sec_asset_mapping`.`assetcolor` AS `assetcolor`,
        `sec_asset_mapping`.`subclasscolor` AS `primeassetcolor`,
        `sec_master`.`assetclass` AS `secAssetClass`,
        `sec_master`.`subclass` AS `secSubAssetClass`,
        `sec_master`.`isin` AS `isin`,
        `sec_master`.`cusip` AS `cusip`,
        `sec_master`.`ric` AS `ric`
    FROM
        ((((`user_basket_access`
        JOIN `sec_asset_mapping` ON ((`user_basket_access`.`theme` = `sec_asset_mapping`.`theme`)))
        JOIN `sec_master` ON (((`sec_asset_mapping`.`ticker` = `sec_master`.`ticker`)
            AND (`sec_master`.`status` = 'A'))))
        LEFT JOIN `sec_rbsa` ON (((`sec_asset_mapping`.`theme` = `sec_rbsa`.`theme`)
            AND (`sec_asset_mapping`.`ticker` = `sec_rbsa`.`ticker`)
            )))
        LEFT JOIN `sec_daily_info` `sd` ON (((`sec_rbsa`.`ticker` = `sd`.`ticker`)
			AND (`user_basket_access`.`tradeCurrency` = `sd`.`dest_currency`)
            AND (DATE_FORMAT(`sd`.`businessdate`, '%Y%m%d') = FUNCT_GET_SWITCH('PRICE_DATE')))))
	WHERE `user_basket_access`.`advisor` = p_advisor
    AND   `user_basket_access`.`theme` = p_theme
    ;
END$$
DELIMITER ;

/* 600.pm.sel_securities_by_theme.sql03022018_pmehta*/

DROP PROCEDURE IF EXISTS `sel_securities_by_theme`;

DELIMITER $$
CREATE PROCEDURE `sel_securities_by_theme`(
	  IN p_advisor	VARCHAR(20)
    , IN p_theme	VARCHAR(50)
)
BEGIN

    SELECT DISTINCT
        IFNULL(`user_basket_access`.`advisor`,
                'Invessence') AS `advisor`,
        IFNULL(`user_basket_access`.`model`, 'F') AS `model`,
        IFNULL(`user_basket_access`.`theme`, 'Unused') AS `theme`,
        `sec_asset_mapping`.`assetclass` AS `assetclass`,
        IFNULL(`sec_rbsa`.`primeasset_ticker`,`sec_asset_mapping`.`ticker`) AS `primeassetclass`,
        `sec_asset_mapping`.`subclassName` AS `subassetName`,
        IFNULL(`sec_rbsa`.`ticker`,
                `sec_asset_mapping`.`ticker`) AS `ticker`,
        `sec_master`.`name` AS `name`,
        `sec_master`.`type` AS `type`,
        `sec_master`.`style` AS `style`,
        `sec_master`.`status` AS `status`,
		`sec_rbsa`.`base_currency`  AS `tradeCurrency`,
        (CASE
            WHEN (UCASE(`sec_master`.`ticker`) = UCASE('Cash')) THEN 1.00
            ELSE IFNULL(`sd`.`converted_adjusted_price`, 0.00)
        END) AS `price`,
        IFNULL(`sec_rbsa`.`dest_currency`, `user_basket_access`.`tradeCurrency`) AS `settleCurrency`,
        (CASE
            WHEN (UCASE(`sec_master`.`ticker`) = UCASE('Cash')) THEN 1.00
            ELSE IFNULL(`sd`.`adjusted_price`, 0.00)
        END) AS `settlePrice`,
        (CASE
            WHEN (UCASE(`sec_master`.`ticker`) = UCASE('Cash')) THEN 1.00
            ELSE IFNULL(`sd`.`exchangeRate`, 1.00)
        END) AS `exchangeRate`,
        IFNULL(`sec_rbsa`.`weight`, 1.0) AS `rbsaweight`,
        ((`sec_asset_mapping`.`assetsortorder` * 10000) + `sec_asset_mapping`.`subclasssortorder`) AS `sortorder`,
        `sec_asset_mapping`.`assetcolor` AS `assetcolor`,
        `sec_asset_mapping`.`subclasscolor` AS `primeassetcolor`,
        `sec_master`.`assetclass` AS `secAssetClass`,
        `sec_master`.`subclass` AS `secSubAssetClass`,
        `sec_master`.`isin` AS `isin`,
        `sec_master`.`cusip` AS `cusip`,
        `sec_master`.`ric` AS `ric`
    FROM
        ((((`user_basket_access`
        JOIN `sec_asset_mapping` ON ((`user_basket_access`.`theme` = `sec_asset_mapping`.`theme`)))
        JOIN `sec_master` ON (((`sec_asset_mapping`.`ticker` = `sec_master`.`ticker`)
            AND (`sec_master`.`status` = 'A'))))
        LEFT JOIN `sec_rbsa` ON (((`sec_asset_mapping`.`theme` = `sec_rbsa`.`theme`)
            AND (`sec_asset_mapping`.`ticker` = `sec_rbsa`.`ticker`)
            )))
        LEFT JOIN `sec_daily_info` `sd` ON (((`sec_rbsa`.`ticker` = `sd`.`ticker`)
			AND (`user_basket_access`.`tradeCurrency` = `sd`.`dest_currency`)
            AND (DATE_FORMAT(`sd`.`businessdate`, '%Y%m%d') = FUNCT_GET_SWITCH('PRICE_DATE')))))
	WHERE `user_basket_access`.`advisor` = p_advisor
    AND   `user_basket_access`.`theme` = p_theme
    ;
END$$
DELIMITER ;

/* 504.pm.sel_daily_prime_historical_returns.sql08022018_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`sel_daily_prime_historical_returns`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`sel_daily_prime_historical_returns`(
)
BEGIN

	DROP TEMPORARY TABLE IF EXISTS tmp_historical_dates;
	CREATE TEMPORARY TABLE tmp_historical_dates
	(
		ticker VARCHAR(20),
        tradeCurrency VARCHAR(3),
	    min_businessdate VARCHAR(10),
	    max_businessdate VARCHAR(10)
	);

	DROP TEMPORARY TABLE IF EXISTS tmp_ticker_list;
	CREATE TEMPORARY TABLE tmp_ticker_list
	(
		ticker VARCHAR(20),
        tradeCurrency VARCHAR(3)
	);

	INSERT INTO tmp_ticker_list
	SELECT DISTINCT 
			sec_assetclass_group.ticker,
            user_basket_access.tradeCurrency
	FROM invdb.sec_assetclass_group,
		 invdb.user_basket_access
	WHERE user_basket_access.theme = sec_assetclass_group.theme
    AND   user_basket_access.`status` in ('A')
    AND   sec_assetclass_group.`status` in ('A');
 
	INSERT INTO tmp_ticker_list
	SELECT DISTINCT 
		   sec_prime_asset_group.ticker,
           user_basket_access.tradeCurrency
	FROM invdb.sec_prime_asset_group,
		 invdb.user_basket_access
	WHERE user_basket_access.theme = sec_prime_asset_group.theme
    AND   user_basket_access.`status` in ('A')
    AND   sec_prime_asset_group.`status` in ('A')
	AND   sec_prime_asset_group.ticker not in (select ticker FROM invdb.sec_assetclass_group);

	DELETE FROM tmp_ticker_list
	WHERE upper(ticker) = 'CASH';

	INSERT INTO tmp_historical_dates
	SELECT `daily`.`ticker`,
		   `tmp_ticker_list`.`tradeCurrency` as `tradeCurrency`,
		   min(businessdate) as min_businessdate, 
		   max(businessdate) as max_businessdate
	FROM `rbsa`.`rbsa_daily` daily,
		 tmp_ticker_list
	WHERE daily.ticker = tmp_ticker_list.ticker
    AND   daily.dest_currency = tmp_ticker_list.tradeCurrency
	group by daily.ticker, daily.dest_currency;

	SELECT  `daily`.`ticker`,
		   `tmp_ticker_list`.`tradeCurrency` as `tradeCurrency`, 
            count(*) as maxrows
	FROM 
		 tmp_ticker_list,
		 `rbsa`.`rbsa_daily` daily,
		 (SELECT max(min_businessdate) as min_date, min(max_businessdate) as max_date from tmp_historical_dates) as tmp
	WHERE businessdate >= tmp.min_date
	AND   businessdate <= tmp.max_date
	AND   daily.ticker = tmp_ticker_list.ticker
    AND   daily.dest_currency = tmp_ticker_list.tradeCurrency
	AND   businessdate in (select businessdate from invdb.inv_date_table)
	GROUP BY daily.ticker, daily.dest_currency; 
	
	SELECT daily.ticker,
		   tmp_ticker_list.tradeCurrency,
           daily.base_currency as settleCurrency,
		   businessdate,
		   IFNULL(daily_return,0) as daily_return
	FROM 
		 tmp_ticker_list,
		 `rbsa`.`rbsa_daily` daily,
		 (SELECT max(min_businessdate) as min_date, min(max_businessdate) as max_date from tmp_historical_dates) as tmp
	WHERE businessdate >= tmp.min_date
	AND   businessdate <= tmp.max_date
	AND   daily.ticker = tmp_ticker_list.ticker
    AND   daily.dest_currency = tmp_ticker_list.tradeCurrency
	AND   businessdate in (select businessdate from invdb.inv_date_table)
	ORDER BY 1, 2, 3 desc;
	

END$$
DELIMITER ;




