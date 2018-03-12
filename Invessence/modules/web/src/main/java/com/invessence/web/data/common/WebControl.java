package com.invessence.web.data.common;

/**
 * Created by prashant on 11/16/2017.
 */
public class WebControl
{
   Integer sortorder;
   String  name;
   String  description;
   String  imagepath;
   String  acronym;

   public WebControl()
   {
   }

   public WebControl(Integer sortorder, String name, String description, String imagepath, String acronym)
   {
      this.sortorder = sortorder;
      this.name = name;
      this.description = description;
      this.imagepath = imagepath;
      this.acronym = acronym;
   }

   public Integer getSortorder()
   {
      return sortorder;
   }

   public void setSortorder(Integer sortorder)
   {
      this.sortorder = sortorder;
   }

   public String getName()
   {
      return name;
   }

   public void setName(String name)
   {
      this.name = name;
   }

   public String getDescription()
   {
      return description;
   }

   public void setDescription(String description)
   {
      this.description = description;
   }

   public String getImagepath()
   {
      return imagepath;
   }

   public void setImagepath(String imagepath)
   {
      this.imagepath = imagepath;
   }

   public String getAcronym()
   {
      return acronym;
   }

   public void setAcronym(String acronym)
   {
      this.acronym = acronym;
   }
}
