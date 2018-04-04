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

   HashMap<String, LinkedHashMap<String, WebMenuItem>> menulist;

   public WebMenuList()
   {
      menulist = new HashMap<String, LinkedHashMap<String, WebMenuItem>>();
   }

   public WebMenuList(HashMap<String, LinkedHashMap<String, WebMenuItem>> menulist)
   {
      this.menulist = menulist;
   }

   public HashMap<String, LinkedHashMap<String, WebMenuItem>> getMenulist()
   {
      return menulist;
   }

   public void setMenulist(HashMap<String, LinkedHashMap<String, WebMenuItem>> menulist)
   {
      this.menulist = menulist;
   }

   public HashMap<String, WebMenuItem> getMenuItemMap(String group)
   {
      if (menulist.containsKey(group)) {
         return menulist.get(group);
      }
      return new HashMap<String, WebMenuItem>();
   }

   public ArrayList<WebMenuItem> getMenuArrayList(String group)
   {
      ArrayList<WebMenuItem> list = new ArrayList<WebMenuItem>();
      if (menulist.containsKey(group)) {
         for (WebMenuItem thismap : menulist.get(group).values()) {
            list.add(thismap);
         }
      }
      return list;
   }

   public void addToMenuList(String group, WebMenuItem menuitem) {
      String key;
      if (menuitem != null)
      {
          if (menulist.containsKey(group))
         {
            menulist.get(group).put(menuitem.getKey(), menuitem);
         }
         else
         {
            LinkedHashMap<String, WebMenuItem> newitem = new LinkedHashMap<>();
            newitem.put(menuitem.getKey(), menuitem);
            menulist.put(group, newitem);
         }
      }
   }

}
