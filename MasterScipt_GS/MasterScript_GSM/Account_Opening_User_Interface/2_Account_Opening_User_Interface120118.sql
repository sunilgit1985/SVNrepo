
/*1_sp_invdb_save_custody_ao_acct_dtls.sql120118_Sagar*/

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
 end$$

DELIMITER ;

/*2_sp_invdb_save_custody_ao_owner_acct_hldr_dtls.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `save_custody_ao_owner_acct_hldr_dtls`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_custody_ao_owner_acct_hldr_dtls`(
in p_acctnum bigint,
in p_acctOwnerId int,
in p_title varchar(45),
in p_fullName varchar(100),
in p_gender varchar(10),
in p_dob varchar(45),
in p_countryOfBirth varchar(45),
in p_emailAddress varchar(45),
in p_ownership varchar(45),
in p_logonId varchar(45))
begin

insert into invdb.ao_owners_details(
	acctnum,
	acctOwnerId,
	title,
	fullName,
	gender,
	dob,
	countryOfBirth,
	emailAddress,
	created,
	createdBy,
	ownership)
select 
	p_acctnum,
	p_acctOwnerId,
	p_title,
	p_fullName,
	p_gender,
	p_dob,
	p_countryOfBirth,
	p_emailAddress,
	now(),
	p_logonId,
	p_ownership
ON DUPLICATE KEY UPDATE 
	acctnum=p_acctnum,
	acctOwnerId=p_acctOwnerId,
	title=p_title,
	fullName=p_fullName,
	gender=p_gender,
	dob=p_dob,
	countryOfBirth=p_countryOfBirth,
	emailAddress=p_emailAddress,
	updated=now(),
	updatedBy=p_logonId,
	ownership=p_ownership;
end$$

DELIMITER ;

/* 3_sp_invdb_save_ao_owner_additional_dtls.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `save_ao_owner_additional_dtls`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_ao_owner_additional_dtls`(in p_acctnum bigint,in p_acctOwnerId int,in p_name varchar(45),in p_value varchar(45),in p_table varchar(100))
BEGIN
declare stmt3 varchar(2000);

SET @t1 =CONCAT("delete FROM ",p_table," where acctnum=",p_acctnum," and acctOwnerId=",p_acctOwnerId," and name='",p_name,"';");
 PREPARE stmt3 FROM @t1;
 -- select @t1;
 EXECUTE stmt3;
 DEALLOCATE PREPARE stmt3;
 
 if(p_value is not null) then
SET @t1 =CONCAT("insert into ",p_table," (acctnum,acctOwnerId,name,value)select ",p_acctnum,",",p_acctOwnerId,",'",p_name,"','",p_value,"';");
  PREPARE stmt3 FROM @t1;
 -- select @t1;
 EXECUTE stmt3;
 DEALLOCATE PREPARE stmt3;
 end if;
 
END$$

DELIMITER ;

/* 4_sp_invdb_save_custody_ao_owner_emp_dtls.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `save_custody_ao_owner_emp_dtls`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_custody_ao_owner_emp_dtls`(
 in p_acctnum int ,
 in p_acctOwnerId int ,
 in p_emplId int ,
 in p_emplTypeId varchar(45) ,
 in p_sourceOfIncome varchar(100) ,
 in p_employerName varchar(45) ,
 in p_occupation varchar(45) ,
 in p_typeOfBusiness varchar(45) ,
 in p_employerStreetAddress1 varchar(100) ,
 in p_employerStreetAddress2 varchar(100) ,
 in p_employerStreetAddress3 varchar(100) ,
 in p_employerStreetAddress4 varchar(100) ,
 in p_employerCity varchar(45) ,
 in p_employerState varchar(45) ,
 in p_employerZipCode varchar(45) ,
 in p_employerZipCountry varchar(45) ,
 in p_fromDate varchar(10) ,
 in p_toDate varchar(10) ,
 in p_logonId varchar(45) )
begin
 
 insert into invdb.ao_owners_employment_details(
 	acctnum,
 	acctOwnerId,
 	emplId,
 	emplTypeId,
 	sourceOfIncome,
 	employerName,
 	occupation,
 	typeOfBusiness,
 	employerStreetAddress1,
 	employerStreetAddress2,
 	employerStreetAddress3,
 	employerStreetAddress4,
 	employerCity,
 	employerState,
 	employerZipCode,
 	employerZipCountry,
 	fromDate,
 	toDate,
 	createdBy,
 	created
 )
 select 
 	p_acctnum ,
 	p_acctOwnerId ,
 	p_emplId ,
 	p_emplTypeId ,
 	p_sourceOfIncome ,
 	p_employerName ,
 	p_occupation ,
 	p_typeOfBusiness ,
 	p_employerStreetAddress1 ,
 	p_employerStreetAddress2 ,
 	p_employerStreetAddress3 ,
 	p_employerStreetAddress4 ,
 	p_employerCity ,
 	p_employerState ,
 	p_employerZipCode ,
 	p_employerZipCountry ,
 	p_fromDate ,
 	p_toDate ,
 	p_logonId,
 	now()
 ON DUPLICATE KEY UPDATE 
 	acctnum = p_acctnum,
 	acctOwnerId = p_acctOwnerId,
 	emplId = p_emplId,
 	emplTypeId = p_emplTypeId,
 	sourceOfIncome = p_sourceOfIncome,
 	employerName = p_employerName,
 	occupation = p_occupation,
 	typeOfBusiness = p_typeOfBusiness,
 	employerStreetAddress1 = p_employerStreetAddress1,
 	employerStreetAddress2 = p_employerStreetAddress2,
 	employerStreetAddress3 = p_employerStreetAddress3,
 	employerStreetAddress4 = p_employerStreetAddress4,
 	employerCity = p_employerCity,
 	employerState = p_employerState,
 	employerZipCode = p_employerZipCode,
 	employerZipCountry = p_employerZipCountry,
 	fromDate = p_fromDate,
 	toDate = p_toDate,
 	updated=now(),
 	updatedBy=p_logonId;
 end$$

DELIMITER ;

/* 5_sp_invdb_save_custody_ao_owner_acct_addr_dtls.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `save_custody_ao_owner_acct_addr_dtls`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_custody_ao_owner_acct_addr_dtls`(
 in p_acctnum bigint,
 in p_acctOwnerId int,
 in p_physicalAddressStreet1 varchar(100) ,
 in p_physicalAddressStreet2 varchar(100) ,
 in p_physicalAddressStreet3 varchar(100) ,
 in p_physicalAddressStreet4 varchar(100) ,
 in p_physicalAddressCity varchar(45) ,
 in p_physicalAddressState varchar(45) ,
 in p_physicalAddressZipCode varchar(45) ,
 in p_physicalAddressCountry varchar(45) ,
 in p_mailingAddressStreet1 varchar(100) ,
 in p_mailingAddressStreet2 varchar(100) ,
 in p_mailingAddressStreet3 varchar(100) ,
 in p_mailingAddressStreet4 varchar(100) ,
 in p_mailingAddressCity varchar(45) ,
 in p_mailingAddressState varchar(45) ,
 in p_mailingAddressZipCode varchar(45) ,
 in p_mailingAddressCountry varchar(45) ,
 in p_logonId varchar(45))
begin
 update invdb.ao_owners_details set
 physicalAddressStreet1 = p_physicalAddressStreet1,
 physicalAddressStreet2 = p_physicalAddressStreet2,
 physicalAddressStreet3 = p_physicalAddressStreet3,
 physicalAddressStreet4 = p_physicalAddressStreet4,
 physicalAddressCity = p_physicalAddressCity,
 physicalAddressState = p_physicalAddressState,
 physicalAddressZipCode = p_physicalAddressZipCode,
 physicalAddressCountry = p_physicalAddressCountry,
 mailingAddressStreet1 = p_mailingAddressStreet1,
 mailingAddressStreet2 = p_mailingAddressStreet2,
 mailingAddressStreet3 = p_mailingAddressStreet3,
 mailingAddressStreet4 = p_mailingAddressStreet4,
 mailingAddressCity = p_mailingAddressCity,
 mailingAddressState = p_mailingAddressState,
 mailingAddressZipCode = p_mailingAddressZipCode,
 mailingAddressCountry = p_mailingAddressCountry,
 updatedBy=p_logonId,
 updated=now()
 where 
 acctnum=p_acctnum and 
 acctOwnerId=p_acctOwnerId;
 end$$

DELIMITER ;

/* 6_sp_invdb_save_custody_ao_owner_acct_set_misc_dtls.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `save_custody_ao_owner_acct_set_misc_dtls`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_custody_ao_owner_acct_set_misc_dtls`(
in p_acctnum bigint,
in p_acctOwnerId int,
in p_category varchar(45),
in p_id int,
in p_name varchar(45),
in p_value varchar(45)
)
begin
insert into invdb.ao_owners_sets_misc_details(
acctnum,
acctOwnerId,
category,
id,
name,
value
)
select 
p_acctnum,
p_acctOwnerId,
p_category,
p_id,
p_name,
p_value;
end$$

DELIMITER ;

/* 7_sp_invdb_del_custody_ao_owner_acct_set_misc_dtls.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `del_custody_ao_owner_acct_set_misc_dtls`;

DELIMITER $$
USE `invdb`$$
CREATE  PROCEDURE `del_custody_ao_owner_acct_set_misc_dtls`(
in p_acctnum bigint,
in p_acctOwnerId int,
in p_category varchar(45)
)
begin
	delete from  invdb.ao_owners_sets_misc_details where acctnum=p_acctnum and acctOwnerId=p_acctOwnerId and category=p_category;
end$$

DELIMITER ;

/* 8_sp_invdb_save_ao_acct_additional_dtls.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `save_ao_acct_additional_dtls`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_ao_acct_additional_dtls`(in p_acctnum bigint,in p_name varchar(45),in p_value varchar(45),in p_table varchar(100))
BEGIN
 declare stmt3 varchar(2000);
 
 SET @t1 =CONCAT("delete FROM ",p_table," where acctnum=",p_acctnum," and name='",p_name,"';");
  PREPARE stmt3 FROM @t1;
  -- select @t1;
  EXECUTE stmt3;
  DEALLOCATE PREPARE stmt3;
  
  if(p_value is not null) then
 SET @t1 =CONCAT("insert into ",p_table," (acctnum,name,value)select ",p_acctnum,",'",p_name,"','",p_value,"';");
   PREPARE stmt3 FROM @t1;
  -- select @t1;
  EXECUTE stmt3;
  DEALLOCATE PREPARE stmt3;
  end if;
  
 END$$

DELIMITER ;

/* 9_sp_invdb_sp_advisor_base_rep_lst.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `sp_advisor_base_rep_lst`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sp_advisor_base_rep_lst`(in p_advisor varchar(20))
begin 

select logonid, advisor,rep,accttype,companyname, displayName, logo, advisor_css from invdb.user_advisor_info where advisor=p_advisor;

end$$

DELIMITER ;

/* 10_so_invdb_sel_custody_file_master_list.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `sel_custody_file_master_list`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sel_custody_file_master_list`(in p_product varchar(45), in p_acctnum bigint,in p_reqType varchar(45),in p_requestFor varchar(15))
begin 
  
  declare p_nationality varchar(45);
  declare p_nationalitySpfy varchar(45);
  declare p_diffAddProof varchar(45);
  
  if(p_requestFor='Upload') then
 	 if(p_reqType='ACCT_OPEN_NEW_USER') then
 		select value into p_nationality from ao_owners_citizenship_details where acctnum=p_acctnum and name='nationality';
 		select value into p_nationalitySpfy from ao_owners_citizenship_details where acctnum=p_acctnum and name='nationalitySpecify';
         select value into p_diffAddProof from  ao_owners_misc_details  where acctnum=p_acctnum and name='mailAddressSameAsPhysical';
 		
 		if(LOWER(p_nationality)='singaporean' || LOWER(p_nationality)='singapore pr'  ) then 
 			select product,action,subaction,requestFor,seqno,fileName,fileLabel,reqType,fileExtensions from invdb.custody_file_master
 			where isActive='Y' and product=p_product and action=p_reqType and 
             (subaction='NRIC' or subaction='Res_Proof' or subaction='BNK_STMT' or (CASE WHEN LOWER(p_diffAddProof)='NO' THEN subaction='Add_Res_Proof' end)) and requestFor='Upload' order by seqno; 
 		elseif( LOWER(p_nationalitySpfy)='malaysia') then
 			select product,action,subaction,requestFor,seqno,fileName,fileLabel,reqType,fileExtensions from invdb.custody_file_master
 			where isActive='Y' and product=p_product and action=p_reqType and 
             (subaction='MYKAD' or subaction='Res_Proof' or subaction='BNK_STMT' or (CASE WHEN LOWER(p_diffAddProof)='NO' THEN subaction='Add_Res_Proof' end)) and requestFor='Upload' order by seqno; 
 		else  
 			select product,action,subaction,requestFor,seqno,fileName,fileLabel,reqType,fileExtensions from invdb.custody_file_master
 			where isActive='Y' and product=p_product and action=p_reqType and 
             (subaction='Passport' or subaction='Res_Proof' or subaction='BNK_STMT' or (CASE WHEN LOWER(p_diffAddProof)='NO' THEN subaction='Add_Res_Proof' end)) and requestFor='Upload' order by seqno; 
             
 		end if; 
 	end if;
 
 	 if(p_reqType='ACCT_OPEN_EXISTING_USER') then 
 			select product,action,subaction,requestFor,seqno,fileName,fileLabel,reqType,fileExtensions from invdb.custody_file_master
 			where isActive='Y' and product=p_product and action=p_reqType and requestFor='Upload' order by seqno; 
 	 end if;
   
   end if;
   
  if(p_requestFor='Download') then
 	select product,action,subaction,requestFor,seqno,fileName,fileLabel,reqType,fileExtensions 
     from invdb.custody_file_master
 	where isActive='Y' and product=p_product and action=p_reqType and requestFor='Download'; 
  end if;
 end$$

DELIMITER ;

/* 11_sp_invdb_save_custody_file_rqst.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `save_custody_file_rqst`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_custody_file_rqst`(
 in p_reqId bigint,
 in p_acctnum bigint,
 in p_product varchar(45),
 in p_action varchar(45),
 in p_requestFor varchar(10),
 in p_fileName varchar(45),
 in p_filePath varchar(45),
 in p_reqType varchar(45),
 in p_logonId varchar(45),
 in p_seqno int)
begin
 update invdb.custody_file_requests set status='I' where action<>p_action and acctnum=p_acctnum;
 
 insert into invdb.custody_file_requests(
reqId, product, acctnum, action, requestFor, seqno, fileName, filePath, reqType,status, createdBy, created)
 select 
 	p_reqId, p_product, p_acctnum, p_action, p_requestFor, p_seqno, p_fileName, p_filePath, p_reqType,'A',p_logonId,now()
 ON DUPLICATE KEY UPDATE 
 	reqId=p_reqId, product=p_product, acctnum=p_acctnum, action=p_action, requestFor=p_requestFor, seqno=p_seqno, 
    fileName=p_fileName, filePath=p_filePath, reqType=p_reqType,status='A',
 	updated=now(),
 	updatedBy=p_logonId;    
 end$$

DELIMITER ;



/* 12_sp_invdb_sel_custody_file_rqst_dtls.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `sel_custody_file_rqst_dtls`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sel_custody_file_rqst_dtls`(in p_product varchar(45),in p_acctnum bigint,in p_action varchar(45))
begin 
select reqId,product, acctnum, action, requestFor, seqno, fileName, filePath, reqType 
from invdb.custody_file_requests
where product=p_product and acctnum=p_acctnum and action=p_action and status='A';
end$$

DELIMITER ;


/* 13_sp_invdb_save_ao_document_request.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `save_ao_document_request`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_ao_document_request`(in p_product varchar(50),in p_acctnum bigint(20),in p_advisorid int,in p_reqType varchar(45))
begin
declare p_insrtId int;
insert into invdb.ao_requests (product,acctnum,advisorid,eventNum,reqType,reqHeading,status,action,subaction,created)
select p_product,p_acctnum,p_advisorid,1,reqType,envelopeHeading,'A',action,subaction,now() from invdb.adv_request_document_mappings where reqType=p_reqType;

select LAST_INSERT_ID() into p_insrtId;


insert into invdb.ao_requests_final (refReqId,product,acctnum,advisorid,eventNum,reqType,seqno,reqHeading,status,formType,created)
select p_insrtId,p_product,p_acctnum,p_advisorid,1,ardm.reqType,seqno,reqHeading,'A',formType,now()
from invdb.ao_requests ar
join invdb.adv_request_document_mappings ardm on(ar.action=ardm.action )
where ar.reqId= p_insrtId and (ardm.subaction='DEFAULT' or ardm.subaction=p_reqType) and acctnum=p_acctnum and templateId='UOBInternal';

select concat(p_insrtId,',1') as 'EventNo';

end$$

DELIMITER ;



/* 14_sp_invdb_save_custody_ao_owner_acct_hldr_bnk_dtls.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `save_custody_ao_owner_acct_hldr_bnk_dtls`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_custody_ao_owner_acct_hldr_bnk_dtls`(
in p_acctnum bigint,
in p_acctOwnerId int,
in p_bankAccountHolderName varchar(60),
in p_bankName varchar(100),
in p_bankAccountNo varchar(45),
in p_bankAddressStreet1  varchar(100),
in p_bankAddressStreet2  varchar(100),
in p_bankAddressStreet3  varchar(100),
in p_bankAddressStreet4  varchar(100),
in p_bankAddressCity varchar(45) ,
in p_bankAddressState varchar(45) ,
in p_bankAddressZipCode varchar(45) ,
in p_bankAddressCountry varchar(45) ,
in p_swiftBic  varchar(45),
in p_correspondentBank  varchar(100),
in p_correspondentBankSwiftBic  varchar(45),
in p_logonId varchar(45))
begin

insert into invdb.ao_owners_bank_details(
	acctnum,
	acctOwnerId,
    bankAccountHolderName,
	bankName,
	bankAccountNo,
	bankAddressStreet1,
	bankAddressStreet2,
	bankAddressStreet3,
	bankAddressStreet4,
    bankAddressCity,
	bankAddressState,
	bankAddressZipCode,
	bankAddressCountry,
	swiftBic,
	correspondentBank,
	correspondentBankSwiftBic,
	created,
	createdBy)
select 
	p_acctnum,
	p_acctOwnerId,
    p_bankAccountHolderName,
	p_bankName,
	p_bankAccountNo,
	p_bankAddressStreet1,
	p_bankAddressStreet2,
	p_bankAddressStreet3,
	p_bankAddressStreet4,
    p_bankAddressCity,
	p_bankAddressState,
	p_bankAddressZipCode,
	p_bankAddressCountry,
	p_swiftBic,
	p_correspondentBank,
	p_correspondentBankSwiftBic,
	now(),
	p_logonId
ON DUPLICATE KEY UPDATE 
	acctnum=p_acctnum,
	acctOwnerId=p_acctOwnerId,
    bankAccountHolderName=p_bankAccountHolderName,
	bankName=p_bankName,
	bankAccountNo=p_bankAccountNo,
	bankAddressStreet1=p_bankAddressStreet1,
	bankAddressStreet2=p_bankAddressStreet2,
	bankAddressStreet3=p_bankAddressStreet3,
	bankAddressStreet4=p_bankAddressStreet4,
    bankAddressCity=p_bankAddressCity,
	bankAddressState=p_bankAddressState,
	bankAddressZipCode=p_bankAddressZipCode,
	bankAddressCountry=p_bankAddressCountry,
	swiftBic=p_swiftBic,
	correspondentBank=p_correspondentBank,
	correspondentBankSwiftBic=p_correspondentBankSwiftBic,
	updated=now(),
	updatedBy=p_logonId;
end$$

DELIMITER ;

/* 15_sp_invdb_sp_user_profile_manage.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `sp_user_profile_manage`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sp_user_profile_manage`(
 	IN p_acctnum   BIGINT(20),
     IN p_status   VARCHAR(1),
     IN p_logonid BIGINT(20)
 )
BEGIN
 
   DECLARE tAdvisor, tRep VARCHAR(30);
   DECLARE tLastStatus VARCHAR(1);
   DECLARE tManaged	  VARCHAR(1);
 
 	SELECT 
 		advisor,
         rep,
         status,
         managed
		INTO tAdvisor, tRep, tLastStatus, tManaged
 	FROM invdb.user_trade_profile
     WHERE acctnum = p_acctnum;
     
   BEGIN
   
 	
 	IF (IFNULL(tLastStatus,'Z') != p_status)
     THEN
     
 		
 		IF (IFNULL(tManaged,'Z') != p_status)
 		THEN
 			IF (tAdvisor is not null)
 			THEN
 				 call invdb.sp_send_advisor_notification(
 					p_acctnum, 
 					tAdvisor, 
 					tRep,
 					CASE 
 						WHEN (p_status = 'P') THEN 'PROCESSED'
 						WHEN (p_status = 'O') THEN 'OPENED'
 						WHEN (p_status = 'A') THEN 'ACTIVE'
 						WHEN (p_status = 'R') THEN 'REBALANCE'
 						WHEN (p_status = 'F') THEN 'FUNDED'
 						WHEN (p_status = 'V') THEN 'VISITOR'
 						WHEN (p_status = 'N') THEN 'NEWCLIENT'
 						WHEN (p_status = 'C') THEN 'CLOSED'
						WHEN (p_status = 'S') THEN 'PRFLCNFREQ'
 						ELSE 'NOEVENT'
 					END
 				 );
 					
                    call invdb.sp_send_user_notification(p_logonid,
 							p_acctnum, 
 							tAdvisor, 
 							tRep,
 							CASE 
 								WHEN (p_status = 'P') THEN 'PROCESSED'
 								WHEN (p_status = 'O') THEN 'OPENED'
 								WHEN (p_status = 'A') THEN 'ACTIVE'
 								WHEN (p_status = 'F') THEN 'FUNDED'
 								WHEN (p_status = 'C') THEN 'CLOSED'
                                WHEN (p_status = 'S') THEN 'PRFLCNFREQ'
 								ELSE 'NOEVENT'
 							END
 						 );
 			END IF;
 		END IF;
         
      
        
         
 		IF (IFNULL(p_status,'V') in ('A', 'O','S'))
         THEN
 			
             update user_trade_profile
 				set status = p_status,
 					 managed = 'A'
 			where acctnum = p_acctnum;
         ELSE
 			update user_trade_profile
 				set status = IFNULL(p_status,'V')
 			where acctnum = p_acctnum;
         END IF;
 
      END IF;
 
   END;
   
 END$$

DELIMITER ;

/* 16_sp_invdb_custody_file_master.sql120118_Sagar*/

-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 192.168.100.92    Database: invdb
-- ------------------------------------------------------
-- Server version	5.5.57

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `custody_file_master`
--

DROP TABLE IF EXISTS `custody_file_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custody_file_master` (
  `product` varchar(45) NOT NULL,
  `action` varchar(45) NOT NULL,
  `subaction` varchar(45) NOT NULL,
  `requestFor` varchar(10) NOT NULL COMMENT 'Upload/Download',
  `seqno` int(11) NOT NULL,
  `fileName` varchar(45) DEFAULT NULL,
  `fileLabel` varchar(255) DEFAULT NULL,
  `reqType` varchar(45) DEFAULT NULL,
  `fileExtensions` varchar(100) DEFAULT NULL,
  `isActive` varchar(5) NOT NULL COMMENT 'Y = Yes, N= No',
  PRIMARY KEY (`product`,`action`,`subaction`,`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custody_file_master`
--

LOCK TABLES `custody_file_master` WRITE;
/*!40000 ALTER TABLE `custody_file_master` DISABLE KEYS */;
INSERT INTO `custody_file_master` (`product`, `action`, `subaction`, `requestFor`, `seqno`, `fileName`, `fileLabel`, `reqType`, `fileExtensions`, `isActive`) VALUES ('UOB','ACCT_OPEN_EXISTING_USER','BNK_STMT','Upload',1,'Bank Statement','Bank Statement','BNK_STMT','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','Add_Res_Proof','Upload',5,'Mailing Resendential Proof','Proof of mailing residential address Examples: Bank Statement, Utilities Bill, Income Tax Statement, Property Tax Statement or Document issued by the Government Agency','ADD_RES_PRF','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','BNK_STMT','Upload',3,'Bank Statement','Bank Statement','BNK_STMT','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','Disclosure','Download',1,'Disclosure.pdf','Disclosure','ACCT_DSCL','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','Guide','Download',1,'Guide.pdf','Guide','ACCT_GUD','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','MasterTradeAgreement','Download',1,'MasterTradeAgreement.pdf','MasterTradeAgreement','ACCT_MSTR_AGGR','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','MYKAD','Upload',1,'Malaysian IC Front','Malaysian Identity Card(provide front copy)','NTN_PRF_FRST','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','MYKAD','Upload',2,'Malaysian IC Back','Malaysian Identity Card(provide back copy)','NTN_PRF_BCK','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','NRIC','Upload',1,'NRIC  Front','Singapore NRIC(provide front copy)','NTN_PRF_FRST','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','NRIC','Upload',2,'NRIC Back','Singapore NRIC(provide back copy)','NTN_PRF_BCK','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','Passport','Upload',1,'Passport','Passport','NTN_PRF','.jpg','Y'),('UOB','ACCT_OPEN_NEW_USER','Res_Proof','Upload',4,'Resendential Proof','Proof of residential address Examples: Bank Statement, Utilities Bill, Income Tax Statement, Property Tax Statement or Document issued by the Government Agency','RES_PRF','.jpg','Y');
/*!40000 ALTER TABLE `custody_file_master` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-12  6:08:51

/* 17_sp_invdb_custody_file_requests.sql120118_Sagar*/

-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 192.168.100.92    Database: invdb
-- ------------------------------------------------------
-- Server version	5.5.57

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `custody_file_requests`
--

DROP TABLE IF EXISTS `custody_file_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custody_file_requests` (
  `reqId` bigint(20) NOT NULL AUTO_INCREMENT,
  `product` varchar(45) NOT NULL,
  `acctnum` bigint(20) NOT NULL,
  `action` varchar(45) NOT NULL,
  `requestFor` varchar(10) DEFAULT NULL COMMENT 'Upload/Download',
  `seqno` int(11) NOT NULL,
  `fileName` varchar(45) DEFAULT NULL,
  `filePath` varchar(45) DEFAULT NULL,
  `reqType` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `createdBy` varchar(45) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `updatedBy` varchar(45) DEFAULT NULL,
  `updated` date DEFAULT NULL,
  PRIMARY KEY (`reqId`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-12  6:11:03

/* 18 18_sp_invdb_edit_user_trade_profile.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `edit_user_trade_profile`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `edit_user_trade_profile`(
	IN	p_logonid	bigint(20),
	IN  p_acctnum	bigint(20),
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
    IN  p_goalDesired 	  double
)
BEGIN 

			call `invdb`.`save_user_trade_profile_audit`(p_acctnum);
			call `invdb`.`save_user_risk_questions_audit`(p_acctnum);
	
			 UPDATE  `invdb`.`user_trade_profile`
			 SET
				`portfolioName` = IFNULL(p_portfolioName,`portfolioName`),
				`advisor` = IFNULL(p_advisor,`advisor`),
                `rep`     = p_rep,
                `firstname` = IFNULL(p_firstname,`firstname`),
                `lastname` = IFNULL(p_lastname,`lastname`),
				`theme` = IFNULL(p_theme,`theme`),
				`goal`	 =	IFNULL(p_goal,`goal`)	,
				`acctType`	 =	IFNULL(p_acctType,`acctType`)	,
				`age`	 =	IFNULL(p_age,`age`)	,
				`horizon`	 =	IFNULL(p_horizon,`horizon`)	,
				`initialInvestment`	 =	IFNULL(p_initialInvestment,`initialInvestment`)	,
				`recurringInvestment`	 =	p_recurringInvestment	,
				`experience`	 =	p_experience	,
				`longTermGoal`	 =	p_objective	,
				`stayInvested`	 =	p_investmentplan	,
				`charitablegoals`	 =	p_charitablegoals	,
				`riskIndex`      =  IFNULL(p_riskIndex,`riskIndex`),
				`keepLiquid`	 =  IFNULL(p_keepLiquid,`keepLiquid`),
				`taxable`        =  IFNULL(p_taxable,`taxable`),
				`assetIndex`	 =  p_allocIndex,
				`portfolioIndex` =  p_portfolioIndex,
				`goalAmount`	 =  p_goalDesired,
				`lastupdated`    = now()
			 WHERE
				`acctnum` = p_acctnum;
                
		IF (p_acctnum is null)
			then set p_acctnum = 0;
		else
			if (IFNULL(p_logonid,0) > 0)
			then
			call `invdb`.`sp_login_access_add_mod`( p_logonid, p_acctnum, 'OWNER', 'W');
			end if;
		end if;
        
         call `invdb`.`sp_user_profile_manage`(p_acctnum,'R',p_logonid);

END$$

DELIMITER ;


/* 19_sp_invdb_save_user_trade_profile.sql120118_Sagar*/

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


/* 20_sp_invdb_save_user_trade_profile_old.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `save_user_trade_profile_old`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_user_trade_profile_old`(
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
     IN  p_goalDesired 	  double
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
 				created
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
 				now()
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
 				lastupdated    = now()
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


/* 21_sp_invdb_sp_emulate_step1_process_account.sql120118_Sagar*/

USE `testing`;
DROP procedure IF EXISTS `sp_emulate_step1_process_account`;

DELIMITER $$
USE `testing`$$
CREATE  PROCEDURE `sp_emulate_step1_process_account`(
  IN p_acctnum BIGINT,
    IN p_logonid BIGINT(20)
)
BEGIN
    DECLARE tFound1 INTEGER;
    DECLARE tFound2 INTEGER;
    DECLARE tStatus VARCHAR(2);
    DECLARE tManaged VARCHAR(2);

    SELECT count(*)
    INTO tFound1
    FROM invdb.ext_acct_info eai
    WHERE eai.acctnum = p_acctnum;

    IF (IFNULL(tFound1, 0) > 0)
    THEN
      SELECT 'This account is already active!' AS msg;
    ELSE
      SELECT
        managed,
        status
      INTO tManaged, tStatus
      FROM invdb.user_trade_profile utp
      WHERE utp.acctnum = p_acctnum;

      IF (IFNULL(tManaged, 'N') != 'N')
      THEN
        SELECT 'This account is marked active but has not external account details.  Cannot proceed!' AS msg;
      ELSE
        UPDATE invdb.user_trade_profile utp
        SET managed = 'N', status = 'P'
        WHERE utp.acctnum = p_acctnum;

        SELECT 'This account is process!' AS msg;
      END IF;

    END IF;

  END$$

DELIMITER ;


/* 22_sp_invdb_sp_emulate_step2_openaccount.sql120118_Sagar*/

USE `testing`;
DROP procedure IF EXISTS `sp_emulate_step2_openaccount`;

DELIMITER $$
USE `testing`$$
CREATE PROCEDURE `sp_emulate_step2_openaccount`(
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
		ssn,
		dob,
		acctType,
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
              NULL, -- worknumber
              NULL, -- faxnum
              daod.ssn,
              invdb.funct_strdate2inv_date(daod.dob, '%m/%d/%Y'),
              dml.displayName,-- acctType,
              NULL, -- taxable
              NULL, -- objective
              invdb.funct_date2inv_date(now()) as performanceInceptionDate, -- dateOpened
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
		ssn,
		dob,
		acctType,
		taxable,
		objective,
		dateOpened,
		created,
		lastUpdated)
          VALUES (
            tClientAccountID,
            p_acctnum,
            'P',
            NULL, -- rep
            CONCAT('testing', p_acctnum, '@invessence.com'), -- email
            'Individual', -- accountType
            'Testing', -- firstname
            NULL, -- middleI
            p_acctnum, -- lastname
            null, -- address1,
            NULL, -- address2
            NULL, -- address3
            null, -- city,
            null, -- state,
            null, -- zip,
            null, -- country,
            null, -- primary phone,
            null, -- secondary phone,
            NULL, -- work phone
            NULL, -- fax number
            null, -- ssnum
            null, -- DOB,
            null, -- acctType
            NULL, -- taxable
            NULL, -- objective
            invdb.funct_date2inv_date(now()), -- date opened
			now(), -- created
            NULL -- last updated
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


/* 23_sp_invdb_sp_emulate_step3_activateaccount.sql120118_Sagar*/

USE `testing`;
DROP procedure IF EXISTS `sp_emulate_step3_activateaccount`;

DELIMITER $$
USE `testing`$$
CREATE PROCEDURE `sp_emulate_step3_activateaccount`(
	IN p_acctnum	BIGINT,
	IN p_amount		DOUBLE,
    IN p_logonid BIGINT(20)
)
BEGIN
	DECLARE tFound1 INTEGER;
  DECLARE tFound2	INTEGER;
	DECLARE tStatus	INTEGER;
  DECLARE tClientAccountID VARCHAR(20);

    SELECT count(*)
    INTO tFound1
    FROM invdb.ext_acct_info eai
    WHERE eai.acctnum = p_acctnum
    ;

	IF (IFNULL(tFound1,0) = 0)
	THEN
		SELECT 'This account# NOT YET OPENED' as msg;
	ELSE
		SELECT clientAccountID
		INTO tClientAccountID
		FROM invdb.ext_acct_info eai
		WHERE eai.acctnum = p_acctnum
        ;

		IF (IFNULL(tClientAccountID,'XXX') != 'XXX')
		THEN

			UPDATE invdb.user_trade_profile utp
				set utp.managed = 'A',
					  utp.status = 'S'
			WHERE utp.acctnum = p_acctnum;

			UPDATE invdb.ext_acct_info eai
				set eai.status = 'A'
			WHERE eai.acctnum = p_acctnum;

            if (p_amount is not null )
            THEN
				CALL testing.sp_fund_account(p_acctnum, p_amount);
				call invdb.sp_user_profile_manage(p_acctnum, 'S',p_logonid);

				SELECT 'This account# was ACTIVATED and POSITION created' as msg;
            ELSE
				call invdb.sp_user_profile_manage(p_acctnum, 'A',p_logonid);

				SELECT 'This account# was ACTIVATED' as msg;
            END IF;

		ELSE
			SELECT 'This account# was NOT FOUND to ext_acct_info' as msg;
 		END IF;

	END IF;



END$$

DELIMITER ;


/* 24_sp_invdb_sp_emulate_step4_funding.sql120118_Sagar*/

USE `testing`;
DROP procedure IF EXISTS `sp_emulate_step4_funding`;

DELIMITER $$
USE `testing`$$
CREATE PROCEDURE `sp_emulate_step4_funding`(
  IN p_acctnum BIGINT,
  IN p_amount  DOUBLE,
    IN p_logonid BIGINT(20)
)
BEGIN
    DECLARE tFound1 INTEGER;
    DECLARE tFound2 INTEGER;
    DECLARE tStatus INTEGER;
    DECLARE tClientAccountID VARCHAR(20);

    SELECT count(*)
    INTO tFound1
    FROM invdb.ext_acct_info eai
    WHERE eai.acctnum = p_acctnum;

    IF (IFNULL(tFound1, 0) = 0)
    THEN
      SELECT 'This account# NOT YET OPENED' AS msg;
    ELSE
      SELECT clientAccountID
      INTO tClientAccountID
      FROM invdb.ext_acct_info eai
      WHERE eai.acctnum = p_acctnum;

      IF (IFNULL(tClientAccountID, 'XXX') != 'XXX')
      THEN
        CALL testing.sp_fund_account(p_acctnum, p_amount);
        CALL invdb.sp_user_profile_manage(p_acctnum, 'F',p_logonid);

        SELECT 'This account# was ACTIVATED and POSITION created' AS msg;
      ELSE
        SELECT 'This account# was NOT FOUND to ext_acct_info' AS msg;
      END IF;

    END IF;


  END$$

DELIMITER ;


/* 25_sp_invdb_sp_emulate_step5_position.sql120118_Sagar*/
USE `testing`;
DROP procedure IF EXISTS `sp_emulate_step5_position`;

DELIMITER $$
USE `testing`$$
CREATE PROCEDURE `sp_emulate_step5_position`(
  IN p_acctnum BIGINT,
    IN p_logonid BIGINT(20)
)
BEGIN
	DECLARE tStatus VARCHAR(1);
    DECLARE tClientAccountID VARCHAR(20);
    DECLARE tCash Double;
    DECLARE tTotal Double;
    DECLARE tReportDate VARCHAR(10);
    DECLARE tTradeCurrency VARCHAR(3);

    SELECT `eai`.`status`, `eai`.`clientAccountID`, IFNULL(`profile`.`tradeCurrency`,'USD')
    INTO tStatus, tClientAccountID, tTradeCurrency
    FROM invdb.ext_acct_info eai, `invdb`.`user_trade_profile` `profile`
    WHERE eai.acctnum = `profile`.`acctnum`
	AND   eai.acctnum = p_acctnum;

	set tReportDate = `invdb`.`FUNCT_GET_SWITCH`('BROKER_BDATE');
    IF (IFNULL(tStatus,'Z') != 'A')
    THEN
      SELECT 'This account# NOT YET Active' AS msg;
    ELSE
	  select SUM(`cash`), sum(`total`)
      INTO tCash, tTotal
      from invdb.ext_nav 
      where clientAccountID = tClientAccountID
      and reportDate = tReportDate;
      
	IF (tCash = 0.0)
		THEN
			SELECT 'This account# NOT YET Funded' AS msg;
		ELSE
			IF (tCash < tTotal)
            THEN
				SELECT 'This account# has already been allocated' AS msg;
           ELSE
           
				DELETE FROM invdb.ext_position 
                where clientAccountID = tClientAccountID
                AND reportDate = tReportDate;
 
				 INSERT INTO `invdb`.`ext_position`
					(`acctnum`,
					`clientAccountID`,
					`tradeCurrency`,
					`fxRateToBase`,
					`symbol`,
					`reportDate`,
					`purchaseDate`,
					`side`,
					`quantity`,
					`costBasisPrice`,
					`costBasisMoney`,
					`markPrice`,
					`positionValue`,
					`pnlUnrealized`,
					`levelOfDetail`,
					`settleCurrency`,
					`settleQty`,
					`settlePrice`,
					`settleMoney`,
					`settleMarkPrice`,
					`settlePnL`,
					`created`)
				SELECT 
					`virtual_portfolio`.`acctnum`,
                    tClientAccountID,
                    `virtual_portfolio`.`tradeCurrency`,
                    `virtual_portfolio`.`exchangeRate`,
					`virtual_portfolio`.`ticker`,
                    tReportDate,
                    tReportDate,
                    'Long',
					`virtual_portfolio`.`qty`,
					(`tTotal` * `virtual_portfolio`.`weight`) / `virtual_portfolio`.`qty`,
                    (`tTotal` * `virtual_portfolio`.`weight`),
					(`tTotal` * `virtual_portfolio`.`weight`) / `virtual_portfolio`.`qty`,
                    (`tTotal` * `virtual_portfolio`.`weight`),
					0.0,
					'Emulated',
                    `virtual_portfolio`.`settleCurrency`,
					IFNULL(`virtual_portfolio`.`settleQty`, `virtual_portfolio`.`qty`),
					(`tTotal` * `virtual_portfolio`.`exchangeRate` * `virtual_portfolio`.`weight`) / IFNULL(`virtual_portfolio`.`settleQty`, `virtual_portfolio`.`qty`),
                    (`tTotal` * `virtual_portfolio`.`exchangeRate` * `virtual_portfolio`.`weight`),
					(`tTotal` * `virtual_portfolio`.`exchangeRate` * `virtual_portfolio`.`weight`) / IFNULL(`virtual_portfolio`.`settleQty`, `virtual_portfolio`.`qty`),
                    0.0,				
					now()
				FROM `invdb`.`virtual_portfolio`
                WHERE acctnum = p_acctnum
				;
                
                SELECT costBasisMoney
                INTO tCash
                FROM invdb.ext_position
                WHERE clientAccountID = tClientAccountID
                AND   upper(symbol) = 'CASH'
                AND reportDate = tReportDate;
                
                UPDATE invdb.ext_nav
                set cash = tCash,
					stock = total - tCash
                where clientAccountID = tClientAccountID
                AND reportDate = tReportDate;
				
				SELECT 'Success: This account# has been allocated' AS msg;
				

            END IF;
	END IF;
        

    END IF;


  END$$

DELIMITER ;

/* 26_sp_invdb_sp_emulate_td_activateaccount.sql120118_Sagar*/

USE `testing`;
DROP procedure IF EXISTS `sp_emulate_td_activateaccount`;

DELIMITER $$
USE `testing`$$
CREATE PROCEDURE `sp_emulate_td_activateaccount`(
	IN p_acctnum	BIGINT,
    IN p_amount		DOUBLE,
    IN p_logonid BIGINT(20)
)
BEGIN
	DECLARE tFound1 INTEGER;
    DECLARE tFound2	INTEGER;
	DECLARE tStatus	INTEGER;
    DECLARE tClientAccountID VARCHAR(20);
    
    SELECT count(*)
    INTO tFound1
    FROM `invdb`.`ext_acct_info`
    WHERE `ext_acct_info`.`acctnum` = `p_acctnum`
    ;
    
	IF (IFNULL(tFound1,0) = 0)
	THEN
		SELECT 'This account# NOT YET OPENED' as msg;
	ELSE
		SELECT `clientAccountID`
		INTO tClientAccountID
		FROM `invdb`.`ext_acct_info`
		WHERE `ext_acct_info`.`acctnum` = `p_acctnum`
        ;

		IF (IFNULL(tClientAccountID,'XXX') != 'XXX')
		THEN
			INSERT INTO `invdb`.`ext_position`
				(`acctnum`,
				`clientAccountID`,
				`currencyPrimary`,
				`fxRateToBase`,
				`symbol`,
				`reportDate`,
				`purchaseDate`,
				`side`,
				`quantity`,
				`costBasisPrice`,
				`costBasisMoney`,
				`markPrice`,
				`positionValue`,
				`pnlUnrealized`,
				`levelOfDetail`,
				`created`
				)
			SELECT
				`ext_acct_info`.`acctnum` 
				, `ext_acct_info`.`clientAccountID` as clientAccountID 
				, 'USD' as currencyPrimary 
				, '1.0' as fxRateToBase
				, 'Cash' as symbol 
				, `invdb`.`FUNCT_GET_SWITCH`('BROKER_BDATE') as reportDate 
				, `invdb`.`FUNCT_GET_SWITCH`('BROKER_BDATE') as purchaseDate 
				, 'Long' as `side`
				, `p_amount` as `quantity`
				, 1 as costBasisPrice
				, `p_amount` as `costBasisMoney`
				, 1 as markPrice
				, `p_amount` as `positionValue`
				, 0 as pnlUnrealized
				, 'Cash' as `levelOfDetail`
				, now() as created
			FROM `invdb`.`ext_acct_info` as `ext_acct_info`
			WHERE `ext_acct_info`.`acctnum` = `p_acctnum`
            ON duplicate key update
				  `quantity` = `quantity` + `p_amount`
                , `costBasisMoney` = `costBasisMoney` + `p_amount`
                , `positionValue` = `positionValue` + `p_amount`
                , `levelOfDetail` = 'Funded'
			;
                

		   INSERT INTO `invdb`.`ext_nav`
				(`clientAccountID`,
				`reportDate`,
				`cash`,
				`stock`,
				`funds`,
				`interestAccrual`,
				`dividentAccrual`,
				`total`)
			VALUES
			(tClientAccountID,
			`invdb`.`FUNCT_GET_SWITCH`('BROKER_BDATE'),
			`p_amount`,
			0,
			0,
			0,
			0,
			`p_amount`)
            ON duplicate key update
				 `cash` = `cash` + `p_amount`
                , `total` = `total` + `p_amount`
			;

                
			UPDATE `invdb`.`ext_acct_info`
				set `ext_acct_info`.`status` = 'A'
			WHERE `ext_acct_info`.`acctnum` = `p_acctnum`;
			
			call `invdb`.`sp_user_profile_manage`(`p_acctnum`, 'A',p_logonid);
                
			SELECT 'This account# was ACTIVATED and POSITION created' as msg;
		ELSE
			SELECT 'This account# was NOT FOUND to ext_acct_info' as msg;
 		END IF;

	END IF;
    
    

END$$

DELIMITER ;


/* 27_sp_invdb_sp_emulate_td_funding.sql120118_Sagar*/

USE `testing`;
DROP procedure IF EXISTS `sp_emulate_td_funding`;

DELIMITER $$
USE `testing`$$
CREATE PROCEDURE `sp_emulate_td_funding`(
	IN p_acctnum	BIGINT,
    IN p_amount		DOUBLE,
    IN p_logonid BIGINT(20)
)
BEGIN
	DECLARE tFound1 INTEGER;
    DECLARE tFound2	INTEGER;
	DECLARE tStatus	INTEGER;
    DECLARE tClientAccountID VARCHAR(20);
    
    SELECT count(*)
    INTO tFound1
    FROM `invdb`.`ext_acct_info`
    WHERE `ext_acct_info`.`acctnum` = `p_acctnum`
    ;
    
	IF (IFNULL(tFound1,0) = 0)
	THEN
		SELECT 'This account# NOT YET OPENED' as msg;
	ELSE
		SELECT `clientAccountID`
		INTO tClientAccountID
		FROM `invdb`.`ext_acct_info`
		WHERE `ext_acct_info`.`acctnum` = `p_acctnum`
        ;

		IF (IFNULL(tClientAccountID,'XXX') != 'XXX')
		THEN
			INSERT INTO `invdb`.`ext_position`
				(`acctnum`,
				`clientAccountID`,
				`currencyPrimary`,
				`fxRateToBase`,
				`symbol`,
				`reportDate`,
				`purchaseDate`,
				`side`,
				`quantity`,
				`costBasisPrice`,
				`costBasisMoney`,
				`markPrice`,
				`positionValue`,
				`pnlUnrealized`,
				`levelOfDetail`,
				`created`
				)
			SELECT
				`ext_acct_info`.`acctnum` 
				, `ext_acct_info`.`clientAccountID` as clientAccountID 
				, 'USD' as currencyPrimary 
				, '1.0' as fxRateToBase
				, 'Cash' as symbol 
				, `invdb`.`FUNCT_GET_SWITCH`('BROKER_BDATE') as reportDate 
				, `invdb`.`FUNCT_GET_SWITCH`('BROKER_BDATE') as purchaseDate 
				, 'Long' as `side`
				, `p_amount` as `quantity`
				, 1 as costBasisPrice
				, `p_amount` as `costBasisMoney`
				, 1 as markPrice
				, `p_amount` as `positionValue`
				, 0 as pnlUnrealized
				, 'Cash' as `levelOfDetail`
				, now() as created
			FROM `invdb`.`ext_acct_info` as `ext_acct_info`
			WHERE `ext_acct_info`.`acctnum` = `p_acctnum`
            ON duplicate key update
				  `quantity` = `quantity` + `p_amount`
                , `costBasisMoney` = `costBasisMoney` + `p_amount`
                , `positionValue` = `positionValue` + `p_amount`
                , `levelOfDetail` = 'Funded'
			;
                

		   INSERT INTO `invdb`.`ext_nav`
				(`clientAccountID`,
				`reportDate`,
				`cash`,
				`stock`,
				`funds`,
				`interestAccrual`,
				`dividentAccrual`,
				`total`)
			VALUES
			(tClientAccountID,
			`invdb`.`FUNCT_GET_SWITCH`('BROKER_BDATE'),
			`p_amount`,
			0,
			0,
			0,
			0,
			`p_amount`)
            ON duplicate key update
				 `cash` = `cash` + `p_amount`
                , `total` = `total` + `p_amount`
			;

		    call `invdb`.`sp_user_profile_manage`(`p_acctnum`, 'F',p_logonid);
                 
			SELECT 'This account# was ACTIVATED and POSITION created' as msg;
		ELSE
			SELECT 'This account# was NOT FOUND to ext_acct_info' as msg;
 		END IF;

	END IF;
    
    

END$$

DELIMITER ;


/* 28_sp_invdb_sp_emulate_td_openaccount.sql120118_Sagar*/

USE `testing`;
DROP procedure IF EXISTS `sp_emulate_td_openaccount`;

DELIMITER $$
USE `testing`$$
CREATE PROCEDURE `sp_emulate_td_openaccount`(
	IN p_acctnum	BIGINT,
    IN p_logonid BIGINT(20)
)
BEGIN
	DECLARE tFound1 INTEGER;
    DECLARE tFound2	INTEGER;
	DECLARE tStatus	INTEGER;
    
    SELECT count(*)
    INTO tFound1
    FROM `invdb`.`dc_requests`
    WHERE `dc_requests`.`reqType` like '%NEW'
    AND `dc_requests`.`acctnum` = `p_acctnum`
    ;
    
    SELECT count(*)
    INTO tFound2
    FROM `invdb`.`ext_acct_info`
    WHERE `ext_acct_info`.`acctnum` = `p_acctnum`
    ;
    
    IF (IFNULL(tFound2,0) != 0)
    THEN
		SELECT 'This account# is already created.' as msg;
	ELSE
        IF (IFNULL(tFound1,0) = 0)
		THEN
			SELECT 'This account# NOT yet processed to TD' as msg;
		ELSE
        
			SELECT COUNT(*)
            INTO tFound2
            FROM `invdb`.`dc_acct_owners_details`
            WHERE `dc_acct_owners_details`.`acctnum` = `p_acctnum`
            ;
            
            IF (IFNULL(tFound2,0) > 0)
            THEN
				INSERT INTO `invdb`.`ext_acct_info`
				(
					`clientAccountID`,
					`acctnum`,
					`status`,
					`rep`,
					`email`,
					`accountType`,
					`applicantFName`,
					`applicantMName`,
					`applicantLName`,
					`address1`,
					`address2`,
					`address3`,
					`city`,
					`state`,
					`zipcode`,
					`country`,
					`primaryPhoneNbr`,
					`secondayPhoneNbr`,
					`workPhoneNbr`,
					`faxNbr`,
					`ssn`,
					`dob`,
					`acctType`,
					`taxable`,
					`objective`,
					`dateOpened`,
					`created`,
					`lastUpdated`
				)
				SELECT
					CONCAT('TST',`dc_acct_owners_details`.`acctnum`) as clientAccountID, 
					`dc_acct_owners_details`.`acctnum`, 
					'P', 
					null , 
					`dc_acct_owners_details`.`emailAddress` , 
					`dc_acct_details`.`acctTypeId`, 
					`dc_acct_owners_details`.`firstName`, 
					null, 
					`dc_acct_owners_details`.`lastName`, 
					`dc_acct_owners_details`.`physicalAddressStreet`, 
					null, 
					null, 
					`dc_acct_owners_details`.`physicalAddressCity`, 
					`dc_acct_owners_details`.`physicalAddressState`, 
					`dc_acct_owners_details`.`physicalAddressZipCode`, 
					'USA',  
					`dc_acct_owners_details`.`phoneNumber`,  
					`dc_acct_owners_details`.`secondPhoneNumber`,  
					null, 
					null, 
					`dc_acct_owners_details`.`ssn`, 
					`invdb`.`funct_strdate2inv_date`(`dc_acct_owners_details`.`dob`,'%m/%d/%Y'), 
					`dc_m_lookup`.`displayName`,
					null, 
					null, 
					`invdb`.`funct_date2inv_date`(now()) `performanceInceptionDate`, 
					now(), 
					null 
				FROM `invdb`.`dc_acct_owners_details` as `dc_acct_owners_details`
					,`invdb`.`dc_acct_details`
					,`invdb`.`dc_m_lookup`
				WHERE `dc_acct_owners_details`.`acctnum` = `p_acctnum`
				AND   `dc_acct_owners_details`.`acctOwnerId` = 1
				AND   `dc_acct_owners_details`.`acctnum`  = `dc_acct_details`.`acctnum`
				AND   `dc_acct_details`.`acctTypeId` = `dc_m_lookup`.`lookupCode`
				AND   `dc_m_lookup`.`lookupSet` = 'ACCTTYPE'
				;
                
				call `invdb`.`sp_user_profile_manage`(`p_acctnum`, 'O',p_logonid);
 
				SELECT 'This account# was ADDED to ext_acct_info' as msg;
			ELSE
				SELECT 'This account# was NOT FOUND to dc_acct_owners_details' as msg;
            END IF;
		END IF;

	END IF;
    
    

END$$

DELIMITER ;


/* 29_sp_invdb_sp_login_add_mod.sql120118_Sagar*/
USE `invdb`;
DROP procedure IF EXISTS `sp_login_add_mod`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sp_login_add_mod`(
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
 				lastupdated,fullname)
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
    END;     
    end if;
    
    update user_trade_profile set fullname=p_fullname where acctnum=p_acctnum;
 	
 	call sp_login_access_add_mod( t_logonID, p_acctnum, 'OWNER', 'W');
     
 	CALL invdb.sp_user_profile_manage(p_acctnum, 'N',t_logonID);
 
 	set p_logonid = t_logonID;
 END$$

DELIMITER ;



/* 30_sp_invdb_sel_ClientProfileData.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `sel_ClientProfileData`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sel_ClientProfileData`(
    	IN p_logonid BIGINT,
    	IN p_acctnum BIGINT,
    	IN p_days	 INTEGER,
        IN p_advisor VARCHAR(20),
        IN p_rep VARCHAR(20)
    )
BEGIN
    
    	DECLARE consumerView Boolean;
    	DECLARE singleAcct  Boolean;
    	DECLARE tAdvisor VARCHAR(25);
    	DECLARE  tRep     VARCHAR(25);
        DECLARE vAdvisor VARCHAR(25);
    
    	
        
        
    	IF (IFNULL(p_acctnum,0) = 0)
    		THEN SET singleAcct = FALSE;   
    		ELSE set singleAcct = TRUE;
    	END IF;
        
    	SELECT advisor, rep
    	INTO tAdvisor, tRep
    	FROM user_advisor_access
    	WHERE logonid = p_logonid
    	LIMIT 1;
    	
        
        
        
    	IF (tAdvisor is NULL)
    		THEN set consumerView = TRUE;  
    		ELSE set consumerView = FALSE;
    	END IF;
        
        IF (tAdvisor is NOT NULL) THEN
    	select advisor into vAdvisor  from user_logon where logonid=p_logonid;
            if(vAdvisor='DEMO') then
    			 set tAdvisor = IFNULL(p_advisor,'');
                 set tRep = IFNULL(p_rep,'');
    		end if;
    	END IF;
    	
    	
        
    	IF (p_days is null)
    		THEN	set p_days = -36500;
    		ELSE	IF (p_days > 0)
    					THEN set p_days = -1 * p_days;
    				END IF;
    	END IF;
        
        IF (consumerView)
    		THEN
    			IF (singleAcct)
    				THEN
    					select 
    					user_logon.logonid,
    					profile.acctnum,
                        profile.managed,
    					IFNULL(profile.firstname, user_logon.firstname) as firstname,
    					IFNULL(profile.lastname, user_logon.lastname) as lastname,
    					profile.portfolioName,
    					IFNULL(profile.email, user_logon.email) as email,
    					user_logon.userid,
    					profile.advisor,
    					profile.rep,
    					profile.theme,
    					user_logon.stateRegistered as state,
    					ext_acct_info.clientAccountID as clientAccountID,profile.status as'a1',
    					CASE WHEN (IFNULL(profile.managed,'N') = 'N' and IFNULL(profile.status,'V') in ('V')) THEN 'Visitor'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) = 'N') THEN 'Pending'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) = 'P') THEN 'Processing'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) is not null) THEN 'Pending'
    						 WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'O') THEN 'Opened'
                             WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'S') THEN 'Confirmation'
                             WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'P') THEN 'Processing'
    						 WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) is not null) THEN 'Active'
    						 ELSE 'Visitor'
    					END as status,
    					CASE WHEN (IFNULL(profile.managed,'N') in ('N')) THEN 'Pending'
    						 WHEN (upper(profile.managed) in ('A')) THEN 'Active'
    						 ELSE 'Pending'
    					END as acctStatus,
    					profile.tradePreference,
    					IFNULL(profile.goal,'Retirement') as goal,
    					profile.acctType as accttype,
    					IFNULL(profile.age,30) as age,
    					IFNULL(profile.horizon,30) as horizon,
    					round(datediff(now(),IFNULL(profile.created,now()))/364,0) as yearnum,
    					IFNULL(profile.riskIndex,0) as riskIndex,
    					CAST(IFNULL(profile.initialInvestment,5000) as SIGNED) as initialInvestment,
    					round(funct_get_actualCapital(profile.acctnum),0) as actualCapital,
    					IFNULL(profile.keepLiquid,0) as keepLiquid,
    					IFNULL(profile.recurringInvestment,0) as recurringInvestment,
    					IFNULL(profile.longTermGoal,0) as longTermGoal,
    					IFNULL(profile.stayInvested,0) as stayInvested,
    					profile.taxable,
    					IFNULL(profile.calcModel,'A') as calcModel,
    					IFNULL(profile.assetIndex,0) as assetIndex,
    					IFNULL(profile.portfolioIndex,0) as portfolioIndex,
    					DATE_FORMAT(profile.created,'%Y%m%d') as dateOpened,
    
    					IFNULL(user_risk_questions.retireage,0) AS retireage,
    					IFNULL(user_risk_questions.ans1,0) AS ans1,
    					IFNULL(user_risk_questions.ans2,0) AS ans2,
    					IFNULL(user_risk_questions.ans3,0) AS ans3,
    					IFNULL(user_risk_questions.ans4,0) AS ans4,
    					IFNULL(user_risk_questions.ans5,0) AS ans5,
    					IFNULL(user_risk_questions.ans6,0) AS ans6,
    					IFNULL(user_risk_questions.ans7,0) AS ans7,
    					IFNULL(user_risk_questions.ans8,0) AS ans8,
    					IFNULL(user_risk_questions.ans9,0) AS ans9,
    					IFNULL(user_risk_questions.ans10,0) AS ans10,
    					IFNULL(user_risk_questions.ans11,0) AS ans11,
    					IFNULL(user_risk_questions.ans12,0) AS ans12,
    					IFNULL(user_risk_questions.ans13,0) AS ans13,
    					IFNULL(user_risk_questions.ans14,0) AS ans14,
    					IFNULL(user_risk_questions.ans15,0) AS ans15,
                        
    						acct_financial.dependent,
    						acct_financial.estdDependentExpense,
    						acct_financial.householdwages,
    						acct_financial.otherincome,
    						acct_financial.bonusincome,
    						acct_financial.interestincome,
    						acct_financial.dividentincome,
    						acct_financial.rentalIncome,
    						acct_financial.totalIncome,
    						acct_financial.totalIncomeAnnulized,
    						acct_financial.householdPayment,
    						acct_financial.otherPropertiesPayment,
    						acct_financial.automobilePayment,
    						acct_financial.medicalPayment,
    						acct_financial.federaltaxes,
    						acct_financial.stateTaxes,
    						acct_financial.propertyTax,
    						acct_financial.otherPropertyTax,
    						acct_financial.homeInsurance,
    						acct_financial.lifeInsurance,
    						acct_financial.autoInsurance,
    						acct_financial.educationPayment,
    						acct_financial.creditCardPayment,
    						acct_financial.miscExpenses,
    						acct_financial.totalExpense,
    						acct_financial.totalExpenseAnnulized,
    						acct_financial.homeEquity,
    						acct_financial.autoValue,
    						acct_financial.moneyMarket,
    						acct_financial.checkingAcct,
    						acct_financial.savingAcct,
    						acct_financial.investment,
    						acct_financial.equityOtherProperties,
    						acct_financial.retirementInvestement,
    						acct_financial.miscInvestment,
    						acct_financial.totalAsset,
    						acct_financial.mortgageLoan,
    						acct_financial.autoLoan,
    						acct_financial.educationLoan,
    						acct_financial.creditCardDebt,
    						acct_financial.otherPropertiesLoan,
    						acct_financial.medicalDebt,
    						acct_financial.otherDebt,
    						acct_financial.totalDebt,
    						acct_financial.liquidnetworth,
    						acct_financial.networth,
    
    
    					IFNULL(profile.goalAmount,0) as goalDesired,
    					DATE_FORMAT(profile.created,'%Y-%m-%d') as created,
                        IFNULL(profile.customName,'') as customName,tradeCurrency,settleCurrency,exchangeRate
    					
    					from
    						user_logon,
    						user_access_role,
    						user_trade_profile profile
    						left join acct_financial
    						On ( profile.acctnum = acct_financial.acctnum)
    						left join user_risk_questions
    						On (profile.acctnum = user_risk_questions.acctnum)
    						left join ext_acct_info ext_acct_info
    						On (ext_acct_info.acctnum = profile.acctnum)
    					where
    						user_logon.logonid = user_access_role.logonid
    					and user_access_role.acctnum = profile.acctnum
    					and user_access_role.role in ('OWNER')
    					and profile.acctnum = p_acctnum
    					and user_logon.logonid = p_logonid
    					and profile.advisor= p_advisor
    					and profile.rep= p_rep
    					order by profile.acctnum
    					LIMIT 1
    					;
    				ELSE
    					select 
    					user_logon.logonid,
    					profile.acctnum,
                        profile.managed,
    					IFNULL(profile.firstname, user_logon.firstname) as firstname,
    					IFNULL(profile.lastname, user_logon.lastname) as lastname,
    					profile.portfolioName,
    					IFNULL(profile.email, user_logon.email) as email,
    					user_logon.userid,
    					profile.advisor,
    					profile.rep,
    					profile.theme,
    					user_logon.stateRegistered as state,
    					ext_acct_info.clientAccountID as clientAccountID,profile.status as'a1',
    					CASE WHEN (IFNULL(profile.managed,'N') = 'N' and IFNULL(profile.status,'V') in ('V')) THEN 'Visitor'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) = 'N') THEN 'Pending'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) = 'P') THEN 'Processing'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) is not null) THEN 'Pending'
    						 WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'O') THEN 'Opened'
                             WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'S') THEN 'Confirmation'
                             WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'P') THEN 'Processing'
    						 WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) is not null) THEN 'Active'
    						 ELSE 'Visitor'
    					END as status,
    					CASE WHEN (IFNULL(profile.managed,'N') in ('N')) THEN 'Pending'
    						 WHEN (upper(profile.managed) in ('A')) THEN 'Active'
    						 ELSE 'Pending'
    					END as acctStatus,
    					profile.tradePreference,
    					IFNULL(profile.goal,'Retirement') as goal,
    					profile.acctType as accttype,
    					IFNULL(profile.age,30) as age,
    					IFNULL(profile.horizon,30) as horizon,
    					round(datediff(now(),IFNULL(profile.created,now()))/364,0) as yearnum,
    					IFNULL(profile.riskIndex,0) as riskIndex,
    					CAST(IFNULL(profile.initialInvestment,5000) as SIGNED) as initialInvestment,
    					round(funct_get_actualCapital(profile.acctnum),0) as actualCapital,
    					IFNULL(profile.keepLiquid,0) as keepLiquid,
    					IFNULL(profile.recurringInvestment,0) as recurringInvestment,
    					IFNULL(profile.longTermGoal,0) as longTermGoal,
    					IFNULL(profile.stayInvested,0) as stayInvested,
    					profile.taxable,
    					IFNULL(profile.calcModel,'A') as calcModel,
    					IFNULL(profile.assetIndex,0) as assetIndex,
    					IFNULL(profile.portfolioIndex,0) as portfolioIndex,
    					DATE_FORMAT(profile.created,'%Y%m%d') as dateOpened,
    
    					IFNULL(user_risk_questions.retireage,0) AS retireage,
    					IFNULL(user_risk_questions.ans1,0) AS ans1,
    					IFNULL(user_risk_questions.ans2,0) AS ans2,
    					IFNULL(user_risk_questions.ans3,0) AS ans3,
    					IFNULL(user_risk_questions.ans4,0) AS ans4,
    					IFNULL(user_risk_questions.ans5,0) AS ans5,
    					IFNULL(user_risk_questions.ans6,0) AS ans6,
    					IFNULL(user_risk_questions.ans7,0) AS ans7,
    					IFNULL(user_risk_questions.ans8,0) AS ans8,
    					IFNULL(user_risk_questions.ans9,0) AS ans9,
    					IFNULL(user_risk_questions.ans10,0) AS ans10,
    					IFNULL(user_risk_questions.ans11,0) AS ans11,
    					IFNULL(user_risk_questions.ans12,0) AS ans12,
    					IFNULL(user_risk_questions.ans13,0) AS ans13,
    					IFNULL(user_risk_questions.ans14,0) AS ans14,
    					IFNULL(user_risk_questions.ans15,0) AS ans15,
                        
    						acct_financial.dependent,
    						acct_financial.estdDependentExpense,
    						acct_financial.householdwages,
    						acct_financial.otherincome,
    						acct_financial.bonusincome,
    						acct_financial.interestincome,
    						acct_financial.dividentincome,
    						acct_financial.rentalIncome,
    						acct_financial.totalIncome,
    						acct_financial.totalIncomeAnnulized,
    						acct_financial.householdPayment,
    						acct_financial.otherPropertiesPayment,
    						acct_financial.automobilePayment,
    						acct_financial.medicalPayment,
    						acct_financial.federaltaxes,
    						acct_financial.stateTaxes,
    						acct_financial.propertyTax,
    						acct_financial.otherPropertyTax,
    						acct_financial.homeInsurance,
    						acct_financial.lifeInsurance,
    						acct_financial.autoInsurance,
    						acct_financial.educationPayment,
    						acct_financial.creditCardPayment,
    						acct_financial.miscExpenses,
    						acct_financial.totalExpense,
    						acct_financial.totalExpenseAnnulized,
    						acct_financial.homeEquity,
    						acct_financial.autoValue,
    						acct_financial.moneyMarket,
    						acct_financial.checkingAcct,
    						acct_financial.savingAcct,
    						acct_financial.investment,
    						acct_financial.equityOtherProperties,
    						acct_financial.retirementInvestement,
    						acct_financial.miscInvestment,
    						acct_financial.totalAsset,
    						acct_financial.mortgageLoan,
    						acct_financial.autoLoan,
    						acct_financial.educationLoan,
    						acct_financial.creditCardDebt,
    						acct_financial.otherPropertiesLoan,
    						acct_financial.medicalDebt,
    						acct_financial.otherDebt,
    						acct_financial.totalDebt,
    						acct_financial.liquidnetworth,
    						acct_financial.networth,
    
    					IFNULL(profile.goalAmount,0) as goalDesired,
    					DATE_FORMAT(profile.created,'%Y-%m-%d') as created,
                        IFNULL(profile.customName,'') as customName,tradeCurrency,settleCurrency,exchangeRate
    					
    					from
    						user_logon,
    						user_access_role,
    						user_trade_profile profile
    						left join acct_financial
    						On ( profile.acctnum = acct_financial.acctnum)
    						left join user_risk_questions
    						On (profile.acctnum = user_risk_questions.acctnum)
    						left join ext_acct_info ext_acct_info
    						On (ext_acct_info.acctnum = profile.acctnum)
    					where
    						user_logon.logonid = user_access_role.logonid
    					and user_access_role.acctnum = profile.acctnum
    					and user_access_role.role in ('OWNER', 'USER')
    					and user_logon.logonid = p_logonid
    					and profile.advisor= p_advisor
    					and profile.rep= p_rep
    					order by profile.acctnum
    					;
    			END IF;
            ELSE
    			IF (singleAcct)
    				THEN
    					select 
    					user_logon.logonid,
    					profile.acctnum,
                        profile.managed,
    					IFNULL(profile.firstname, user_logon.firstname) as firstname,
    					IFNULL(profile.lastname, user_logon.lastname) as lastname,
    					profile.portfolioName,
    					IFNULL(profile.email, user_logon.email) as email,
    					user_logon.userid,
    					profile.advisor,
    					profile.rep,
    					profile.theme,
    					user_logon.stateRegistered as state,
    					ext_acct_info.clientAccountID as clientAccountID,profile.status as'a1',
    					CASE WHEN (IFNULL(profile.managed,'N') = 'N' and IFNULL(profile.status,'V') in ('V')) THEN 'Visitor'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) = 'N') THEN 'Pending'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) = 'P') THEN 'Processing'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) is not null) THEN 'Pending'
    						 WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'O') THEN 'Opened'
                             WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'S') THEN 'Confirmation'
                             WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'P') THEN 'Processing'
    						 WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) is not null) THEN 'Active'
    						 ELSE 'Visitor'
    					END as status,
    					CASE WHEN (IFNULL(profile.managed,'N') in ('N')) THEN 'Pending'
    						 WHEN (upper(profile.managed) in ('A')) THEN 'Active'
    						 ELSE 'Pending'
    					END as acctStatus,
    					profile.tradePreference,
    					IFNULL(profile.goal,'Retirement') as goal,
    					(case when (ext_acct_info.accountType is not null )
    								then ext_acct_info.accountType 
    						  else profile.acctType 
    					end) as accttype,
    					IFNULL(profile.age,30) as age,
    					IFNULL(profile.horizon,30) as horizon,
    					round(datediff(now(),IFNULL(profile.created,now()))/364,0) as yearnum,
    					IFNULL(profile.riskIndex,0) as riskIndex,
    					CAST(IFNULL(profile.initialInvestment,5000) as SIGNED) as initialInvestment,
    					round(funct_get_actualCapital(profile.acctnum),0) as actualCapital,
    					IFNULL(profile.keepLiquid,0) as keepLiquid,
    					IFNULL(profile.recurringInvestment,0) as recurringInvestment,
    					IFNULL(profile.longTermGoal,0) as longTermGoal,
    					IFNULL(profile.stayInvested,0) as stayInvested,
    					profile.taxable,
    					IFNULL(profile.calcModel,'A') as calcModel,
    					IFNULL(profile.assetIndex,0) as assetIndex,
    					IFNULL(profile.portfolioIndex,0) as portfolioIndex,
    					DATE_FORMAT(profile.created,'%Y%m%d') as dateOpened,
    
    					IFNULL(user_risk_questions.retireage,0) AS retireage,
    					IFNULL(user_risk_questions.ans1,0) AS ans1,
    					IFNULL(user_risk_questions.ans2,0) AS ans2,
    					IFNULL(user_risk_questions.ans3,0) AS ans3,
    					IFNULL(user_risk_questions.ans4,0) AS ans4,
    					IFNULL(user_risk_questions.ans5,0) AS ans5,
    					IFNULL(user_risk_questions.ans6,0) AS ans6,
    					IFNULL(user_risk_questions.ans7,0) AS ans7,
    					IFNULL(user_risk_questions.ans8,0) AS ans8,
    					IFNULL(user_risk_questions.ans9,0) AS ans9,
    					IFNULL(user_risk_questions.ans10,0) AS ans10,
    					IFNULL(user_risk_questions.ans11,0) AS ans11,
    					IFNULL(user_risk_questions.ans12,0) AS ans12,
    					IFNULL(user_risk_questions.ans13,0) AS ans13,
    					IFNULL(user_risk_questions.ans14,0) AS ans14,
    					IFNULL(user_risk_questions.ans15,0) AS ans15,
                        
    						acct_financial.dependent,
    						acct_financial.estdDependentExpense,
    						acct_financial.householdwages,
    						acct_financial.otherincome,
    						acct_financial.bonusincome,
    						acct_financial.interestincome,
    						acct_financial.dividentincome,
    						acct_financial.rentalIncome,
    						acct_financial.totalIncome,
    						acct_financial.totalIncomeAnnulized,
    						acct_financial.householdPayment,
    						acct_financial.otherPropertiesPayment,
    						acct_financial.automobilePayment,
    						acct_financial.medicalPayment,
    						acct_financial.federaltaxes,
    						acct_financial.stateTaxes,
    						acct_financial.propertyTax,
    						acct_financial.otherPropertyTax,
    						acct_financial.homeInsurance,
    						acct_financial.lifeInsurance,
    						acct_financial.autoInsurance,
    						acct_financial.educationPayment,
    						acct_financial.creditCardPayment,
    						acct_financial.miscExpenses,
    						acct_financial.totalExpense,
    						acct_financial.totalExpenseAnnulized,
    						acct_financial.homeEquity,
    						acct_financial.autoValue,
    						acct_financial.moneyMarket,
    						acct_financial.checkingAcct,
    						acct_financial.savingAcct,
    						acct_financial.investment,
    						acct_financial.equityOtherProperties,
    						acct_financial.retirementInvestement,
    						acct_financial.miscInvestment,
    						acct_financial.totalAsset,
    						acct_financial.mortgageLoan,
    						acct_financial.autoLoan,
    						acct_financial.educationLoan,
    						acct_financial.creditCardDebt,
    						acct_financial.otherPropertiesLoan,
    						acct_financial.medicalDebt,
    						acct_financial.otherDebt,
    						acct_financial.totalDebt,
    						acct_financial.liquidnetworth,
    						acct_financial.networth,
    
    					IFNULL(profile.goalAmount,0) as goalDesired,
    					DATE_FORMAT(profile.created,'%Y-%m-%d') as created,
                        IFNULL(profile.customName,'') as customName,tradeCurrency,settleCurrency,exchangeRate
    					
    					from
    						user_trade_profile profile
    						left join user_access_role
    						ON (user_access_role.acctnum = profile.acctnum
    						AND user_access_role.role = 'OWNER' )
    						left join user_logon
    						ON (user_logon.logonid = user_access_role.logonid)
    						left join acct_financial
    						On ( profile.acctnum = acct_financial.acctnum)
    						left join user_risk_questions
    						On (profile.acctnum = user_risk_questions.acctnum)
    						left join ext_acct_info ext_acct_info
    						On (ext_acct_info.acctnum = profile.acctnum)
    					where
    						IFNULL(profile.advisor,'Invessence') like tAdvisor
    					and IFNULL(profile.rep,'000') like tRep
    					and profile.acctnum = p_acctnum
    					order by profile.acctnum
    					;
                    ELSE
    					select 
    					user_logon.logonid,
    					profile.acctnum,
                        profile.managed,
    					IFNULL(profile.firstname, user_logon.firstname) as firstname,
    					IFNULL(profile.lastname, user_logon.lastname) as lastname,
    					profile.portfolioName,
    					IFNULL(profile.email, user_logon.email) as email,
    					user_logon.userid,
    					profile.advisor,
    					profile.rep,
    					profile.theme,
    					user_logon.stateRegistered as state,
    					ext_acct_info.clientAccountID as clientAccountID,profile.status as'a1',
    					CASE WHEN (IFNULL(profile.managed,'N') = 'N' and IFNULL(profile.status,'V') in ('V')) THEN 'Visitor'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) = 'N') THEN 'Pending'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) = 'P') THEN 'Processing'
    						 WHEN (IFNULL(profile.managed,'N') = 'N' and upper(profile.status) is not null) THEN 'Pending'
    						 WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'O') THEN 'Opened'
                             WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'S') THEN 'Confirmation'
                             WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) = 'P') THEN 'Processing'
    						 WHEN (IFNULL(profile.managed,'N') = 'A' and upper(profile.status) is not null) THEN 'Active'
    						 ELSE 'Visitor'
    					END as status,
    					CASE WHEN (IFNULL(profile.managed,'N') in ('N')) THEN 'Pending'
    						 WHEN (upper(profile.managed) in ('A')) THEN 'Active'
    						 ELSE 'Pending'
    					END as acctStatus,
    					profile.tradePreference,
    					IFNULL(profile.goal,'Retirement') as goal,
    					 (case when (ext_acct_info.accountType is not null )
    								then ext_acct_info.accountType 
    							else profile.acctType 
    					 end) as accttype,
    					IFNULL(profile.age,30) as age,
    					IFNULL(profile.horizon,30) as horizon,
    					round(datediff(now(),IFNULL(profile.created,now()))/364,0) as yearnum,
    					IFNULL(profile.riskIndex,0) as riskIndex,
    					CAST(IFNULL(profile.initialInvestment,5000) as SIGNED) as initialInvestment,
    					round(funct_get_actualCapital(profile.acctnum),0) as actualCapital,
    					IFNULL(profile.keepLiquid,0) as keepLiquid,
    					IFNULL(profile.recurringInvestment,0) as recurringInvestment,
    					IFNULL(profile.longTermGoal,0) as longTermGoal,
    					IFNULL(profile.stayInvested,0) as stayInvested,
    					profile.taxable,
    					IFNULL(profile.calcModel,'A') as calcModel,
    					IFNULL(profile.assetIndex,0) as assetIndex,
    					IFNULL(profile.portfolioIndex,0) as portfolioIndex,
    					DATE_FORMAT(profile.created,'%Y%m%d') as dateOpened,
    
    					IFNULL(user_risk_questions.retireage,0) AS retireage,
    					IFNULL(user_risk_questions.ans1,0) AS ans1,
    					IFNULL(user_risk_questions.ans2,0) AS ans2,
    					IFNULL(user_risk_questions.ans3,0) AS ans3,
    					IFNULL(user_risk_questions.ans4,0) AS ans4,
    					IFNULL(user_risk_questions.ans5,0) AS ans5,
    					IFNULL(user_risk_questions.ans6,0) AS ans6,
    					IFNULL(user_risk_questions.ans7,0) AS ans7,
    					IFNULL(user_risk_questions.ans8,0) AS ans8,
    					IFNULL(user_risk_questions.ans9,0) AS ans9,
    					IFNULL(user_risk_questions.ans10,0) AS ans10,
    					IFNULL(user_risk_questions.ans11,0) AS ans11,
    					IFNULL(user_risk_questions.ans12,0) AS ans12,
    					IFNULL(user_risk_questions.ans13,0) AS ans13,
    					IFNULL(user_risk_questions.ans14,0) AS ans14,
    					IFNULL(user_risk_questions.ans15,0) AS ans15,
                        
                        
    						acct_financial.dependent,
    						acct_financial.estdDependentExpense,
    						acct_financial.householdwages,
    						acct_financial.otherincome,
    						acct_financial.bonusincome,
    						acct_financial.interestincome,
    						acct_financial.dividentincome,
    						acct_financial.rentalIncome,
    						acct_financial.totalIncome,
    						acct_financial.totalIncomeAnnulized,
    						acct_financial.householdPayment,
    						acct_financial.otherPropertiesPayment,
    						acct_financial.automobilePayment,
    						acct_financial.medicalPayment,
    						acct_financial.federaltaxes,
    						acct_financial.stateTaxes,
    						acct_financial.propertyTax,
    						acct_financial.otherPropertyTax,
    						acct_financial.homeInsurance,
    						acct_financial.lifeInsurance,
    						acct_financial.autoInsurance,
    						acct_financial.educationPayment,
    						acct_financial.creditCardPayment,
    						acct_financial.miscExpenses,
    						acct_financial.totalExpense,
    						acct_financial.totalExpenseAnnulized,
    						acct_financial.homeEquity,
    						acct_financial.autoValue,
    						acct_financial.moneyMarket,
    						acct_financial.checkingAcct,
    						acct_financial.savingAcct,
    						acct_financial.investment,
    						acct_financial.equityOtherProperties,
    						acct_financial.retirementInvestement,
    						acct_financial.miscInvestment,
    						acct_financial.totalAsset,
    						acct_financial.mortgageLoan,
    						acct_financial.autoLoan,
    						acct_financial.educationLoan,
    						acct_financial.creditCardDebt,
    						acct_financial.otherPropertiesLoan,
    						acct_financial.medicalDebt,
    						acct_financial.otherDebt,
    						acct_financial.totalDebt,
    						acct_financial.liquidnetworth,
    						acct_financial.networth,
    
    					IFNULL(profile.goalAmount,0) as goalDesired,
    					DATE_FORMAT(profile.created,'%Y-%m-%d') as created,
                        IFNULL(profile.customName,'') as customName,tradeCurrency,settleCurrency,exchangeRate
    					
    					from
    						user_trade_profile profile
    						left join user_access_role
    						ON (user_access_role.acctnum = profile.acctnum
    						AND user_access_role.role = 'OWNER' )
    						left join user_logon
    						ON (user_logon.logonid = user_access_role.logonid)
    						left join acct_financial
    						On ( profile.acctnum = acct_financial.acctnum)
    						left join user_risk_questions
    						On (profile.acctnum = user_risk_questions.acctnum)
    						left join ext_acct_info ext_acct_info
    						On (ext_acct_info.acctnum = profile.acctnum)
    					where
    						IFNULL(profile.advisor,'Invessence') like tAdvisor
    					and IFNULL(profile.rep,'000') like tRep
                        AND (IFNULL(profile.created,now()) >= DATE_ADD(now(),INTERVAL p_days DAY)
    					AND ext_acct_info.acctnum is null)
    					order by profile.acctnum
    					;
    			END IF;
    	END IF;
      END$$

DELIMITER ;


/* 31_sp_invdb_insrt_web_menu.sql120118_Sagar*/


INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) 
select url, 'User', 'Demo', 'Open Account', '0', '0', '7', 'A', 'N', 'consumer', 'cadd.xhtml', now() from invdb.web_menu group by url;

/* 32_sp_invdb_insrt_web_site_info.sql120118_Sagar*/


INSERT INTO `invdb`.`web_site_info` (`url`, `name`, `status`, `value`, `encrFlag`, `created`) 
select url, 'CUSTODY.UPLOAD.PATH', 'A', '/data/upload/uob/consumerUpload/', 'N',now() from web_site_info group by url;
INSERT INTO `invdb`.`web_site_info` (`url`, `name`, `status`, `value`, `encrFlag`, `created`) 
select url, 'CUSTODY.DOWNLOAD.PATH', 'A', '/data/download/uob/custodyFiles/', 'N',now() from web_site_info group by url;

/* 33_sp_rbsa_altr_sec_exchangerate_data.sql120118_Sagar*/

ALTER TABLE `rbsa`.`sec_exchangerate_data` 
ADD COLUMN `marketSymbol` VARCHAR(20) NULL AFTER `symbol`;

ALTER TABLE `rbsa`.`sec_exchangerate_data` 
CHANGE COLUMN `marketSymbol` `marketSymbol` VARCHAR(20) Default NULL ;

/* 34_sp_invdb_sel_position.sql120118_Sagar*/

USE `invdb`;
DROP procedure IF EXISTS `sel_position`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sel_position`(
  	IN p_logonid  bigint(20),
  	IN p_acctnum  bigint(20) ,
     IN p_advisor VARCHAR(20),
     IN p_rep VARCHAR(20)
 )
BEGIN
 
 	DECLARE tAdvisor VARCHAR(25);
     DECLARE tfilterType   VARCHAR(1);
     
     DECLARE tTotalPos	 DOUBLE;
 	DECLARE tRep VARCHAR(25);
     DECLARE vAdvisor VARCHAR(25);
 
     select advisor into vAdvisor  from user_logon where logonid=p_logonid;
     if(vAdvisor='DEMO') then
 			 set tAdvisor = IFNULL(p_advisor,'%');
              set tRep = IFNULL(p_rep,'%');
     else
 		SELECT 
 		  advisor,
 		  rep
 		INTO tAdvisor, tRep FROM
 		user_advisor_access
 		WHERE logonid = p_logonid;
     
     end if;
         
 	IF (tAdvisor is NOT NULL)
 		THEN set tfilterType = 'A';
 		ELSE set tfilterType = 'O';  
 	END IF;
 
 			select SUM(ext_position.positionValue)
             INTO tTotalPos
 			FROM ext_position
 			WHERE ext_position.acctnum = p_acctnum
 			AND   ext_position.reportDate = ( select max(pos.reportDate) from ext_position pos)
 			;
             
             IF (tTotalPos = 0)
              THEN set tTotalPos = 1;
 			END IF;
 
 	IF (tfilterType = 'O')
 		THEN
 			select
 				 IFNULL(sec_asset_mapping.assetsortorder,9999) * 1000 +
                  IFNULL(sec_asset_mapping.subclasssortorder,9999) as sortorder
 				,ext_position.clientAccountID
 				,ext_position.symbol
 				,ext_position.reportDate
 				,ext_position.side
                 ,ext_position.tradeCurrency
 				,SUM(ext_position.quantity) as quantity
 				,AVG(ext_position.costBasisPrice) costBasisPrice
 				,SUM(ext_position.costBasisMoney) as costBasisMoney
 				,AVG(ext_position.markPrice) markPrice
 				,SUM(ext_position.positionValue) as positionValue
                 ,SUM(ext_position.pnlUnrealized) as fifoPnlUnrealized
                 ,SUM(ext_position.positionValue/tTotalPos) as weight
 				, ext_acct_info.acctnum
                 , IFNULL(ext_acct_info.applicantFName,user_trade_profile.firstname) as firstname
                 , IFNULL(ext_acct_info.applicantLName,user_trade_profile.lastname) as lastname
                 , CONCAT(IFNULL(ext_acct_info.applicantFName,user_trade_profile.firstname),' ',
                  		 IFNULL(ext_acct_info.applicantLName,user_trade_profile.lastname)
                          ) as fullname  
 				,ext_acct_info.rep
 				,ext_acct_info.dateOpened
 				,sec_master.name as description
 				,IFNULL(sec_asset_mapping.assetclass,sec_master.assetclass) as assetclass
 				,IFNULL(sec_asset_mapping.subclass,sec_master.subclass) as subclass
 				,IFNULL(sec_asset_mapping.assetName,sec_master.assetclass) as assetName
 				,IFNULL(sec_asset_mapping.subclassName,sec_master.subclass) as subclassName
                 ,IFNULL(sec_asset_mapping.assetcolor,'#ffffff') as color
                 ,user_trade_profile.theme
 				,user_trade_profile.portfolioName as accountAlias
                 ,ext_position.settleCurrency
 				,SUM(ext_position.settleQty) as settleQty
 				,AVG(ext_position.settlePrice) settlePrice
 				,SUM(ext_position.settleQty * ext_position.settlePrice) as settleCostBasisMoney
 				,AVG(ext_position.settleMarkPrice) settlementMarkPrice
 				,SUM(ext_position.settleMoney) as settleMoney
                 ,SUM(ext_position.settlePnL) as settlePnL
 			FROM ext_position
 				 INNER JOIN ext_acct_info
 				 ON (ext_position.clientAccountID = ext_acct_info.clientAccountID)
 				 INNER JOIN user_trade_profile
 				 ON (ext_acct_info.acctnum = user_trade_profile.acctnum)
 				 INNER JOIN user_access_role
 				 ON (ext_acct_info.acctnum = user_access_role.acctnum
 				 AND  user_access_role.role in ('OWNER', 'USER'))
 				 INNER JOIN user_logon
 				 ON (user_access_role.logonid = user_logon.logonid)
 				 LEFT JOIN sec_master
 				 ON (ext_position.symbol= sec_master.ticker)
 				 LEFT JOIN sec_asset_mapping
 				 ON (sec_master.ticker= sec_asset_mapping.ticker
 				 AND sec_asset_mapping.theme = user_trade_profile.theme)
 			WHERE ext_acct_info.acctnum = p_acctnum
 			AND   user_logon.logonid    = p_logonid
 			AND   ext_position.reportDate = ( select max(pos.reportDate) from ext_position pos)
             GROUP BY
                  sec_asset_mapping.assetsortorder
                 ,sec_asset_mapping.subclasssortorder
 				,ext_position.clientAccountID
 				,ext_position.symbol
 				,ext_position.reportDate
 				,ext_position.side
 				, ext_acct_info.acctnum
                 ,ext_position.tradeCurrency
                 , IFNULL(ext_acct_info.applicantFName,user_trade_profile.firstname)
                 , IFNULL(ext_acct_info.applicantLName,user_trade_profile.lastname)
 				,ext_acct_info.rep
 				,ext_acct_info.dateOpened
 				,sec_master.name
 				,IFNULL(sec_asset_mapping.assetName,sec_master.assetclass)
 				,IFNULL(sec_asset_mapping.assetName,sec_master.assetclass)
 				,sec_master.subclass
                 ,IFNULL(sec_asset_mapping.assetcolor,'#ffffff')
                 ,user_trade_profile.theme
 				,user_trade_profile.portfolioName
                 ,ext_position.settleCurrency
  			ORDER BY 1, ext_position.symbol
 			;
         ELSE
 			select
 				 IFNULL(sec_asset_mapping.assetsortorder,9999) * 1000 +
                  IFNULL(sec_asset_mapping.subclasssortorder,9999) as sortorder
 				,ext_position.clientAccountID
 				,ext_position.symbol
 				,ext_position.reportDate
 				,ext_position.side
                 ,ext_position.tradeCurrency
 				,SUM(ext_position.quantity) as quantity
 				,AVG(ext_position.costBasisPrice) costBasisPrice
 				,SUM(ext_position.costBasisMoney) as costBasisMoney
 				,AVG(ext_position.markPrice) markPrice
 				,SUM(ext_position.positionValue) as positionValue
                 ,SUM(ext_position.pnlUnrealized) as fifoPnlUnrealized
                 ,SUM(ext_position.positionValue/tTotalPos) as weight
 				, ext_acct_info.acctnum
                 , IFNULL(ext_acct_info.applicantFName,user_trade_profile.firstname) as firstname
                 , IFNULL(ext_acct_info.applicantLName,user_trade_profile.lastname) as lastname
                 , CONCAT(IFNULL(ext_acct_info.applicantFName,user_trade_profile.firstname),' ',
                  		 IFNULL(ext_acct_info.applicantLName,user_trade_profile.lastname)
                          ) as fullname  
 				,ext_acct_info.rep
 				,ext_acct_info.dateOpened
 				,sec_master.name as description
 				,IFNULL(sec_asset_mapping.assetclass,sec_master.assetclass) as assetclass
 				,IFNULL(sec_asset_mapping.subclass,sec_master.subclass) as subclass
 				,IFNULL(sec_asset_mapping.assetName,sec_master.assetclass) as assetName
 				,IFNULL(sec_asset_mapping.subclassName,sec_master.subclass) as subclassName
                 ,IFNULL(sec_asset_mapping.assetcolor,'#ffffff') as color
                 ,user_trade_profile.theme
 				,user_trade_profile.portfolioName as accountAlias
                 ,ext_position.settleCurrency
 				,SUM(ext_position.settleQty) as settleQty
 				,AVG(ext_position.settlePrice) settlePrice
 				,SUM(ext_position.settleQty * ext_position.settlePrice) as settleCostBasisMoney
 				,AVG(ext_position.settleMarkPrice) settlementMarkPrice
 				,SUM(ext_position.settleMoney) as settleMoney
                 ,SUM(ext_position.settlePnL) as settlePnL
 		FROM ext_position
 				 INNER JOIN ext_acct_info
 				 ON (ext_position.clientAccountID = ext_acct_info.clientAccountID)
 				 INNER JOIN user_trade_profile
 				 ON (ext_acct_info.acctnum = user_trade_profile.acctnum)				 
 				 LEFT JOIN sec_master
 				 ON (ext_position.symbol= sec_master.ticker)
 				 LEFT JOIN sec_asset_mapping
 				 ON (sec_master.ticker= sec_asset_mapping.ticker
 				 AND sec_asset_mapping.theme = user_trade_profile.theme)
 			WHERE ext_acct_info.acctnum = p_acctnum
 			AND   IFNULL(user_trade_profile.advisor,'Invessence') like tAdvisor
             AND   IFNULL(user_trade_profile.rep, 'CATCALL') LIKE tRep
 			AND   ext_position.reportDate = ( select max(pos.reportDate) from ext_position pos)
             GROUP BY
                  sec_asset_mapping.assetsortorder
                 ,sec_asset_mapping.subclasssortorder
 				,ext_position.clientAccountID
 				,ext_position.symbol
 				,ext_position.reportDate
 				,ext_position.side
 				, ext_acct_info.acctnum
                 ,ext_position.tradeCurrency
                 , IFNULL(ext_acct_info.applicantFName,user_trade_profile.firstname)
                 , IFNULL(ext_acct_info.applicantLName,user_trade_profile.lastname)
 				,ext_acct_info.rep
 				,ext_acct_info.dateOpened
 				,sec_master.name
 				,IFNULL(sec_asset_mapping.assetName,sec_master.assetclass)
 				,IFNULL(sec_asset_mapping.assetName,sec_master.assetclass)
 				,sec_master.subclass
                 ,IFNULL(sec_asset_mapping.assetcolor,'#ffffff')
                 ,user_trade_profile.theme
 				,user_trade_profile.portfolioName
                 ,ext_position.settleCurrency
                 ,sec_asset_mapping.assetsortorder
                 ,sec_asset_mapping.subclasssortorder
 			ORDER BY 1, ext_position.symbol
 			;
 	END IF;
 
 
 
 END$$

DELIMITER ;


/* 35_sp_invdb_save_user_trade_profile.sql120118_Sagar*/

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




