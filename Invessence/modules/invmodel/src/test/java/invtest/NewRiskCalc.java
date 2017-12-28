package invtest;

import java.io.*;
import java.util.*;

import com.invmodel.asset.data.AssetClass;
import com.invmodel.dao.data.PrimeAssetClassData;
import com.invmodel.inputData.ProfileData;
import com.invmodel.model.ModelUtil;
import com.invmodel.model.dynamic.PortfolioOptimizer;
import com.invmodel.portfolio.data.*;
import com.invmodel.risk.dao.RiskDAO;
import com.invmodel.risk.data.*;
import com.invmodel.risk.data.client.UOBRiskCalc;

/**
 * Created by prashant on 11/13/2017.
 */
public class NewRiskCalc
{

   static RiskDAO riskfetchDAO = new RiskDAO();
   static ModelUtil modelUtil = ModelUtil.getInstance();
   static UserRiskProfile userRiskProfile;
   static AdvisorRiskMaster advisorRiskMaster;
   static RiskCalc riskCalc;
   static ProfileData profileData;

   static String datadir = "C:/Data/Testing";
   static Map<String, PrintData> printDataMap = new HashMap<String, PrintData>();


   public static void main(String[] args) throws Exception
   {
      testRisk(args);
   }

   public static void testRisk(String[] args) throws Exception
   {

      String advisor = "UOB";
      Long acctnum = null;


      advisorRiskMaster = new AdvisorRiskMaster(advisor);

      // Use existing account to collect data
      userRiskProfile = new UserRiskProfile(advisor, acctnum);

      // overrideRisk(userRiskProfile);
      riskCalc = new UOBRiskCalc(userRiskProfile);
      modelUtil.refreshData();

      // Data needed for Profiledata
      profileData = new ProfileData();
      profileData.setRiskProfile(userRiskProfile);
      if (userRiskProfile.getRiskData().containsKey(RiskConst.INITIALINVESTMENT))
      {
         profileData.setActualInvestment(userRiskProfile.getRiskData().get(RiskConst.INITIALINVESTMENT).getAnswerDouble());
      }
      else
      {
         profileData.setActualInvestment(100000.0);
      }

      profileData.setInitialInvestment(600000);
      profileData.setActualInvestment(600000.0);
      profileData.setRecurringInvestment(30000);
      userRiskProfile.setAnswer(RiskConst.RECURRINGPERIOD,1);
      profileData.setAdvisor(advisor);
      profileData.setTheme(userRiskProfile.getAnswer(RiskConst.THEME));

      calculateOneRisk();
      System.out.print("Done");
   }

   public static void calculateOneRisk() {
      riskCalc.ageTimeFormula(64,3);
      riskCalc.calculate();
      System.out.println("Score:" + userRiskProfile.getScore(0));
   }


   public static void calculateRisk() {
      Integer startingQuestion = 4;
      Integer lastQuestion = userRiskProfile.getRiskQuestion();
      Boolean skipKnockout = true;
      int[][] possibleChoices = createGrid(skipKnockout);

      Integer key = 0;
      for (Integer age = 0; age < 100; age+=5) {
         for (Integer horizon = 1; horizon < 35; horizon+=5) {
            riskCalc.ageTimeFormula(age,horizon);
/*
            for (Integer loop = 0; loop < possibleChoices.length; loop++)
            {
               for (Integer q = startingQuestion; q <= lastQuestion; q++)
               {
                  riskCalc.setQuestionsRisk(q, possibleChoices[loop][q-1], null);
               }
               riskCalc.calculate(0);

****
               AssetClass[] aamc = modelUtil.buildAllocation(userRiskProfile, profileData);
               Portfolio[] pfclass = modelUtil.buildPortfolio(aamc, userRiskProfile, profileData);

               PrintData printData = new PrintData(profileData, aamc, pfclass);
               printDataMap.put(key.toString(), printData);
******

            }
         */
         }
      }
      try
      {
         createPortfolioArray(printDataMap);
      }
      catch (Exception ex) {

      }

   }
   public static int[][] createGrid(Boolean skipKnockout)
   {
      // Skip Question #1, it is part of Goal legecy!

      Integer numQuestions = userRiskProfile.getRiskQuestion();
      Integer maxChoice = 1;
      for (Integer q = 1; q <= numQuestions; q++)
      {

         Integer numOfQuestions = userRiskProfile.getAdvisorRiskMaster().getAdvisorMappings().get(q).getNumOfWeights();
         if (skipKnockout) {
            if (userRiskProfile.getAdvisorRiskMaster().getAdvisorMappings().get(q).getKnockoutQuestion() > 0) {
               numOfQuestions--;
            }
         }

         // Just in case there is only one choice, we don't want to multiply by zero.
         if (numOfQuestions > 0)
            maxChoice *= numOfQuestions;
      }
      // We want all initialized array.  Therefore we are using the base int class.
      int[][] possibleChoices = new int[maxChoice][numQuestions];
      // Starting with last question .
      Integer increment = 1;
      Integer elements;

      for (Integer q = numQuestions; q >= 1; q--)
      {
         elements = userRiskProfile.getAdvisorRiskMaster().getAdvisorMappings().get(q).getNumOfWeights();
         Integer knockoutAns = userRiskProfile.getAdvisorRiskMaster().getAdvisorMappings().get(q).getKnockoutQuestion();
         if (skipKnockout) {
            if (knockoutAns > 0) {
               elements--;
               if (elements <=0) {
                  continue;
               }
            }
         }
         Integer split = (Integer) (maxChoice / elements);
         Integer choice = 1;
         Integer qptr = 1;
         for (Integer loop = 0; loop < maxChoice; loop++)
         {
            if (skipKnockout) {
               if (qptr == knockoutAns)
                  choice++;
            }
            possibleChoices[loop][q-1] = choice;

            qptr++;
            if (qptr > increment)
            {
               qptr = 1;
               choice++;
               if (choice > elements)
                  choice = 1;
            }

         }
         increment *= elements;
      }
      System.out.println("GRID [" + maxChoice + "," + numQuestions + "]");
      // riskCalc.calculate(years);
      return possibleChoices;
   }


   public static void overrideRisk(UserRiskProfile userRiskProfile)
   {
      // userRiskProfile.setAnswer(RiskConst.ADVISOR, "UOB", "T");  This is already defined in default Init process
      userRiskProfile.setAnswer(RiskConst.THEME, "0.SGWealthSGD");
      userRiskProfile.setAnswer(RiskConst.GOAL, "Retirement");
      userRiskProfile.setAnswer(RiskConst.AGE, 45);
      userRiskProfile.setAnswer(RiskConst.HORIZON, 20);
      userRiskProfile.setAnswer(RiskConst.TRADECURRENCY, "SGD");
      userRiskProfile.setAnswer(RiskConst.SETTLECURRENCY, "SGD");
      userRiskProfile.setAnswer(RiskConst.INITIALINVESTMENT, 100000.0);
      userRiskProfile.setAnswer(RiskConst.RECURRINGINVESTMENT, 5000.0);
      userRiskProfile.setAnswer(RiskConst.RECURRINGTERM, "YEARLY");
      userRiskProfile.setAnswer(RiskConst.RECURRINGPERIOD, 1);
      userRiskProfile.setAnswer(RiskConst.WITHDRAWALPERIOD, 10);
      userRiskProfile.setAnswer(RiskConst.KEEPLIQUID, 0.0);
      userRiskProfile.setAnswer(RiskConst.KNOCKOUT, false);
      userRiskProfile.setAnswer(RiskConst.TAXABLE, false);
      userRiskProfile.setAnswer(RiskConst.TAXRATE, 0.20);
      userRiskProfile.setAnswer(RiskConst.EXPERIENCE, 1);

      userRiskProfile.setAnswer(RiskConst.RISKQUESTIONS, 8);
      userRiskProfile.setAnswer(RiskConst.CALCMETHOD, RiskConst.CALCMETHODS.AGETIME.toString());
      userRiskProfile.setAnswer(RiskConst.CALCFORMULA, RiskConst.CALCFORMULAS.C.toString().substring(1, 1));

   }


   public PrintWriter getFileHandle(String tax, String fileName)
   {
      File file;
      PrintWriter writer = null;

      try
      {

         if (tax.equals("No"))
         {
            file = new File(datadir + "/" + fileName);
         }
         else
         {
            file = new File(datadir + "/taxable/"+ fileName);
         }

         //file = new RandomAccessFile ("filename.ext","rw");
         file.getParentFile().mkdirs();
         writer = new PrintWriter(file);
      }
      catch (FileNotFoundException e)
      {
         e.printStackTrace();
      }
      return writer;
   }

   public static void createPortfolioArray(Map<String, PrintData> data) throws Exception
   {

   }

   public static void createPrimeAssetArry(PortfolioOptimizer portfolioOptimizer, ProfileData profileData,
                                           Map <Integer,Portfolio> portList) throws Exception
   {

      String fileName;
      PrintWriter writer = null;

      fileName = "EfficientFrontierPrime";
      fileName = fileName + profileData.getTheme() + ".csv";

      writer = TestDistribution.getInstance().getFileHandle("No", fileName);


      String theme = profileData.getTheme();

      for (int i=0; i < portList.size(); ++i)
      {
         if (i == 0)
         {
            for (String assetName : portfolioOptimizer.getOrderedAsset(profileData.getTheme()))
            {

               for (PrimeAssetClassData primeData : portfolioOptimizer.getAssetData(theme, assetName).getOrderedPrimeAssetData())
               {
                  writer.print("," + primeData.getTicker());
               }


            }
            writer.println();
         }

         for (String assetName : portfolioOptimizer.getOrderedAsset(profileData.getTheme()))
         {

            double[] weight = portfolioOptimizer.getAssetData(theme, assetName).getPrimeAssetweights()[i];

            for (int j = 0; j < weight.length; j++)
            {

               writer.print("," + weight[j]);
            }

         }
         writer.println();
      }
      writer.close();
   }

   public static void createEfficientFrontier(AssetClass[] aamc, Portfolio[] pfclass, PortfolioOptimizer portfolioOptimizer,
                                              ProfileData profileData, Map <Integer,Portfolio> portList) throws Exception
   {

      String fileName;
      PrintWriter writer = null;
      fileName = "AssetsEfficientFrontier";
      fileName = fileName + profileData.getTheme() + ".csv";

      writer = TestDistribution.getInstance().getFileHandle("No", fileName);
      String theme = profileData.getTheme();

      for (int riskNum = 0; riskNum < 100; riskNum++)
      {
         ArrayList assetName = portfolioOptimizer.getAdvisorOrdertedAssetList(theme);
         double[] weight = portfolioOptimizer.getAssetOrderedWeight(theme, riskNum);
         if(riskNum==0) {

            writer.print("Risk Number" +
                            "," + assetName.get(0) +
                            "," + assetName.get(1) +
                            "," + assetName.get(2) +
                            "," + assetName.get(3));
            writer.println();
         }

         writer.print(riskNum +
                         "," + weight[0] +
                         "," + weight[1] +
                         "," + weight[2] +
                         "," + weight[3]);
         writer.println();
      }
      writer.close();
   }

}
