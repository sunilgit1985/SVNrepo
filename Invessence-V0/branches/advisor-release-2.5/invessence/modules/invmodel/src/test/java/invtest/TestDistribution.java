package invtest;

import com.invmodel.Const.InvConst;
import com.invmodel.asset.*;
import com.invmodel.asset.data.*;
import com.invmodel.inputData.ProfileData;
import com.invmodel.portfolio.*;
import com.invmodel.portfolio.data.*;
import com.invmodel.dao.*;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.*;

import static java.lang.String.valueOf;

/**
 * Hello world!
 */
public class TestDistribution
{
   private static TestDistribution instance = null;
   private static String datadir = "C:/Users/Jigar/Work Related/RiverFrontAdvisors/Clients/";


   public static synchronized TestDistribution getInstance()
   {
      if (instance == null)
      {
         instance = new TestDistribution();
      }

      return instance;
   }


   /**
    * @param args
    */
   public static void main(String[] args) throws Exception
   {
      //getPortfolioAllocation(args);
      //testAllocation(args);
      //testPorfolioModel(args);
      //testPorfolioModel_noargs();
      testPerformanceModel(args);
      //testAllocationV2(args);
   }

   public static void testPerformanceModel(String[] args) throws Exception
   {
      //AssetDBCollection assetdao = AssetDBCollection.getInstance();

      // doMatrixMultiplication();

      int age, duration;
      String risk, tax;

      Integer invCapital, riskOffset;
      Integer yearlyInvestments;
      Integer stayInvested;
      String name = "";
      ProfileData profileData = new ProfileData();

      tax = "No";

      profileData.setName("Retirement");
      //profileData.setAdvisor("PrimeAsset");
      //profileData.setTheme("0.Income");
      profileData.setTheme("0.Core");
      profileData.setAccountTaxable(false);

      profileData.setAge(50);
      age = profileData.getAge();

      profileData.setHorizon(30);
      duration = profileData.getHorizon();

      // profileData.setAccountTaxable(false);
      profileData.setRiskIndex(0);

      //1 = preservation 2 = Accumulation
      profileData.setObjective(2);
      //2 = Go to Cash, 1 = Stay Invested
      profileData.setStayInvested(1);

      profileData.setInitialInvestment(100000);
      invCapital = profileData.getInitialInvestment();
      profileData.setRecurringInvestment(5000);

      profileData.setDependent(0);
      profileData.setTotalIncome(120000);
      profileData.setLiquidAsset(5000000);
      profileData.setTotalExpense(0);
      profileData.setNumOfAllocation(duration);



      profileData.setRisk("M");
      risk = profileData.getRisk();

      //profileData.offsetRiskIndex();

      //createRandomNumbers();

      PortfolioOptimizer poptimizer = PortfolioOptimizer.getInstance();
      poptimizer.refreshDataFromDB();

      Random randomGenerator = new Random();
      //for (int i = 0; i < 10; i++){

         //int randomAge = randomGenerator.nextInt(100);

         //profileData.setAge(randomAge);
         //age = profileData.getAge();

         AssetAllocationModel assetAllocationModel = AssetAllocationModel.getInstance();
         assetAllocationModel.setPortfolioOptimizer(poptimizer);

         // assetAllocationModel.setHr(HistoricalReturns.getInstance());
         AssetClass[] aamc = assetAllocationModel.getAssetDistribution(profileData);
         profileData.setAssetData(aamc);
         PortfolioModel portfolioModel = new PortfolioModel();
         portfolioModel.setPortfolioOptimizer(poptimizer);
         SecurityDBCollection secDao = new SecurityDBCollection();

         //secDao.loadDataFromDB("0.Core");
         //secDao.loadDataFromDB(InvConst.DEFAULT_THEME);

         portfolioModel.setSecurityDao(secDao);
         // portfolioModel.setMonthlyDao(DailyReturns.getInstance());
         profileData.setNumOfPortfolio(profileData.getHorizon());

         Portfolio[] pfclass = portfolioModel.getDistributionList(aamc, profileData);
      //}

      tax = "No";

      //createWeightFile(profileData, poptimizer);
      /*for (String advisorName: poptimizer.getAdvisorList()) {
         for (PrimeAssetClassData pacd : poptimizer.getPrimeAssetData(advisorName)) {
            //printData(advisorName + "-Risk-" + pacd.getPrimeAssetName()  + ".csv", pacd.getRisk());
            //printData(advisorName + "-Return-" + pacd.getPrimeAssetName()  + ".csv", pacd.getReturns());
         }

      }*/

      //Create a file for initial asset allocation
      //createFirstAssetAllocationChart(tax, duration, age, risk, invCapital,aamc, poptimizer);

      //String[] orderedAssets = assetdao.getOrderedAsset(profileData.getAdvisor());

      //Portfolio[] pfclass = portfolioModel.getDistributionList(profileData);



      //Create a assetPerformanceFile
      createAssetPerformanceFile(tax, pfclass, aamc, age);

      createHoldingsFile(pfclass, tax, aamc, profileData);
   }

   public static void createRandomNumbers()
   {

      Double mean=new Double(0.07);
      Double stDev=new Double(0.08);
      Double randNorDist=new Double(0.0);

      Random rand = new Random();
      // return


      String fileName;
      PrintWriter writer = null;
      fileName = "normalDistribution" + ".csv";

      writer = TestDistribution.getInstance().getFileHandle("No", fileName);
      writer.println("Count" + "," + "Number" );


      for (int i = 0; i < 10000; i++)
      {
         //System.out.print(i);
         //System.out.println(randNorDist);

         randNorDist= stDev * rand.nextGaussian() + mean;

         if (randNorDist <= (3.0*stDev+mean) && randNorDist >= (-3.0*stDev+mean))
            writer.println(i + "," + randNorDist );
      }

      writer.close();
   }

   public static void doMatrixMultiplication()
   {
      for (int j = 0; j < 100000; j++)
      {
         for (int i = 0; i < 100000; i++)
         {

          int W = i*j;

         }
      System.out.println(j);
      }


   }
   /*public static void createWeightFile(PortfolioOptimizer assetDao){

      String fileName;
      PrintWriter writer = null;

      fileName = "PortfolioWeights" + ".csv";
      writer = TestDistribution.getInstance().getFileHandle("No", fileName);

      int count = 0;
      String []tickers = secDao.getAssetOrderedAssetTickers(null, theme, null, null);
      String [] index = assetDao.getAdvisorAssetList(groupName);

      writer.print("count");


      for(int i = 0; i < index.length; i++) {
         writer.print("," + index[i]);
      }
      for(int i = 0; i < tickers.length; i++) {
         writer.print("," + tickers[i]);
      }

      writer.print("," + "portfolio Returns" + "," + "Portfolio Risk");
      writer.println();

      double[][] weights = secDao.getThemeWeights(groupName,theme);
      double[] portRisk = secDao.getThemeRisk(groupName,theme);
      double[] portReturns = secDao.getThemeReturns(groupName, theme);
      double[][] assetWeight = assetDao.getAssetOrderedWeightArray(groupName);

      for(count = 0; count< portReturns.length; count++)
      {
         writer.print(count);
         for(int i = 0; i < assetWeight.length; i++)
         {
            writer.print("," + assetWeight[i][count]);
         }

         for(int i = 0; i < tickers.length; i++)
         {
            writer.print("," + weights[count][i]);
         }

         writer.print("," + portReturns[count] + "," + portRisk[count] );

         writer.println();
      }

      writer.close();
   }*/

   public static void createHoldingsFile(Portfolio[] pfclass, String tax, AssetClass[] aamc, ProfileData profileData) throws Exception
   {

      Double mean=new Double(0.0);
      Double stDev=new Double(0.0);
      Double randNorDist=new Double(0.0);

      Random rand = new Random();
      // return
      randNorDist= stDev * rand.nextGaussian() + mean;

      String fileName;
      PrintWriter writer = null;

      double totalMoney = 0.0;

      double[] portfolioRisk = new double[aamc.length];
      double[] portfolioReturn = new double[aamc.length];
      double[] secPortfolioRisk = new double[aamc.length];

      if (tax.equals("No"))
      {
         fileName = "dev_iraPortfolioHoldings";

         fileName = fileName + profileData.getAge() + ".csv";
      }
      else
      {
         fileName = "taxablePortfolioHoldings.csv";
      }

      writer = TestDistribution.getInstance().getFileHandle(tax, fileName);

      writer.println("Year" +
                        "," + "Ticker" +
                        "," + "Asset Class" +
                        "," + "Sub Asset" +
                        "," + "Weight per Asset" +
                        "," + "Price" +
                        "," + "Shares" +
                        "," + "Investment Value" +
                        "," + "Weight per portfolio" +
                        "," + "New Investments" +
                        "," + "Total Assets" +
                        "," + "Expected Return" +
                        "," + "Yield" +
                        "," + "Sec Risk");

      //for(int year = aamc.length-1; year >=0; year--)  {

      int year = 0;
      profileData.setNumOfPortfolio(aamc.length);
      //pfclass = PortfolioModel.getInstance().getDistributionList(aamc, profileData);

      for (year = 0; year < aamc.length; year++)
      {


         PortfolioSecurityData[] pfList = new PortfolioSecurityData[aamc.length];

         //pfclass[year] = PortfolioModel.getInstance().getDistribution(aamc[year], year, duration, invCapital, riskOffset);

         for (int i = 0; i < pfclass[year].getPortfolio().size(); i++)
         {
            pfList[year] = pfclass[year].getPortfolio().get(i);


            totalMoney += pfList[year].getMoney();
         }

         String ticker;
         String[] tickerList = new String[pfclass[year].getPortfolio().size()];
         double[] secWeight = new double[pfclass[year].getPortfolio().size()];

         System.out.print(year);
         System.out.println("-----------");
         for (int i = 0; i < pfclass[year].getPortfolio().size(); i++)
         {
            pfList[year] = pfclass[year].getPortfolio().get(i);

            tickerList[i] = pfList[year].getTicker();
            secWeight[i] = (pfList[year].getMoney() / totalMoney);

            ticker = pfList[year].getTicker();

            //System.out.println(pfList[year].getWeight());

            writer.println(year +
                              "," + ticker +
                              "," + valueOf(pfList[year].getAssetclass()) +
                              "," + valueOf(pfList[year].getSubclass()) +
                              "," + valueOf(pfList[year].getWeight()) +
                              "," + valueOf(pfList[year].getDailyprice()) +
                              "," + valueOf(pfList[year].getShares()) +
                              "," + valueOf(pfList[year].getMoney()) +
                              "," + valueOf(pfList[year].getMoney() / totalMoney) +
                              "," + valueOf(profileData.getRecurringInvestment()) +
                              "," + totalMoney +
                              "," + valueOf(pfList[year].getExpectedReturn())+
                              "," + valueOf(pfList[year].getYield())+
                              "," + valueOf(pfList[year].getSecRisk()));
         }

         //portfolioRisk = pf.getPortfolioRiskReturn(tax, aamc);
         //portfolioReturn = pf.avgYearReturns(aamc, );
         //secPortfolioRisk[year] = pf.getSecPortRisk(tickerList, secWeight);


         totalMoney = 0;
      }

      writer.close();

      //createRiskReturnFile(tax, portfolioRisk, portfolioReturn, secPortfolioRisk);
   }




   public static void createRiskReturnFile(String tax, double[] portfolioRisk, double[] portfolioReturn, double[] secWgtRisk) throws Exception
   {

      String fileName;
      PrintWriter writer = null;

      if (tax.equals("No"))
      {
         fileName = "iraPortRisk.csv";
      }
      else
      {
         fileName = "taxablePortRisk.csv";
      }

      writer = TestDistribution.getInstance().getFileHandle(tax, fileName);

      writer.println("Portfolio Risk" + ", Security Weighted Risk" + ", Portfolio Return");

      //File is created in TestDistribution
      for (int y = 0; y < portfolioReturn.length; y++)
      {
         writer.println(portfolioRisk[y] + "," + secWgtRisk[y] + "," + portfolioReturn[y]);
      }

      writer.close();
   }

   public static void createAssetPerformanceFile(String tax, Portfolio[] pfclass, AssetClass[] aamc, int age) throws Exception
   {

      String fileName;
      PrintWriter writer = null;

      if (tax.equals("No"))
      {
         fileName = "dev_iraAssetsGrowth";
         fileName = fileName + age + ".csv";
      }
      else
      {
         fileName = "taxedAssetsGrowth.csv";
      }
      writer = TestDistribution.getInstance().getFileHandle(tax, fileName);

      DecimalFormat df = new DecimalFormat("#.###");

      int y = 0;
      for (y = 0; y < aamc.length; y++)
      {
         if (y == 0)
         {
            writer.println("Year" + "," + "AvgYearReturns" + "," + "AvgYearRisk" + "," + "Savings" + "," +
                              "Domestic" +","+ "International" + "," + "Bond" + "," + "Commodity" + "," +
                              "Cash" + "," + "2Sigma Error" + "," + "Upper" + "," + "Lower");
         }

         double sigmaError = (pfclass[y].getTotalRisk()*2*pfclass[y].getTotalMoney());

         writer.println(y + "," + df.format(pfclass[y].getExpReturns()) + ","
                           + df.format(pfclass[y].getTotalRisk()) + ","
                           + df.format(pfclass[y].getTotalMoney()) + ","
                           + df.format(aamc[y].getAsset("Domestic").getUserweight()) + ","
                           + df.format(aamc[y].getAsset("International").getUserweight()) + ","
                           + df.format(aamc[y].getAsset("Bond").getUserweight()) + ","
                           + df.format(aamc[y].getAsset("Commodity").getUserweight()) + ","
                           + df.format(aamc[y].getAsset("Cash").getUserweight()) + ","
                           + sigmaError + ","
                           + df.format(pfclass[y].getUpperTotalMoney()) + ","
                           + df.format(pfclass[y].getLowerTotalMoney()));

      }

      writer.println();
      writer.close();
   }

   public static void createFirstAssetAllocationChart(String tax, int duration, int age, String risk,
                                                      double invCapital,
                                                      AssetClass[] aamc, PortfolioOptimizer portfolioOptimizers) throws Exception
   {

      //Create a file for initial asset allocation

      String fileName;
      PrintWriter writer = null;

      if (tax.equals("No"))
      {
         fileName = "iraAssets.csv";
      }
      else
      {
         fileName = "taxableAssets.csv";
      }
      writer = TestDistribution.getInstance().getFileHandle(tax, fileName);

      writer.println("Profile: Age " + String.valueOf(age) + ", Risk " + risk +
                        ", Duration " + String.valueOf(duration) + ", Investment Capital " + String.valueOf(invCapital) + ", Tax rate 30% " + tax);
      writer.println("Assets, Weights");

      for (String assetName : portfolioOptimizers.getAdvisorOrdertedAssetList("0.Core"))
      {
         writer.println(assetName + ", " + aamc[0].getAsset(assetName).getUserweight());
      }

      writer.println();
      writer.close();

   }

   public PrintWriter getFileHandle(String tax, String fileName)
   {
      File file;
      PrintWriter writer = null;

      try
      {

         if (tax.equals("No"))
         {
            file = new File(datadir + "Testing/" + fileName);
         }
         else
         {
            file = new File(datadir + fileName);
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

}
