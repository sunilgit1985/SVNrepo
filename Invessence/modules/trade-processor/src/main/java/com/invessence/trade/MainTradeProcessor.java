package com.invessence.trade;

import com.invessence.trade.service.TradeProcessor;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/*
   This class is use to call method process() of PriceProcessor.class
 */
public class MainTradeProcessor
{

   public static void main(String[] args)
   {
      try
      {

         ConfigurableApplicationContext context = new ClassPathXmlApplicationContext("tradeProcessorConfig.xml");
         TradeProcessor pp = context.getBean(TradeProcessor.class);
         pp.process();
         //pp.initialProcess("SPY");

         context.close();
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }

   }


}
