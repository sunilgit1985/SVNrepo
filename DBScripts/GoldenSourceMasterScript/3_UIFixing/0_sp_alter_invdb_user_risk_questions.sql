
ALTER TABLE invdb.user_risk_questions 
ADD COLUMN riskByQuestion tinyint(4) NULL DEFAULT NULL AFTER totalrisk;

ALTER TABLE invdb.user_risk_questions 
ADD COLUMN riskOverride tinyint(4) NULL DEFAULT NULL AFTER riskByQuestion;