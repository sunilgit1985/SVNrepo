package com.invessence.converter;

import java.io.Serializable;
import java.text.DecimalFormat;

/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 4/16/14
 * Time: 6:17 PM
 * To change this template use File | Settings | File Templates.
 */
public class JavaUtil implements Serializable
{

   public String displayFormat(Integer value, String format) {
      if (value == null) {
         return ("");
      }
      else {
         DecimalFormat df = new DecimalFormat(format);
         return df.format(value);
     }
   }

   public String displayFormat(Double value, String format) {
      if (value == null) {
         return ("");
      }
      else {
         DecimalFormat df = new DecimalFormat(format);
         return df.format(value);
      }
   }

   public String displayFormat(String value, String format) {
      if (value == null || value.isEmpty()) {
         return ("");
      }
      else {
         DecimalFormat df = new DecimalFormat(format);
         return df.format(Double.parseDouble(value));

      }
   }

   public String displayDateFormat(String input) {
      String year, month, date;
      try {
         if (input == null || input.isEmpty()) {
            return ("");
         }
         else {
            if (input.contains("/") || input.contains("-")) {
               return input;
            }
            else {
               date =  input.substring(6,8);
               month = input.substring(4,6);
               year = input.substring(0,4);
               return  month + "/" + date + "/" + year ;
            }
         }
      }
      catch (Exception ex) {
         return input;
      }
   }
    public static String UppercaseFirstLetters(String str)
    {
        if (str != null) {
            boolean prevWasWhiteSp = true;
            char[] chars = str.toCharArray();
            for (int i = 0; i < chars.length; i++) {
                if (Character.isLetter(chars[i])) {
                    if (prevWasWhiteSp) {
                        chars[i] = Character.toUpperCase(chars[i]);
                    }
                    prevWasWhiteSp = false;
                } else {
                    prevWasWhiteSp = Character.isWhitespace(chars[i]);
                }
            }
            return new String(chars);
        }
        else
            return null;
    }


}
