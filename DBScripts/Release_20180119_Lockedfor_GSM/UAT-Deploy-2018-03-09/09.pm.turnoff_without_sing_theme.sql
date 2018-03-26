UPDATE `invdb`.`advisor_risk_master` 
	SET `remarks`='Default Theme'
		, defaultValue = 'KayHian.Without.Sing'
    WHERE `advisor`='UOB'
    and `key`='THEME';

DELETE FROM `invdb`.`advisor_risk_master` 
where `key` in ('THEME-1', 'THEME-2');

INSERT INTO `invdb`.`advisor_risk_master` 
(`advisor`, `sortorder`, `key`, `displayName`, `defaultValue`, `dataType`, `displayOnStart`, `displayAdvisor`, `saveforUser`, `remarks`) 
VALUES 
 ('UOB', '801', 'THEME-1', 'Theme#1', 'KayHian.Without.Sing', 'T', '0', '0', '0', 'Theme')
,('UOB', '802', 'THEME-2', 'Theme#2', 'KayHian.Without.Sing', 'T', '0', '0', '0', 'Theme');
