USE `invdb`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
   
    SQL SECURITY DEFINER
VIEW `invdb`.`vw_user_logon` AS
    SELECT 
        `ui`.`logonid` AS `logonid`,
        `ui`.`userid` AS `userid`,
        `ui`.`email` AS `email`,
        `ui`.`pwd` AS `pwd`,
        `ui`.`logonstatus` AS `logonstatus`,
        `ui`.`firstname` AS `firstname`,
        `ui`.`lastname` AS `lastname`,
        IFNULL(`ui`.`fullname`, `ui`.`firstname`) AS `fullname`,
        `ui`.`ip` AS `ip`,
        `ui`.`stateRegistered` AS `stateRegistered`,
        `ui`.`leadSource` AS `leadSource`,
        `ui`.`resetID` AS `resetID`,
        `ui`.`cid` AS `cid`,
        `ui`.`advisor` AS `advisor`,
        `ui`.`rep` AS `rep`,
        `ui`.`emailmsgtype` AS `emailmsgtype`,
        IFNULL(`ui`.`access`, 'User') AS `access`,
        `ui`.`atstart` AS `atstart`,
        IFNULL(`basket`.`theme`, '0.Core') AS `theme`
    FROM
        (`invdb`.`user_logon` `ui`
        LEFT JOIN `invdb`.`user_basket_access` `basket` ON (((`basket`.`advisor` = `ui`.`advisor`)
            AND (`basket`.`sortorder` = 0)
            AND (`basket`.`primary` = 'Y'))));
