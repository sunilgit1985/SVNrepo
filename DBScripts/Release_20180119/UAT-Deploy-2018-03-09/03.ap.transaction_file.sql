UPDATE `service`.`file_details` SET `parentPostDBProcess`='temp.sp_trade_process_both_update', `postDBProcess`='' WHERE `vendor`='UOB' and`fileName`='CLNTORD' and`processId`='DOWD1' and`seqNo`='1';
UPDATE `service`.`file_details` SET `parentPostDBProcess`='temp.sp_trade_process_both_update' WHERE `vendor`='UOB' and`fileName`='CLNTORDISIN' and`processId`='DOWD1' and`seqNo`='2';


update service.file_process_rules set seqNo= seqNo+2 where fileId in('UOB_ORDER_PROCESSING_FILE') and seqNo>2 order by fileId, seqNo; 


INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE', 'SEDOL', 'Sedol', '3', '23', '26', '4', 'TEXT', '0', 'Y', ',', 'Left', 'sedol', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE', 'RIC', 'Ric', '4', '23', '26', '4', 'TEXT', '0', 'Y', ',', 'Left', 'ric', 'Y', 'N');


update service.file_process_rules set seqNo= seqNo+2 where fileId in('UOB_ORDER_PROCESSING_FILE_ISIN_WISE') and seqNo>1 order by fileId, seqNo; 

INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE_ISIN_WISE', 'SEDOL', 'Sedol', '2', '23', '26', '4', 'TEXT', '0', 'Y', ',', 'Left', 'sedol', 'Y', 'N');
INSERT INTO `service`.`file_process_rules` (`fileId`, `dataField`, `description`, `seqNo`, `startPos`, `endPos`, `length`, `type`, `decimals`, `isDelimited`, `delimiter`, `justified`, `dbColumn`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ORDER_PROCESSING_FILE_ISIN_WISE', 'RIC', 'Ric', '3', '23', '26', '4', 'TEXT', '0', 'Y', ',', 'Left', 'ric', 'Y', 'N');



