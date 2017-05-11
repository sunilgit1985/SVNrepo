-- Primary Key issue
ALTER TABLE `invdb`.`state_mapping` 
CHANGE COLUMN `name` `name` VARCHAR(100) NOT NULL DEFAULT '' ,
CHANGE COLUMN `country` `country` VARCHAR(100) NOT NULL DEFAULT '' ;


USE `invdb`;
DROP function IF EXISTS `getTitleRegi`;

DELIMITER $$
USE `invdb`$$
CREATE FUNCTION `getTitleRegi`(p_acctnum VARCHAR(45)) RETURNS varchar(200) 
DETERMINISTIC
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE v_loopIndex INT DEFAULT 1;
	DECLARE v_outputValue VARCHAR(200);
    DECLARE v_firstName VARCHAR(45);
    DECLARE v_midInitial VARCHAR(2);
    DECLARE v_lastName VARCHAR(45);
    DECLARE v_acctType VARCHAR(45);
    
	DEClARE user_cursor CURSOR FOR select firstName, case when (isnull(midInitial) or trim(midInitial)='') then '' else concat(midInitial,'.')end midInitial, lastName from dc_acct_owners_details where acctnum=p_acctnum;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	IF (p_acctnum is NULL)
	   THEN RETURN NULL;
	END IF;

	IF (trim(p_acctnum) = '')
		THEN return null;
	END IF;
        
	select acctTypeId into v_acctType from dc_acct_details where acctnum=p_acctnum;
        
	IF (v_acctType is NULL)
	   THEN RETURN NULL;
	END IF;

	IF (trim(v_acctType) = '')
		THEN return null;
	END IF;
     set v_outputValue :='';
	OPEN user_cursor;
   
	read_user: LOOP
		
		FETCH user_cursor INTO v_firstName, v_midInitial, v_lastName;
        IF done THEN
		  LEAVE read_user;
		END IF;
		IF (v_acctType = 'ACINDIV') THEN
		   set v_outputValue :=concat(v_outputValue,' ',v_firstName, ' ' ,v_midInitial, ' ' ,v_lastName);
		elseIF (v_acctType = 'ACJOINT') THEN
			if(v_loopIndex=1)then
				set v_outputValue :=concat(v_outputValue,' ',v_firstName, ' ' ,v_midInitial, ' ' ,v_lastName);
            else
				set v_outputValue :=concat(v_outputValue,' & ',v_firstName, ' ' ,v_midInitial, ' ' ,v_lastName);
            end if;
		elseIF (v_acctType = 'ACCSTD') THEN
			if(v_loopIndex=1)then
				set v_outputValue :=concat(v_outputValue,' ',v_firstName, ' ' ,v_midInitial, ' ' ,v_lastName);
            else
				set v_outputValue :=concat(v_outputValue,' as Custodian for ',v_firstName, ' ' ,v_midInitial, ' ' ,v_lastName);
            end if;
		else
			set v_outputValue :=concat(v_outputValue,' ',v_firstName, ' ' ,v_midInitial, ' ' ,v_lastName);
		END IF;
		-- set  v_outputValue := concat(v_outputValue,'Abhang A. Patil');
        
		set v_loopIndex:=v_loopIndex+1;
	END LOOP read_user;    
	CLOSE user_cursor;
    
    IF (v_acctType = 'ACINDIV') THEN
	   set v_outputValue :=concat(v_outputValue,' Individual Account');
	elseIF (v_acctType = 'ACJOINT') THEN
		set v_outputValue :=concat(v_outputValue,' Joint Account');
	elseIF (v_acctType = 'ACCSTD') THEN
		set v_outputValue :=concat(v_outputValue,' Jr. UTMA');
	else
		set v_outputValue :=concat(v_outputValue,' ',get_lookup_value(v_acctType),' IRA');
	END IF;
    
RETURN v_outputValue;
END$$

DELIMITER ;




USE `invdb`;
DROP function IF EXISTS `get_acct_type`;

DELIMITER $$
USE `invdb`$$
CREATE FUNCTION `get_acct_type`(p_inputValue VARCHAR(45)) 
RETURNS varchar(45) 
DETERMINISTIC
BEGIN
	DECLARE v_outputValue VARCHAR(45);
    DECLARE v_refValue VARCHAR(45);
	BEGIN
		IF (p_inputValue is NULL)
		   THEN RETURN NULL;
		END IF;

        IF (trim(p_inputValue) = '')
			THEN return null;
		END IF;
        
        if(p_inputValue='ACINDIV')then
			set v_refValue :='ATINDIV';
        elseif(p_inputValue='IRABENE')then
			set v_refValue :='ATINDIV';
        elseif(p_inputValue='IRABENE')then
			set v_refValue :='ATIRABENE';
        elseif(p_inputValue='IRAROTH')then
			set v_refValue :='ATIRAROTH';
		elseif(p_inputValue='IRASEP')then
			set v_refValue :='ATIRASEP';
		elseif(p_inputValue='IRASIMPLE')then
			set v_refValue :='ATIRASIMPLE';
		elseif(p_inputValue='IRATRAD' or p_inputValue='IRAROOV')then
			set v_refValue :='ATIRATRADROLL';
		elseif(p_inputValue='ACJOINT')then
			set v_refValue :='ATJOINT';
		elseif(p_inputValue='ACCSTD')then
			set v_refValue :='ATUTMAUGMA';            
        end if;
        IF (v_refValue is NULL)
		   THEN RETURN NULL;
		END IF;

        IF (trim(v_refValue) = '')
			THEN return null;
		END IF;        
        
		select value into v_outputValue from dc_m_lookup where lookupCode=v_refValue;

		RETURN v_outputValue;
	END;
END$$

DELIMITER ;

USE `invdb`;
DROP function IF EXISTS `GET_LOOKUP_VALUE`;

DELIMITER $$
USE `invdb`$$
CREATE FUNCTION `GET_LOOKUP_VALUE`(p_inputValue VARCHAR(45)) RETURNS varchar(45) CHARSET latin1
BEGIN
       DECLARE v_outputValue VARCHAR(45);
       BEGIN
               IF (p_inputValue is NULL)
                  THEN RETURN NULL;
               END IF;

       IF (trim(p_inputValue) = '')
                       THEN return null;
               END IF;

               select value into v_outputValue from dc_m_lookup where lookupCode=p_inputValue;

               RETURN v_outputValue;
       END;
END$$

DELIMITER ;