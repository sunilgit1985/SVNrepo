package webtest;

import java.util.*;

import javax.faces.bean.ManagedProperty;

import com.invessence.LTAMOptimizer;
import com.invessence.dao.consumer.ConsumerListDataDAO;
import com.invessence.data.common.AccountData;
import com.invessence.data.consumer.ConsumerData;
import com.invessence.data.ltam.LTAMRiskData;
import com.invessence.util.WebUtil;

/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 4/8/16
 * Time: 10:41 AM
 * To change this template use File | Settings | File Templates.
 */
public class testRisk
{
   @ManagedProperty("#{consumerListDataDAO}")
   static private ConsumerListDataDAO listDAO;
   public void setListDAO(ConsumerListDataDAO consumerListDataDAO)
   {
      this.listDAO = consumerListDataDAO;
   }


   public static void main(String[] args) throws Exception
   {
      testRiskofUsers(args);
   }

   public static void testRiskofUsers(String[] args) {
      List<ConsumerData> consumerList;
      LTAMRiskData riskData = new LTAMRiskData();
      consumerList = listDAO.getClientProfileData(10L, "A", null);
      System.out.println("Account#" + "," +
                            "Age" + "," + "Ans2" + "," + "Ans3" + "," +
                            "Ans4" + "," + "Ans5" + "," + "Ans6" + "," +
                            "OrigRisk" + "," + "NewRisk");
      for (ConsumerData cd : consumerList) {
         AccountData  ad= listDAO.getAccountData(cd.getLogonid(), cd.getAcctnum());
         riskData.setAgeforRisk(ad.getAge());  // This is same as ans1
         riskData.setAns2(ad.getAns2());
         riskData.setAns3(ad.getAns3());
         riskData.setAns4(ad.getAns4());
         riskData.setAns5(ad.getAns5());
         riskData.setAns6(ad.getAns6());
         Double riskIndex = riskData.calcRiskIndex();
         System.out.println(ad.getAcctnum() + "," +
                               ad.getAge() + "," + ad.getAns2() + "," + ad.getAns3() + "," +
                               ad.getAns4() + "," + ad.getAns5() + "," + ad.getAns5() + "," +
                               ad.getRiskIndex() + "," + riskIndex);

      }

   }

   public static void testRedirect(String[] args) {
      LTAMRiskData riskData = new LTAMRiskData();
      WebUtil webUtil = new WebUtil();

      Integer a1,a2,a3,a4,a5;
      a1=a2=a3=a4=a5=0;
      for (int age = 20; age <= 100; age+=5) {
         for (int sample = 0; sample < 2; sample++) {
            switch (sample) {
               case 0:
                  a1=a2=a3=a4=a5=1;
                  break;
               case 1:
                  a1=a2=a3=a4=a5=5;
                  break;
               case 2:
                  a1=a2=a3=a4=a5=2;
                  break;
               case 3:
                  a1=a2=a3=a4=a5=3;
                  break;
               case 4:
                  a1=a2=a3=a4=a5=4;
                  break;
               case 5:
                  a1=1;a2=2;a3=3;a4=4;a5=5;
                  break;
               case 6:
                  a1=1;a2=1;a3=3;a4=4;a5=5;
                  break;
               case 7:
                  a1=1;a2=1;a3=1;a4=4;a5=5;
                  break;
               case 8:
                  a1=1;a2=1;a3=1;a4=1;a5=5;
                  break;
               case 9:
                  a1=2;a2=2;a3=3;a4=4;a5=5;
                  break;
               case 10:
                  a1=3;a2=3;a3=4;a4=4;a5=5;
                  break;
               case 11:
                  a1=4;a2=4;a3=1;a4=1;a5=1;
                  break;
               case 12:
                  a1=5;a2=5;a3=1;a4=1;a5=1;
                  break;
               default:
            }

/*
            Integer a1=webUtil.randomGenerator(1,6);
            Integer a2=webUtil.randomGenerator(1,6);
            Integer a3=webUtil.randomGenerator(1,6);
            Integer a4=webUtil.randomGenerator(1,6);
            Integer a5=webUtil.randomGenerator(1,6);
*/
            riskData.setAgeforRisk(age);  // This is same as ans1
            riskData.setAns2(a1);
            riskData.setAns3(a2);
            riskData.setAns4(a3);
            riskData.setAns5(a4);
            riskData.setAns6(a5);
            Double riskIndex = riskData.calcRiskIndex();
            System.out.println(age + "," + a1 + "," + a2 + "," + a3 + "," + a4 + "," + a5 + "," + riskIndex);
         }
      }

    }

}
