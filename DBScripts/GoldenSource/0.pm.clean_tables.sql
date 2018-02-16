truncate table invdb.acct_financial;  -- user data
truncate table invdb.actual_portfolio; -- to drop
truncate table invdb.aggr_mx_audit;
truncate table `invdb`.`asset_alloc`; -- pretrade asset allocation

truncate table invdb.cash_transaction; -- IB data
truncate table `invdb`.`clients_to_trade`;  -- To drop,not used in new design
truncate table `invdb`.`commission`; -- IB data
truncate table `invdb`.`crm_redtail_audit`; -- redtails audit data
truncate table `invdb`.`crm_user_logon`; -- redtail logon

-- All tables that starts with dc are Docusign process
DELETE FROM `invdb`.`dc_acct_details`;
DELETE FROM `invdb`.`dc_acct_owners_details`;
DELETE FROM `invdb`.`dc_acct_owners_details_history`;
DELETE FROM `invdb`.`dc_acct_transfer_details`;
DELETE FROM  invdb.dc_ach_bank_details;
DELETE FROM `invdb`.`dc_advisor_details`;
DELETE FROM `invdb`.`dc_benefiaciary_details`;
DELETE FROM `invdb`.`dc_decedent_information`;
DELETE FROM `invdb`.`dc_dup_doc_req_party`;
DELETE FROM `invdb`.`dc_elecfund_transfer_details`;
DELETE FROM `invdb`.`dc_employment_details`;
DELETE FROM `invdb`.`dc_internal_transfer_details`;
DELETE FROM `invdb`.`dc_move_money_details`;
DELETE FROM `invdb`.`dc_mp_movemoney_paymethod`;
DELETE FROM `invdb`.`dc_request_audit`;
DELETE FROM `invdb`.`dc_requests`;
DELETE FROM `invdb`.`dc_requests_final`;
DELETE FROM `invdb`.`dc_td_transfer_details`;
DELETE FROM `invdb`.`dc_visa_details`;
DELETE FROM `invdb`.`joint_info`;

-- -----------------
DELETE FROM `invdb`.`email_alerts`;
DELETE FROM `invdb`.`email_messages`;

DROP table `invdb`.`historical_index`;
DELETE FROM `invdb`.`internal_alerts`;

DELETE FROM `invdb`.`inv_date_table`;
DELETE FROM `invdb`.`inv_monthly_date_table`;
DELETE FROM invdb.login_audit;
DELETE FROM `invdb`.`monthly_date_table`;
DELETE FROM `invdb`.`performance_info`;
DELETE FROM `invdb`.`pretrade_details`;
DELETE FROM `invdb`.`rebalance_info`;
DELETE FROM `invdb`.`rebalance_positions`;
DELETE FROM `invdb`.`rebalance_trade`;
DELETE FROM `invdb`.`registration_audit`;
DELETE FROM `invdb`.`relAndunrel`; -- IB data

DELETE FROM `invdb`.`trade_process_identifier`;
DELETE FROM `invdb`.`trades`;
DELETE FROM `invdb`.`unbundld_commission`;

DELETE FROM `invdb`.`user_logon_exception`;
DELETE FROM `invdb`.`user_notification`;
DELETE FROM `invdb`.`user_reports`;
DELETE FROM `invdb`.`user_risk_questions`;
DELETE FROM `invdb`.`user_risk_questions_audit`;
DELETE FROM `invdb`.`user_trade_log`;
DELETE FROM `invdb`.`user_trade_profile_audit`;
DELETE FROM `invdb`.`virtual_portfolio`;
DELETE FROM `invdb`.`visitor`;
DELETE FROM `invdb`.`yahoo_prices`;

--  Keep All Yodlee data ydl 

-- Specific cleanup
DELETE FROM `invdb`.`user_trade_profile` where acctnum > 2000;
DELETE FROM `invdb`.`user_logon` where logonid > 1000;
DELETE FROM `invdb`.`user_access_role` where acctnum > 2000;








































