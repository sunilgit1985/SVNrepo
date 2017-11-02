drop procedure if exists invdb.sel_transaction_dtls;
delimiter $$
CREATE PROCEDURE invdb.sel_transaction_dtls(
 IN p_logonid  bigint(20),
 IN p_acctnum  bigint(20) ,
 IN p_advisor VARCHAR(20),
 IN p_rep VARCHAR(20),
 IN p_trnstatus varchar(10))
 BEGIN
   
 DECLARE tAdvisor VARCHAR(25);
 DECLARE tfilterType   VARCHAR(1);
 DECLARE tRep VARCHAR(25);
 DECLARE vAdvisor VARCHAR(25);
   
 select advisor into vAdvisor  from user_logon where logonid=p_logonid;
 
 if(vAdvisor='DEMO') then
 	set tAdvisor = IFNULL(p_advisor,'%');
 	set tRep = IFNULL(p_rep,'%');
 else
 	SELECT 
 		advisor,rep	INTO tAdvisor, tRep 
     FROM
 		user_advisor_access
 	WHERE 
 		logonid = p_logonid;      
 end if;
           
 IF (tAdvisor is NOT NULL)
 	THEN set tfilterType = 'A';
 	ELSE set tfilterType = 'O';  
 END IF;  
   
 IF (tfilterType = 'O')THEN
 	select 
 		IFNULL(sam.assetsortorder,9999) * 1000 +IFNULL(sam.subclasssortorder,9999) as sortorder
 		,IFNULL(sam.assetclass,sm.assetclass) as assetclass
 		,IFNULL(sam.subclass,sm.subclass) as subclass
 		,IFNULL(sam.assetName,sm.assetclass) as assetName
 		,IFNULL(sam.subclassName,sm.subclass) as subclassName
 		,IFNULL(sam.assetcolor,'#ffffff') as color
 		,et.acctnum,et.clientAccountID
 		,IFNULL(eai.applicantFName,utp.firstname) as firstname
 		,IFNULL(eai.applicantLName,utp.lastname) as lastname
 		,CONCAT(IFNULL(eai.applicantFName,utp.firstname),' ',IFNULL(eai.applicantLName,utp.lastname)) as fullname
 		,eai.rep
 		,eai.dateOpened
 		,et.ticker
 		,sm.name as description
 		,utp.theme
 		,utp.customName as accountAlias
 		,et.isin
 		,et.confirmNumber
 		,et.transactionSource
 		,et.transactionType
 		,et.transactionStatus
 		,et.controlNumber
 		,et.quantity
 		,et.price
 		,et.netAmount
 		,et.commission
 		,et.otherFees
 		,et.tradeDate
 		,et.settDate
 		,et.voidDate
 		,et.comment
 		,et.tradedCurrency
 		,et.fxRateToBase
 		,et.settleCurrency
 		,et.settleQty
 		,et.settlePrice
 		,et.settleNetAmount
 		,et.settleFees
 		,et.created
 	 from 
 		ext_transaction et
 		INNER JOIN ext_acct_info eai
 		ON (et.clientAccountID = eai.clientAccountID)
 		 INNER JOIN user_trade_profile utp
 		 ON (eai.acctnum = utp.acctnum)
 		 INNER JOIN user_access_role uar
 		 ON (eai.acctnum = uar.acctnum
 		 AND  uar.role in ('OWNER', 'USER'))
 		 INNER JOIN user_logon ul
 		 ON (uar.logonid = ul.logonid)
 		 LEFT JOIN sec_master sm
 		 ON (et.ticker= sm.ticker)
 		 LEFT JOIN sec_asset_mapping sam
 		 ON (sm.ticker= sam.ticker
 		 AND sam.theme = utp.theme)
 	WHERE
 		eai.acctnum = p_acctnum
 		AND ul.logonid= p_logonid
 		AND et.transactionStatus=p_trnstatus
 	GROUP BY
 		sam.assetsortorder
 		,sam.subclasssortorder
 		,et.clientAccountID
 		,et.ticker
 		, eai.acctnum
 		,et.tradedCurrency
 		, IFNULL(eai.applicantFName,utp.firstname)
 		, IFNULL(eai.applicantLName,utp.lastname)
 		,eai.rep
 		,eai.dateOpened
 		,sm.name
 		,IFNULL(sam.assetName,sm.assetclass)
 		,IFNULL(sam.assetName,sm.assetclass)
 		,sm.subclass
 		,IFNULL(sam.assetcolor,'#ffffff')
 		,utp.theme
 		,utp.customName
 		,et.settleCurrency
 	ORDER BY 1, et.ticker;  	
  ELSE
 	select 
 		IFNULL(sam.assetsortorder,9999) * 1000 +IFNULL(sam.subclasssortorder,9999) as sortorder
 		,IFNULL(sam.assetclass,sm.assetclass) as assetclass
 		,IFNULL(sam.subclass,sm.subclass) as subclass
 		,IFNULL(sam.assetName,sm.assetclass) as assetName
 		,IFNULL(sam.subclassName,sm.subclass) as subclassName
 		,IFNULL(sam.assetcolor,'#ffffff') as color
 		,et.acctnum,et.clientAccountID
 		,IFNULL(eai.applicantFName,utp.firstname) as firstname
 		,IFNULL(eai.applicantLName,utp.lastname) as lastname
 		,CONCAT(IFNULL(eai.applicantFName,utp.firstname),' ',IFNULL(eai.applicantLName,utp.lastname)) as fullname
 		,eai.rep
 		,eai.dateOpened
 		,et.ticker
 		,sm.name as description
 		,utp.theme
 		,utp.customName as accountAlias
 		,et.isin
 		,et.confirmNumber
 		,et.transactionSource
 		,et.transactionType
 		,et.transactionStatus
 		,et.controlNumber
 		,et.quantity
 		,et.price
 		,et.netAmount
 		,et.commission
 		,et.otherFees
 		,et.tradeDate
 		,et.settDate
 		,et.voidDate
 		,et.comment
 		,et.tradedCurrency
 		,et.fxRateToBase
 		,et.settleCurrency
 		,et.settleQty
 		,et.settlePrice
 		,et.settleNetAmount
 		,et.settleFees
 		,et.created
 	 from 
 		ext_transaction et
 		INNER JOIN ext_acct_info eai
 		ON (et.clientAccountID = eai.clientAccountID)
 		 INNER JOIN user_trade_profile utp
 		 ON (eai.acctnum = utp.acctnum)
 		 INNER JOIN user_access_role uar
 		 ON (eai.acctnum = uar.acctnum
 		 AND  uar.role in ('OWNER', 'USER'))
 		 INNER JOIN user_logon ul
 		 ON (uar.logonid = ul.logonid)
 		 LEFT JOIN sec_master sm
 		 ON (et.ticker= sm.ticker)
 		 LEFT JOIN sec_asset_mapping sam
 		 ON (sm.ticker= sam.ticker
 		 AND sam.theme = utp.theme)
 	WHERE
 		eai.acctnum = p_acctnum
 		AND et.transactionStatus=p_trnstatus
 		AND IFNULL(utp.advisor,'Invessence') like tAdvisor
 		AND IFNULL(utp.rep, 'CATCALL') LIKE tRep
 	GROUP BY
 		sam.assetsortorder
 		,sam.subclasssortorder
 		,et.clientAccountID
 		,et.ticker
 		, eai.acctnum
 		,et.tradedCurrency
 		, IFNULL(eai.applicantFName,utp.firstname)
 		, IFNULL(eai.applicantLName,utp.lastname)
 		,eai.rep
 		,eai.dateOpened
 		,sm.name
 		,IFNULL(sam.assetName,sm.assetclass)
 		,IFNULL(sam.assetName,sm.assetclass)
 		,sm.subclass
 		,IFNULL(sam.assetcolor,'#ffffff')
 		,utp.theme
 		,utp.customName
 		,et.settleCurrency
 	ORDER BY 1, et.ticker;  
 End if;
 END