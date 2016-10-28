DROP PROCEDURE IF EXISTS `updt_user_risk_index`;

DELIMITER $$
CREATE PROCEDURE `updt_user_risk_index` (
	IN  p_addmodflag VARCHAR(1),
	IN	p_acctnum	bigint(20),
	IN	p_ans1	tinyint,
	IN	p_ans2	tinyint,
	IN	p_ans3	tinyint,
	IN	p_ans4	tinyint,
	IN	p_ans5	tinyint,
	IN	p_ans6	tinyint,
	IN	p_ans7	tinyint,
	IN	p_ans8	tinyint,
	IN	p_ans9	tinyint,
	IN	p_ans10	tinyint,
	IN	p_ans11	tinyint,
	IN	p_ans12	tinyint,
	IN	p_ans13	tinyint,
	IN	p_ans14	tinyint,
	IN	p_ans15	tinyint
)
BEGIN 

	DECLARE tData	INTEGER;

	SELECT COUNT(*)
	INTO tData
	FROM `user_risk_questions`
	WHERE `acctnum` = p_acctnum;

	IF (tData is null or tData = 0)
		THEN 
			INSERT INTO `user_risk_questions`
				(`acctnum`,
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
				`created`,
				`lastUpdated`
			)
			VALUES (
				p_acctnum,
				p_ans1,
				p_ans2,
				p_ans3,
				p_ans4,
				p_ans5,
				p_ans6,
				p_ans7,
				p_ans8,
				p_ans9,
				p_ans10,
				p_ans11,
				p_ans12,
				p_ans13,
				p_ans14,
				p_ans15,
				now(),
				null
			)
			;
		ELSE 
			 UPDATE  `user_risk_questions`
			 SET 
				`ans1`	 =	p_ans1	,
				`ans2`	 =	p_ans2	,
				`ans3`	 =	p_ans3	,
				`ans4`	 =	p_ans4	,
				`ans5`	 =	p_ans5	,
				`ans6`	 =	p_ans6	,
				`ans7`	 =	p_ans7	,
				`ans8`	 =	p_ans8	,
				`ans9`	 =	p_ans9	,
				`ans10`	 =	p_ans10	,
				`ans11`	 =	p_ans11	,
				`ans12`	 =	p_ans12	,
				`ans13`	 =	p_ans13	,
				`ans14`	 =	p_ans14	,
				`ans15`	 =	p_ans15	,
				`lastupdated` = now()
			 WHERE
				`acctnum` = p_acctnum;
	END IF;



END$$
DELIMITER ;