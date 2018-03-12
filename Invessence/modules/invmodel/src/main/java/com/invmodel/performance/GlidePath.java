package com.invmodel.performance;

/**
 * User: Prashant
 * Date: 1/7/18
 * Time: 1:47 PM
 * To change this template use File | Settings | File Templates.
 * <p/>
 * Objectives:
 * Create Glidepath given new Risk Calculator
 */

import java.util.*;

import com.invmodel.Const.InvConst;
import com.invmodel.dao.data.AssetData;
import com.invmodel.model.dynamic.PortfolioOptimizer;
import com.invmodel.model.fixedmodel.FixedModelOptimizer;
import com.invmodel.performance.data.ProjectionData;
import com.invmodel.risk.data.RiskCalc;


//Formula to convert longTermReturns to daily returns
//Effective rate for period = ((1 + annual rate)^(1 / # of periods)) – 1
//Effective rate for period  = Math.pow((1.0+ daily rate), 1/365.0)-1.0;

//Convert returns back to annualized returns
//Effective rate for period  = Math.pow((1.0+ daily rate), 365.0)-1.0;


public class GlidePath
{
   private PortfolioOptimizer portfolioOptimizer;
   private FixedModelOptimizer fixedOptimizer;

   public GlidePath()
   {
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
      Double thisscore;

      for (Integer thisyear = 0; thisyear < years; thisyear++)
      {
         ProjectionData pdata = new ProjectionData();
         Double score = riskCalc.calculateRisk(age, horizon, investment,
                                               recurring, recurringPeriod,
                                               withDrwalPeriod, withdrawlamount);

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
            assetWgt = weights[assetnum];
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
               ticker_weight = assetWgt * primeAssetWeights[offset][tickerNum];
               portfolioReturns = portfolioReturns + assetdata.getPrimeAssetreturns()[offset] * ticker_weight;
               portfolioRisk = portfolioRisk + assetdata.getPrimeAssetrisk()[offset] * ticker_weight;
            }
         }
         pdata.setTheme(theme);
         pdata.setInvestmentReturns(portfolioReturns);
         pdata.setInvestmentRisk(portfolioRisk);
         pdata.setInvestedCapital(investment);
         pdata.setRecurInvestments(recurring);
         age++;
         horizon--;
         recurringPeriod--;
         if (recurringPeriod <= 0) {
            recurring = 0.0;
         }
         horizon = (horizon <= 0) ? 0 : horizon;

         if (horizon <= 0 && canWithdraw) {
            canWithdraw = false;
            if (withDrwalPeriod >= 0)
            {
               if (withdrawlamount == null || withdrawlamount <= 0.0)
               {
                  Integer yearsRemain = (years - thisyear);
                  withdrawlamount = (investment + recurring) / (yearsRemain / years);
               }
            }
         }
         if (horizon <= 0)
         {
            pdata.setWithdrawlAmount(withdrawlamount);
            if ((withDrwalPeriod <= 0)) {
               break;
            }
            withDrwalPeriod--;
         }
         investment = investment * (1 + portfolioReturns);
         investment += recurring;
         projectiondatas.add(thisyear,pdata);
      }
      return projectiondatas;
   }
}
