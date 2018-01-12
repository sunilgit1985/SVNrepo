USE `invdb`;
DROP procedure IF EXISTS `sp_advisor_base_rep_lst`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sp_advisor_base_rep_lst`(in p_advisor varchar(20))
begin 

select logonid, advisor,rep,accttype,companyname, displayName, logo, advisor_css from invdb.user_advisor_info where advisor=p_advisor;

end$$

DELIMITER ;

