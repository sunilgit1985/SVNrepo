drop procedure if exists invdb.sel_virtual_position;
delimiter $$
CREATE PROCEDURE invdb.sel_virtual_position(
    	IN p_logonid  bigint(20),
    	IN p_acctnum  bigint(20) ,
       IN p_advisor VARCHAR(20),
       IN p_rep VARCHAR(20)
   )
 BEGIN
  	DECLARE tAdvisor VARCHAR(25);
      DECLARE tfilterType   VARCHAR(1);
      DECLARE tTotalPos	 DOUBLE;
   	DECLARE tRep VARCHAR(25);
      DECLARE vAdvisor VARCHAR(25);
      
      select advisor into vAdvisor  from user_logon where logonid=p_logonid;
      
      if(vAdvisor='DEMO') then
  		set tAdvisor = IFNULL(p_advisor,'');
          set tRep = IFNULL(p_rep,'');
       else
   		SELECT advisor, rep INTO tAdvisor, tRep 
          FROM invdb.user_advisor_access
   		WHERE logonid = p_logonid;     
       end if;
           
   	IF (tAdvisor is NOT NULL) THEN 
  		set tfilterType = 'A';
  	ELSE 
  		set tfilterType = 'O';  
   	END IF;
   
  	select SUM(ext_position.positionValue) INTO tTotalPos
  	FROM invdb.ext_position
  	WHERE ext_position.acctnum = p_acctnum AND   ext_position.reportDate = ( select max(pos.reportDate) from ext_position pos);
      
      IF (tTotalPos = 0) THEN 
  		set tTotalPos = 1;
  	END IF;
   
   	IF (tfilterType = 'O') THEN
  		select vp.acctnum, itemnum, -- vp.instrumentid, 
         sec_master.ticker as symbol,qty as quantity,
          weight,investmentvalue as costBasisPrice,sec_asset_mapping.assetclass, assetName, assetcolor as color, assetsortorder
   		FROM 
   			invdb.virtual_portfolio vp
   			INNER JOIN user_trade_profile ON (vp.acctnum = user_trade_profile.acctnum)
   			INNER JOIN user_access_role ON (vp.acctnum = user_access_role.acctnum AND  user_access_role.role in ('OWNER', 'USER'))
   			INNER JOIN user_logon ON (user_access_role.logonid = user_logon.logonid)
   			LEFT JOIN sec_master ON (vp.ticker= sec_master.ticker)
   			LEFT JOIN sec_asset_mapping ON (sec_master.ticker= sec_asset_mapping.ticker AND sec_asset_mapping.theme = user_trade_profile.theme)
   		WHERE 
   			vp.acctnum = p_acctnum AND user_logon.logonid = p_logonid 
           GROUP BY 
   			IFNULL(sec_asset_mapping.subclasssortorder,9999)
   			,vp.acctnum
   			,vp.ticker
   			,sec_master.name
   			,IFNULL(sec_asset_mapping.assetName,sec_master.assetclass)
   			,IFNULL(sec_asset_mapping.assetName,sec_master.assetclass)
   			,sec_master.subclass
   			 ,IFNULL(sec_asset_mapping.assetcolor,'#ffffff')
   			 ,user_trade_profile.theme
   			,user_trade_profile.portfolioName
   		ORDER BY 
   			1, sec_master.assetclass, vp.ticker;
  	ELSE
  		select vp.acctnum, itemnum, -- vp.instrumentid, 
         sec_master.ticker as symbol,qty as quantity,
          weight,investmentvalue as costBasisPrice,sec_asset_mapping.assetclass, assetName, assetcolor as color, assetsortorder
   		FROM 
   			invdb.virtual_portfolio vp
   			INNER JOIN user_trade_profile ON (vp.acctnum = user_trade_profile.acctnum)
   			INNER JOIN user_access_role ON (vp.acctnum = user_access_role.acctnum AND  user_access_role.role in ('OWNER', 'USER'))
   			INNER JOIN user_logon ON (user_access_role.logonid = user_logon.logonid)
   			LEFT JOIN sec_master ON (vp.ticker= sec_master.ticker)
   			LEFT JOIN sec_asset_mapping ON (sec_master.ticker= sec_asset_mapping.ticker AND sec_asset_mapping.theme = user_trade_profile.theme)
   		WHERE 
   			vp.acctnum = p_acctnum AND IFNULL(user_trade_profile.advisor,'Invessence') like tAdvisor
  			AND IFNULL(user_trade_profile.rep, 'CATCALL') LIKE tRep
           GROUP BY 
   			IFNULL(sec_asset_mapping.subclasssortorder,9999)
   			,vp.acctnum
   			,vp.ticker
   			,sec_master.name
   			,IFNULL(sec_asset_mapping.assetName,sec_master.assetclass)
   			,IFNULL(sec_asset_mapping.assetName,sec_master.assetclass)
   			,sec_master.subclass
   			 ,IFNULL(sec_asset_mapping.assetcolor,'#ffffff')
   			 ,user_trade_profile.theme
   			,user_trade_profile.portfolioName
   		ORDER BY 
   			1, sec_master.assetclass, vp.ticker;
   	END IF; 
   END