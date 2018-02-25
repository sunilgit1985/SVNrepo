package com.invmodel.performance;

import java.util.*;

import com.invmodel.Const.InvConst;
import com.invmodel.asset.data.AssetClass;
import com.invmodel.dao.data.*;
import com.invmodel.model.dynamic.PortfolioOptimizer;
import com.invmodel.model.fixedmodel.FixedModelOptimizer;
import com.invmodel.model.fixedmodel.data.*;
import com.invmodel.performance.data.ProjectionData;
import com.invmodel.inputData.ProfileData;
import com.invmodel.portfolio.data.Portfolio;
import com.invmodel.risk.data.RiskCalc;

/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 6/20/16
 * Time: 2:51 PM
 * To change this template use File | Settings | File Templates.
 */
public class ForwardProjection
{
   private static ForwardProjection instance;
   private PortfolioOptimizer portfolioOptimizer;
   private FixedModelOptimizer fixedOptimizer;

   public static synchronized ForwardProjection getInstance()
   {
      if (instance == null)
      {
         instance = new ForwardProjection();
      }

      return instance;
   }

   private ForwardProjection()
   {
      this.portfolioOptimizer = PortfolioOptimizer.getInstance();
      this.fixedOptimizer = FixedModelOptimizer.getInstance();

   }

   public void setPortfolioOptimizer(PortfolioOptimizer portfolioOptimizer)
   {
      this.portfolioOptimizer = portfolioOptimizer;
   }

   public void setFixedOptimizer(FixedModelOptimizer fixedOptimizer)
   {
      this.fixedOptimizer = fixedOptimizer;
   }


   public ArrayList<ProjectionData> createGlidePath(Integer years, RiskCalc riskCalc)
   {
      String theme = riskCalc.getTheme();

   /*
      if (fixedOptimizer != null)
      {
         if (fixedOptimizer.isThisFixedTheme(theme))
         {
            return createFixedModelData(years, riskCalc);
         }
      }
   */
      // If the fixedModel conditions failed, then attmpt to solve as generic handler (Optimized model)
      return createOptimizedData(years, riskCalc);


   }

   public ArrayList<ProjectionData> createOptimizedData(Integer years, RiskCalc riskCalc)
   {

      ArrayList<ProjectionData> projectiondatas = new ArrayList<ProjectionData>();

      if (riskCalc == null)
      {
         return projectiondatas;
      }

      String theme = riskCalc.getTheme();
      ArrayList<String> orderedAssets = portfolioOptimizer.getAdvisorOrdertedAssetList(theme);
      AssetData assetdata;
      years = (years == null) ? 1 : years;

      Integer age = riskCalc.getDefaultAge();
      Integer horizon = riskCalc.getDefaultHorizon();
      Double investment = riskCalc.getDefaultInvestment();
      Double recurring = riskCalc.getDefaultRecurring();
      Integer recurringPeriod = riskCalc.getDefaultRecurringPeriod();
      Integer withDrwalPeriod = riskCalc.getDefaultWithDrwalPeriod();
      Double withdrawlamount = riskCalc.getDefaultWithdrawlAmount();
      Boolean canWithdraw = (withDrwalPeriod > 0 || withdrawlamount >= 0.0);
      Double invCapital = investment;
      Double thisscore;
      withdrawlamount=0.0;
      for (Integer thisyear = 0; thisyear < years; thisyear++)
      {
//         withdrawlamount=0.0;
//         if(thisyear>horizon){
//            withdrawlamount= (0.95 * investment)/ ;
//         }
         ProjectionData pdata = new ProjectionData();
         Double score = riskCalc.calculateRisk(age, horizon, invCapital,
                                               recurring, recurringPeriod,
                                               withDrwalPeriod, withdrawlamount);

         score = (score > InvConst.ASSET_INTERPOLATION - 1 ) ? InvConst.ASSET_INTERPOLATION - 1 : score;
         score = (score <= 0) ? 0 : score;
         double[] weights = portfolioOptimizer.getAssetOrderedWeight(theme, score.intValue());

         Double assetWgt = 0.0;
         Integer offset;
         Double portfolioReturns = 0.0;
         Double portfolioRisk = 0.0;
         for (int assetnum = 0; assetnum < (orderedAssets.size()); assetnum++)
         {
            String assetname = orderedAssets.get(assetnum);
            assetdata = portfolioOptimizer.getAssetData(theme, assetname);

            Double ticker_weight = 0.0;
            assetWgt = assetdata.getWeight(score.intValue());
            if (assetWgt < 0.0001)
            {
               continue;
            }
            double[][] primeAssetWeights = assetdata.getPrimeAssetweights();
            offset = (score.intValue() < 0) ? 0 : score.intValue();
            offset = (offset > InvConst.PORTFOLIO_INTERPOLATION - 1) ? InvConst.PORTFOLIO_INTERPOLATION - 1 : offset;

            int tickerNum = 0;
            for (String primeassetclass : assetdata.getOrderedPrimeAssetList())
            {
               PrimeAssetClassData primeAssetClassData = assetdata.getPrimeAssetData(primeassetclass);
               String ticker = primeAssetClassData.getTicker();
               ticker_weight = assetWgt * primeAssetWeights[offset][tickerNum];
               Double expectedReturn = primeAssetClassData.getExpectedReturn();
               Double expectedRisk = primeAssetClassData.getRiskSTD();
               portfolioReturns = portfolioReturns + (expectedReturn * ticker_weight);
               portfolioRisk = portfolioRisk + (assetdata.getPrimeAssetrisk()[offset] * ticker_weight);
               tickerNum++;
            }
         }
         pdata.setYear(thisyear);
         pdata.setTheme(theme);
         pdata.setInvestmentReturns(portfolioReturns);
         pdata.setInvestmentRisk(portfolioRisk);
//         pdata.setInvestedCapital(investment);
//         pdata.setTotalCapitalWithGains(invCapital);
         pdata.setWithdrawlAmount(0.0);
         pdata.setRecurInvestments(recurring);
//         age++;
//         horizon--;
//         recurringPeriod--;
         if (recurringPeriod <= 0) {
            recurring = 0.0;
            recurringPeriod = 0;
         }
         horizon = (horizon <= 0) ? 0 : horizon;

         if (horizon <= 0 && canWithdraw) {
            canWithdraw = false;
            if (withDrwalPeriod >= 0)
            {
               if (withdrawlamount == null || withdrawlamount <= 0.0)
               {
                  Integer yearsRemain = (years - thisyear) - 1;
                  withdrawlamount = (invCapital / ((yearsRemain <= 0) ? 1 : yearsRemain));
               }
            }
         }

         if (horizon <= 0 )
         {
//            invCapital -= withdrawlamount;
            withdrawlamount= (0.95 * invCapital)/(withDrwalPeriod) ;
            pdata.setWithdrawlAmount(withdrawlamount);
            if ((withDrwalPeriod <= 0)) {
               break;
            }
            withDrwalPeriod--;
         }
         System.out.println("###################END####################");
         System.out.println("Year "+thisyear);
         System.out.println("invCapital "+invCapital);
         System.out.println("withdrawlamount "+withdrawlamount);
         System.out.println("portfolioReturns "+portfolioReturns);
         if(withdrawlamount<=0)
         {
            invCapital = invCapital * (1 + portfolioReturns);//need to add condition for subtracting th withdrawal amount
         }else if(invCapital>withdrawlamount){
            invCapital=invCapital-withdrawlamount;
            invCapital = invCapital * (1 + portfolioReturns);
         }else if(invCapital<withdrawlamount){
            invCapital=withdrawlamount-invCapital;
            invCapital = invCapital * (1 + portfolioReturns);
         }
         System.out.println("invCapital "+invCapital);
         System.out.println("withdrawlamount "+withdrawlamount);
         System.out.println("portfolioReturns "+portfolioReturns);
         System.out.println("###################END####################");
         pdata.setTotalCapitalWithGains(invCapital);
         pdata.setInvestedCapital(investment);
         invCapital += recurring;
         investment += recurring;
         projectiondatas.add(thisyear,pdata);
         age++;
         horizon--;
         recurringPeriod--;
      }
      return projectiondatas;
   }


   public ProjectionData[] buildFMPerformanceData(ProfileData pdata, FMData fmdata)
   {
      ArrayList<ProjectionData[]> perfdata = null;

      ProjectionData[] array = null;
      if (fmdata != null)
      {
         // First check if we have projection data on DB.  If so, then use the data as is.
         FMProjection fmprojection = fmdata.getPerformance();
         if (fmprojection != null)
         {
            array = loadFMPerformanceData(fmprojection, pdata);
         }
      }
      return array;
   }

   public ArrayList<ProjectionData[]> buildProjectionData(ProfileData pdata)
   {
      ArrayList<ProjectionData[]> perfdata = null;
      if (pdata == null)
      {
         return null;
      }

      ProjectionData[] array;
      if (fixedOptimizer != null)
      {
         Double investment = (pdata.getInitialInvestment() != null) ? pdata.getInitialInvestment().doubleValue() : 100000.0;
         Double recurring = (pdata.getRecurringInvestment() != null) ? pdata.getRecurringInvestment() : 0.0;
         Integer horizon = (pdata.getHorizon() != null) ? pdata.getHorizon() : 35;
         horizon = (horizon < 20) ? 20 : horizon;
         String theme;
         // Only base these, does not use both Taxable and non-taxable.
         if (pdata.getTheme() != null && pdata.getTheme().startsWith("T")) {
            theme = pdata.getTheme().substring(2);
         }
         else {
            theme = pdata.getTheme();
         }
         // First check if we have projection data on DB.  If so, then use the data as is.
         Map<String, ArrayList<FMProjectionData>> fmprojection = fixedOptimizer.getFmprojection(theme);
         if (fmprojection != null) {
            perfdata = new ArrayList<ProjectionData[]>();
            for (String model : fmprojection.keySet()) {
               array =  goalsProjection(investment,
                                        recurring,
                                        model,
                                        fmprojection.get(model));

               if (array != null)
               {
                  perfdata.add(array);
               }
            }
         }
         else {
            // First we don't have the data then use the expected return to calc.
            if (fixedOptimizer.isThisFixedTheme(pdata.getTheme()))
            {
               perfdata = new ArrayList<ProjectionData[]>();
               for (FMData data : fixedOptimizer.getThemes(pdata.getTheme())) {
                  array = goalsProjection(investment,
                                          recurring,
                                          horizon,
                                          pdata.getTheme(),
                                          pdata.getPortfolioData()[0].getExpReturns(),
                                          pdata.getPortfolioData()[0].getTotalRisk(),
                                          pdata.getPortfolioData()[0].getTotalCost());
                  if (array != null)
                  {
                     perfdata.add(array);
                  }
               }
            }
         }
      }
      return perfdata;
   }

   private ArrayList<ProjectionData[]> showGoalsByTheme(ProfileData pdata)
   {

      try
      {
         if (pdata == null)
         {
            return null;
         }

         String theme = pdata.getTheme();
         if (fixedOptimizer.canCreateProjection(theme))
         {
            Integer numOfPortfolio = fixedOptimizer.getThemes(theme).size();
            Integer numOfYears = (pdata.getHorizon() <= 0) ? 1 : pdata.getHorizon();
            ArrayList<ProjectionData[]> perfdata = new ArrayList<ProjectionData[]>();
            Integer portfolio = 0;

            Double investment = pdata.getDefaultInvestment();
            Integer recurring = pdata.getRecurringInvestment();
            Integer horizon = pdata.getHorizon();

            investment = (investment == null) ? 100000 : investment;
            recurring = (recurring == null) ? 0 : recurring;
            horizon = (horizon == null) ? 20 : horizon;
            for (FMData data : fixedOptimizer.getThemes(theme))
            {
               Double expectedReturns = data.getExpectedreturn();
               Double expectedRisk = data.getExpectedrisk();
               Double cost = 0.0;
               ProjectionData[] array = goalsProjection(investment,
                                                        recurring.doubleValue(),
                                                        horizon,
                                                        theme,
                                                        expectedReturns,
                                                        expectedRisk,
                                                        cost);
               perfdata.add(array);
            }
            return perfdata;
         }
      }
      catch (Exception ex)
      {
         return null;
      }
      return null;
   }

   private ProjectionData[] goalsProjection(Double invested, Double recurring,
                                            Integer horizon, String theme,
                                            Double investmentReturn, Double investmentRisk, Double cost)
   {

      try
      {
         // Integer numOfYears = (horizon <= 0) ? 35 : horizon;
         Integer numOfYears = 35;  // Hard Coding to 35 years
         ProjectionData[] array = new ProjectionData[numOfYears];
         Double totalCost = 0.0;
         double portGrowth = invested;
         double investmentCapital = invested;
         double totalcapitalgain = invested;
         double upper1 = invested;
         double upper2 = invested;
         double lower1 = invested;
         double lower2 = invested;

         Calendar cal = Calendar.getInstance();
         for (Integer year = 0; year < numOfYears; year++)
         {
            // Safety, that we don't over-run
            if (year > numOfYears)
            {
               break;
            }

            ProjectionData perf = new ProjectionData();
            perf.setYear((cal.YEAR + year));
            perf.setTheme(theme);
            perf.setTotalCapitalWithGains(totalcapitalgain);
            perf.setTotalCost(totalCost);
            perf.setInvestmentReturns(investmentReturn);
            perf.setInvestmentRisk(investmentRisk);
            perf.setUpperBand1(upper1);
            perf.setUpperBand2(upper2);
            perf.setLowerBand1(lower1);
            perf.setLowerBand2(lower2);
            perf.setInvestedCapital(investmentCapital);
            perf.setRecurInvestments(recurring);
            perf.setUpperBand1(upper1);
            perf.setUpperBand2(upper2);

            if (lower1 < 0.0)
            {
               lower1 = 0.0;
            }
            perf.setLowerBand1(lower1);

            if (lower2 < 0.0)
            {
               lower2 = 0.0;
            }
            perf.setLowerBand2(lower2);

            array[year] = perf;
            investmentCapital += recurring;
            totalCost = (cost / investmentCapital) * investmentCapital;
            totalcapitalgain = (investmentReturn * totalcapitalgain) + (totalcapitalgain - cost);
            portGrowth = investmentReturn * investmentCapital + portGrowth - cost;
            upper1 = (investmentRisk * totalcapitalgain) + totalcapitalgain;
            upper2 = (2 * investmentRisk * totalcapitalgain) + totalcapitalgain;
            lower1 = (-1 * investmentRisk * totalcapitalgain) + totalcapitalgain;
            lower2 = (-2 * investmentRisk * totalcapitalgain) + totalcapitalgain;
         }
         return array;
      }
      catch (Exception e)
      {
      }
      return null;
   }

   private ProjectionData[] goalsProjection(Double invested, Double recurring,
                                            String model,
                                            ArrayList<FMProjectionData> projectionchart)
   {

      try
      {
         // Integer numOfYears = (horizon <= 0) ? 35 : horizon;
         Integer numOfYears = 35;  // Hard Coding to 35 years

         if (projectionchart == null) {
            return null;
         }

         Integer smallest = projectionchart.size();

         ProjectionData[] array = new ProjectionData[smallest];
         Double totalCost = 0.0;
         double portGrowth = invested;
         double totalRecurring = 0.0;

         Double datalower2, datalower1, datamid, dataupper1, dataupper2;

         Calendar cal = Calendar.getInstance();
         for (Integer year = 0; year < numOfYears; year++)
         {
            // Safety, that we don't over-run
            if (year > numOfYears)
            {
               break;
            }

            ProjectionData perf = new ProjectionData();
            perf.setTheme(model.toString());
            perf.setYear((cal.YEAR + year));

            datalower2 = projectionchart.get(year).getFivepercent();
            datalower1 = projectionchart.get(year).getTwentyfivepercent();
            datamid =  projectionchart.get(year).getFiftypercent();
            dataupper1 = projectionchart.get(year).getSeventyfivepercent();
            dataupper2 = projectionchart.get(year).getNintyfivepercent();

            if (datalower1 < 0.0)
            {
               datalower1 = 0.0;
            }

            if (datalower2 < 0.0)
            {
               datalower2 = 0.0;
            }

            array[year] = perf;

            portGrowth += recurring;
            perf.setTotalCost(0);
            perf.setInvestmentReturns(portGrowth);
            perf.setInvestmentRisk(0);
            perf.setUpperBand1(invested * dataupper1);
            perf.setUpperBand2(invested * dataupper2);
            perf.setLowerBand1(invested * datalower1);
            perf.setLowerBand2(invested * datalower2);
            perf.setTotalCapitalWithGains(invested * datamid);
            perf.setInvestedCapital(portGrowth);
            perf.setRecurInvestments(totalRecurring);
            totalRecurring = totalRecurring + recurring;

         }
         return array;
      }
      catch (Exception e)
      {
      }
      return null;
   }

   private ProjectionData[] loadFMPerformanceData(FMProjection fmprojectiondata, ProfileData pdata)
   {

      try
      {
         // Integer numOfYears = (horizon <= 0) ? 35 : horizon;

         if (fmprojectiondata == null) {
            return null;
         }

         String model = fmprojectiondata.getTheme();
         String key = fmprojectiondata.getDisplayname();
         Integer smallest = fmprojectiondata.getData().get(key).size();
         ArrayList<FMProjectionData> projectionData = fmprojectiondata.getData().get(key);

         ProjectionData[] array = new ProjectionData[smallest];
         Double totalCost = 0.0;
         Double invested = pdata.getInitialInvestment().doubleValue();
         Double portGrowth = pdata.getInitialInvestment().doubleValue();
         Double recurring = pdata.getRecurringInvestment().doubleValue();
         double totalRecurring = 0.0;

         Double datalower2, datalower1, datamid, dataupper1, dataupper2;

         Calendar cal = Calendar.getInstance();
         Integer numOfYears = smallest;

         for (Integer year = 0; year < numOfYears; year++)
         {
            // Safety, that we don't over-run
            if (year > numOfYears)
            {
               break;
            }

            ProjectionData perf = new ProjectionData();
            perf.setTheme(model.toString());
            perf.setYear((cal.YEAR + year));

            datalower2 = projectionData.get(year).getFivepercent();
            datalower1 = projectionData.get(year).getTwentyfivepercent();
            datamid =  projectionData.get(year).getFiftypercent();
            dataupper1 = projectionData.get(year).getSeventyfivepercent();
            dataupper2 = projectionData.get(year).getNintyfivepercent();

            if (datalower1 < 0.0)
            {
               datalower1 = 0.0;
            }

            if (datalower2 < 0.0)
            {
               datalower2 = 0.0;
            }

            array[year] = perf;

            portGrowth += recurring;
            perf.setTotalCost(0);
            perf.setInvestmentReturns(portGrowth);
            perf.setInvestmentRisk(0);
            perf.setUpperBand1(invested * dataupper1);
            perf.setUpperBand2(invested * dataupper2);
            perf.setLowerBand1(invested * datalower1);
            perf.setLowerBand2(invested * datalower2);
            perf.setTotalCapitalWithGains(invested * datamid);
            perf.setInvestedCapital(portGrowth);
            perf.setRecurInvestments(totalRecurring);
            totalRecurring = totalRecurring + recurring;

         }
         return array;
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      return null;
   }

   public void goalTracking(ProfileData pdata)
   {
      int termyear = 0;

      Double goalAmount, interestRate, actualInitialAmount, recurringAmount, calcRecurringAmount;
      ArrayList<Double> growth = new ArrayList<Double>();
      try
      {
         if (pdata.getGoalData() == null)
         {
            return;
         }

         if (pdata.getProjectionData() == null)
            return;

         actualInitialAmount = pdata.getGoalData().getActualInitialAmount();
         recurringAmount = pdata.getGoalData().getActualRecurringAmount();
         // pfdata.getGoalData().setActualInitialAmount(actualInitialAmount);
         // pfdata.getGoalData().setActualRecurringAmount(recurringAmount);
         termyear = pdata.getProjectionData().length;


         goalAmount = pdata.getGoalData().getGoalDesired();

         interestRate = pdata.getProjectionData()[0].getInvestmentReturns();

         pdata.getGoalData().setRisk(pdata.getProjectionData()[0].getInvestmentRisk());
         pdata.getGoalData().setInterestrate(interestRate);
         pdata.getGoalData().setTerm((double) termyear);

         Double n1 = Math.pow((1.0 + interestRate), termyear);
         Double n2 = actualInitialAmount * n1;
         //Double n3 = goalAmount - n2;
         Double n3 = goalAmount - pdata.getProjectionData()[0].getLowerBand2();
         Double numerator = interestRate * n3;
         Double d1 = Math.pow((1 + interestRate), (termyear + 1));
         Double denominator = (d1 - 1 - interestRate);

         calcRecurringAmount = numerator / denominator;

         pdata.getGoalData().setCalcRecurringAmount(calcRecurringAmount);


         if (calcRecurringAmount <= 0) {
            pdata.getGoalData().setReachable(true);
         }
         else {
            pdata.getGoalData().setReachable(false);
         }

      }
      catch (Exception ex)
      {

      }
   }

}
