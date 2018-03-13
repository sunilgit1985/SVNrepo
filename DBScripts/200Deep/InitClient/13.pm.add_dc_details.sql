INSERT INTO `service`.`dc_template_details`
SELECT `dc_template_details`.`mode`,
    'BELLROCK',
    `dc_template_details`.`service`,
    `dc_template_details`.`tempCode`,
    `dc_template_details`.`tempId`,
    `dc_template_details`.`tempName`,
    `dc_template_details`.`authRequired`,
    `dc_template_details`.`status`,
    `dc_template_details`.`remark`,
    `dc_template_details`.`created`,
    `dc_template_details`.`createdBy`,
    `dc_template_details`.`updated`,
    `dc_template_details`.`updatedBy`,
    `dc_template_details`.`configFile`
FROM `service`.`dc_template_details`
WHERE `dc_template_details`.`company` = 'TCM';

INSERT INTO `service`.`dc_document_details`
SELECT 'BELLROCK',
    `dc_document_details`.`service`,
    `dc_document_details`.`docCode`,
    `dc_document_details`.`docName`,
    `dc_document_details`.`docType`,
    `dc_document_details`.`docSeq`,
    `dc_document_details`.`fileName`,
    `dc_document_details`.`editable`,
    `dc_document_details`.`status`,
    `dc_document_details`.`remark`,
    `dc_document_details`.`created`,
    `dc_document_details`.`createdBy`,
    `dc_document_details`.`updated`,
    `dc_document_details`.`updatedBy`
FROM `service`.`dc_document_details`
WHERE `dc_document_details`.`company` = 'TCM';

