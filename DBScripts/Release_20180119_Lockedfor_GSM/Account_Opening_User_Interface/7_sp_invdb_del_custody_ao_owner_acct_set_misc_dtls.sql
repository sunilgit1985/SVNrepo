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

