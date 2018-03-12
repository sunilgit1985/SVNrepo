package com.invessence.fileProcessor;


import java.util.*;

import com.invessence.fileProcessor.service.FileProcessor;
import com.invessence.service.bean.*;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by Bharati on 1/25/2018.
 */
public class ManualFileProcessor
{
   public static void main(String[] args)
   {
      try
      {
         ConfigurableApplicationContext context = new ClassPathXmlApplicationContext("fileProcessorConfig.xml");
         FileProcessor fp = context.getBean(FileProcessor.class);
         System.out.println("************** Manual File Processor Execution Start **************");
         if(args.length>=3)
         {
            ServiceRequest serviceRequest = new ServiceRequest(args[0], args[1], args[2]);
            System.out.println("serviceRequest = " + serviceRequest);

            Scanner scanner = new Scanner(System.in);
            System.out.print("Enter File Sequence ID : ");
            int sequenceId = Integer.parseInt(scanner.next());
            serviceRequest.setSequenceId(sequenceId);

            WSCallResult wsCallResult=fp.process(serviceRequest);
            System.out.println("wsCallResult = " + wsCallResult);
         }else{
            System.out.println("Required parameters are not entered!");
         }
         context.close();
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }

   }
}
