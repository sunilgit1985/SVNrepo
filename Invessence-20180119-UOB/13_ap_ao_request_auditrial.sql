USE `invdb`;
DROP procedure IF EXISTS `ao_request_auditrial`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `ao_request_auditrial`(
in p_id numeric(10),
in p_product varchar(50),
in p_mode varchar(20),
in p_requestIds varchar(100),
in p_acctNum varchar(12),
in p_eventNum varchar(12),
in p_reqAckwNum varchar(100),
in p_status varchar(1),
in p_aoRequest varchar(5000),
in p_aoResponce  varchar(1000),
in p_reqTime  datetime,
in p_resTime   datetime,
in p_remarks varchar(1000),
in p_opt varchar(20),
out op_msgCode int(3),out op_msg varchar(20))
BEGIN

if(p_opt='INSERT') then
	Insert into ao_request_audit(product, mode, requestIds,acctnum,eventNum, aoRequest, aoResponce, status, remarks, reqTime, resTime)
    value(p_product, p_mode, p_requestIds,p_acctNum, p_eventNum, p_aoRequest, p_aoResponce, p_status, p_remarks, p_reqTime, p_resTime);

    if(p_status='S') then
		update ao_requests_final set status='S' , reqAckwNum =p_reqAckwNum where acctnum=p_acctNum and eventNum=p_eventNum and status='I';
        update ao_requests set status='S' , reqAckwNum =p_reqAckwNum where reqId in(select distinct(refReqId) from ao_requests_final where acctnum=p_acctNum and eventNum=p_eventNum);
    elseif(p_status='E') then
		update ao_requests_final set status='E' where acctnum=p_acctNum and eventNum=p_eventNum and status='I';
        update ao_requests set status='E' where reqId in(select distinct(refReqId) from ao_requests_final where acctnum=p_acctNum and eventNum=p_eventNum);
    else
		update ao_requests_final set status='X' where acctnum=p_acctNum and eventNum=p_eventNum and status='I';
        update ao_requests set status='X' where reqId in(select distinct(refReqId) from ao_requests_final where acctnum=p_acctNum and eventNum=p_eventNum);

    end if;

	SELECT p_opt, 1 INTO op_msg , op_msgCode;

end if;
END$$

DELIMITER ;

