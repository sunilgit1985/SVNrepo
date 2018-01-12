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

