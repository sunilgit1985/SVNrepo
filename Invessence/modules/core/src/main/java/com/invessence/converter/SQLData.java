package com.invessence.converter;

import java.io.Serializable;
import java.util.*;

import com.invessence.util.Reflection;
import org.apache.log4j.Logger;

/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 4/14/14
 * Time: 12:46 PM
 * To change this template use File | Settings | File Templates.
 */
public class SQLData implements Serializable
{
   private static final Logger logger = Logger.getLogger(SQLData.class);
   private static final long serialVersionUID = -1983L;

   Reflection reflection=new Reflection();

   public String getStrData(Object dataobj)
   {
      String val = "";
      try
      {
         if (dataobj == null)
            return null;
         else
            val = dataobj.toString();
      }
      catch (Exception ex)
      {
         return "";
      }
      return val;
   }

   public Integer getIntData(Object dataobj)
   {
      Integer val = null;
      try
      {
         if (dataobj == null)
            return 0;
         else {
            Double dValue =  getDoubleData(dataobj);
            val = dValue.intValue();
         }
      }
      catch (Exception ex)
      {
         return null;
      }
      return val;
   }

   public Long getLongData(Object dataobj)
   {
      Long val = null;
      try
      {
         if (dataobj == null)
            return 0L;
         else
            val = Long.parseLong(dataobj.toString());
      }
      catch (Exception ex)
      {
         return null;
      }
      return val;
   }

   public Double getDoubleData(Object dataobj)
   {
      Double val = null;
      try
      {
         if (dataobj == null)
            return 0.0;
         else
            val = Double.parseDouble(dataobj.toString());
      }
      catch (Exception ex)
      {
         return null;
      }
      return val;
   }

   public Float getFloatData(Object dataobj)
   {
      Float val = null;
      try
      {
         if (dataobj == null)
            return 0.0f;
         else
            val = Float.parseFloat(dataobj.toString());
      }
      catch (Exception ex)
      {
         return null;
      }
      return val;
   }


   public String getDateData(Object dataobj)
   {
      String val = "";
      try
      {
         if (dataobj == null)
            return "";
         else
            val = dataobj.toString();
      }
      catch (Exception ex)
      {
         return "";
      }
      return val;
   }

   public Date getDateFormatData(Object dataobj)
   {
      Date val = new Date();
      try
      {
         if (dataobj == null)
            return val;
         else
            val = (Date)dataobj;
      }
      catch (Exception ex)
      {
         return val;
      }
      return val;
   }

   public Boolean getBooleanData(Object dataobj)
   {
      String text;
      try
      {
         if (dataobj == null)
            return false;
         else
         {
            text = dataobj.toString();
            if (text.equalsIgnoreCase("true") || text.equalsIgnoreCase("t")) {
               return true;
            }
            else
               return false;
         }
      }
      catch (Exception ex)
      {
         return false;
      }
   }

   public void getObjectFormROW(ArrayList<LinkedHashMap<String, Object>> dbRows, Object object, String column, Object value) {
      Boolean isDetailsAvailable=false;
      Iterator<LinkedHashMap<String, Object>> itr = dbRows.iterator();

      while (itr.hasNext())
      {
         StringBuilder fileRow = new StringBuilder();
         LinkedHashMap<String, Object> map = itr.next();
//         System.out.println(map.get("name") + ":" + map.get("value"));
//         for (Map.Entry<String, Object> entry : map.entrySet()) {
//            System.out.println("Key : " + entry.getKey() + " Value : " + entry.getValue());
         try
         {
            if(map.get(column).equals(value))
            {
               isDetailsAvailable = true;
//               System.out.println(" column = [" + column + "], value = [" + value + "]");
               reflection.setInstanceValue(object, map.get("name").toString(), map.get("value"));
            }
         }
         catch (NoSuchFieldException e)
         {
            logger.error(e.getMessage());
//               e.printStackTrace();
         }
         catch (ClassNotFoundException e)
         {
            logger.error(e.getMessage());
//               e.printStackTrace();
         }
         catch (IllegalAccessException e)
         {
            logger.error(e.getMessage());
//               e.printStackTrace();
         }
//         }

      }
//      if(isDetailsAvailable.equals(false)){
//         object=null;
//         System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//
//      }
   }

   public void getObjectFormROW(ArrayList<LinkedHashMap<String, Object>> dbRows, Object object){

      Iterator<LinkedHashMap<String, Object>> itr = dbRows.iterator();

      while (itr.hasNext())
      {
         StringBuilder fileRow=new StringBuilder();
         LinkedHashMap<String, Object> map = itr.next();
         System.out.println(map.get("name")+":"+map.get("value"));
//         for (Map.Entry<String, Object> entry : map.entrySet()) {
//            System.out.println("Key : " + entry.getKey() + " Value : " + entry.getValue());
         try
         {
            reflection.setInstanceValue(object,map.get("name").toString(),map.get("value"));
         }
         catch (NoSuchFieldException e)
         {
            logger.error(e.getMessage());
//               e.printStackTrace();
         }
         catch (ClassNotFoundException e)
         {
            logger.error(e.getMessage());
//               e.printStackTrace();
         }
         catch (IllegalAccessException e)
         {
            logger.error(e.getMessage());
//               e.printStackTrace();
         }
//         }

      }
   }

   public void getObjectFormCOLUMN(ArrayList<LinkedHashMap<String, Object>> dbRow, Object object, String column, Object value){
      Boolean isDetailsAvailable=false;
      Iterator<LinkedHashMap<String, Object>> itr = dbRow.iterator();

      while (itr.hasNext())
      {
         StringBuilder fileRow = new StringBuilder();
         LinkedHashMap<String, Object> map = itr.next();

         for (Map.Entry<String, Object> entry : map.entrySet())
         {
            System.out.println("Key : " + entry.getKey() + " Value : " + entry.getValue());
            try
            {
//               reflection.setInstanceValue(object, entry.getKey(), entry.getValue());
               if(map.get(column).equals(value))
               {
                  isDetailsAvailable = true;
//               System.out.println(" column = [" + column + "], value = [" + value + "]");
                  reflection.setInstanceValue(object, entry.getKey(), entry.getValue());
               }
            }
            catch (NoSuchFieldException e)
            {
               logger.error(e.getMessage());
//               e.printStackTrace();
            }
            catch (ClassNotFoundException e)
            {
               logger.error(e.getMessage());
//               e.printStackTrace();
            }
            catch (IllegalAccessException e)
            {
               logger.error(e.getMessage());
//               e.printStackTrace();
            }

         }
      }
   }


   public void getObjectFormCOLUMN(ArrayList<LinkedHashMap<String, Object>> dbRow, Object object){
      Iterator<LinkedHashMap<String, Object>> itr = dbRow.iterator();

      while (itr.hasNext())
      {
         StringBuilder fileRow = new StringBuilder();
         LinkedHashMap<String, Object> map = itr.next();

         for (Map.Entry<String, Object> entry : map.entrySet())
         {
            System.out.println("Key : " + entry.getKey() + " Value : " + entry.getValue());
            try
            {
               reflection.setInstanceValue(object, entry.getKey(), entry.getValue());
            }
            catch (NoSuchFieldException e)
            {
               logger.error(e.getMessage());
//               e.printStackTrace();
            }
            catch (ClassNotFoundException e)
            {
               logger.error(e.getMessage());
//               e.printStackTrace();
            }
            catch (IllegalAccessException e)
            {
               logger.error(e.getMessage());
//               e.printStackTrace();
            }

         }
      }
   }

   public void getObjectFormCOLUMN(LinkedHashMap<String, Object> dbRow, Object object){


      for (Map.Entry<String, Object> entry : dbRow.entrySet()) {
         System.out.println("Key : " + entry.getKey() + " Value : " + entry.getValue());
         try
         {
            reflection.setInstanceValue(object,entry.getKey(),entry.getValue());
         }
         catch (NoSuchFieldException e)
         {
            logger.error(e.getMessage());
//               e.printStackTrace();
         }
         catch (ClassNotFoundException e)
         {
            logger.error(e.getMessage());
//               e.printStackTrace();
         }
         catch (IllegalAccessException e)
         {
            logger.error(e.getMessage());
//               e.printStackTrace();
         }

      }
   }

}
