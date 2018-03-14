
INSERT INTO `invdb`.`web_menu` (`url`, `access`, `permission`, `label`, `level`, `sublevel`, `seq`, `status`, `availOnMobile`, `destdir`, `htmlpage`, `created`)
select url, 'User', 'User', 'Alerts', '0', '0', '11', 'A', 'N', 'consumer', 'alert_notification.xhtml', now() from invdb.web_menu group by url;