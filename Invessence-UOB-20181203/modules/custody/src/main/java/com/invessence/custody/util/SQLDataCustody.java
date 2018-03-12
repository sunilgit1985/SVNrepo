package com.invessence.custody.util;

import java.io.Serializable;
import java.util.*;

import com.invessence.converter.SQLData;
import org.apache.log4j.Logger;

/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 4/14/14
 * Time: 12:46 PM
 * To change this template use File | Settings | File Templates.
 */
public class SQLDataCustody extends SQLData implements Serializable
{
   private static final Logger logger = Logger.getLogger(SQLDataCustody.class);
   private static final long serialVersionUID = -1984L;

   ReflectionCustody reflection=new ReflectionCustody();
   public void getObjectFormROW(ArrayList<LinkedHashMap<String, Object>> dbRows, Object object, String category, String column, Object value) {
      Boolean isDetailsAvailable=false;
      Iterator<LinkedHashMap<String, Object>> itr = dbRows.iterator();

      int id=0;
      Object obj=null;
      while (itr.hasNext())
      {
         StringBuilder fileRow = new StringBuilder();
         LinkedHashMap<String, Object> map = itr.next();
         try
         {
            if(map.get("category").equals(category) && map.get(column).equals(value))
            {
               if(id==0){
                  id= getIntData(map.get("id"));

//                  ownerTaxationDetails=new OwnerTaxationDetails();
                  obj=reflection.initiateObject(category, id);
                  reflection.setInstanceValue(obj, map.get("name").toString(), map.get("value"));
               }else if(id!=0 && id==getIntData(map.get("id"))){
                  reflection.setInstanceValue(obj, map.get("name").toString(), map.get("value"));
               }else if(id!=0 && id!=getIntData(map.get("id"))){
                  id= getIntData(map.get("id"));
//                  ((List<OwnerTaxationDetails>)object).add(ownerTaxationDetails);
                  reflection.addToList(object, obj, category);
//                  ownerTaxationDetails=new OwnerTaxationDetails();
                  obj=reflection.initiateObject(category, id);
                  reflection.setInstanceValue(obj, map.get("name").toString(), map.get("value"));
               }
            }
         }
         catch (NoSuchFieldException e)
         {
            logger.error(e.getMessage());
         }
         catch (ClassNotFoundException e)
         {
            logger.error(e.getMessage());
         }
         catch (IllegalAccessException e)
         {
            logger.error(e.getMessage());
         }
      }
//      if(category.equals("Taxation") && ownerTaxationDetails!=null){
//         ((List<OwnerTaxationDetails>)object).add(ownerTaxationDetails);
      reflection.addToList(object, obj, category);
//      }

   }

}
