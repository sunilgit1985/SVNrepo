update `invdb`.`user_trade_profile`
set `user_trade_profile`.`status` = 'V'
where `user_trade_profile`.`acctnum` not in (select `acctnum` from `invdb`.`user_access_role` where `role` = 'OWNER');

update `invdb`.`user_trade_profile`
set `user_trade_profile`.`status` = 'N'
where `user_trade_profile`.`status` = 'V'
and `user_trade_profile`.`acctnum` in (select `acctnum` from `invdb`.`user_access_role` where `role` = 'OWNER');
