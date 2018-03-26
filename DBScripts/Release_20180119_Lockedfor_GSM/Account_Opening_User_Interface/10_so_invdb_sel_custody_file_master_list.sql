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

