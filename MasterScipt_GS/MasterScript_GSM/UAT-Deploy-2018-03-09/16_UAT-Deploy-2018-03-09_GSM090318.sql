
/* 01.ap.additional.sql090318_abhang*/

UPDATE `invdb`.`web_site_info` SET `value`='/javax.faces.resource/images/uobFavicon.ico.xhtml?ln=uob' WHERE `url`='utraderobo' and`name`='WEB.FAVICONLOGO';
UPDATE `invdb`.`web_site_info` SET `value`='/javax.faces.resource/images/favicon/uobFavicon.ico.xhtml?ln=uob' WHERE `url`='utraderobo' and`name`='WEB.FAVICONLOGO';

UPDATE `invdb`.`web_site_info` SET `name`='EMAIL.WELCOME.SUBJECT', `value`='Welcome-UOB Kay Hian' WHERE `url`='utraderobo' and`name`='SUBJECT.EMAIL.WELCOME';
UPDATE `invdb`.`web_site_info` SET `name`='EMAIL.RESET.SUBJECT', `value`='Reset Password-UOB Kay Hian' WHERE `url`='utraderobo' and`name`='SUBJECT.EMAIL.RESET';
UPDATE `invdb`.`web_site_info` SET `name`='EMAIL.LOCKED.SUBJECT', `value`='Account Locked-UOB Kay Hian' WHERE `url`='utraderobo' and`name`='SUBJECT.EMAIL.LOCKED';
UPDATE `invdb`.`web_site_info` SET `name`='EMAIL.ACTIVATE.SUBJECT' WHERE `url`='utraderobo' and`name`='SUBJECT.EMAIL.ACTIVATE';


/* 02.ap.user_advisor_info.sql090318_abhang*/

ALTER TABLE `invdb`.`user_advisor_info` 
ADD COLUMN `displayRep` VARCHAR(20) NULL AFTER `companyname`;


UPDATE `invdb`.`user_advisor_info` SET `displayRep`='436', `displayName`='Paul Devierno' WHERE `logonid`='4';




UPDATE `service`.`pdf_file_rules` SET `dbColumn`='displayRepName' WHERE `fileId`='UOB_ACCT_OPEN_EXISTING_USER' and`dataField`='salesPersonName';
UPDATE `service`.`pdf_file_rules` SET `dbColumn`='displayRepName' WHERE `fileId`='UOB_ACCT_OPEN_NEW_USER' and`dataField`='salesPersonName';
UPDATE `service`.`pdf_file_rules` SET `dbColumn`='displayRep' WHERE `fileId`='UOB_ACCT_OPEN_EXISTING_USER' and`dataField`='repId';
UPDATE `service`.`pdf_file_rules` SET `dbColumn`='displayRep' WHERE `fileId`='UOB_ACCT_OPEN_NEW_USER' and`dataField`='repId';



UPDATE `invdb`.`invessence_switch` SET `name`='SETT_CURRENCY', `description`='Settlment Currency' WHERE `name`='SETT_CURRUNCY';





USE `invdb`;
DROP procedure IF EXISTS `spao_uob_fetch_data`;

DELIMITER $$
USE `invdb`$$
CREATE  PROCEDURE `spao_uob_fetch_data`(`p_acctnum` bigint(20))
BEGIN

declare v_acc_deta_count int;

/* select count(1) into v_acc_deta_count from invdb.ao_acct_details where acctnum=p_acctnum;
if(v_acc_deta_count=0)then
	select * from invdb.ao_acct_details where 1=2;
else*/

select acctnum, clientAccountID, repId, uai.displayName displayRepName, ifnull(uai.displayRep,rep)displayRep, caseNumber, advisorId, acctTypeId,
			IF((ISNULL(acctTypeId)
                OR (acctTypeId = '')),
            NULL,
            (SELECT 
                    dc_m_lookup.value
                FROM
                    dc_m_lookup
                WHERE
                    (dc_m_lookup.lookupCode = acctTypeId))) AS acctTypeVal,
                   (select date_format(created,'%d/%m/%Y') from ao_requests where reqId=(select max(reqid) from ao_requests where acctnum=p_acctnum)) as dateOfApplication
                    from invdb.ao_acct_details ao_ad , invdb.user_advisor_info uai where ao_ad.acctnum=p_acctnum and uai.logonid=ao_ad.advisorId;
/*

	select acctnum, clientAccountID, repId, caseNumber, advisorId, acctTypeId,
			IF((ISNULL(acctTypeId)
                OR (acctTypeId = '')),
            NULL,
            (SELECT 
                    dc_m_lookup.value
                FROM
                    dc_m_lookup
                WHERE
                    (dc_m_lookup.lookupCode = acctTypeId))) AS acctTypeVal,
                   (select date_format(created,'%d/%m/%Y') from ao_requests where reqId=(select max(reqid) from ao_requests where acctnum=p_acctnum)) as dateOfApplication
                    from invdb.ao_acct_details where acctnum=p_acctnum;*/
    select acctnum, name, case when(name ='existingTradeAcctNumber') then LPAD(value,7,'0') else value end as value from ao_acct_misc_details where acctnum=p_acctnum;
-- end if;

select acctnum, acctOwnerId, title, firstName, midInitial, lastName, fullName, gender, dob,
date_format(STR_TO_DATE(dob, '%m-%d-%Y'),'%d/%m/%Y') dobDDMMYYYY,
countryOfBirth, emailAddress, physicalAddressStreet1, physicalAddressStreet2, physicalAddressStreet3, physicalAddressStreet4, physicalAddressCity, physicalAddressState, physicalAddressZipCode, physicalAddressCountry, mailingAddressStreet1, mailingAddressStreet2, mailingAddressStreet3, mailingAddressStreet4, mailingAddressCity, mailingAddressState, mailingAddressZipCode, mailingAddressCountry, created, createdBy, updated, updatedBy, ownership 
from invdb.ao_owners_details where acctnum=p_acctnum;

select * from invdb.ao_owners_contact_details where acctnum=p_acctnum;
select * from ao_owners_finacial_details where acctnum=p_acctnum;
select * from ao_owners_regularity_details where acctnum=p_acctnum; 
select * from ao_owners_misc_details where acctnum=p_acctnum; 
select * from ao_owners_indentification_details where acctnum=p_acctnum;
select * from ao_owners_citizenship_details where acctnum=p_acctnum;
select * from ao_owners_employment_details where acctnum=p_acctnum;
select * from ao_owners_sets_misc_details where acctnum=p_acctnum order by acctnum, acctOwnerId, category, id, name;
select * from ao_owners_bank_details where acctnum=p_acctnum;  

END$$

DELIMITER ;


/* 03.ap.transaction_file.sql090318_abhang*/

UPDATE `service`.`file_details` SET `parentPostDBProcess`='temp.sp_trade_process_both_update', `postDBProcess`='' WHERE `vendor`='UOB' and`fileName`='CLNTORD' and`processId`='DOWD1' and`seqNo`='1';
UPDATE `service`.`file_details` SET `parentPostDBProcess`='temp.sp_trade_process_both_update' WHERE `vendor`='UOB' and`fileName`='CLNTORDISIN' and`processId`='DOWD1' and`seqNo`='2';


update service.file_process_rules set seqNo= seqNo+2 where fileId in('UOB_ORDER_PROCESSING_FILE') and seqNo>2 order by fileId, seqNo; 


INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE', 'SEDOL', 'Sedol', '3', '23', '26', '4', 'TEXT', '0', 'Y', ',', 'Left', 'sedol', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE', 'RIC', 'Ric', '4', '23', '26', '4', 'TEXT', '0', 'Y', ',', 'Left', 'ric', 'Y', 'N');


update service.file_process_rules set seqNo= seqNo+2 where fileId in('UOB_ORDER_PROCESSING_FILE_ISIN_WISE') and seqNo>1 order by fileId, seqNo; 

INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE_ISIN_WISE', 'SEDOL', 'Sedol', '2', '23', '26', '4', 'TEXT', '0', 'Y', ',', 'Left', 'sedol', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE_ISIN_WISE', 'RIC', 'Ric', '3', '23', '26', '4', 'TEXT', '0', 'Y', ',', 'Left', 'ric', 'Y', 'N');



/* 03_sp_update_advisor_risk_master.sql090318_sagar*/

UPDATE `invdb`.`advisor_risk_master` SET `defaultValue`='KayHian.Without.Sing' WHERE `advisor`='UOB' and`sortorder`='15' and`key`='THEME';



/* 04.ap.sp_trade_process_both.sql090318_sagar*/

USE `temp`;
DROP procedure IF EXISTS `sp_trade_process_both`;

DELIMITER $$
USE `temp`$$
CREATE  PROCEDURE `sp_trade_process_both`()
BEGIN

declare v_tradeDate varchar(10);
select value into v_tradeDate from invdb.invessence_switch where name='BUSINESS_DATE';

/*update invdb.user_trade_log utl
  set utl.tradeStatus='P'
  WHERE utl.tradeStatus = 'S'
  and utl.qty<>0
  AND utl.investmentamount<>0;*/

SELECT 
    utl.acctnum,
    utl.clientAccountID,
    utl.tradeStatus,
    -- DATE_FORMAT(utl.tradedate,'%Y%m%d')tradedate,
    v_tradeDate tradedate,
    ifnull(sm.ISIN,utl.ticker)ticker,
    ifnull(sm.sedol,utl.ticker)sedol,
    -- utl.ticker,
    ifnull(sm.ric,utl.ticker) ric,
    case utl.action when 'BUY' then 'B'
    when 'SELL' then 'S'
    else 'N'
    end action,
    utl.sectype,
    -- utl.exchange,
    'SGX' exchange,
    utl.currency,
    utl.timeinforce,
    ABS(utl.qty)qty,
    utl.tradeprice,
    abs(utl.investmentamount)investmentamount,
    utl.tradeID,
    utl.ordertype,
    utl.confirmationID,
    utl.firmAccount,
    utl.created,
    utl.lastupdated,
    daod.email
FROM
    invdb.user_trade_log utl,
    invdb.ext_acct_info daod,
    invdb.sec_master sm
WHERE
    utl.acctnum = daod.acctnum
        AND utl.tradeStatus in( 'P', 'I')
        AND utl.ticker not in('Cash')
        AND daod.acctnum = daod.acctnum
        and utl.qty<>0
        AND utl.investmentamount<>0
        and sm.ticker=utl.ticker
	ORDER BY acctnum,ticker,action;
	update invdb.user_trade_log utl
  set utl.tradeStatus='I'
  WHERE utl.tradeStatus = 'P'
  and utl.qty<>0
  AND utl.investmentamount<>0;

END$$

DELIMITER ;

/* 04_sp_update_invdb_web_site_info.sql*/

UPDATE `invdb`.`web_site_info` SET `value`='KayHian.Without.Sing' WHERE `url`='utraderobo' and`name`='DEFAULT.MODEL';

/* 05.ap.sp_trade_process_isin_wise.sql*/

USE `temp`;
DROP procedure IF EXISTS `sp_trade_process_isin_wise`;

DELIMITER $$
USE `temp`$$
CREATE  PROCEDURE `sp_trade_process_isin_wise`()
BEGIN

declare v_tradeDate varchar(10);
select value into v_tradeDate from invdb.invessence_switch where name='BUSINESS_DATE';

select ifnull(sm.ISIN,a.ticker)ticker,
    ifnull(sm.sedol,a.ticker)sedol,
    -- utl.ticker,
    ifnull(sm.ric,a.ticker) ric, sum(a.buyQty)buyQty, sum(a.sellQty)sellQty, sum(a.buyQty-a.sellQty)netQty, v_tradeDate tradeDate from 
(SELECT  utl.ticker,
   -- DATE_FORMAT(utl.tradedate,'%Y%m%d')tradedate,
    ABS(sum(utl.qty))buyQty, ''sellQty
FROM
    invdb.user_trade_log utl,
    invdb.ext_acct_info daod
WHERE
    utl.acctnum = daod.acctnum
        AND utl.tradeStatus in( 'P', 'I')
        AND utl.action = 'BUY'
        and utl.qty<>0
        AND utl.investmentamount<>0
        group by ticker -- , tradedate
        
        union all
        SELECT  
    utl.ticker,
    -- DATE_FORMAT(utl.tradedate,'%Y%m%d')tradedate,
    ''buyQty, ABS(sum(utl.qty))sellQty
FROM
    invdb.user_trade_log utl,
    invdb.ext_acct_info daod
WHERE
    utl.acctnum = daod.acctnum
        AND utl.tradeStatus in( 'P', 'I')
        AND utl.action = 'SELL'
        and utl.qty<>0
        AND utl.investmentamount<>0
        group by ticker -- , tradedate
        )a, invdb.sec_master sm
        where sm.ticker=a.ticker
        and a.ticker not in('Cash')
        group by a.ticker
	ORDER BY a.ticker;


END$$

DELIMITER ;

/* 05_sp_invdb_save_custody_ao_acct_dtls.sql*/

USE `invdb`;
DROP procedure IF EXISTS `save_custody_ao_acct_dtls`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_custody_ao_acct_dtls`(
 in p_acctnum bigint,
 in p_clientAccountID varchar(45),
 in p_repId varchar(45),
 in p_caseNumber varchar(10),
 in p_advisorId varchar(45),
 in p_acctTypeId varchar(45),
 in p_logonId varchar(45))
begin
 
 insert into invdb.ao_acct_details(
 acctnum,
 repId,
 caseNumber,
 advisorId,
 acctTypeId,
 created,
 createdBy)
 select 
 	p_acctnum,
 	p_repId,
 	p_caseNumber,
 	p_advisorId,
 	p_acctTypeId,
 	now(),
 	p_logonId
 ON DUPLICATE KEY UPDATE 
 	acctnum=p_acctnum,
 	repId=p_repId,
 	caseNumber=p_caseNumber,
 	advisorId=p_advisorId,
 	acctTypeId=p_acctTypeId,
 	updated=now(),
 	updatedBy=p_logonId;
    
   update invdb.user_trade_profile set acctType=CASE 
 						WHEN (p_acctTypeId = 'ACINDIV') THEN 'INDIVIDUAL'
 						WHEN (p_acctTypeId = 'ACJOINT') THEN 'JOINT' 						
 						ELSE null end where acctnum=p_acctnum;
 /*insert into invdb.ao_acct_details(
 acctnum,
 repId,
 caseNumber,
 advisorId,
 acctTypeId,
 created,
 createdBy)
 select 
 	p_acctnum,
 	p_repId,
 	p_caseNumber,
 	p_advisorId,
 	p_acctTypeId,
 	now(),
 	p_logonId
 ON DUPLICATE KEY UPDATE 
 	acctnum=p_acctnum,
 	repId=p_repId,
 	caseNumber=p_caseNumber,
 	advisorId=p_advisorId,
 	acctTypeId=p_acctTypeId,
 	updated=now(),
 	updatedBy=p_logonId;*/
 end$$

DELIMITER ;

/* 06.ap.sp_trade_process_both_update.sql*/

USE `temp`;
DROP procedure IF EXISTS `sp_trade_process_both_update`;

DELIMITER $$
USE `temp`$$
CREATE  PROCEDURE `sp_trade_process_both_update`()
BEGIN

update invdb.user_trade_log utl
set utl.tradeStatus='S'
WHERE utl.tradeStatus = 'I';

END$$

DELIMITER ;

/*09.pm.turnoff_without_sing_theme.sql130318_pmehta*/

UPDATE `invdb`.`advisor_risk_master` 
	SET `remarks`='Default Theme'
		, defaultValue = 'KayHian.Without.Sing'
    WHERE `advisor`='UOB'
    and `key`='THEME';

DELETE FROM `invdb`.`advisor_risk_master` 
where `key` in ('THEME-1', 'THEME-2');

INSERT INTO `invdb`.`advisor_risk_master` 
(`advisor`, `sortorder`, `key`, `displayName`, `defaultValue`, `dataType`, `displayOnStart`, `displayAdvisor`, `saveforUser`, `remarks`) 
VALUES 
 ('UOB', '801', 'THEME-1', 'Theme#1', 'KayHian.Without.Sing', 'T', '0', '0', '0', 'Theme')
,('UOB', '802', 'THEME-2', 'Theme#2', 'KayHian.Without.Sing', 'T', '0', '0', '0', 'Theme');

/* 10.pm.change_asset_colors.sql130318_pmehta*/

UPDATE `invdb`.`sec_assetclass_group` SET `color`='#e97922' WHERE `theme`='KayHian.With.Sing' and`assetclass`='Commodity';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#e97922' WHERE `theme`='KayHian.Without.Sing' and`assetclass`='Commodity';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#439b3b' WHERE `theme`='KayHian.With.Sing' and`assetclass`='Fixed Income';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#439b3b' WHERE `theme`='KayHian.Without.Sing' and`assetclass`='Fixed Income';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#f7eb31' WHERE `theme`='KayHian.Without.Sing' and`assetclass`='Cash';
UPDATE `invdb`.`sec_assetclass_group` SET `color`='#f7eb31' WHERE `theme`='KayHian.With.Sing' and`assetclass`='Cash';

/*10.pm.save_executedTrades.sql210318_pmehta*/

DROP PROCEDURE IF EXISTS `invdb`.`save_executedTrades`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`save_executedTrades`(
	p_acctnum 	BIGINT(20)
)
BEGIN
	DECLARE today	VARCHAR(10);
	begin
        DELETE FROM `invdb`.`user_trade_log`
        WHERE `user_trade_log`.`acctnum` = p_acctnum
        AND `user_trade_log`.`tradeStatus` = 'P';
        
		INSERT INTO `invdb`.`user_trade_log`
		(`acctnum`,
		`clientAccountID`,
		`tradeStatus`,
		`tradedate`,
		`ticker`,
		`action`,
		`sectype`,
		`exchange`,
		`currency`,
		`timeinforce`,
		`qty`,
		`tradeprice`,
		`investmentamount`,
		`tradeID`,
		`ordertype`,
		`confirmationID`,
		`firmAccount`,
		`created`,
		`lastupdated`)
        SELECT 
			`trade_process_identifier`.`acctnum`,
            `ext_acct_info`.`clientAccountID`,
            'P' as tradeStatus,
            ifnull(tradeDate,DATE_FORMAT(now(),'%Y%m%d')) as tradedate,
            `rebal`.`newTicker`,
            CASE WHEN (`rebal`.`settleNewQty` < 0) THEN 'SELL'
				 ELSE 'BUY'
			END as `action`,
            null as `sectype`,
            `rebal`.`exchangeRate`,
            `rebal`.`settleCurrency` as `currency`,
            'DAY' as `timeinforce`,
            ABS(`rebal`.`settleNewQty`) as `qty`,
            `rebal`.`settleNewPrice` as `tradeprice`,
            ABS(`rebal`.`settleNewValue`) as `investmentamount`,
            CONCAT(`rebal`.`newTicker`,DATE_FORMAT(now(),'%Y%m%d%H%i%s')) as `tradeID`,
            'LMT' as `ordertype`,
            null as `confirmationID`,
            null as `firmAccount`,
            now() as `created`,
            null as `lastupdated`
		FROM `trade_process_identifier`
        INNER JOIN `ext_acct_info`
        ON (`ext_acct_info`.`acctnum` = `trade_process_identifier`.`acctnum`
			AND `ext_acct_info`.`status` in ('A'))
		INNER JOIN `user_trade_preprocess` as `rebal`
        ON (`rebal`.`acctnum` = `trade_process_identifier`.`acctnum`)
        INNER JOIN `sec_master`
        ON (`sec_master`.`ticker` = `rebal`.`newTicker`)
        WHERE IFNULL(`trade_process_identifier`.`processStatus`,'N') in ('R')
        AND  `trade_process_identifier`.`acctnum` = p_acctnum
    	;

    end;
    
    begin
		update trade_process_identifier
			set tradeStatus = 'V', processStatus = 'S'
		where acctnum = p_acctnum;
    end;
END$$
DELIMITER ;

/* 11.pm.reset_initialAmt.sql210318_pmehta*/

UPDATE `invdb`.`advisor_risk_master` SET `defaultValue`='5000' WHERE `advisor`='UOB' and`sortorder`='100' and`key`='INITIALINVESTMENT';
UPDATE `invdb`.`advisor_risk_master` SET `defaultValue`='5000' WHERE `advisor`='UOB' and`sortorder`='600' and`key`='MININTITIALRQMT';
UPDATE `invdb`.`advisor_risk_master` SET `defaultValue`='500' WHERE `advisor`='UOB' and`sortorder`='610' and`key`='MIN2NDINTIALRQMT';
