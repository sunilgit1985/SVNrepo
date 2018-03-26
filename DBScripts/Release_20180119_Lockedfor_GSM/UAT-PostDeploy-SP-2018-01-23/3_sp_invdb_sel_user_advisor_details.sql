
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