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

