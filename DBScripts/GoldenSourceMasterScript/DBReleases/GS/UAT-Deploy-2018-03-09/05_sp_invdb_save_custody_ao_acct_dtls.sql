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

