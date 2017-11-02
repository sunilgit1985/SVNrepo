drop procedure invdb.sel_risk_questions;
delimiter $$
CREATE PROCEDURE invdb.sel_risk_questions(
  	IN p_acctnum BIGINT
  )
 BEGIN
  
  	SELECT 
  		uaq.acctnum,
  		uaq.investmentgoal,
  		uaq.age,
  		uaq.retireage,
  		uaq.retired,
  		uaq.horizon,
  		uaq.ans1,
  		uaq.ans2,
  		uaq.ans3,
  		uaq.ans4,
  		uaq.ans5,
  		uaq.ans6,
  		uaq.ans7,
  		uaq.ans8,
  		uaq.ans9,
  		uaq.ans10,
  		uaq.ans11,
  		uaq.ans12,
  		uaq.ans13,
  		uaq.ans14,
  		uaq.ans15,
  		uaq.formula,
  		uaq.risk1,
  		uaq.risk2,
  		uaq.risk3,
  		uaq.risk4,
  		uaq.risk5,
  		uaq.risk6,
  		uaq.risk7,
  		uaq.risk8,
  		uaq.risk9,
  		uaq.risk10,
  		uaq.risk11,
  		uaq.risk12,
  		uaq.risk13,
  		uaq.risk14,
  		uaq.risk15,
  		uaq.totalrisk,
         uaq.riskByQuestion,
         uaq.riskOverride,
  		uaq.created,
  		uaq.lastUpdated
  	FROM user_risk_questions as uaq
      WHERE uaq.acctnum = p_acctnum;
  
  
  END