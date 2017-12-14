package com.invessence.web.util;

import java.awt.*;
import java.util.*;

/**
 * Created by prashant on 12/7/2017.
 */
public class WebMenuList
{
   public enum ListComponent  {
      GOAL,
      CURRENCY;
   }

   Map<String, ArrayList<WebMenuItem>> menulist;

   public WebMenuList()
   {
      menulist = new HashMap<String, ArrayList<WebMenuItem>>();
   }

   public WebMenuList(Map<String, ArrayList<WebMenuItem>> menulist)
   {
      this.menulist = menulist;
   }

   public Map<String, ArrayList<WebMenuItem>> getMenulist()
   {
      return menulist;
   }

   public void setMenulist(Map<String, ArrayList<WebMenuItem>> menulist)
   {
      this.menulist = menulist;
   }

   public void addToMenuList(WebMenuItem menuitem) {
      String key;
      if (menuitem != null)
      {
         key = menuitem.getKey();
         if (menulist.containsKey(key))
         {
            menulist.get(key).add(menuitem);
         }
         else
         {
            ArrayList<WebMenuItem> list = new ArrayList<WebMenuItem>();
            list.add(menuitem);
            menulist.put(key, list);
         }
      }
   }
}
