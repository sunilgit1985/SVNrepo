create table user_risk_questions_20160824
as
select * from user_risk_questions;

INSERT INTO `invdb`.`user_risk_questions`
(`acctnum`,
`age`,
`retireage`,
`horizon`,
`ans1`,
`ans2`,
`ans3`,
`ans4`,
`ans5`,
`ans6`,
`ans7`,
`ans8`,
`ans9`,
`ans10`,
`ans11`,
`ans12`,
`ans13`,
`ans14`,
`ans15`,
`formula`,
`risk1`,
`risk2`,
`risk3`,
`risk4`,
`risk5`,
`risk6`,
`risk7`,
`risk8`,
`risk9`,
`risk10`,
`risk11`,
`risk12`,
`risk13`,
`risk14`,
`risk15`,
`totalrisk`,
`created`,
`lastUpdated`)
select 
`acctnum`,
`age`,
`retireage`,
`horizon`,
`ans1`,
`ans2`,
`ans3`,
`ans4`,
`ans5`,
`ans6`,
`ans7`,
`ans8`,
`ans9`,
`ans10`,
`ans11`,
`ans12`,
`ans13`,
`ans14`,
`ans15`,
`formula`,
`risk1`,
`risk2`,
`risk3`,
`risk4`,
`risk5`,
`risk6`,
`risk7`,
`risk8`,
`risk9`,
`risk10`,
`risk11`,
`risk12`,
`risk13`,
`risk14`,
`risk15`,
`totalrisk`,
`created`,
`lastUpdated`
FROM 
user_risk_questions_20160824;