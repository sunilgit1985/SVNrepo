
UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Singapore & Singapore PR NRIC (Provide front copy)' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='NRIC' and`seqno`='1';
UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Singapore & Singapore PR NRIC (Provide back copy)' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='NRIC' and`seqno`='2';
UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Malaysian IC (Provide front copy)' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='MYKAD' and`seqno`='1';
UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Malaysian IC (Provide back copy)' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='MYKAD' and`seqno`='2';
UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Passport (For Other Nationalities)' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='Passport' and`seqno`='1';
UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Bank Statement (For Remittance Standing Instruction)' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='BNK_STMT' and`seqno`='3';
UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Bank Statement (For Remittance Standing Instruction)' WHERE `product`='UOB' and`action`='ACCT_OPEN_EXISTING_USER' and`subaction`='BNK_STMT' and`seqno`='1';
UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Proof of Residential address' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='Res_Proof' and`seqno`='4';
UPDATE `invdb`.`custody_file_master` SET `fileLabel`='Proof of Mailing  address' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='Add_Res_Proof' and`seqno`='5';
UPDATE `invdb`.`custody_file_master` SET `fileName`='Declarations.pdf' WHERE `product`='UOB' and`action`='ACCT_OPEN_NEW_USER' and`subaction`='MasterTradeAgreement' and`seqno`='1';
