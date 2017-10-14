USE `invdb`;
DROP procedure IF EXISTS `sel_web_mnu_detail`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `sel_web_mnu_detail`(in p_url varchar(45),in p_access varchar(20))
begin
 DECLARE tFound INTEGER;
   
   IF (p_url is null)
   THEN
 	set p_url = 'invessence';
   END IF;
 
   if (substr(p_url,1,9) != 'localhost')
 	then
 		  set p_url = replace(p_url,'www.','');
 		  set tFound = locate('.',p_url);
 		  IF (tFound > 0)
 		  THEN
 			set p_url = substr(p_url,1,tFound - 1 );
 		  END IF;
 		  
 		  set tFound = locate(':',p_url);
 		  IF (tFound > 0)
 		  THEN
 			set p_url = substr(p_url,1,tFound - 1 );
 		  END IF;
   end if;
  if(lower(p_access)='superadmin') then
  select url, access, permission, label, icon, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, command
   from invdb.web_menu wm where wm.url=p_url and wm.status='A' and wm.access<>'User';
   else
  select url, access, permission, label, icon, level, sublevel, seq, status, availOnMobile, destdir, htmlpage, command
   from invdb.web_menu wm where wm.url=p_url and wm.access=p_access and wm.status='A';
   end if;
  end$$

DELIMITER ;

