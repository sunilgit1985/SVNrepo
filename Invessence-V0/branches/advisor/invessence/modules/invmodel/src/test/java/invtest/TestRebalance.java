package invtest;

import java.io.*;
import java.text.DecimalFormat;
import java.util.*;

import com.invmodel.asset.AssetAllocationModel;
import com.invmodel.asset.data.AssetClass;
import com.invmodel.dao.*;
import com.invmodel.dao.data.ClientProfileData;
import com.invmodel.inputData.ProfileData;
import com.invmodel.portfolio.PortfolioModel;
import com.invmodel.portfolio.data.*;

import static java.lang.String.valueOf;

/**
 * Hello world!
 */
public class TestRebalance
{
   private static TestRebalance instance = null;

   public static synchronized TestRebalance getInstance()
   {
      if (instance == null)
      {
         instance = new TestRebalance();
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
      ClientProfileDataLoader clientPDL = ClientProfileDataLoader.getInstance();
      AssetDBCollection assetdao = AssetDBCollection.getInstance();
      SecurityDBCollection securityDao = SecurityDBCollection.getInstance();
      ProfileData profileData = new ProfileData();

      String fileName = null;
      String tax = "IRA";
      if (tax.equals("IRA"))
      {
         fileName = "RebalancePortfolio.csv";
      }
      else
      {
         fileName = "taxableRebalancePortfolio.csv";
      }

      PrintWriter writer = TestRebalance.getInstance().getFileHandle(tax, fileName);

      Map<String, ClientProfileData> clientDataList = clientPDL.getClientAccountTypeList();
      String clientAccountNumber = null;
      int clientNum = 0;
      for (String ibAcct: clientDataList.keySet())
      {
         if (ibAcct.equals("U1256464") == false && ibAcct.equals("U1234") == false )  //Exclude Jigars IRA with stocks
         {

            System.out.println (ibAcct);
            clientAccountNumber = ibAcct;
            //profileData.setIbAcctNum(ibAcct);

            int age, duration;
            String risk;

            Integer invCapital, riskOffset;
            Integer yearlyInvestments;
            Integer stayInvested;
            String name = "";

            // Get asset allocation

            //Load profile data

            if (clientDataList.get(clientAccountNumber).getTaxType().contains(tax))
               profileData.setAccountTaxable(false);
            else
               profileData.setAccountTaxable(true);

            profileData.setAccountType(clientDataList.get(clientAccountNumber).getTaxType());

            profileData.setAge(clientDataList.get(clientAccountNumber).getAge());
            age = profileData.getAge();
            profileData.setHorizon(clientDataList.get(clientAccountNumber).getDuration());
            duration = profileData.getHorizon();


            profileData.setRiskIndex(clientDataList.get(clientAccountNumber).getRiskIndex());
            profileData.setNumOfAllocation(profileData.getHorizon());

            //1 = preservation 2 = Accumulation
            //profileData.setObjective(2);

            //1 = Go to Cash, 2 = Stay Invested
            if (clientDataList.get(clientAccountNumber).isStayInvested()== true)
               profileData.setStayInvested(1);
            else
               profileData.setStayInvested(2);

            invCapital = (int) (clientDataList.get(clientAccountNumber).getTotalCapital());
            if (ibAcct.equals("U1297404"))
               invCapital = invCapital - 15000; //Subtracting Preeti's FB position (200*75)

            if (ibAcct.equals("U1297285"))
               invCapital = invCapital - 60000; //Subtracting Lanif's $60,000 cash

            profileData.setInitialInvestment(invCapital);

            profileData.setCurrentIncome((int)clientDataList.get(clientAccountNumber).getTotalIncomeAnnulized());

            AssetAllocationModel assetAllocationModel = AssetAllocationModel.getInstance();
            assetAllocationModel.setAssetdao(AssetDBCollection.getInstance());
            assetAllocationModel.setHr(HistoricalReturns.getInstance());
            AssetClass[] aamc = assetAllocationModel.getAssetDistribution(profileData);


            String[] orderedAssets = assetdao.getOrderedAsset(profileData.getAdvisor());

            //Create a file for initial asset allocation
            createFirstAssetAllocationChart(tax, duration, age, "M", invCapital, assetdao, aamc, orderedAssets);

            //Portfolio[] pfclass = new Portfolio[aamc.length];

            PortfolioModel portfolioModel = PortfolioModel.getInstance();
            portfolioModel.setMonthlyDao(DailyReturns.getInstance());
            portfolioModel.setSecurityDao(SecurityDBCollection.getInstance());
            profileData.setNumOfPortfolio(aamc.length);
            Portfolio[] pfclass = portfolioModel.getDistributionList(aamc, profileData);


            //pfclass = PortfolioModel.getInstance().getDistributionList(aamc, profileData, aamc.length);

            //Create a assetPerformanceFile
            createAssetPerformanceFile(tax, pfclass, aamc);

            createHoldingsFile(pfclass, tax, aamc, profileData, writer, clientNum);

            clientNum = clientNum + 1;
         }
     }

     writer.close();
   }

   public static void createHoldingsFile(Portfolio[] pfclass, String tax, AssetClass[] aamc,
                                         ProfileData profileData, PrintWriter writer, int clientNum) throws Exception
   {

      SecurityDBCollection securityDao = SecurityDBCollection.getInstance();

      double totalMoney = 0.0;

      double[] portfolioRisk = new double[aamc.length];
      double[] portfolioReturn = new double[aamc.length];
      double[] secPortfolioRisk = new double[aamc.length];

      if (clientNum == 0)
      {
         writer.println("Year" + "," + "AcctNumber" + ","+ "Ticker" + "," + "Asset Class" + "Sub Asset Class" + "," +
                           "Type Of Account" + "," + "Price" + "," + "Shares" + "," + "Investment Value" +
                           "," + "Weight per portfolio" + "," + "Total Assets" + "," + "Expected Return" +
                           "," + "Yield" + "," + "Sec Risk" + "," + "ExpRatio");
      }

      //for(int year = aamc.length-1; year >=0; year--)  {

      int year = 0;
      profileData.setNumOfPortfolio(aamc.length);
      pfclass = PortfolioModel.getInstance().getDistributionList(aamc, profileData);

      for (year = 0; year < 1; year++)
      {
         System.out.println(year);

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


         for (int i = 0; i < pfclass[year].getPortfolio().size(); i++)
         {
            pfList[year] = pfclass[year].getPortfolio().get(i);

            tickerList[i] = pfList[year].getTicker();
            secWeight[i] = (pfList[year].getMoney() / totalMoney);
            ;

            if (pfList[year].getTicker().equals("BIL"))
            {
               ticker = "Cash";
            }
            else
            {
               ticker = pfList[year].getTicker();
            }
            Double secExpense = pfList[year].getExpenseRatio();
            writer.println(year +
                              //"," + valueOf(profileData.getIbAcctNum()) +
                              "," + ticker +
                              "," + valueOf(pfList[year].getAssetclass()) +
                              "," + valueOf(pfList[year].getSubclass()) +
                              "," + valueOf(profileData.getAccountType()) +
                              "," + valueOf(pfList[year].getDailyprice()) +
                              "," + valueOf(pfList[year].getShares()) +
                              "," + valueOf(pfList[year].getMoney()) +
                              "," + valueOf(pfList[year].getMoney() / totalMoney) +
                              "," + totalMoney +
                              "," + valueOf(pfList[year].getExpectedReturn())+
                              "," + valueOf(pfList[year].getYield())+
                              "," + valueOf(pfList[year].getSecRisk()) +
                              "," + valueOf(secExpense));
         }

         //portfolioRisk = pf.getPortfolioRiskReturn(tax, aamc);
         //portfolioReturn = pf.avgYearReturns(aamc, );
         //secPortfolioRisk[year] = pf.getSecPortRisk(tickerList, secWeight);


         totalMoney = 0;
      }



      createRiskReturnFile(tax, portfolioRisk, portfolioReturn, secPortfolioRisk);
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

      writer = TestRebalance.getInstance().getFileHandle(tax, fileName);

      writer.println("Portfolio Risk" + ", Security Weighted Risk" + ", Portfolio Return");

      //File is created in TestDistribution
      for (int y = 0; y < portfolioReturn.length; y++)
      {
         writer.println(portfolioRisk[y] + "," + secWgtRisk[y] + "," + portfolioReturn[y]);
      }

      writer.close();
   }

   public static void createAssetPerformanceFile(String tax, Portfolio[] pfclass, AssetClass[] aamc) throws Exception
   {

      String fileName;
      PrintWriter writer = null;

      if (tax.equals("No"))
      {
         fileName = "iraAssetsGrowth.csv";
      }
      else
      {
         fileName = "taxedAssetsGrowth.csv";
      }
      writer = TestRebalance.getInstance().getFileHandle(tax, fileName);

      DecimalFormat df = new DecimalFormat("#.##");

      int y = 0;
      for (y = 0; y < aamc.length; y++)
      {
         if (y == 0)
         {
            writer.println("Year" + "," + "AvgYearReturns" + "," + "Savings" + "," + "Domestic" + "International" + "," + "Bond" + "," + "Commodity" + "," + "Cash");
         }

         writer.println(y + "," + df.format(pfclass[y].getExpReturns()) + "," + df.format(pfclass[y].getTotalMoney()) + ","
                           + df.format(aamc[y].getAssetActualWeight("Domestic")) + ","
                           + df.format(aamc[y].getAssetActualWeight("International")) + ","
                           + df.format(aamc[y].getAssetActualWeight("Bond")) + ","
                           + df.format(aamc[y].getAssetActualWeight("Commodity")) + ","
                           + df.format(aamc[y].getAssetActualWeight("Cash")));
      }

      writer.println();
      writer.close();
   }

   public static void createFirstAssetAllocationChart(String tax, int duration, int age, String risk,
                                                      double invCapital, AssetDBCollection assetdao,
                                                      AssetClass[] aamc, String[] orderedAssets) throws Exception
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
      writer = TestRebalance.getInstance().getFileHandle(tax, fileName);

      writer.println("Profile: Age " + String.valueOf(age) + ", Risk " + risk +
                        ", Duration " + String.valueOf(duration) + ", Investment Capital " + String.valueOf(invCapital) + ", Tax rate 30% " + tax);
      writer.println("Assets, Weights");

      for (int i = 0; i < (orderedAssets.length); i++)
      {
         String assetName = orderedAssets[i];
         writer.println(assetName + ", " + aamc[0].getAssetActualWeight(assetName));
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
            file = new File("C:/Users/Jigar/Work Related/RiverFrontAdvisors/Clients/" + fileName);
         }
         else
         {
            file = new File("C:/Users/Jigar/Work Related/RiverFrontAdvisors/Clients/" + fileName);
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
