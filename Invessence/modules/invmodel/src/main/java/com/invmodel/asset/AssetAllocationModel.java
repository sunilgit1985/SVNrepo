package com.invmodel.asset;

import java.util.*;

import com.invmodel.Const.InvConst;
import com.invmodel.asset.data.*;
import com.invmodel.model.dynamic.PortfolioOptimizer;
import com.invmodel.inputData.ProfileData;
import com.invmodel.model.fixedmodel.FixedModelOptimizer;
import com.invmodel.model.fixedmodel.data.*;
import com.invmodel.risk.data.*;
import webcab.lib.finance.portfolio.*;

//------------------------------
// To Do
// When loading asset level data we should also load other data such as their name, cost, lower and upper
// bound constraints, every thing that is specific to each assets
//
// Added riskIndex and TOTAL_RISK_INDEX -JAV 8/29/2013
//-------------------------------

public class AssetAllocationModel
{
   private static AssetAllocationModel instance;
   private AssetParameters assetParameters = new AssetParameters();
   private PortfolioOptimizer portfolioOptimizer;
   private FixedModelOptimizer fixedOptimizer;

   public static synchronized AssetAllocationModel getInstance()
   {
      if (instance == null)
      {
         instance = new AssetAllocationModel();
      }

      return instance;
   }

   private AssetAllocationModel()
   {
      portfolioOptimizer = PortfolioOptimizer.getInstance();
      fixedOptimizer = FixedModelOptimizer.getInstance();
   }

   public void setPortfolioOptimizer(PortfolioOptimizer portfolioOptimizer)
   {
      this.portfolioOptimizer = portfolioOptimizer;
   }

   public void setFixedOptimizer(FixedModelOptimizer fixedOptimizer)
   {
      this.fixedOptimizer = fixedOptimizer;
   }

   public AssetClass createAllocation(RiskCalc calculator)
   {
      String theme = calculator.getTheme();

      if (fixedOptimizer != null)
      {
         if (fixedOptimizer.isThisFixedTheme(theme))
         {
            return createFixedModelAsset(calculator);
         }
      }

      // If the fixedModel conditions failed, then attmpt to solve as generic handler (Optimized model)
      return createOptimizedAssets(calculator);
   }

/*
   public AssetClass[] buildAllocation(UserRiskProfile userrisk, ProfileData pdata)
   {
      if (fixedOptimizer != null)
      {
         if (fixedOptimizer.isThisFixedTheme(pdata.getTheme()))
         {
            return fixedModelAllocation(userrisk, pdata);
         }
      }

      // If the fixedModel conditions failed, then attmpt to solve as generic handler (Optimized model)
      return getOptimizedAssets(userrisk, pdata);
   }
*/


   public AssetClass[] buildAllocation(ProfileData pdata)
   {
      if (fixedOptimizer != null)
      {
         if (fixedOptimizer.isThisFixedTheme(pdata.getTheme()))
         {
            pdata.setFixedModel(true);
            //rc.client.getRisk(...);
            pdata.setMaxAssetAllocatonPoints(fixedOptimizer.getThemes(pdata.getTheme()).size() - 1);
            AssetClass[] assetclass = new AssetClass[1];
            assetclass[0] = fixedOrigModelAllocation(pdata);
            return assetclass;
         }
      }

      if (!portfolioOptimizer.isValidTheme(pdata.getTheme()))
      {
         pdata.setTheme(InvConst.DEFAULT_THEME);
      }

      pdata.setMaxAssetAllocatonPoints(portfolioOptimizer.getAssetAllocationPoints());
      pdata.setFixedModel(false);
      pdata.setHasReturn(true);
      pdata.setHasRisk(true);

      if (pdata.getRiskCalcMethod() == null || pdata.getRiskCalcMethod().startsWith(InvConst.CONSUMER_RISK_FORMULA))
      {
         return getAssetsInfoByIndex(pdata, pdata.getRiskIndex().intValue());
      }
      else
      {
         return getAssetsInfoByIndex(pdata, pdata.getAllocationIndex());
      }

/*
      if (pdata.getRiskCalcMethod() == null || pdata.getRiskCalcMethod().startsWith(InvConst.CONSUMER_RISK_FORMULA))
      {
         return getAssetInfoByRisk(pdata);
      }
      else
      {
         return getAssetsInfoByIndex(pdata);
      }
*/
   }

   public AssetClass createOptimizedAssets(RiskCalc calculator)
   {
      String theme;
      Integer age, horizon, recurringPeriod, withDrwalPeriod;
      Double investment, recurring, withdrawlamount;


      Double score;
      try
      {

         theme = calculator.getTheme();

         age = calculator.getDefaultAge();
         horizon = calculator.getDefaultHorizon();
         investment = calculator.getDefaultInvestment();
         recurring = calculator.getDefaultRecurring();
         recurringPeriod = calculator.getDefaultRecurringPeriod();
         withDrwalPeriod = calculator.getDefaultWithDrwalPeriod();
         withdrawlamount = calculator.getDefaultWithdrawlAmount();

         if (calculator.getUserRiskProfile() != null)
         {
            calculator.getUserRiskProfile().setAnswer(RiskConst.PREDEFINEDMODEL, false);
         }

         Integer riskFormula;
         int assetnum = 0;

            AssetClass assetclass = new AssetClass();
            String color = portfolioOptimizer.getCashColor(theme);

            if (calculator.getKnockOutFlag())
            {
               score = 0.0;
               assetclass.initAssetClass(age, horizon, score, theme);
               setThisAssetToCash(assetclass, theme, investment, color);
            }
            else
            {
               score = calculator.getRiskScore();

               Double offset = (score == null) ? InvConst.ASSET_DEFAULT_POINT : score;
               offset = (offset > InvConst.ASSET_INTERPOLATION - 1.0) ? InvConst.ASSET_INTERPOLATION - 1.0 : offset;
               offset = (offset < 0.0) ? 0.0 : offset;
               assetclass.initAssetClass(age, horizon, offset, theme);
               optimizedAllocation(assetclass, investment);
            }
         return assetclass;
      }
      catch (Exception e)
      {
         return null;
      }

   }

   private AssetClass optimizedAllocation(AssetClass assetclass, Double investment)
   {

      try
      {
         String theme = assetclass.getTheme();
         ArrayList<String> orderedAssets = portfolioOptimizer.getAdvisorOrdertedAssetList(theme);
         double[] avgReturns = portfolioOptimizer.getAssetOrderedAvgReturns(theme);
         double[] weights = portfolioOptimizer.getAssetOrderedWeight(theme, assetclass.getRiskOffset().intValue());
         double wght = 0.0;

         double totalRemainWeight = 1.0;
         // Currently we are using Fixed Risk Adjustments,  We'll change this to get the data from DB
         // and store in assets Class.

         for (int i = 0; i < (orderedAssets.size()); i++)
         {
            String assetname = orderedAssets.get(i);
            String displayName = portfolioOptimizer.getAssetData(theme, assetname).getDisplayname();
            String assetcolor = portfolioOptimizer.getAssetData(theme, assetname).getColor();

            // Always add each to asset List.
            assetclass.addAssetClass(assetname, displayName, assetcolor, 0.0, 0.0);

            wght = weights[i];
            if (wght < 0.0001)
            {
               continue;
            }

            if (!assetname.equals("Cash"))
            {
               // JAV 6/2/2017
               //This is to risk adjust target date funds. Only for Invessence models
               double factor = 0.0;
               //Only themes used by Invessence
/*
               if ( theme.contentEquals("0.Core 0.Safety 0.Income T.0.Core T.0.Income T.0.Safety"))
               {
                  factor = adjustmentFactors(duration, age, stayInvested, theme, assetname, wght);
               }
*/

               wght = (wght + factor);

               if (wght > totalRemainWeight)
               {
                  wght = totalRemainWeight;
               }

               assetclass.getAsset(assetname).setAllocweight(wght);
               assetclass.getAsset(assetname).setUserweight(wght);
               assetclass.getAsset(assetname).setActualweight(wght);
               assetclass.getAsset(assetname).setAvgReturn(avgReturns[i]);
               assetclass.getAsset(assetname).setValue(investment * wght);
               if (!assetname.equals("Cash"))
               {
                  totalRemainWeight = totalRemainWeight - wght;
               }
            }
            else
            {
               if (totalRemainWeight < 0.0)
               {
                  totalRemainWeight = 0.0;
               }
               assetclass.getAsset("Cash").setAllocweight(totalRemainWeight);  // Adjust weight.
               assetclass.getAsset("Cash").setUserweight(totalRemainWeight);
               assetclass.getAsset("Cash").setActualweight(totalRemainWeight);
               assetclass.getAsset(assetname).setValue(investment * totalRemainWeight);
               // allocation Cash here with color.
               //assetclass.addAssetClass(assetname, totalWeight, 0.0, assetcolor[i]);
            }
         }
         return assetclass;
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      return null;

   }

/*
   public AssetClass[] getOptimizedAssets(UserRiskProfile userrisk, RiskCalc calculator)
   {
      AssetClass[] assetclass;
      String theme;
      Integer age = userrisk.getDefaultAge();
      Integer duration = userrisk.getDefaultHorizon();
      Double investment = userrisk.getDefaultInitialInvestment();
      Double score;
      try
      {

         theme = userrisk.getAnswer(RiskConst.THEME);

         if (!portfolioOptimizer.isValidTheme(theme))
         {
            theme = InvConst.DEFAULT_THEME;
         }


         int numofAllocation = userrisk.getALLRiskScores().size();
         if (numofAllocation <= 0)
         {
            numofAllocation = 1;
         }
         assetclass = new AssetClass[numofAllocation];
         Integer riskFormula;
         int counter = 0;
         while (numofAllocation > 0)
         {
            RiskScore riskScore = userrisk.getRiskScoreObj(counter);
            if (riskScore == null) {
               break;
            }
            if (riskScore.getAllCashFlag()) {
               assetclass[numofAllocation] = setThisAssetToCash(theme, investment);
            }
            else {
               if (RiskConst.CALCFORMULAS.valueOf(riskScore.getCalcFormula()) == RiskConst.CALCFORMULAS.C)
               {
                  score = riskScore.getScore();
               }
               else
               {
                  score = riskScore.getAssetScore();
               }

               Double offset = (score == null) ? InvConst.ASSET_DEFAULT_POINT : score;
               //Offset is now a slider (Just moving along the points)
               // offset = InvConst.ASSET_INTERPOLATION - offset;
               offset = (offset > InvConst.ASSET_INTERPOLATION - 1.0) ? InvConst.ASSET_INTERPOLATION - 1.0 : offset;
               offset = (offset < 0.0) ? 0.0 : offset;
               age++;
               duration--;
               assetclass[counter] = createAssetsByIndex(theme, offset.intValue(), duration, age);
            }
            numofAllocation--;
            counter++;
            investment = investment + userrisk.getDefaultRecurringInvestment();
         }
         return assetclass;
      }
      catch (Exception e)
      {
         return buildAllCashAsset(userrisk);
      }

   }
*/

   public AssetClass[] getAssetsInfoByIndex(ProfileData pdata, Integer riskIndex)
   {
      AssetClass[] assetclass;
      String theme;
      try
      {
         Double investment = pdata.getActualInvestment();
         Integer age = pdata.getAge();
         Integer duration = pdata.getHorizon();
         theme = pdata.getTheme();

         if (!portfolioOptimizer.isValidTheme(pdata.getTheme()))
         {
            pdata.setTheme(InvConst.DEFAULT_THEME);
         }

         pdata.setMaxAssetAllocatonPoints(portfolioOptimizer.getAssetAllocationPoints());
         pdata.setFixedModel(false);
         pdata.setHasReturn(true);
         pdata.setHasRisk(true);

         int numofAllocation = pdata.getNumOfAllocation();
         if (numofAllocation <= 0)
         {
            numofAllocation = 1;
         }
         assetclass = new AssetClass[numofAllocation];
         int counter = 0;
         int offset = (riskIndex == null) ? InvConst.ASSET_DEFAULT_POINT : riskIndex;
         while (numofAllocation > 0)
         {
            //Offset is now a slider (Just moving along the points)
            // offset = InvConst.ASSET_INTERPOLATION - offset;
            offset = (offset > InvConst.ASSET_INTERPOLATION - 1) ? InvConst.ASSET_INTERPOLATION - 1 : offset;
            offset = (offset < 0) ? 0 : offset;
            if (counter == 0)
            {
               pdata.setAllocationIndex(offset);
            }
            assetclass[counter] = createAssetsByIndex(theme, offset, duration, age);
            numofAllocation--;
            counter++;

         }
         return assetclass;
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      return null;
   }

   private AssetClass createAssetsByIndex(String theme, int offset,
                                          int duration, int age)
   {

      AssetClass assetclass = new AssetClass();
      try
      {
         assetclass.initAssetClass(age, duration, (double) offset, theme);
         ArrayList<String> orderedAssets = portfolioOptimizer.getAdvisorOrdertedAssetList(theme);
         double[] avgReturns = portfolioOptimizer.getAssetOrderedAvgReturns(theme);
         double[] weights = portfolioOptimizer.getAssetOrderedWeight(theme, offset);
         duration = (duration > InvConst.MAX_DURATION) ? InvConst.MAX_DURATION : duration;
         double wght = 0.0;

         double totalRemainWeight = 1.0;


         // Currently we are using Fixed Risk Adjustments,  We'll change this to get the data from DB
         // and store in assets Class.

         for (int i = 0; i < (orderedAssets.size()); i++)
         {
            String assetname = orderedAssets.get(i);
            String displayName = portfolioOptimizer.getAssetData(theme, assetname).getDisplayname();
            String assetcolor = portfolioOptimizer.getAssetData(theme, assetname).getColor();

            // Always add each to asset List.
            assetclass.addAssetClass(assetname, displayName, assetcolor, 0.0, 0.0);

            wght = weights[i];
            if (wght < 0.0001)
            {
               continue;
            }

            if (!assetname.equals("Cash"))
            {
               // JAV 6/2/2017
               //This is to risk adjust target date funds. Only for Invessence models
               double factor = 0.0;
               //Only themes used by Invessence
/*
               if ( theme.contentEquals("0.Core 0.Safety 0.Income T.0.Core T.0.Income T.0.Safety"))
               {
                  factor = adjustmentFactors(duration, age, stayInvested, theme, assetname, wght);
               }
*/

               wght = (wght + factor);

               if (wght > totalRemainWeight)
               {
                  wght = totalRemainWeight;
               }

               assetclass.getAsset(assetname).setAllocweight(wght);
               assetclass.getAsset(assetname).setUserweight(wght);
               assetclass.getAsset(assetname).setActualweight(wght);
               assetclass.getAsset(assetname).setAvgReturn(avgReturns[i]);
               if (!assetname.equals("Cash"))
               {
                  totalRemainWeight = totalRemainWeight - wght;
               }
            }
            else
            {
               if (totalRemainWeight < 0.0)
               {
                  totalRemainWeight = 0.0;
               }
               assetclass.getAsset("Cash").setAllocweight(totalRemainWeight);  // Adjust weight.
               assetclass.getAsset("Cash").setUserweight(totalRemainWeight);
               assetclass.getAsset("Cash").setActualweight(totalRemainWeight);
               // allocation Cash here with color.
               //assetclass.addAssetClass(assetname, totalWeight, 0.0, assetcolor[i]);
            }
         }

         return assetclass;
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      return null;

   }

   private void setThisAssetToCash(AssetClass assetclass, String theme, Double investmentAmount, String color)
   {

      try
      {
         double wght = 1.0;

         String cash = "Cash";

         // Always add each to asset List.
         color = (color == null) ? "#f5f5f5" : color;
         assetclass.addAssetClass(cash, cash, color, 0.0, 0.0);
         assetclass.getAsset(cash).setAllocweight(wght);
         assetclass.getAsset(cash).setUserweight(wght);
         assetclass.getAsset(cash).setActualweight(wght);
         assetclass.getAsset(cash).setAvgReturn(0.0);
         assetclass.getAsset(cash).setHoldingValue(investmentAmount);
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
   }

   private AssetClass createAssetsByRisk(String theme, int offset, int duration, int age)
   {

      AssetClass assetclass = new AssetClass();
      try
      {
         assetclass.initAssetClass(age, duration, (double) offset, theme);
         ArrayList<String> orderedAssets = portfolioOptimizer.getAdvisorOrdertedAssetList(theme);
         double[] avgReturns = portfolioOptimizer.getAssetOrderedAvgReturns(theme);
         double[] weights = portfolioOptimizer.getAssetOrderedWeight(theme, offset);
         duration = (duration > InvConst.MAX_DURATION) ? InvConst.MAX_DURATION : duration;
         double wght = 0.0;
         double risk_adjustment = 0.0;
         double totalWeight = 1.0;
         double baseNum = 1 + ((double) duration / (double) age);
         double powerNum = -1 * (duration - 1);

         // Currently we are using Fixed Risk Adjustments,  We'll change this to get the data from DB
         // and store in assets Class.

         for (int i = 0; i < (orderedAssets.size()); i++)
         {
            String assetname = orderedAssets.get(i);
            String displayName = portfolioOptimizer.getAssetData(theme, assetname).getDisplayname();
            String assetcolor = portfolioOptimizer.getAssetData(theme, assetname).getColor();

            // Always add each to asset List.
            assetclass.addAssetClass(assetname, displayName, assetcolor, 0.0, 0.0);

            wght = weights[i];
            if (wght < 0.0001)
            {
               continue;
            }

            // If input from user is to go to cash then risk_adjustment should be 0
            // If input from user is stay_invested then initial equity allocation is
            // Equity allocation = 100 - age
            // Adjust this number for risk tolerance

            //only risk adjust equity


            if (!assetname.equals("Cash"))
            {

/*
               if (stayInvested == 1)
               {
                  risk_adjustment = portfolioOptimizer.getRiskAdjustment(theme, assetname);
               }
               else
               {

                  risk_adjustment = portfolioOptimizer.getEnd_allocation(theme, assetname);
               }
*/

               double factor = (risk_adjustment - wght) * Math.pow(baseNum, powerNum);
               wght = (wght + factor);

               if (wght > totalWeight)
               {
                  wght = totalWeight;
               }

               assetclass.getAsset(assetname).setAllocweight(wght);
               assetclass.getAsset(assetname).setUserweight(wght);
               assetclass.getAsset(assetname).setActualweight(wght);
               assetclass.getAsset(assetname).setAvgReturn(avgReturns[i]);
               if (!assetname.equals("Cash"))
               {
                  totalWeight = totalWeight - wght;
               }
            }
            else
            {
               if (totalWeight < 0.0)
               {
                  totalWeight = 0.0;
               }
               assetclass.getAsset("Cash").setAllocweight(totalWeight);  // Adjust weight.
               assetclass.getAsset("Cash").setUserweight(totalWeight);  // Adjust weight.
               assetclass.getAsset("Cash").setActualweight(totalWeight);  // Adjust weight.
               // allocation Cash here with color.
               //assetclass.addAssetClass(assetname, totalWeight, 0.0, assetcolor[i]);
            }
         }

         return assetclass;
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      return null;

   }

   public AssetClass createFixedModelAsset(RiskCalc calc)
   {
      String theme = calc.getTheme();
      Integer age, horizon, recurringPeriod, withDrwalPeriod;
      Double investment, recurring, withdrawlamount;

      try
      {
         if (calc.getUserRiskProfile() == null)
         {
            return null;
         }

         FMData fixedModelData;

         Double score;

         if (calc.getUserRiskProfile() != null)
         {
            calc.getUserRiskProfile().setAnswer(RiskConst.PREDEFINEDMODEL, true);
         }

         age = calc.getDefaultAge();
         horizon = calc.getDefaultHorizon();
         investment = calc.getDefaultInvestment();
         recurring = calc.getDefaultRecurring();

         AssetClass assetclass = new AssetClass();
         String color = fixedOptimizer.getCashColor(theme);
         if (calc.getKnockOutFlag())
         {
            score = 0.0;
            assetclass.initAssetClass(age, horizon, score, theme);
            setThisAssetToCash(assetclass, theme, investment, color);
         }
         else
         {
            score = calc.getRiskScore();

            fixedModelData = fixedOptimizer.getThemeByIndex(theme, score.intValue());
            if (fixedModelData != null)
            {
               assetclass.initAssetClass(age, horizon, score, theme);
            }
            else
            {
               assetclass.initAssetClass(age, horizon, 0.0, theme);
               setThisAssetToCash(assetclass, theme, investment, color);
            }
         }

         return assetclass;
      }
      catch (Exception e)
      {
         return null;
      }

   }

   public AssetClass fixedModelCreateAsset(AssetClass assetclass, FMData fixedModelData, Double investment)
   {

      Double wght;
      Double totalWeight = 1.0;

      if (fixedModelData != null)
      {
         assetclass.setThemeName(fixedModelData.getDisplayname());
         assetclass.setThemeDescription(fixedModelData.getDescription());
         for (FMAssetData fiasset : fixedModelData.getAssetsData())
         {
            String assetname = fiasset.getAsset();
            String displayName = fiasset.getDisplayname();
            String assetcolor = fiasset.getColor();

            // Always add each to asset List.
            assetclass.addAssetClass(assetname, displayName, assetcolor, 0.0, 0.0);

            wght = fiasset.getWeight();

            if (!assetname.equalsIgnoreCase("Cash"))
            {
               if (wght < 0.0001)
               {
                  continue;
               }

               Double risk_adjustment = 0.0;

               if (wght > totalWeight)
               {
                  wght = totalWeight;
               }

               assetclass.getAsset(assetname).setAllocweight(wght);
               assetclass.getAsset(assetname).setUserweight(wght);
               assetclass.getAsset(assetname).setActualweight(wght);
               assetclass.getAsset(assetname).setValue(wght * investment);
               assetclass.getAsset(assetname).setAvgReturn(0.0);
               if (!assetname.equals("Cash"))
               {
                  totalWeight = totalWeight - wght;
               }
            }
            else
            {
               if (totalWeight < 0.0)
               {
                  totalWeight = 0.0;
               }
               assetclass.getAsset("Cash").setAllocweight(totalWeight);  // Adjust weight.
               assetclass.getAsset("Cash").setUserweight(totalWeight);  // Adjust weight.
               assetclass.getAsset("Cash").setActualweight(totalWeight);  // Adjust weight.
               assetclass.getAsset("Cash").setValue(totalWeight * investment);
               // allocation Cash here with color.
               //assetclass.addAssetClass(assetname, totalWeight, 0.0, assetcolor[i]);
            }
         }
      }
      return assetclass;
   }

   public AssetClass fixedOrigModelAllocation(ProfileData pdata)
   {

      try
      {
         FMData fixedModelData;
         Double wght;
         Double totalWeight = 1.0;
         Integer age = pdata.getAge();
         Integer horizon = pdata.getHorizon();
         Double investment = pdata.getInvestmentAmount();
         String theme = pdata.getTheme();

         Double adjRiskOffet = pdata.getRiskIndex();
         //Age based offset

         AssetClass assetclass;
         if (pdata.getAllCashonZeroRisk() && pdata.getRiskIndex() <= 0)
         {
            assetclass = new AssetClass();
            setThisAssetToCash(assetclass, theme, investment, null);
         }

         else
         {
            assetclass = new AssetClass();
            assetclass.initAssetClass(pdata.getAge(), pdata.getDefaultHorizon(), adjRiskOffet, theme);

            if (pdata.getRiskCalcMethod().equalsIgnoreCase(InvConst.CONSUMER_RISK_FORMULA))
            {
               fixedModelData = fixedOptimizer.getTheme(theme, adjRiskOffet);
            }
            else
            {
               fixedModelData = fixedOptimizer.getThemeByIndex(theme, pdata.getAllocationIndex());
            }

            pdata.setFixedFMModel(fixedModelData);
            if (fixedModelData != null)
            {
               pdata.setAllocationIndex(fixedModelData.getIndex());
               pdata.setPortfolioIndex(fixedModelData.getIndex());
               fixedModelCreateAsset(assetclass, fixedModelData, investment);
            }
            else
            {
               setThisAssetToCash(assetclass, theme, investment, null);
            }
         }
         return assetclass;
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      return null;

   }

}
