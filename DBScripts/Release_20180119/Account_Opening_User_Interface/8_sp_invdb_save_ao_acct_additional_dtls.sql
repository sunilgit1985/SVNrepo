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

