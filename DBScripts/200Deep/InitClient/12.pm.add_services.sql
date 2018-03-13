INSERT INTO `service`.`service_master`
SELECT 'BELLROCK',
    `service_master`.`service`,
    `service_master`.`status`,
    `service_master`.`vendor`
FROM `service`.`service_master`
WHERE `service_master`.`company` = 'TCM';

INSERT INTO `service`.`service_operation_details`
SELECT 'BELLROCK',
    `service_operation_details`.`service`,
    `service_operation_details`.`operation`,
    `service_operation_details`.`vendor`,
    `service_operation_details`.`status`,
    `service_operation_details`.`priority`,
    `service_operation_details`.`refValue`
FROM `service`.`service_operation_details`
WHERE `service_operation_details`.`company` = 'TCM';

INSERT INTO `service`.`service_config_details`
SELECT `service_config_details`.`mode`,
    'BELLROCK',
    `service_config_details`.`service`,
    `service_config_details`.`vendor`,
    `service_config_details`.`name`,
    `service_config_details`.`value`,
    `service_config_details`.`encrFlag`,
    `service_config_details`.`created`,
    `service_config_details`.`updated`
FROM `service`.`service_config_details`
WHERE `service_config_details`.`company` = 'TCM';



