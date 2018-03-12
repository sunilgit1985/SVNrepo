package com.invessence.util;

import java.lang.reflect.Field;

/**
 * Created by abhangp on 12/5/2017.
 */
public class Reflection
{
   public static Object getInstanceValue(final Object classInstance, final String fieldName) throws SecurityException, NoSuchFieldException, ClassNotFoundException, IllegalArgumentException, IllegalAccessException
   {

      // Get the private field
      final Field field = classInstance.getClass().getDeclaredField(fieldName);
      // Allow modification on the field
      field.setAccessible(true);
      // Return the Obect corresponding to the field
      return field.get(classInstance);

   }

   public static void setInstanceValue(final Object classInstance, final String fieldName, final Object value) throws SecurityException, NoSuchFieldException, ClassNotFoundException, IllegalArgumentException, IllegalAccessException
   {

      // Get the private field
      final Field field = classInstance.getClass().getDeclaredField(fieldName);
      // Allow modification on the field
      field.setAccessible(true);
      // Return the Obect corresponding to the field
      field.set(classInstance,value);

   }

}
