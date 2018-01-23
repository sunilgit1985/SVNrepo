drop procedure if exists invdb.sp_custody_fund_save;
delimiter $$
create procedure invdb.sp_custody_fund_save(in p_acctnum bigint,in p_clientAccountID varchar(12),in p_investmentDate varchar(12),in p_netAmount double,in p_status varchar(25))
begin 
insert into invdb.ext_investment(acctnum,clientAccountID,investmentDate,netAmount,status,created)
values(p_acctnum,p_clientAccountID,p_investmentDate,p_netAmount,p_status,now());
end;
