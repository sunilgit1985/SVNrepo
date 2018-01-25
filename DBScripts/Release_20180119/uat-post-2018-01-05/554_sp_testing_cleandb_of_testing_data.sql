USE `testing`;
DROP procedure IF EXISTS `cleandb_of_testing_data`;

DELIMITER $$
USE `testing`$$
CREATE  PROCEDURE `cleandb_of_testing_data`(
    p_action	VARCHAR(3),
	p_acctum	BIGINT
)
BEGIN

	SET SQL_SAFE_UPDATES = 0;

	DROP TEMPORARY TABLE IF EXISTS cleanacct;
	CREATE TEMPORARY TABLE cleanacct(
		acctnum	BIGINT(20)
	);
    
    IF (p_acctum is null)
    THEN
		IF (IFNULL(p_action,'XXX') = 'ALL')
        THEN
			INSERT INTO cleanacct
			SELECT acctnum from `testing`.`cleanup_acct`;
		ELSE 
			INSERT INTO cleanacct
			SELECT acctnum from invdb.user_access_role
			WHERE logonid < 100
			AND acctnum not in (SELECT acctnum from invdb.ext_acct_info where clientAccountID not like 'TST%')
			and acctnum > 1000
			;
			
			INSERT INTO cleanacct
			select user_access_role.acctnum 
			from invdb.user_logon, invdb.user_access_role
			where user_logon.logonid = user_access_role.logonid
			and user_logon.email like '%@invessence.com'
			and user_logon.logonid > 100
			and user_logon.logonstatus not in ('A', 'L');

		END IF;
			
        
    ELSE
		INSERT INTO cleanacct
		VALUES
		(p_acctnum)
		;
    END IF;
    
    
    DELETE FROM invdb.`acct_ben`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`acct_financial`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`acct_info`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`acct_risk_data`
    where acctnum in (select distinct acctnum from cleanacct);
    
   DELETE FROM invdb.`acct_trade_preference`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`actual_portfolio`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`advisor_notification`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`asset_alloc`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`clients_to_trade`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`dc_acct_owners_details_history`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`dc_acct_transfer_details`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`dc_benefiaciary_details`
    where acctnum in (select distinct acctnum from cleanacct);

    -- DELETE FROM invdb.`dc_decedent_information`
    -- where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_dup_doc_req_party`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_employment_details`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_ach_bank_details`
    where moveMoneyPayMethodID in (select distinct moveMoneyPayMethodID from cleanacct, invdb.dc_elecfund_transfer_details where cleanacct.acctnum = dc_elecfund_transfer_details.acctnum);

    DELETE FROM invdb.`dc_fedwire_acct_details`
    where moveMoneyPayMethodID in (select distinct moveMoneyPayMethodID from cleanacct, invdb.dc_elecfund_transfer_details where cleanacct.acctnum = dc_elecfund_transfer_details.acctnum);

    DELETE FROM invdb.`dc_internal_transfer_details`
    where moveMoneyPayMethodID in (select distinct moveMoneyPayMethodID from cleanacct, invdb.dc_elecfund_transfer_details where cleanacct.acctnum = dc_elecfund_transfer_details.acctnum);

    DELETE FROM invdb.`dc_elecfund_transfer_details`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_move_money_details`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`dc_mp_movemoney_paymethod`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_td_transfer_details`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_visa_details`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_request_audit`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_requests`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`dc_requests_final`
    where acctnum in (select distinct acctnum from cleanacct);


    DELETE FROM invdb.`cash_report`
    where clientAccountID in (select distinct clientAccountID from cleanacct, invdb.ext_acct_info where cleanacct.acctnum = ext_acct_info.acctnum);
    
    DELETE FROM invdb.`cash_transaction`
    where clientAccountID in (select distinct clientAccountID from cleanacct, invdb.ext_acct_info where cleanacct.acctnum = ext_acct_info.acctnum);
    
    DELETE FROM invdb.`commission`
    where clientAccountID in (select distinct clientAccountID from cleanacct, invdb.ext_acct_info where cleanacct.acctnum = ext_acct_info.acctnum);

    DELETE FROM invdb.`ext_nav`
    where clientAccountID in (select distinct clientAccountID from cleanacct, invdb.ext_acct_info where cleanacct.acctnum = ext_acct_info.acctnum);

	DELETE FROM invdb.`ext_position`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`ext_transaction`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`pretrade_details`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`rebalance_info`
    where acctnum in (select distinct acctnum from cleanacct);
    
	/*
    DELETE FROM invdb.`rebalance_trade`
    where acctnum in (select distinct acctnum from cleanacct);
    */

    DELETE FROM invdb.`relAndunrel`
    where clientAccountID in (select distinct clientAccountID from cleanacct, invdb.ext_acct_info where cleanacct.acctnum = ext_acct_info.acctnum);

	/*
    DELETE FROM invdb.`sav_acct_financial`
    where acctnum in (select distinct acctnum from cleanacct);
    */

    DELETE FROM invdb.`position`
    where clientAccountID in (select distinct clientAccountID from cleanacct, invdb.ext_acct_info where cleanacct.acctnum = ext_acct_info.acctnum);
    
    DELETE FROM invdb.`trades`
    where clientAccountID in (select distinct clientAccountID from cleanacct, invdb.ext_acct_info where cleanacct.acctnum = ext_acct_info.acctnum);
   
	DELETE FROM invdb.`unbundld_commission`
    where clientAccountID in (select distinct clientAccountID from cleanacct, invdb.ext_acct_info where cleanacct.acctnum = ext_acct_info.acctnum);

	/*
	DELETE FROM invdb.`user_exclude_subclass`
    where acctnum in (select distinct acctnum from cleanacct);
    */

    DELETE FROM invdb.`user_notification`
    where logonid in (select distinct logonid from cleanacct, invdb.user_access_role where cleanacct.acctnum = user_access_role.acctnum);

	DELETE FROM invdb.`user_reports`
    where acctnum in (select distinct acctnum from cleanacct);
    
	DELETE FROM invdb.`user_risk_questions`
    where acctnum in (select distinct acctnum from cleanacct);
    
	DELETE FROM invdb.`user_risk_questions_audit`
    where acctnum in (select distinct acctnum from cleanacct);

	DELETE FROM invdb.`virtual_portfolio`
    where acctnum in (select distinct acctnum from cleanacct);

	DELETE FROM invdb.`visitor`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`ext_acct_info`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`user_trade_log`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`user_trade_profile_audit`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`user_risk_profile`
    where acctnum in (select distinct acctnum from cleanacct);
    
    DELETE FROM invdb.`user_risk_score`
    where acctnum in (select distinct acctnum from cleanacct);

    DELETE FROM invdb.`user_trade_profile`
    where acctnum in (select distinct acctnum from cleanacct);
    
		DELETE FROM `invdb`.`user_logon`
		WHERE logonid > 100
		AND   logonstatus not in ('A', 'L')
		and   logonid in (select logonid from invdb.`user_access_role`
							where acctnum in (select distinct acctnum from cleanacct));

		DELETE FROM invdb.`user_access_role`
		where acctnum in (select distinct acctnum from cleanacct);

    
    DELETE FROM invdb.`user_logon_exception`;
    
    
	SET SQL_SAFE_UPDATES = 0;

END$$

DELIMITER ;
