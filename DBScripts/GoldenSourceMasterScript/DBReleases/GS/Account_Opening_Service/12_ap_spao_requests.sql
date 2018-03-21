USE `invdb`;
DROP procedure IF EXISTS `spao_requests`;

DELIMITER $$
USE `invdb`$$
CREATE  PROCEDURE `spao_requests`(`p_acctnum` bigint(20),`p_eventnum` int(2))
BEGIN

declare v_acc_deta_count int;

/* select count(1) into v_acc_deta_count from invdb.ao_acct_details where acctnum=p_acctnum;
if(v_acc_deta_count=0)then
	select * from invdb.ao_acct_details where 1=2;
else*/
	select * from invdb.ao_requests_final where acctnum=p_acctnum and eventNum=p_eventnum 
    and refReqId=(select max(refReqId) from invdb.ao_requests_final where acctnum=p_acctnum and eventNum=p_eventnum ) 
    order by eventNum, seqno;

END$$

DELIMITER ;

