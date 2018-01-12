
INSERT INTO invdb.web_menu (url, access, permission, label, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, created) 
select url, 'User', 'Demo', 'Open Account', '0', '0', '7', 'A', 'N', 'consumer', 'cadd.xhtml', now() from invdb.web_menu group by url;
