package com.invessence.price.processor;

import com.invessence.emailer.util.EmailCreator;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;

/**
 * Created by sagar on 4/20/2017.
 */

@Component
public class Processing
{

   private static final Logger logger = Logger.getLogger(Main.class);
   @Autowired
   EmailCreator emailCreator;
   @Autowired
   ExchangeRateProcessing exchngProcess;
   @Autowired
   PriceProcessing priceProcess;


   public void startProcessing(String[] args)
   {
      StringBuilder mailFailureAlertMsg = null;
      StringBuilder mailWaringAlertMsg = null;
      try
      {
         mailFailureAlertMsg = new StringBuilder();
         mailWaringAlertMsg = new StringBuilder();
         if (args.length != 0)
         {
            String company = null, mode = null, exchngrqd = null, ondemandrqd = null;
            logger.info(" Processing.startProcessing() passing argument length " + args.length);
            for (int i = 0; i < args.length; i++)
            {
               if (i == 0)
               {
                  company = "" + args[i].trim();
               }
               if (i == 1)
               {
                  mode = "" + args[i].trim();
               }
               if (i == 2)
               {
                  exchngrqd = "" + args[i].trim();
               }
               if (i == 3)
               {
                  ondemandrqd = "" + args[i].trim();
               }
            }

            logger.info(" Processing.startProcessing() passing argument company " + company + " mode " + mode + " exchngrqd " + exchngrqd+" ondemandrqd "+ondemandrqd);
            if (company != null && mode != null && exchngrqd != null && ondemandrqd != null && company != "" && mode != "" && exchngrqd != "" && ondemandrqd != "")
            {

               if (exchngrqd.equalsIgnoreCase("Y") || exchngrqd.equalsIgnoreCase("EXCHANGE_YES"))
               {
                  //ExchangeRateProcessing exchngProcess = context.getBean(ExchangeRateProcessing.class);
                  boolean bFlag = exchngProcess.process(company, mode, mailFailureAlertMsg, mailWaringAlertMsg,ondemandrqd);
                  logger.info(" Processing.startProcessing() Exchange rate processing bFlag " + bFlag);
                  if (bFlag)
                  {
//                  PriceProcessing priceProcess = context.getBean(PriceProcessing.class);
                     priceProcess.process(company, mode, mailFailureAlertMsg, mailWaringAlertMsg,ondemandrqd);
                  }
                  else
                  {
                     logger.info(" Processing.startProcessing() No Attempt for Pricing as exchange rates are not collected ");
                     mailWaringAlertMsg.append(" Processing.startProcessing() No Attempt for Pricing as exchange rates are not collected \n");
                  }
//               context.close();
               }
               else
               {
//               PriceProcessing priceProcess = context.getBean(PriceProcessing.class);
                  priceProcess.process(company, mode, mailFailureAlertMsg, mailWaringAlertMsg,ondemandrqd);
//               context.close();
               }
            }
            else
            {
               logger.info(" Processing.startProcessing() Company/mode/pricingrqd  not specified, since process not started for Exhange Rate &/ Price collection processing");
               mailFailureAlertMsg.append("Processing.startProcessing() Company/mode/pricingrqd  not specified, since process not started for Exhange Rate &/ Price collection processing. \n");
            }
         }
         else
         {
            logger.info(" Processing.startProcessing() Company/mode/pricingrqd  not specified, since process not started for Exhange Rate &/ Price collection processing");
            mailFailureAlertMsg.append("Processing.startProcessing() Company/mode/pricingrqd  not specified, since process not started for Exhange Rate &/ Price collection processing. \n");
         }
      }
      catch (Exception e)
      {
         logger.info(" Processing.startProcessing() Error " + e);
         e.printStackTrace();
      }
      finally
      {
         if (mailFailureAlertMsg.length() > 0)
         {
            logger.info("mailFailureAlertMsg IS :" + mailFailureAlertMsg);
            emailCreator.sendToSupport("ERR", "EXCEPTION:PRICING MODULE", mailFailureAlertMsg.toString());
         }
         else
         {
            logger.info("mailFailureAlertMsg is empty");
         }
         if (mailWaringAlertMsg.length() > 0)
         {
            logger.info("mailWaringAlertMsg IS :" + mailWaringAlertMsg);
            emailCreator.sendToSupport("WARN", "WARNING:PRICING MODULE", mailWaringAlertMsg.toString());
         }
         else
         {
            logger.info("mailWaringAlertMsg is empty");
         }
      }
   }
}
