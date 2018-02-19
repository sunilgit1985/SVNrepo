package com.invessence.converter;

import java.text.*;
import java.util.*;

/**
 * Created by abhangp on 1/11/2018.
 */
public class DateUtil
{
   public static String parseDate(String candidate, String dateFormat, String expDateFormat){
      List<String> knownPatterns = new ArrayList<String>();
      knownPatterns.add("yyyyMMdd");
      knownPatterns.add("MM/dd/yyyy"); // yyyy/MM/dd
      knownPatterns.add("yyyy-MM-dd");
      knownPatterns.add("yyyy/MM/dd");
      knownPatterns.add("yyyy MM dd");
      knownPatterns.add("yyyy.MM.dd");
      knownPatterns.add("yyyy-MM-dd'T'HH:mm:ss'Z'");
      knownPatterns.add("yyyy-MM-dd'T'HH:mm.ss'Z'");
      knownPatterns.add("yyyy-MM-dd'T'HH:mm:ss");
      knownPatterns.add("yyyy-MM-dd' 'HH:mm:ss");
      knownPatterns.add("yyyy-MM-dd'T'HH:mm:ssXXX");

      for (String pattern : knownPatterns) {

         try
         {
            if(pattern.equals(dateFormat))
            {
               SimpleDateFormat simpleDateFormat= new SimpleDateFormat(pattern);
               SimpleDateFormat expSimpleDateFormat=new SimpleDateFormat(expDateFormat);
               Date date=simpleDateFormat.parse(candidate);
               return expSimpleDateFormat.format(date);
            }
         }
         catch (ParseException e)
         {
            e.printStackTrace();
         }


      }
      System.err.println("No known Date format found: " + candidate);
      return null;
   }

   public static void main(String[] args)
   {
      System.out.println(parseDate("20171107","yyyyMMdd","yyyyMMdd"));
      System.out.println(parseDate("20171107","yyyyMMdd","yyyy-MM-dd"));
      System.out.println(parseDate("20171107","yyyyMMdd","yyyy/MM/dd"));
      System.out.println(parseDate("20171107","yyyyMMdd","yyyy MM dd"));
      System.out.println(parseDate("20171107","yyyyMMdd","yyyy.MM.dd"));
   }
}
/*Letter	Description	Examples
y	Year	2013
M	Month in year	July, 07, 7
d	Day in month	1-31
E	Day name in week	Friday, Sunday
a	Am/pm marker	AM, PM
H	Hour in day	0-23
h	Hour in am/pm	1-12
m	Minute in hour	0-60
s	Second in minute	0-60*/