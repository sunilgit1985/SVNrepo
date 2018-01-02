package com.invessence.web.util;

/**
 * Created by prashant on 12/7/2017.
 */
public class WebMenuItem
{
   private String key;
   private Integer sortorder;
   private String displayName;
   private String image;
   private String shortname;
   private String description;
   private String otherinfo;

   public WebMenuItem()
   {
   }

   public WebMenuItem(String key, Integer sortorder, String displayName,
                      String image, String shortname, String description, String otherinfo)
   {
      this.key = key;
      this.sortorder = sortorder;
      this.displayName = displayName;
      this.image = image;
      this.shortname = shortname;
      this.description = description;
      this.otherinfo = otherinfo;
   }

   public String getKey()
   {
      return key;
   }

   public void setKey(String key)
   {
      this.key = key;
   }

   public Integer getSortorder()
   {
      return sortorder;
   }

   public void setSortorder(Integer sortorder)
   {
      this.sortorder = sortorder;
   }

   public String getDisplayName()
   {
      return displayName;
   }

   public void setDisplayName(String displayName)
   {
      this.displayName = displayName;
   }

   public String getImage()
   {
      return image;
   }

   public void setImage(String image)
   {
      this.image = image;
   }

   public String getShortname()
   {
      return shortname;
   }

   public void setShortname(String shortname)
   {
      this.shortname = shortname;
   }

   public String getDescription()
   {
      return description;
   }

   public void setDescription(String description)
   {
      this.description = description;
   }
}
