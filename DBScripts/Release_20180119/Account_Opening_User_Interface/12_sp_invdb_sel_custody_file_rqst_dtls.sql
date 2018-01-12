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

