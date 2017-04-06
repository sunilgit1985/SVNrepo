USE `invdb`;
DROP procedure IF EXISTS `dctd_add_template_id`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `dctd_add_template_id`(
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
    DECLARE tAdvisorID		BIGINT(20);

	SELECT
    COUNT(`adv_request_document_mappings`.`templateId`)
INTO tTemplateID FROM
    `adv_request_document_mappings`
WHERE
    `adv_request_document_mappings`.`templateId` = p_templateID;

    IF (p_templateID is null or tTemplateID =0 )
    THEN
		SELECT "Not sufficient data to create new ID.  Either Template ID has to be provided or can only update data.";
	ELSE
		SELECT  'U', id
		INTO tFunction, tAdvisorID
		FROM `dc_advisor_details`
		WHERE `dc_advisor_details`.`advisorName` = p_advisor
		AND   `dc_advisor_details`.`repId` = p_rep;
		IF (tFunction = 'U')
			THEN
				UPDATE `invdb`.`dc_advisor_details`
				SET`advisorCode` = IFNULL(p_advisorCode, `dc_advisor_details`.`advisorCode`),
					`firmName` = IFNULL(p_firmname, `dc_advisor_details`.`firmName`),
					`primaryContact` = IFNULL(p_primaryContact, `dc_advisor_details`.`primaryContact`),
                    `templateId`= IFNULL(p_templateID, `dc_advisor_details`.`templateId`),
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
                    `templateId`,
					`email`,
					`created`,
					`createdBy`)
					SELECT
						IFNULL(p_advisorCode, `dc_advisor_details`.`advisorCode`),
						p_advisor,
						p_rep,
						IFNULL(p_firmname, `dc_advisor_details`.`firmName`),
						IFNULL(p_primaryContact, `dc_advisor_details`.`primaryContact`),
                        p_templateID,
						IFNULL(p_ops_email, `dc_advisor_details`.`email`),
						now(),
						'SYSTEM'
					FROM `invdb`.`dc_advisor_details`
					WHERE `dc_advisor_details`.`id` = tTemplateID;
				END IF;
		END IF;


    END IF;


END$$

DELIMITER ;


