package com.invmodel.performance;

import java.util.*;

import com.invmodel.Const.InvConst;
import com.invmodel.asset.data.AssetClass;
import com.invmodel.model.dynamic.PortfolioOptimizer;
import com.invmodel.model.fixedmodel.FixedModelOptimizer;
import com.invmodel.model.fixedmodel.data.FMData;
import com.invmodel.performance.data.ProjectionData;
import com.invmodel.inputData.ProfileData;
import com.invmodel.portfolio.data.Portfolio;

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



   public ArrayList<ProjectionData[]> buildProjectionData(ProfileData pdata)
   {
      ArrayList<ProjectionData[]> perfdata = null;
      if (pdata == null)
      {
         return null;
      }

      if (fixedOptimizer != null)
      {
         if (fixedOptimizer.isThisFixedTheme(pdata.getTheme()))
         {
            perfdata = showGoalsByTheme(pdata);
         }
      }
      else
      {
         if (pdata.getPortfolioData() != null)
         {
            Double investment = (pdata.getActualInvestment() != null) ? pdata.getActualInvestment() : 100000;
            Double recurring = (pdata.getRecurringInvestment() != null) ? pdata.getRecurringInvestment() : 0.0;
            Integer horizon = (pdata.getHorizon() != null) ? pdata.getHorizon() : 20;
            ProjectionData[] array = goalsProjection(investment,
                                                     recurring,
                                                     horizon,
                                                     pdata.getPortfolioData()[0].getExpReturns(),
                                                     pdata.getPortfolioData()[0].getTotalRisk(),
                                                     pdata.getPortfolioData()[0].getTotalCost());
            if (array != null)
            {
               perfdata = new ArrayList<ProjectionData[]>();
               perfdata.add(array);
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

            Double investment = pdata.getActualInvestment();
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
                                            Integer horizon,
                                            Double investmentReturn, Double investmentRisk, Double cost)
   {

      try
      {
         Integer numOfYears = (horizon <= 0) ? 20 : horizon;
         ProjectionData[] array = new ProjectionData[numOfYears];
         Double totalCost = 0.0;
         double portGrowth = invested;
         double investmentCapital = invested;
         double totalcapitalgain = invested;
         double upper1 = invested;
         double upper2 = invested;
         double lower1 = invested;
         double lower2 = invested;

         for (Integer year = 0; year < numOfYears; year++)
         {
            // Safety, that we don't over-run
            if (year > numOfYears)
            {
               break;
            }

            ProjectionData perf = new ProjectionData();
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
