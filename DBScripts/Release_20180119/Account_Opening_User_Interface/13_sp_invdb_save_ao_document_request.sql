USE `invdb`;
DROP procedure IF EXISTS `save_ao_document_request`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `save_ao_document_request`(in p_product varchar(50),in p_acctnum bigint(20),in p_advisorid int,in p_reqType varchar(45))
begin
declare p_insrtId int;
insert into invdb.ao_requests (product,acctnum,advisorid,eventNum,reqType,reqHeading,status,action,subaction,created)
select p_product,p_acctnum,p_advisorid,1,reqType,envelopeHeading,'A',action,subaction,now() from invdb.adv_request_document_mappings where reqType=p_reqType;

select LAST_INSERT_ID() into p_insrtId;


insert into invdb.ao_requests_final (refReqId,product,acctnum,advisorid,eventNum,reqType,seqno,reqHeading,status,formType,created)
select p_insrtId,p_product,p_acctnum,p_advisorid,1,ardm.reqType,seqno,reqHeading,'A',formType,now()
from invdb.ao_requests ar
join invdb.adv_request_document_mappings ardm on(ar.action=ardm.action )
where ar.reqId= p_insrtId and (ardm.subaction='DEFAULT' or ardm.subaction=p_reqType) and acctnum=p_acctnum and templateId='UOBInternal';

select concat(p_insrtId,',1') as 'EventNo';

end$$

DELIMITER ;

