package com.invmodel.portfolio;

import java.util.*;

import com.invmodel.Const.InvConst;
import com.invmodel.asset.data.*;
import com.invmodel.dao.data.*;
import com.invmodel.dao.invdb.*;
import com.invmodel.dao.rbsa.*;
import com.invmodel.inputData.ProfileData;
import com.invmodel.model.dynamic.PortfolioOptimizer;
import com.invmodel.model.fixedmodel.FixedModelOptimizer;
import com.invmodel.model.fixedmodel.data.*;
import com.invmodel.portfolio.data.Portfolio;
import com.invmodel.risk.data.*;

public class PortfolioModel
{

   //private SecurityDBCollection securityDao;
   private static PortfolioModel instance;
   private SecurityCollection secCollection;
   private HistoricalReportsReturns historicalReportsReturns;
   private PortfolioOptimizer portfolioOptimizer;
   private FixedModelOptimizer fixedOptimizer;

   public static synchronized PortfolioModel getInstance()
   {
      if (instance == null)
      {
         instance = new PortfolioModel();
      }

      return instance;
   }

   public PortfolioModel()
   {
      portfolioOptimizer = PortfolioOptimizer.getInstance();
      fixedOptimizer = FixedModelOptimizer.getInstance();
      secCollection = new SecurityCollection();
      historicalReportsReturns = null;
   }

   public void setPortfolioOptimizer(PortfolioOptimizer portfolioOptimizer)
   {
      this.portfolioOptimizer = portfolioOptimizer;
   }

   public void setSecurityDao(SecurityCollection secCollection)
   {
      this.secCollection = secCollection;
   }

   public void setFixedOptimizer(FixedModelOptimizer fixedOptimizer)
   {
      this.fixedOptimizer = fixedOptimizer;
   }

   public Portfolio createPortfolio(AssetClass assetClass, RiskCalc calc)
   {
      String theme = assetClass.getTheme();
      if (fixedOptimizer != null)
      {
         if (fixedOptimizer.isThisFixedTheme(theme))
         {
            return createFixedPortfolio(assetClass, calc);
         }
      }

      return createOptimizedPortfolio(assetClass, calc);


   }

   public Portfolio[] buildPortfolio(AssetClass[] assetData, ProfileData profileData)
   {
      Integer duration;
      Double invCapital;
      Double keepLiquidCash;
      Double reinvestment = 0.0;
      String advisor;
      String theme;

      try
      {
         if (assetData == null)
         {
            return null;
         }

         if (profileData == null)
         {
            return null;
         }

         // 04-15-14 Added this logic to use the actual Cash instead of entered on screen!
         // 2017-10-10 Currency converted value
         invCapital = profileData.getInvestmentAmount();

         // 04-15-14 Keep Liquid Cash as required.
         keepLiquidCash = 0.0;
         //05-14-15 changed, should be set in the database with setKeepLiquid
         if (invCapital < 100000)
         {
            if ((profileData.getKeepLiquid() != null) && (profileData.getKeepLiquid() < InvConst.MIN_LIQUID_CASH))
            {
               profileData.setKeepLiquid(((int) InvConst.MIN_LIQUID_CASH));
            }
         }

         if (profileData.getKeepLiquid() != null)
         {
            keepLiquidCash = profileData.getKeepLiquid().doubleValue();
         }

         // profileData.setKeepLiquid(keepLiquidCash.intValue());

         if (invCapital < 0.0)
         {
            invCapital = 0.0;
         }

         theme = profileData.getTheme();
         advisor = profileData.getAdvisor();
         ArrayList<String> assetList = assetData[0].getOrderedAsset();
         Double riskOffset = assetData[0].getRiskOffset();
         duration = profileData.getDefaultHorizon();
         double totalIncEarned = 0.0;
         double investment = invCapital - keepLiquidCash;

         if (profileData.getRecurringInvestment() == null)
         {
            reinvestment = 0.0;
         }
         else
         {
            reinvestment = profileData.getRecurringInvestment().doubleValue();
         }


         if (fixedOptimizer != null)
         {
            if (fixedOptimizer.isThisFixedTheme(theme))
            {
               profileData.setFixedModel(true);
               profileData.setNumOfPortfolio(1);
               Portfolio[] portfolio = new Portfolio[profileData.getNumOfPortfolio()];
               profileData.setMaxPortfolioAllocationPoints(fixedOptimizer.getThemes(theme).size() - 1);
               portfolio[0] = createOrigFixedPortfolio(assetData, profileData);

               return portfolio;
            }
         }

         // NOTE:  If Theme is default, then use Invessence - Core portfolio.
         // However, the Asset Weights may have been defined by Advisor's mapping.
         if (!portfolioOptimizer.isValidTheme(theme))
         {
            theme = InvConst.DEFAULT_THEME;
         }

         if (advisor == null || advisor.isEmpty())
         {
            advisor = InvConst.INVESSENCE_ADVISOR;
         }

         // Now collect all securities for this theme;
         if (secCollection == null)
         {
            secCollection = new SecurityCollection();
         }
         // if security of this theme is already loaded, then don't reload.
         // NOTE: If they individual choose the non-taxable, but is taxable, then load the taxable strategy.
         if (!secCollection.getThemeLoaded().equalsIgnoreCase(theme))
         {
            secCollection.loadDataFromDB(advisor, theme);
         }

//         if (historicalReportsReturns == null) {
//            historicalReportsReturns = HistoricalReportsReturns.getInstance(theme);
//         }
//         else if ( ! historicalReportsReturns.getThisTheme().equalsIgnoreCase(theme)) {
//               historicalReportsReturns.refreshDataFromDB(theme);
//         }

         profileData.setMaxPortfolioAllocationPoints(InvConst.PORTFOLIO_INTERPOLATION - 1);
         if (profileData.getRiskCalcMethod() == null || profileData.getRiskCalcMethod().startsWith(InvConst.CONSUMER_RISK_FORMULA))
         {
            return getOrigPortfolioByIndex(assetData, profileData, profileData.getRiskIndex().intValue(),
                                           advisor, theme, invCapital, investment, reinvestment, keepLiquidCash, duration, riskOffset);
         }
         else
         {
            return getOrigPortfolioByIndex(assetData, profileData, profileData.getPortfolioIndex(),
                                           advisor, theme, invCapital, investment, reinvestment, keepLiquidCash, duration, riskOffset);
         }

/*
         if (profileData.getRiskCalcMethod() == null || profileData.getRiskCalcMethod().startsWith(InvConst.CONSUMER_RISK_FORMULA))
         {
            return getPortfolioByRisk(assetData, profileData,
                                      advisor, theme, invCapital, investment, reinvestment, keepLiquidCash, duration, riskOffset);
         }
         else
         {
            return getPortfolioByIndex(assetData, profileData,
                                       advisor, theme, invCapital, investment, reinvestment, keepLiquidCash, duration, riskOffset);
         }
*/

      }
      catch (Exception ex)
      {

      }
      return null;
   }

   public Double getPortfolioScore(RiskCalc riskCalc)
   {
      return ((riskCalc == null) ? InvConst.PORTFOLIO_DEFAULT_POINT : riskCalc.getRiskScore());
   }

   private Portfolio createOptimizedPortfolio(AssetClass assetclass, RiskCalc riskCalc)
   {
      Double actualInvestment, reinvestment;
      String advisor, theme;


      try
      {

         theme = assetclass.getTheme();
         advisor = riskCalc.getAdvisor();
         actualInvestment = riskCalc.getDefaultInvestment();
         reinvestment = riskCalc.getDefaultRecurring();

         if (actualInvestment == 0.0)
         {
            return thisCashPortfolio(1.0, assetclass);
         }

         // NOTE:  If Theme is default, then use Invessence - Core portfolio.
         // However, the Asset Weights may have been defined by Advisor's mapping.
         if (!portfolioOptimizer.isValidTheme(theme))
         {
            theme = InvConst.DEFAULT_THEME;
         }

         if (advisor == null || advisor.isEmpty())
         {
            advisor = InvConst.INVESSENCE_ADVISOR;
         }

         // Now collect all securities for this theme;
         if (secCollection == null)
         {
            secCollection = new SecurityCollection();
         }
         // if security of this theme is already loaded, then don't reload.
         // NOTE: If they individual choose the non-taxable, but is taxable, then load the taxable strategy.
         if (!secCollection.getThemeLoaded().equalsIgnoreCase(theme))
         {
            secCollection.loadDataFromDB(advisor, theme);
         }

         Portfolio portfolio = createPortfolioAllocation(assetclass, riskCalc);

         portfolio.setActualInvestments(actualInvestment);
         portfolio.setTotalMoney(actualInvestment);
         //assign total risk and expReturn JAV
         return portfolio;
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      return null;


   }
   private Portfolio createPortfolioAllocation(AssetClass assetClass, RiskCalc riskCalc)
   {
      Portfolio pclass;
      String advisor, theme;
      Double investment, keepLiquidCash, invCapital;
      Double remaining2Invest;

      try
      {

         if (riskCalc == null)
         {
            return thisCashPortfolio(1.0, assetClass);
         }
         theme = riskCalc.getTheme();
         advisor = riskCalc.getAdvisor();

         investment = 0.0;
         keepLiquidCash = 0.0;
         if (riskCalc.getUserRiskProfile() != null)
         {
            keepLiquidCash = riskCalc.getUserRiskProfile().getDefaultDoubleValue(RiskConst.KEEPLIQUID, 0.0);
            investment = riskCalc.getDefaultInvestment();
         }

         Double totalPortfolioWeight = 0.0;
         Double ticker_weight;
         Double portfolioReturns = 0.0;
         Double portfolioRisk = 0.0;
         Double avgExpense = 0.0;
         Double incEarned = 0.0;
         Double secExpense = 0.0;
         Double investByAsset = 0.0;
         Integer offset = 0;

         AssetData assetdata;
         Asset asset;
         double[][] primeAssetWeights;
         Double assetWgt;

         pclass = new Portfolio();
         pclass.setTheme(theme);

         Double score = getPortfolioScore(riskCalc);

         //Initially, all of the money is in Cash bucket (including the keep liquid)
         pclass.setCashMoney(riskCalc.getDefaultInvestment());
         invCapital = investment - keepLiquidCash;
         remaining2Invest = invCapital;
         pclass.setActualInvestments(invCapital);

         offset = (score.intValue() < 0) ? 0 : score.intValue();
         offset = (offset > InvConst.PORTFOLIO_INTERPOLATION - 1) ? InvConst.PORTFOLIO_INTERPOLATION - 1 : offset;

         // Prime asset class loop
         for (String assetname : portfolioOptimizer.getAdvisorOrdertedAssetList(theme))
         {
            investByAsset = 0.0;
            assetdata = portfolioOptimizer.getAssetData(theme, assetname);
            asset = assetClass.getAsset(assetname);
            if (asset == null)
            { // If asset is not found, then return in case of Cash only account.
               continue;
            }
            primeAssetWeights = assetdata.getPrimeAssetweights();
            assetWgt = asset.getUserweight();
            int tickerNum = 0;
            Double calcprimeassetWeight = 0.0;
            if (!assetname.equalsIgnoreCase("CASH"))
            {
               for (String primeassetclass : assetdata.getOrderedPrimeAssetList())
               {
                  if (primeAssetWeights.length >= offset) {
                     calcprimeassetWeight = primeAssetWeights[offset][tickerNum];
                  }
                  else {
                     calcprimeassetWeight = 0.0;
                  }
                  ticker_weight = assetWgt * calcprimeassetWeight;
                  if (secCollection.getOrderedSecurityList(advisor, theme, primeassetclass) != null)
                  {
                     for (SecurityData sd : secCollection.getOrderedSecurityList(advisor, theme, primeassetclass))
                     {
                        PrimeAssetClassData pacd = portfolioOptimizer.getPrimeAssetData(theme, assetname, primeassetclass);
                        double price = sd.getDailyprice();
                        Double settleCurrencyInvestment = investment * sd.getExchangeRate();
                        Double settlePrice = sd.getSettlePrice();
                        Double rbsaWeight = (Double) ticker_weight * sd.getRbsaWeight();  // RBSA PREP WORK:  Currently all have rate of 1
                        // If there is no weight, just skip this ticker all together.
                        Double shares = 0.0, money = 0.0;
                        Double settleShare = 0.0, settleMoney = 0.0;
                        if (rbsaWeight > 0.0 && price > 0.0)
                        {
                           shares = (double) Math.round(((invCapital * rbsaWeight) / price) - 0.5);
                           money = shares * price;

                           settleShare = (double) Math.round(((settleCurrencyInvestment * rbsaWeight) / settlePrice) - 0.5);
                           settleMoney = settleShare * settlePrice;

                           // Only create this portfolio if there are shares and money
                           totalPortfolioWeight = 0.0;
                           if ((shares > 0.0) && (money > 0.0))
                           {
                              if (remaining2Invest > 0.0)
                              {
                                 totalPortfolioWeight = money / invCapital;
                              }

                              investByAsset = investByAsset + money;
                              pclass.setPortfolio(sd.getTicker(), sd.getName(), asset.getColor(),
                                                  sd.getType(), sd.getStyle(),
                                                  sd.getSecurityAssetClass(), sd.getSecuritySubAssetClass(),
                                                  price, rbsaWeight,
                                                  0.0, 0.0, 0.0, 0.0,
                                                  shares, money, pacd.getSortorder(), totalPortfolioWeight,
                                                  sd.getIsin(), sd.getCusip(), sd.getRic(),
                                                  sd.getTradeCurrency(), sd.getSettleCurrency(), sd.getExchangeRate(),
                                                  settleShare, settlePrice, settleMoney);
                              pclass.addSubclassMap(sd.getSecurityAssetClass(), sd.getSecuritySubAssetClass(),
                                                    asset.getColor(),
                                                    totalPortfolioWeight, money, true);


                              secExpense = secExpense + 0.0 * rbsaWeight;
                              remaining2Invest = remaining2Invest - money;
                           }
                           pclass.setCashMoney(remaining2Invest);
                           Double volatiity;
                           SecurityData secdata = portfolioOptimizer.getSecurityData(sd.getTicker(), sd.getTradeCurrency());
                           volatiity = (secdata != null) ? secdata.getVolatility() : assetdata.getPrimeAssetrisk()[offset];

                           portfolioRisk = portfolioRisk + volatiity * totalPortfolioWeight;
                           double pAssetreturns = assetdata.getPrimeAssetreturns()[offset];
                           portfolioReturns = portfolioReturns + assetdata.getPrimeAssetreturns()[offset] * totalPortfolioWeight;

                           //ticker_weight = ticker_weight - rbsaWeight;
                        }
                     }

                  }
                  //look at the next ticker in primeAssetFrontier
                  tickerNum++;

               }

               if (assetdata.getPrimeAssetreturns() != null)
               {
                  asset.setExpectedReturn(assetdata.getPrimeAssetreturns()[offset]);
                  asset.setRisk(assetdata.getPrimeAssetrisk()[offset]);
               }
               asset.setValue(investByAsset);
               if (invCapital == 0.0)
               {
                  asset.setActualweight(0.0);
               }
               else
               {
                  asset.setActualweight(investByAsset / invCapital);
               }
            }
         }

         if (remaining2Invest >= 0.0)
         {
            SecurityData sd = secCollection.getSecurity("CASH");
            assetdata = portfolioOptimizer.getAssetData(theme, "Cash");
            asset = assetClass.getAsset("Cash");
            if (invCapital == 0.0)
            {
               assetWgt = 0.0;
            }
            else
            {
               assetWgt = (remaining2Invest + keepLiquidCash) / invCapital;
            }

            double cash = remaining2Invest + keepLiquidCash;
            double settlecash = cash;
            investByAsset = remaining2Invest;

            totalPortfolioWeight = assetWgt;
            pclass.setPortfolio("Cash", "Cash", asset.getColor(),
                                "Cash", "Cash", "Cash", "Cash",
                                1.0, assetWgt,
                                0.0, 0.0, 0.0, 0.0,
                                cash, cash, 999999, assetWgt,
                                "Cash", "Cash", "Cash",
                                sd.getTradeCurrency(), sd.getSettleCurrency(), sd.getExchangeRate(),
                                settlecash, 1.0, settlecash);
            if (sd != null)
            {
               pclass.addSubclassMap(sd.getAssetclass(), sd.getPrimeassetclass(),
                                     asset.getColor(),
                                     assetWgt, remaining2Invest, true);
            }
            else
            {
               pclass.addSubclassMap("Cash", "Cash",
                                     asset.getColor(),
                                     assetWgt, remaining2Invest, true);

            }
            if (assetdata.getPrimeAssetrisk() != null)
            {
               portfolioRisk = portfolioRisk + assetdata.getPrimeAssetrisk()[offset] * totalPortfolioWeight;
               portfolioReturns = portfolioReturns + assetdata.getPrimeAssetreturns()[offset] * totalPortfolioWeight;
            }

            if (assetdata.getPrimeAssetreturns() != null)
            {
               asset.setExpectedReturn(assetdata.getPrimeAssetreturns()[offset]);
               asset.setRisk(assetdata.getPrimeAssetrisk()[offset]);
            }
            asset.setValue(investByAsset);
            if (invCapital == 0.0)
            {
               asset.setActualweight(0.0);
            }
            else
            {
               asset.setActualweight(investByAsset / invCapital);
            }


         }

         incEarned = portfolioReturns * invCapital;
         pclass.setExpReturns(portfolioReturns);
         pclass.setTotalRisk(portfolioRisk);
         pclass.setTotalCapitalGrowth(incEarned);
         pclass.setAvgExpense(secExpense * invCapital);

         if (InvConst.MIN_MNGT_FEES_DOLLARS > InvConst.MNGT_FEES * invCapital)
         {
            pclass.setAvgCost(InvConst.MIN_MNGT_FEES_DOLLARS);
            pclass.setTotalCost(InvConst.MIN_MNGT_FEES_DOLLARS + secExpense * invCapital);
         }
         else
         {
            pclass.setAvgCost(InvConst.MNGT_FEES * invCapital);
            pclass.setTotalCost(InvConst.MNGT_FEES * invCapital + secExpense * invCapital);
         }
         return pclass;
      }
      catch (Exception e)
      {
         return thisCashPortfolio(1.0, assetClass);
      }
   }

   private Portfolio thisCashPortfolio(Double totalWeight, AssetClass assetclass)
   {
      Portfolio thisportfolio = null;
      String tradeCurrency, settmentCurrency;
      Double investment = 100000.0;
      try
      {
         if (assetclass != null)
         {
            investment = assetclass.getTotalInvested();
         }
         totalWeight = (totalWeight == null) ? 1.0 : totalWeight;

         Double money = totalWeight * investment;

         thisportfolio = new Portfolio();
         thisportfolio.setCashMoney(money);
         thisportfolio.setPortfolio("Cash", "Cash", null,
                                    null, null, "Cash", "Cash",
                                    1.0, totalWeight,
                                    0.0, 0.0, 0.0, 0.0,
                                    money, money, 999999, 1.0,
                                    "", "", "",
                                    null, null, 1.0,
                                    money, 1.0, money);

         thisportfolio.addSubclassMap("Cash", "Cash",
                                      null,
                                      totalWeight, money, true);
         thisportfolio.setExpReturns(0.0);
         thisportfolio.setTotalRisk(0.0);
         thisportfolio.setTotalCapitalGrowth(0.0);
         thisportfolio.setAvgExpense(0.0);
         thisportfolio.setTheme(assetclass.getTheme());
      }
      catch (Exception ex)
      {
         thisportfolio = null;
      }

      return thisportfolio;

   }

   private Portfolio createFixedPortfolio(AssetClass assetclass, RiskCalc riskCalc)
   {

      String theme = assetclass.getTheme();
      Double price;
      String type, style;
      String assetname, subclass, color, sec_name;
      Integer sortorder;
      Double totalWeight = 1.0;
      Double investment = riskCalc.getDefaultInvestment();
      Double amount_remain = investment;

      try
      {
         // Integer riskFormula = userRiskProfile.convertCalcFormula2Int(userRiskProfile.getCalcFormula());  Not used in the current process.
         Double score;
         FMData fixedModelData;

         score = riskCalc.getRiskScore();

         fixedModelData = fixedOptimizer.getTheme(theme, score);
         Portfolio thisportfolio = new Portfolio();
         investment = (investment == null || investment == 0.0) ? 100000.0 : investment;
         thisportfolio.setCashMoney(investment);

         for (FMPortfolioData portfoliodata : fixedModelData.getPortfolioData())
         {
            Double wght = portfoliodata.getWeight();
            String ticker = portfoliodata.getTicker();
            double shares = 0.0;

            if (wght < 0)
            {
               wght = 0.0;
            }
            price = 100.00;
            type = portfoliodata.getAsset();
            style = portfoliodata.getDisplayname();
            subclass = portfoliodata.getDisplayname();
            assetname = portfoliodata.getAsset();
            color = portfoliodata.getColor();
            sortorder = portfoliodata.getSortorder();
            sec_name = portfoliodata.getSec_name();


            if (ticker.equalsIgnoreCase("Cash"))
            {
               wght = totalWeight;
            }
            else
            {
               if ((totalWeight - wght) < 0.0)
               {
                  wght = totalWeight;
               }
            }
            totalWeight -= wght;

            shares = Math.round(((investment * wght) / price) - 0.5);

            Double money = wght * investment;
            Double totalPortfolioWeight = money / investment;
            thisportfolio.setPortfolio(ticker, sec_name, color,
                                       type, style, assetname, subclass,
                                       price, wght,
                                       0.0, 0.0, 0.0, 0.0,
                                       shares, money, sortorder, totalPortfolioWeight,
                                       "", "", "",
                                       null, null, 1.0,
                                       shares, price, money);
            thisportfolio.addSubclassMap(assetname, subclass,
                                         color,
                                         totalPortfolioWeight, amount_remain, true);
            amount_remain = amount_remain - money;
            thisportfolio.setCashMoney(amount_remain);
         }

         if (!thisportfolio.getPortfolioMap().containsKey("Cash"))
         {
            thisportfolio = thisCashPortfolio(totalWeight, assetclass);
         }
         Double expectedReturn = fixedModelData.getExpectedreturn();
         Double expectedRisk = fixedModelData.getExpectedrisk();
         thisportfolio.setTheme(assetclass.getTheme());
         thisportfolio.setTotalCapitalGrowth(0.0);
         thisportfolio.setAvgExpense(0.0);

         if (fixedModelData.getExpectedreturn() != null && fixedModelData.getExpectedreturn() != 0.0)
         {
            thisportfolio.setExpReturns(expectedReturn);
            thisportfolio.setTotalRisk(expectedRisk);
         }
         else
         {
            thisportfolio.setExpReturns(0.0);
            thisportfolio.setTotalRisk(0.0);
         }

         if (fixedModelData.getExpectedrisk() != null && fixedModelData.getExpectedrisk() != 0.0)
         {
            thisportfolio.setExpReturns(expectedReturn);
            thisportfolio.setTotalRisk(expectedRisk);
         }
         else
         {
            thisportfolio.setExpReturns(0.0);
            thisportfolio.setTotalRisk(0.0);
         }
         return thisportfolio;
      }
      catch (Exception ex)
      {
         return thisCashPortfolio(totalWeight, assetclass);
      }
   }


   // ----------------------------------------------------------
   // All of this is obsolete code
   public Integer getPortfolioIndex(ProfileData pdata)
   {

      if (pdata == null)
      {
         return InvConst.PORTFOLIO_DEFAULT_POINT;
      }

      if (pdata.getAssetData() == null)
      {
         return InvConst.PORTFOLIO_DEFAULT_POINT;
      }

      Double riskOffset = pdata.getAssetData()[0].getRiskOffset();
      Integer duration = pdata.getDefaultHorizon();

      int offset = (int) (StrictMath.sqrt(StrictMath.pow(duration, 2.0) - StrictMath.pow((double) 0, 2.0))) * (InvConst.PORTFOLIO_INTERPOLATION / duration);
      offset = (int) (riskOffset * (double) offset);
      offset = (offset > InvConst.PORTFOLIO_INTERPOLATION - 1) ? InvConst.PORTFOLIO_INTERPOLATION - 1 : offset;
      if (offset < 0)
      {
         offset = 0;
      }

      return offset;
   }


   private Portfolio[] getOrigPortfolioByIndex(AssetClass[] assetData, ProfileData profileData, Integer riskIndex,
                                               String advisor, String theme, Double invCapital, Double investment,
                                               Double reinvestment, Double keepLiquidCash, Integer duration, Double riskOffset)
   {
      String assetName;

      try
      {
         // This actualInvestment already is reduced by KeepLiquid
         double actualInvestment = investment;

         //Asset data is for each year of investment horizon
         int years = (profileData.getNumOfPortfolio() == null || profileData.getNumOfPortfolio() == 0) ? profileData.getAssetData().length : profileData.getNumOfPortfolio();
         years = (profileData.getAssetData().length < years) ? profileData.getAssetData().length : years;
         Portfolio[] portfolioclass = new Portfolio[years];
         int offset = (riskIndex == null) ? InvConst.PORTFOLIO_DEFAULT_POINT : riskIndex;
         offset = (offset > InvConst.PORTFOLIO_INTERPOLATION - 1) ? InvConst.PORTFOLIO_INTERPOLATION - 1 : offset;
         offset = (offset < 0) ? 0 : offset;
         for (int investmentYear = 0; investmentYear < years; investmentYear++)
         {
            portfolioclass[investmentYear] = new Portfolio();
            portfolioclass[investmentYear].setTheme(theme);

            //JAV added keepLiquid
            portfolioclass[investmentYear].setCashMoney(invCapital);


            //offset = (int) (StrictMath.sqrt(StrictMath.pow(duration, 2.0) - StrictMath.pow((double) investmentYear, 2.0)))*(InvConst.PORTFOLIO_INTERPOLATION/duration);
            //offset = (int) (riskOffset * (double) offset);

            // Actual Investment is investment and recurring the next year.  Does not contain the returns.
            portfolioclass[investmentYear].setActualInvestments(invCapital);
               createPortfolio(advisor, theme, assetData[investmentYear], portfolioclass[investmentYear],
                               invCapital, investment, keepLiquidCash,
                               investmentYear, profileData, offset);


            // Total Money = Investment + Projection
            portfolioclass[investmentYear].setTotalMoney(invCapital);
            actualInvestment += reinvestment;
            invCapital += reinvestment;

            // Total Money = Investment + Projection
            if (investmentYear == 0)
            {
               portfolioclass[investmentYear].setTotalMoney(invCapital);
            }
            else
            {
               portfolioclass[investmentYear].setTotalMoney(invCapital);
            }

            if (investmentYear > 0)
            {
               portfolioclass[investmentYear].setUpperTotalMoney((2 * portfolioclass[investmentYear - 1].getTotalRisk() * investment)
                                                                    + investment);
               portfolioclass[investmentYear].setLowerTotalMoney(investment -
                                                                    (2 * portfolioclass[investmentYear - 1].getTotalRisk() * investment));
            }
            else
            {
               portfolioclass[investmentYear].setUpperTotalMoney(investment);
               portfolioclass[investmentYear].setLowerTotalMoney(investment);

            }
            investment = portfolioclass[investmentYear].getTotalMoney() +
               portfolioclass[investmentYear].getTotalCapitalGrowth() +
               reinvestment;

         }
         //assign total risk and expReturn JAV
         return portfolioclass;
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      return null;

   }

   private void createPortfolio(String advisor, String theme,
                                AssetClass assetClass, Portfolio pclass,
                                double invCapital, double investment, double keepLiquidCash,
                                int year, ProfileData pdata, int offset)
   {
      try
      {

         double amount2Allocate = investment;

         double totalPortfolioWeight = 0.0;
         double ticker_weight;
         double portfolioReturns = 0.0;
         double portfolioRisk = 0.0;
         double avgExpense = 0.0;
         double incEarned = 0.0;
         double secExpense = 0.0;

         double investByAsset = 0.0;
         AssetData assetdata;
         Asset asset;
         double[][] primeAssetWeights;
         double assetWgt;
         // Prime asset class loop
         for (String assetname : portfolioOptimizer.getAdvisorOrdertedAssetList(theme))
         {
            investByAsset = 0.0;
            assetdata = portfolioOptimizer.getAssetData(theme, assetname);
            asset = assetClass.getAsset(assetname);
            if (asset == null)
            { // If asset is not found, then return in case of Cash only account.
               continue;
            }
            primeAssetWeights = assetdata.getPrimeAssetweights();
            assetWgt = asset.getUserweight();
            int tickerNum = 0;
            if (!assetname.equalsIgnoreCase("CASH"))
            {
               for (String primeassetclass : assetdata.getOrderedPrimeAssetList())
               {
                  ticker_weight = assetWgt * primeAssetWeights[offset][tickerNum];
                  if (secCollection.getOrderedSecurityList(advisor, theme, primeassetclass) != null)
                  {
                     for (SecurityData sd : secCollection.getOrderedSecurityList(advisor, theme, primeassetclass))
                     {
                        PrimeAssetClassData pacd = portfolioOptimizer.getPrimeAssetData(theme, assetname, primeassetclass);
                        double price = sd.getDailyprice();
                        Double settleCurrencyInvestment = investment * sd.getExchangeRate();
                        Double settlePrice = sd.getSettlePrice();
                        Double rbsaWeight = (Double) ticker_weight * sd.getRbsaWeight();  // RBSA PREP WORK:  Currently all have rate of 1
                        // If there is no weight, just skip this ticker all together.
                        Double shares = 0.0, money = 0.0;
                        Double settleShare = 0.0, settleMoney = 0.0;
                        if (rbsaWeight > 0.0 && price > 0.0)
                        {
                           shares = (double) Math.round(((invCapital * rbsaWeight) / price) - 0.5);
                           money = shares * price;

                           settleShare = (double) Math.round(((settleCurrencyInvestment * rbsaWeight) / settlePrice) - 0.5);
                           settleMoney = settleShare * settlePrice;

                           // Only create this portfolio if there are shares and money
                           if ((shares > 0.0) && (money > 0.0))
                           {
                              totalPortfolioWeight = 0.0;
                              if (amount2Allocate > 0.0)
                              {
                                 totalPortfolioWeight = money / invCapital;
                              }

                              investByAsset = investByAsset + money;
                              pclass.setPortfolio(sd.getTicker(), sd.getName(), asset.getColor(),
                                                  sd.getType(), sd.getStyle(),
                                                  sd.getSecurityAssetClass(), sd.getSecuritySubAssetClass(),
                                                  price, rbsaWeight,
                                                  0.0, 0.0, 0.0, 0.0,
                                                  shares, money, pacd.getSortorder(), totalPortfolioWeight,
                                                  sd.getIsin(), sd.getCusip(), sd.getRic(),
                                                  sd.getTradeCurrency(), sd.getSettleCurrency(), sd.getExchangeRate(),
                                                  settleShare, settlePrice, settleMoney);
                              pclass.addSubclassMap(sd.getSecurityAssetClass(), sd.getSecuritySubAssetClass(),
                                                    asset.getColor(),
                                                    totalPortfolioWeight, money, true);


                              secExpense = secExpense + 0.0 * rbsaWeight;
                              amount2Allocate = amount2Allocate - money;
                           }
                           pclass.setCashMoney(amount2Allocate);
                           Double volatiity;
                           SecurityData secdata = portfolioOptimizer.getSecurityData(sd.getTicker(), sd.getTradeCurrency());
                           volatiity = (secdata != null) ? secdata.getVolatility() : assetdata.getPrimeAssetrisk()[offset];

                           portfolioRisk = portfolioRisk + volatiity * totalPortfolioWeight;
                           double pAssetreturns = assetdata.getPrimeAssetreturns()[offset];
                           portfolioReturns = portfolioReturns + assetdata.getPrimeAssetreturns()[offset] * totalPortfolioWeight;

                           //ticker_weight = ticker_weight - rbsaWeight;
                        }
                     }

                  }
                  //look at the next ticker in primeAssetFrontier
                  tickerNum++;

               }

               if (assetdata.getPrimeAssetreturns() != null)
               {
                  asset.setExpectedReturn(assetdata.getPrimeAssetreturns()[offset]);
                  asset.setRisk(assetdata.getPrimeAssetrisk()[offset]);
               }
               asset.setValue(investByAsset);
               asset.setActualweight(investByAsset / invCapital);
            }
         }

         if (amount2Allocate >= 0)
         {
            SecurityData sd = secCollection.getSecurity("CASH");
            assetdata = portfolioOptimizer.getAssetData(theme, "Cash");
            asset = assetClass.getAsset("Cash");
            assetWgt = (amount2Allocate + keepLiquidCash) / invCapital;
            double cash = amount2Allocate + keepLiquidCash;
            double settlecash = cash;
            investByAsset = amount2Allocate;

            totalPortfolioWeight = assetWgt;
            pclass.setPortfolio("Cash", "Cash", asset.getColor(),
                                "Cash", "Cash", "Cash", "Cash",
                                1.0, assetWgt,
                                0.0, 0.0, 0.0, 0.0,
                                cash, cash, 999999, assetWgt,
                                "Cash", "Cash", "Cash",
                                sd.getTradeCurrency(), sd.getSettleCurrency(), sd.getExchangeRate(),
                                settlecash, 1.0, settlecash);
            if (sd != null)
            {
               pclass.addSubclassMap(sd.getAssetclass(), sd.getPrimeassetclass(),
                                     asset.getColor(),
                                     assetWgt, amount2Allocate, true);
            }
            else
            {
               pclass.addSubclassMap("Cash", "Cash",
                                     asset.getColor(),
                                     assetWgt, amount2Allocate, true);

            }
            if (assetdata.getPrimeAssetrisk() != null)
            {
               portfolioRisk = portfolioRisk + assetdata.getPrimeAssetrisk()[offset] * totalPortfolioWeight;
               portfolioReturns = portfolioReturns + assetdata.getPrimeAssetreturns()[offset] * totalPortfolioWeight;
            }

            if (assetdata.getPrimeAssetreturns() != null)
            {
               asset.setExpectedReturn(assetdata.getPrimeAssetreturns()[offset]);
               asset.setRisk(assetdata.getPrimeAssetrisk()[offset]);
            }
            asset.setValue(investByAsset);
            asset.setActualweight(investByAsset / invCapital);

         }

         incEarned = portfolioReturns * invCapital;
         pclass.setExpReturns(portfolioReturns);
         pclass.setTotalRisk(portfolioRisk);
         pclass.setTotalCapitalGrowth(incEarned);
         pclass.setAvgExpense(secExpense * invCapital);

         if (InvConst.MIN_MNGT_FEES_DOLLARS > InvConst.MNGT_FEES * invCapital)
         {
            pclass.setAvgCost(InvConst.MIN_MNGT_FEES_DOLLARS);
            pclass.setTotalCost(InvConst.MIN_MNGT_FEES_DOLLARS + secExpense * invCapital);
         }
         else
         {
            pclass.setAvgCost(InvConst.MNGT_FEES * invCapital);
            pclass.setTotalCost(InvConst.MNGT_FEES * invCapital + secExpense * invCapital);
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
   }



   private Portfolio createOrigFixedPortfolio(AssetClass[] assetData, ProfileData pdata)
   {

      String theme = pdata.getTheme();
      Double price;
      String type, style;
      String assetname, subclass, color, sec_name;
      Integer sortorder;
      Portfolio portfolio = new Portfolio();
      double totalWeight = 1.0;
      double investment = pdata.getDefaultInvestment();
      double amount_remain = investment;

      portfolio.setTheme(pdata.getTheme());
      portfolio.setCashMoney(investment);
      FMData fixedModelData;
      if (pdata.getRiskCalcMethod().equalsIgnoreCase(InvConst.CONSUMER_RISK_FORMULA))
      {
         fixedModelData = fixedOptimizer.getTheme(theme, assetData[0].getRiskOffset());
      }
      else
      {
         fixedModelData = fixedOptimizer.getThemeByIndex(theme, pdata.getPortfolioIndex());
      }

      pdata.setFixedFMModel(fixedModelData);
      if (fixedModelData != null)
      {
         if (fixedModelData.getExpectedreturn() != null && fixedModelData.getExpectedreturn() != 0.0)
         {
            pdata.setHasReturn(true);
            portfolio.setExpReturns(fixedModelData.getExpectedreturn());
         }
         else
         {
            pdata.setHasReturn(false);
         }

         if (fixedModelData.getExpectedrisk() != null && fixedModelData.getExpectedrisk() != 0.0)
         {
            pdata.setHasRisk(true);
            portfolio.setTotalRisk(fixedModelData.getExpectedrisk());
         }
         else
         {
            pdata.setHasRisk(false);
         }

         pdata.setAllocationIndex(fixedModelData.getIndex());
         pdata.setPortfolioIndex(fixedModelData.getIndex());
         for (FMPortfolioData portfoliodata : fixedModelData.getPortfolioData())
         {
            Double wght = portfoliodata.getWeight();
            String ticker = portfoliodata.getTicker();
            double shares = 0.0;

            if (wght < 0)
            {
               wght = 0.0;
            }
            price = 100.00;
            type = portfoliodata.getAsset();
            style = portfoliodata.getDisplayname();
            subclass = portfoliodata.getDisplayname();
            assetname = portfoliodata.getAsset();
            color = portfoliodata.getColor();
            sortorder = portfoliodata.getSortorder();
            sec_name = portfoliodata.getSec_name();


            if (ticker.equalsIgnoreCase("Cash"))
            {
               wght = totalWeight;
            }
            else
            {
               if ((totalWeight - wght) < 0.0)
               {
                  wght = totalWeight;
               }
            }
            totalWeight -= wght;

            shares = Math.round(((investment * wght) / price) - 0.5);

            Double money = wght * investment;
            Double totalPortfolioWeight = money / investment;
            portfolio.setPortfolio(ticker, sec_name, color,
                                   type, style, assetname, subclass,
                                   price, wght,
                                   0.0, 0.0, 0.0, 0.0,
                                   shares, money, sortorder, totalPortfolioWeight,
                                   "", "", "",
                                   "USD", "USD", 1.0,
                                   shares, price, money);
            portfolio.addSubclassMap(assetname, subclass,
                                     color,
                                     totalPortfolioWeight, amount_remain, true);
            amount_remain = amount_remain - money;
            portfolio.setCashMoney(amount_remain);
         }
         if (!portfolio.getPortfolioMap().containsKey("Cash"))
         {
            Double money = totalWeight * investment;
            portfolio.setPortfolio("Cash", "Cash", null,
                                   null, null, "Cash", "Cash",
                                   1.0, totalWeight,
                                   0.0, 0.0, 0.0, 0.0,
                                   money, money, 999999, totalWeight,
                                   "", "", "",
                                   "USD", "USD", 1.0,
                                   money, 1.0, money);
            portfolio.addSubclassMap("Cash", "Cash",
                                     null,
                                     totalWeight, money, true);

         }
         portfolio.setExpReturns(fixedModelData.getExpectedreturn());
         portfolio.setTotalRisk(fixedModelData.getExpectedrisk());
         portfolio.setTotalCapitalGrowth(0.0);
         portfolio.setAvgExpense(0.0);

      }

      return portfolio;
   }

}
