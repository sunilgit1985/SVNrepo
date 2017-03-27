package com.invessence.service;

import com.invessence.service.bean.ServiceStatus;
import com.invessence.service.dao.ServiceDao;
import com.invessence.service.util.*;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by abhangp on 1/11/2017.
 */
public class MainNew
{
   public static void main(String[] args)
   {
   try
   {

      ConfigurableApplicationContext context = new ClassPathXmlApplicationContext("serviceConfig.xml");
      ServiceDao serviceDao=(ServiceDao) context.getBean("wsCommonDao");
      ServiceDetails serviceDetails=new ServiceDetails(serviceDao);
//      System.out.println("Exception Hip Hip Hurray!");
//      System.out.println(new ExceptionHandler().exceptionHandler("BUILDINGBENJAMINS",Constant.SERVICES.AGGREGATION_SERVICES.toString(),Constant.AGGREGATION_SERVICES.MX.toString(),
//                                                                 new ServiceStatus(null,"Server errors - Something went wrong on MX’s end..")));
//      System.out.println("******************************");

   }
   catch (Exception e)
   {
      e.printStackTrace();
   }
}
}
