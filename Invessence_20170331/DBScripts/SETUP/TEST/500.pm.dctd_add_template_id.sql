DROP PROCEDURE IF EXISTS `invdb`.`dctd_add_template_id`;

DELIMITER $$
CREATE PROCEDURE `invdb`.`dctd_add_template_id`(
   p_templateID		VARCHAR(20)
  ,p_advisorCode	VARCHAR(20)
  ,p_advisor		VARCHAR(20)
  ,p_rep			VARCHAR(20)
  ,p_firmname		VARCHAR(60)
  ,p_primaryContact VARCHAR(60)
  ,p_ops_email		VARCHAR(60)
)
BEGIN

    DECLARE tTemplateID		BIGINT(20);
    DECLARE tNewID			BIGINT(20);
    DECLARE tFunction		VARCHAR(1);
    
    IF (p_templateID is NOT NULL)
    THEN
		SELECT `dc_advisor_details`.`id`
        INTO tTemplateID
		FROM `dc_advisor_details`
        WHERE `dc_advisor_details`.`primaryContact` = p_templateID
		AND   `dc_advisor_details`.`advisorName` = p_advisor;		
	END IF;
    
	SELECT  'U'
	INTO tFunction
	FROM `dc_advisor_details`
	WHERE `dc_advisor_details`.`advisorName` = p_advisor
	AND   `dc_advisor_details`.`repId` = p_rep;

    IF (tTemplateID is null)
    THEN
		SELECT "Not sufficient data to create new ID.  Either Template ID has to be provided or can only update data.";
	ELSE
		IF (tFunction = 'U')
			THEN
				UPDATE `invdb`.`dc_advisor_details`
				SET`advisorCode` = IFNULL(p_advisorCode, `dc_advisor_details`.`advisorCode`),
					`firmName` = IFNULL(p_firmname, `dc_advisor_details`.`firmName`),
					`primaryContact` = IFNULL(p_primaryContact, `dc_advisor_details`.`primaryContact`),
					`email` = IFNULL(p_ops_email, `dc_advisor_details`.`email`),
					`updated` = now(),
					`updatedBy` = 'SYSTEM'
				WHERE `dc_advisor_details`.`advisorName` = p_advisor
				AND   `dc_advisor_details`.`repId` = p_rep;
			ELSE
 				IF (p_advisor is null and p_rep is null)
					THEN
						SELECT "Not sufficient data to create new ID.  Either Advisor and/or name is missing.";
                    ELSE
					INSERT INTO `invdb`.`dc_advisor_details`
					(`advisorCode`,
					`advisorName`,
					`repId`,
					`firmName`,
					`primaryContact`,
					`email`,
					`created`,
					`createdBy`)
					SELECT 
						IFNULL(p_advisorCode, `dc_advisor_details`.`advisorCode`),
						p_advisor,
						p_rep,
						IFNULL(p_firmname, `dc_advisor_details`.`firmName`),
						IFNULL(p_primaryContact, `dc_advisor_details`.`primaryContact`),
						IFNULL(p_ops_email, `dc_advisor_details`.`email`),
						now(),
						'SYSTEM'
					FROM `invdb`.`dc_advisor_details`
					WHERE `dc_advisor_details`.`id` = tTemplateID
					;
					
					SELECT LAST_INSERT_ID() into tNewID;
					
					 INSERT INTO `invdb`.`adv_request_document_mappings`
						(`advisorid`,
						`action`,
						`subaction`,
						`reqType`,
						`envelopeHeading`,
						`seqno`,
						`formType`)
					SELECT tNewID,
						`adv_request_document_mappings`.`action`,
						`adv_request_document_mappings`.`subaction`,
						`adv_request_document_mappings`.`reqType`,
						`adv_request_document_mappings`.`envelopeHeading`,
						`adv_request_document_mappings`.`seqno`,
						`adv_request_document_mappings`.`formType`
					FROM `invdb`.`adv_request_document_mappings`
					WHERE `adv_request_document_mappings`.`advisorid` = tTemplateID;				
				END IF;
		END IF;
        
		
    END IF;
    
    
END$$
DELIMITER ;
