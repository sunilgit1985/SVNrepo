package com.invessence;

import com.invessence.emailer.util.EmailJob;
import org.quartz.Scheduler;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 11/5/14
 * Time: 12:17 PM
 * To change this template use File | Settings | File Templates.
 */
public class EmailProcessor
{
/* Only for testing purpose
   static{

      System.out.println("Start static block :");
      String [] args = new String[2];
      args[0] = "-test";
      args[1] = "abhangp@mindcraft.in";
      EmailProcessor.main(args);
   }
*/

   public static void main(String[] args)
   {

      try
      {
         if (args.length == 2)
         {
            if (args[0].equals("-test"))
            {
               // If called with test mode, then send one email and quit.
               String[] emailAddresses = args[1].split(",");
               EmailJob.setTestMode(false, emailAddresses);
            }
            else if (args[0].equals("-resend"))  {
               // Resend message ID: Which is part of sencond arg.
               String[] messageid = args[1].split(",");
               // Code to write:
               //  Option 1:  Just toggle the flags, so that the message is resent by normal emailer process.
               //  Option 2:  Force a resend by calling fetch of the message and resending it.
               //  With Option1 (We can call from web), and let stand alone module run.
               //  Option 2, can only be run from command line.  How do you handle already running version
            }
            else {
               System.out.println("test 0");
               // Else start the camel context and keep checking the email.
               ClassPathXmlApplicationContext applicationContext = new ClassPathXmlApplicationContext("META-INF/spring/email.util.xml");
               Scheduler schedulerFactory = (Scheduler) applicationContext.getBean("schedulerFactory");
               schedulerFactory.start();
            }
         }
         else {
            System.out.println("Start of Process: META-INF/spring/email.util.xml");
            ClassPathXmlApplicationContext applicationContext = new ClassPathXmlApplicationContext("META-INF/spring/email.util.xml");
            Scheduler schedulerFactory = (Scheduler) applicationContext.getBean("schedulerFactory");
            schedulerFactory.start();
         }
      }
      catch (Error e)
      {

         e.printStackTrace();
      }
      catch (Exception e)
      {
         System.out.println("Exception 2 :"+e.toString());
         e.printStackTrace();
      }
   }
}
