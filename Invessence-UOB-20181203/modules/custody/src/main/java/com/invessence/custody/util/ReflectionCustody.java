package com.invessence.custody.util;

import java.lang.reflect.Field;
import java.util.List;

import com.invessence.custody.uob.data.OwnerTaxationDetails;
import com.invessence.util.Reflection;

/**
 * Created by abhangp on 12/5/2017.
 */
public class ReflectionCustody extends Reflection
{

   public void addToList(Object listObject, Object object, String category){

      if(category.equals("Taxation")){
         ((List<OwnerTaxationDetails>)listObject).add((OwnerTaxationDetails) object);
      }
   }

   public Object initiateObject(String category, int id){

      if(category.equals("Taxation")){
         return new OwnerTaxationDetails(id);
      }
      return null;
   }

}
