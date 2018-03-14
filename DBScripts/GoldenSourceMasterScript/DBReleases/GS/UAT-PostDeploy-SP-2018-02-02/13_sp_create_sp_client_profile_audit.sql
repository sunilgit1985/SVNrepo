USE `audit`;
DROP procedure IF EXISTS `sp_client_profile_audit`;

DELIMITER $$
USE `audit`$$
CREATE PROCEDURE `sp_client_profile_audit`(in p_acctnum bigint)
begin
declare maxsrno bigint;
## audit entry for invdb user_trade_profile
insert into audit.user_trade_profile(acctnum,advisor,rep,theme,firstname,fullname,lastname,portfolioName,goal,acctType,age,horizon,initialInvestment,tradeCurrency,settleCurrency,exchangeRate,
recurringInvestment,experience,longTermGoal,stayInvested,charitablegoals,dependent,riskIndex,tradePreference,keepLiquid,taxable,calcModel,assetIndex,portfolioIndex,
goalAmount,email,ip,created,lastUpdated,managed,clientAccountID,status,customName,auditedBy,audited)
select acctnum,advisor,rep,theme,firstname,fullname,lastname,portfolioName,goal,acctType,age,horizon,initialInvestment,tradeCurrency,settleCurrency,exchangeRate,
recurringInvestment,experience,longTermGoal,stayInvested,charitablegoals,dependent,riskIndex,tradePreference,keepLiquid,taxable,calcModel,assetIndex,portfolioIndex,
goalAmount,email,ip,created,lastUpdated,managed,clientAccountID,status,customName,'SYSTEM',now() 
from invdb.user_trade_profile where acctnum=p_acctnum;

## audit entry for invdb user_risk_profile
select ifnull(max(srno),0)+1 into maxsrno from audit.user_risk_profile ;

insert into audit.user_risk_profile (srno,acctnum,`key`,sortorder,answer,answerType,riskScore,created,lastUpdated,auditedBy,audited)
select maxsrno,acctnum,`key`,sortorder,answer,answerType,riskScore,created,lastUpdated,'SYSTEM',now() 
from invdb.user_risk_profile where acctnum=p_acctnum;

## audit entry for invdb user_risk_score
insert into audit.user_risk_score (acctnum,`year`,calcFormula,allCashFlag,score,standardScore,assetScore,portfolioScore,adjustment,created,lastUpdated,auditedBy,audited)
select acctnum,`year`,calcFormula,allCashFlag,score,standardScore,assetScore,portfolioScore,adjustment,created,lastUpdated,'SYSTEM',now()
from invdb.user_risk_score where acctnum=p_acctnum;

## audit entry for invdb user_risk_questions
insert into audit.user_risk_questions (acctnum,investmentgoal,age,retireage,retired,horizon,ans1,ans2,ans3,ans4,ans5,ans6,ans7,ans8,ans9,ans10,ans11,ans12,ans13,ans14,
ans15,formula,risk1,risk2,risk3,risk4,risk5,risk6,risk7,risk8,risk9,risk10,risk11,risk12,risk13,risk14,risk15,standardRisk,overrideRisk,totalrisk,riskByQuestion,
riskOverride,created,lastUpdated,auditedBy,audited)
select acctnum,investmentgoal,age,retireage,retired,horizon,ans1,ans2,ans3,ans4,ans5,ans6,ans7,ans8,ans9,ans10,ans11,ans12,ans13,ans14,ans15,formula,
risk1,risk2,risk3,risk4,risk5,risk6,risk7,risk8,risk9,risk10,risk11,risk12,risk13,risk14,risk15,standardRisk,overrideRisk,totalrisk,riskByQuestion,riskOverride,created,
lastUpdated,'SYSTEM',now() 
from invdb.user_risk_questions where acctnum=p_acctnum;

## audit entry for invdb acct_financial
insert into audit.acct_financial (acctnum,dependent,estdDependentExpense,householdwages,otherincome,bonusincome,interestincome,dividentincome,rentalIncome,totalIncome,
totalIncomeAnnulized,householdPayment,otherPropertiesPayment,automobilePayment,medicalPayment,federaltaxes,stateTaxes,propertyTax,otherPropertyTax,homeInsurance,lifeInsurance,
autoInsurance,educationPayment,creditCardPayment,miscExpenses,totalExpense,totalExpenseAnnulized,homeEquity,autoValue,moneyMarket,checkingAcct,savingAcct,investment,
equityOtherProperties,retirementInvestement,miscInvestment,totalAsset,mortgageLoan,autoLoan,educationLoan,creditCardDebt,otherPropertiesLoan,medicalDebt,otherDebt,totalDebt,
liquidnetworth,networth,created,lastupdated,auditedBy,audited)
select acctnum,dependent,estdDependentExpense,householdwages,otherincome,bonusincome,interestincome,dividentincome,rentalIncome,totalIncome,totalIncomeAnnulized,
householdPayment,otherPropertiesPayment,automobilePayment,medicalPayment,federaltaxes,stateTaxes,propertyTax,otherPropertyTax,homeInsurance,lifeInsurance,autoInsurance,
educationPayment,creditCardPayment,miscExpenses,totalExpense,totalExpenseAnnulized,homeEquity,autoValue,moneyMarket,checkingAcct,savingAcct,investment,equityOtherProperties,
retirementInvestement,miscInvestment,totalAsset,mortgageLoan,autoLoan,educationLoan,creditCardDebt,otherPropertiesLoan,medicalDebt,otherDebt,totalDebt,liquidnetworth,
networth,created,lastupdated,'SYSTEM',now() from invdb.acct_financial where acctnum=p_acctnum;

## audit entry for invdb asset_alloc
select ifnull(max(srno),0)+1 into maxsrno from audit.asset_alloc;

insert into audit.asset_alloc (srno,acctnum,assetclass,themecode,allocationmodel,assetyear,active,sortnum,weight,base_currency,money,created,lastupdated,auditedBy,audited)
select maxsrno,acctnum,assetclass,themecode,allocationmodel,assetyear,active,sortnum,weight,base_currency,money,created,lastupdated,'SYSTEM',now() from invdb.asset_alloc where acctnum=p_acctnum;

## audit entry for invdb virtual_portfolio
select ifnull(max(srno),0)+1 into maxsrno from audit.virtual_portfolio;

insert into audit.virtual_portfolio (srno,acctnum,itemnum,ticker,active,tradeCurrency,qty,weight,tradeprice,investmentvalue,settleCurrency,exchangeRate,dest_currency,dest_qty,
dest_price,dest_value,settleQty,settlePrice,settleValue,created,lastupdated,auditedBy,audited)
select maxsrno,acctnum,itemnum,ticker,active,tradeCurrency,qty,weight,tradeprice,investmentvalue,settleCurrency,exchangeRate,dest_currency,dest_qty,dest_price,
dest_value,settleQty,settlePrice,settleValue,created,lastupdated,'SYSTEM',now() 
from invdb.virtual_portfolio where acctnum=p_acctnum;

end$$

DELIMITER ;

