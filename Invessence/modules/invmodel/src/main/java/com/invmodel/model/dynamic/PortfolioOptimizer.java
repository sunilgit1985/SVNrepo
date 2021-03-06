package com.invmodel.model.dynamic;

import java.sql.*;
import java.util.*;
import java.util.concurrent.locks.*;
import java.util.logging.Logger;

import javax.sql.DataSource;

import com.invessence.converter.*;
import com.invessence.converter.SQLData;
import com.invmodel.Const.InvConst;
import com.invmodel.dao.*;
import com.invmodel.dao.data.*;
import com.invmodel.dao.rbsa.*;
import com.invmodel.utils.MergeSort;
import org.apache.commons.dbutils.DbUtils;
import webcab.lib.finance.portfolio.*;

/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 1/24/15
 * Time: 5:16 PM
 * To change this template use File | Settings | File Templates.
 */
public class PortfolioOptimizer
{

   private static PortfolioOptimizer instance = null;
   private final Logger logger = Logger.getLogger(PortfolioOptimizer.class.getName());

   private final ReentrantReadWriteLock readWriteLock = new ReentrantReadWriteLock();
   private final Lock read = readWriteLock.readLock();
   private final Lock write = readWriteLock.writeLock();

   private Map<String, ArrayList<String>> themeAssetMap;
   private Map<String, AssetData> assetDataMap;
   private HolisticModelOptimizer hoptimizer;
   private HistoricalDailyReturns historicaldailyreturns;
   private Map<String, SecurityData> securityDataMap;

   private PortfolioOptimizer()
   {
      super();
      themeAssetMap = new LinkedHashMap<String, ArrayList<String>>();
      assetDataMap = new HashMap<String, AssetData>();
      hoptimizer = HolisticModelOptimizer.getInstance();
      historicaldailyreturns = new HistoricalDailyReturns();
      securityDataMap = new HashMap<String, SecurityData>();

   }

   public static synchronized PortfolioOptimizer getInstance()
   {
      if (instance == null)
      {
         instance = new PortfolioOptimizer();
      }

      return instance;
   }

   private String checkKey(String keyname)
   {
      if (keyname == null || keyname.length() == 0)
      {
         keyname = "DISCARD";
      }

      return keyname.toUpperCase();
   }

   private String buildSecurityKey(String ticker, String basecurrency)
   {

      return checkKey(ticker) + "." + checkKey(basecurrency);
   }

   // If Theme is null, then reload all model.
   public void loadDataFromDB(String theme)
   {
      write.lock();
      try
      {
         themeAssetMap.clear();
         assetDataMap.clear();

         logger.info("Loading Historical Returns from RBSA");
         historicaldailyreturns.refreshDataFromDB();
         logger.info("Loading ASSET information from DB");
         loadAssetDataFromDB(theme);
         logger.info("Loading Prime Asset information from DB");
         loadPrimeAssetsFromDB(theme);
         logger.info("Optimize Asset Class");
         saveAssetWeights();
         logger.info("Optimize Prime Asset Class");
         savePrimeAssetWeights();
         logger.info("Load Security for volatality");
         loadSecurityData();
         logger.info("Calculate Volatality");
         calcSecurityVolatality();
      }
      catch (Exception ex)
      {

      }
      finally
      {
         write.unlock();
      }

   }

   public void refreshDataFromDB()
   {
      loadDataFromDB(null);
   }

   private String checkThemeName(String theme)
   {
      if (theme == null || theme.length() == 0)
      {
         theme = "DISCARD";
      }
      return theme.toUpperCase();
   }

   private String checkAssetName(String assetName)
   {
      if (assetName == null || assetName.length() == 0)
      {
         assetName = "DISCARD";
      }

      return assetName.toUpperCase();
   }


   private String buildAssetKey(String theme, String assetName)
   {

      return checkThemeName(theme) + "." + checkAssetName(assetName);
   }

   public ArrayList<String> getAdvisorList()
   {
      ArrayList<String> themeList = new ArrayList<String>();
      for (String theme : themeAssetMap.keySet())
      {
         themeList.add(theme);
      }
      return themeList;
   }

   public ArrayList<String> getAdvisorOrdertedAssetList(String theme)
   {
      return themeAssetMap.get(checkThemeName(theme));
   }

   public void addAssetClass(String theme, String assetName, AssetData assetData)
   {
      String key;

      key = buildAssetKey(theme, assetName);
      theme = checkThemeName(theme);
      if (!key.contains("DISCARD"))
      {
         if (!assetDataMap.containsKey(key))
         {
            if (!themeAssetMap.containsKey(theme))
            {
               ArrayList<String> assetList = new ArrayList<String>();
               assetList.add(assetName);
               themeAssetMap.put(theme, assetList);
            }
            else
            {
               themeAssetMap.get(theme).add(assetName);
            }
         }
         assetDataMap.put(key, assetData);
      }

   }

   public ArrayList<AssetData> getAssetDataList(String theme)
   {
      ArrayList<AssetData> assetDataList = new ArrayList<AssetData>();

      for (String assetName : themeAssetMap.get(checkThemeName(theme)))
      {
         String key = buildAssetKey(checkThemeName(theme), assetName);
         assetDataList.add(assetDataMap.get(key));
      }

      return assetDataList;
   }

   public String getCashColor(String theme)
   {
      read.lock();
      try
      {
         String key = buildAssetKey(checkThemeName(theme), "Cash");
         if (assetDataMap.containsKey(key))
         {
            return assetDataMap.get(key).getColor();
         }
         return "#f5f5f5";
      }
      catch (Exception ex)
      {

      }
      finally
      {
         read.unlock();
      }
      return null;

   }

   public AssetData getAssetData(String theme, String assetName)
   {
      read.lock();
      try
      {
         String key = buildAssetKey(checkThemeName(theme), assetName);
         return assetDataMap.get(key);
      }
      catch (Exception ex)
      {

      }
      finally
      {
         read.unlock();
      }
      return null;
   }

   public Boolean isValidTheme(String theme)
   {
      return themeAssetMap.containsKey(checkThemeName(theme));
   }

   public ArrayList<PrimeAssetClassData> getPrimeAssetDataList(String theme)
   {
      ArrayList<PrimeAssetClassData> primeassetdata = new ArrayList<PrimeAssetClassData>();
      read.lock();
      try
      {
         for (String asset : themeAssetMap.get(checkThemeName(theme)))
         {
            String key = buildAssetKey(theme, asset);
            for (String primeasset : assetDataMap.get(key).getOrderedPrimeAssetList())
            {
               primeassetdata.add(assetDataMap.get(key).getPrimeAssetData(primeasset));
            }
         }
      }
      catch (Exception ex)
      {

      }
      finally
      {
         read.unlock();
      }
      return primeassetdata;
   }

   public PrimeAssetClassData getPrimeAssetData(String theme, String assetname, String ticker)
   {
      read.lock();
      try
      {
         String key = buildAssetKey(theme, assetname);
         return assetDataMap.get(key).getPrimeAssetData(ticker);
      }
      catch (Exception ex)
      {

      }
      finally
      {
         read.unlock();
      }
      return null;
   }

   public String[] getOrderedAsset(String theme)
   {
      read.lock();
      try
      {
         theme = checkThemeName(theme);
         if (themeAssetMap.containsKey(theme))
         {
            String[] asset = new String[themeAssetMap.get(theme).size()];
            for (int i = 0; i < themeAssetMap.get(theme).size(); i++)
            {
               String assetname = checkAssetName(themeAssetMap.get(theme).get(i));
               String key = buildAssetKey(theme, assetname);
               asset[i] = assetDataMap.get(key).getAsset();
            }
            return asset;
         }
         else
         {
            return null;
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      finally
      {
         read.unlock();
      }
      return null;
   }

   private void setAssetdata(String theme, String currency,
                             String assetName, String displayName,
                             double lbConstraint, double ubConstraint,
                             String index, double averageReturn,
                             String color, double risk_adjustment, double end_allocation, int sortorder)
   {
      try
      {
         AssetData data = new AssetData(theme,
                                        currency,
                                        assetName,
                                        displayName,
                                        lbConstraint,
                                        ubConstraint,
                                        index,
                                        averageReturn,
                                        color,
                                        risk_adjustment,
                                        end_allocation,
                                        sortorder
         );
         addAssetClass(theme, assetName, data);
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
   }

   private void loadAssetDataFromDB(String theme)
   {
      DBConnectionProvider dbconnection = DBConnectionProvider.getInstance();
      SQLData convert = new com.invessence.converter.SQLData();
      DataSource ds = dbconnection.getMySQLDataSource();
      try
      {
         read.lock();
         String storedProcName = "invdb.sel_sec_assetclass_group";
         InvModelSP sp = new InvModelSP(ds, storedProcName, 0, 1);

         Map outMap = sp.assetDataFromDB(theme);
         if (outMap != null)
         {
            ArrayList<Map<String, Object>> rows;
            rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
            if (rows != null)
            {
               int i = 0;
               for (Map<String, Object> map : rows)
               {
                  Map rs = (Map) rows.get(i);
                  setAssetdata(convert.getStrData(rs.get("theme")),
                               convert.getStrData(rs.get("tradeCurrency")),
                               convert.getStrData(rs.get("assetclass")),
                               convert.getStrData(rs.get("displayName")),
                               convert.getDoubleData(rs.get("lowerBound")),
                               convert.getDoubleData(rs.get("upperBound")),
                               convert.getStrData(rs.get("ticker")),
                               convert.getDoubleData(rs.get("averageReturn")),
                               convert.getStrData(rs.get("color")),
                               convert.getDoubleData(rs.get("riskAdjustment")),
                               convert.getDoubleData(rs.get("endAllocation")),
                               convert.getIntData(rs.get("sortorder")));
                  i++;
               }
            }
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      finally
      {
         read.unlock();
      }
   }

   private void setSecurityData(String theme, String ticker,
                                String assetname,
                                double expenseRatio, double adv3Month,
                                double aum, double beta, double riskSTD,
                                double expectedReturn,
                                double ubConstraint, double lbConstraint, double yield,
                                int sortorder, String tradeCurrency)
   {
      try
      {
         String key = buildAssetKey(theme, assetname);
         if (!key.contains("DISCARD"))
         {
            PrimeAssetClassData primeassetdata = new PrimeAssetClassData
               (theme, assetname, ticker,
                expenseRatio, adv3Month, aum, beta,
                riskSTD, expectedReturn, ubConstraint, lbConstraint, yield,
                sortorder, tradeCurrency);

            assetDataMap.get(key).addPrimeAsset(ticker, primeassetdata);
         }
      }
      catch (Exception ex)
      {
      }
   }


   private void loadPrimeAssetsFromDB(String theme)
   {

      DBConnectionProvider dbconnection = DBConnectionProvider.getInstance();
      SQLData convert = new com.invessence.converter.SQLData();
      DataSource ds = dbconnection.getMySQLDataSource();
      try
      {
         read.lock();
         String storedProcName = "invdb.sel_sec_primeasset_group";
         InvModelSP sp = new InvModelSP(ds, storedProcName, 0, 2);

         Map outMap = sp.loadPrimeAssetsFromDB(theme);
         if (outMap != null)
         {
            ArrayList<Map<String, Object>> rows;
            rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
            if (rows != null)
            {
               int i = 0;
               for (Map<String, Object> map : rows)
               {
                  Map rs = (Map) rows.get(i);
                  setSecurityData(
                     convert.getStrData(rs.get("theme")), // String theme
                     convert.getStrData(rs.get("ticker")), // String ticker
                     convert.getStrData(rs.get("assetclass")),  // String assetclass
                     convert.getDoubleData(rs.get("expenseRatio")),  // double expenseRatio
                     convert.getDoubleData(rs.get("adv3months")), // double adv3Month
                     convert.getDoubleData(rs.get("aum")),          // double aum
                     convert.getDoubleData(rs.get("beta")),         // double beta
                     convert.getDoubleData(rs.get("securityRiskSTD")), // double riskSTD
                     convert.getDoubleData(rs.get("expectedReturn")), // double expectedReturn
                     convert.getDoubleData(rs.get("upperBound")), // double ubConstraint
                     convert.getDoubleData(rs.get("lowerBound")), // double lbConstraint
                     convert.getDoubleData(rs.get("yield")),//double yields
                     convert.getIntData(rs.get("sortorder")), //double sortorder
                     convert.getStrData(rs.get("tradeCurrency")) //String currency
                  );
                  i++;
               }
            }
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      finally
      {
         read.unlock();
      }
   }

   private void saveAssetWeights()
   {
      try
      {
         ArrayList asset = null;
         // DailyReturns dailyReturns = HistoricalDailyReturns.getInstance();
         CapitalMarket instanceOfCapitalMarket = new CapitalMarket();
         AssetParameters assetParameters = new AssetParameters();
         if (themeAssetMap.size() > 0)
         {
            for (String theme : themeAssetMap.keySet())
            {
               String[] indexFund = getAssetOrderedIndex(theme);
               if (indexFund == null)
               {
                  return;
               }
               logger.info("Asset Class Optimizer for theme: " + theme);
               String destCurrency = getAssetCurrency(theme);
               double[][] histReturns = historicaldailyreturns.getDailyReturnsArray(indexFund, destCurrency);
               if (histReturns != null)
               {
                  //double[] expectedReturnsOfFunds = assetParameters.expectedReturns(histReturns);  // This is based on historical returns
                  double[][] covarianceOfFunds = assetParameters.covarianceMatrix(histReturns);

                  // Here we evaluate the maximum expected return  of  the  Portfolio's  on
                  // the Efficient Frontier.

                  double[] lowerBound = getAssetOrderedLowerBound(theme);
                  double[] upperBound = getAssetOrderedUpperBound(theme);

                  instanceOfCapitalMarket.setConstraints(lowerBound, upperBound);

                  double[] expectedReturns = getAssetOrderedAvgReturns(theme);
                  double minReturn1 = instanceOfCapitalMarket.minFrontierReturn(expectedReturns);
                  double maxReturn1 = instanceOfCapitalMarket.maxFrontierReturn(expectedReturns);
                  instanceOfCapitalMarket.calculateEfficientFrontier(
                     minReturn1, // minimumExpectedReturn
                     maxReturn1, // maximumExpectedReturn
                     covarianceOfFunds,//Covariance matrix
                     expectedReturns, // expectedReturns
                     InvConst.ASSET_INTERPOLATION, // numberInterpolationPoints
                     InvConst.ASSET_PRECISION  // precision
                  );

                  //double[] risk1 = instanceOfCapitalMarket.getEfficientFrontierPortfolioRisks( covarianceOfFunds);
                  double[][] weights = instanceOfCapitalMarket.getEfficientFrontierAssetWeights();

                  //risk = instanceOfCapitalMarket.getEfficientFrontierPortfolioRisks(covarianceOfFunds);
                  double[] risk1 = instanceOfCapitalMarket.getEfficientFrontierPortfolioRisks(covarianceOfFunds);
                  double[] return1 = instanceOfCapitalMarket.getEfficientFrontierExpectedReturns();

                  int minRiskOffset = getMin(risk1);
                  double minRiskUtil = risk1[minRiskOffset];
                  minReturn1 = return1[minRiskOffset];

                  int maxReturnOffset = getMax(return1);
                  double maxRiskUtil = risk1[maxReturnOffset];
                  maxReturn1 = return1[maxReturnOffset];

                  instanceOfCapitalMarket.calculateEfficientFrontier(
                     //InvConst.MIN_CAPM_RETURNS,   // Minimum CAPM returns
                     //InvConst.MAX_CAPM_RETURNS,  // Maximum CAPM returns
                     minReturn1,   // Minimum CAPM returns
                     maxReturn1,  // Maximum CAPM returns
                     covarianceOfFunds,//Covariance matrix
                     expectedReturns, // expectedReturns
                     InvConst.PORTFOLIO_INTERPOLATION, // numberInterpolationPoints
                     InvConst.PORTFOLIO_PRECISION // precision
                  );

                  //risk = instanceOfCapitalMarket.getEfficientFrontierPortfolioRisks(covarianceOfFunds);
                  risk1 = instanceOfCapitalMarket.getEfficientFrontierPortfolioRisks(covarianceOfFunds);
                  return1 = instanceOfCapitalMarket.getEfficientFrontierExpectedReturns();

                  if (weights.length > 0)
                  {
                     int count = 0;
                     for (String assetname : getAdvisorOrdertedAssetList(theme))
                     {
                        String key = buildAssetKey(theme, assetname);
                        double[] wght = new double[weights.length];
                        for (int i = 0; i < weights.length; i++)
                        {
                           wght[i] = weights[i][count];
                        }

                        assetDataMap.get(key).setWeights(wght);
                        count++;
                     }
                  }

               }
            }
         }

      }
      catch (Exception e)
      {
         e.printStackTrace();
      }

   }

   private double[] getAssetOrderedLowerBound(String groupname)
   {
      String theme;
      read.lock();
      try
      {
         theme = checkThemeName(groupname);
         if (themeAssetMap.containsKey(theme))
         {
            double[] value = new double[themeAssetMap.get(theme).size()];
            for (int i = 0; i < themeAssetMap.get(theme).size(); i++)
            {
               String assetname = checkAssetName(themeAssetMap.get(theme).get(i));
               String key = buildAssetKey(theme, assetname);
               value[i] = assetDataMap.get(key).getLbConstraint();
            }
            return value;
         }
         else
         {
            return null;
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      finally
      {
         read.unlock();
      }
      return null;
   }

   private double[] getAssetOrderedUpperBound(String groupname)
   {
      String theme;
      read.lock();
      try
      {
         theme = checkThemeName(groupname);
         if (themeAssetMap.containsKey(theme))
         {
            double[] value = new double[themeAssetMap.get(theme).size()];
            for (int i = 0; i < themeAssetMap.get(theme).size(); i++)
            {
               String assetname = checkAssetName(themeAssetMap.get(theme).get(i));
               String key = buildAssetKey(theme, assetname);
               value[i] = assetDataMap.get(key).getUbConstraint();
            }
            return value;
         }
         else
         {
            return null;
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      finally
      {
         read.unlock();
      }
      return null;
   }

   private String[] getAssetOrderedIndex(String groupname)
   {
      String theme;
      read.lock();
      try
      {
         theme = checkThemeName(groupname);
         if (themeAssetMap.containsKey(theme))
         {
            String[] index = new String[themeAssetMap.get(theme).size()];
            int i = 0;
            for (String assetname : themeAssetMap.get(theme))
            {
               String key = buildAssetKey(theme, assetname);
               index[i++] = assetDataMap.get(key).getIndex();
            }
            return index;
         }
         else
         {
            return null;
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      finally
      {
         read.unlock();
      }
      return null;
   }

   private String getAssetCurrency(String groupname)
   {
      String theme;
      String currency = "USD";
      try
      {
         theme = checkThemeName(groupname);
         if (themeAssetMap.containsKey(theme))
         {
            int i = 0;
            for (String assetname : themeAssetMap.get(theme))
            {
               String key = buildAssetKey(theme, assetname);
               currency = assetDataMap.get(key).getCurrency();
               break;
            }
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      return currency;
   }


   private void savePrimeAssetWeights()
   {
      String groupkey = null;
      // DailyReturns dailyReturns = DailyReturns.getInstance();
      try
      {

         Integer numofTicker;
         Integer numofPrimeAssets;
         for (String theme : themeAssetMap.keySet())
         {
            for (String assetName : themeAssetMap.get(theme))
            {
               logger.info("Primeasset Class Optimizer for theme: " + theme + " assetclass: " + assetName);
               String key = buildAssetKey(theme, assetName);
               String destCurrency = getAssetCurrency(theme);
               ArrayList<PrimeAssetClassData> pacd = assetDataMap.get(key).getOrderedPrimeAssetData();
               if (pacd != null && pacd.size() > 0)
               {
                  numofTicker = pacd.size();
                  CapitalMarket capMarketData = null;
                  double[][] mrData = null;
                  double[] historicalReturns = new double[numofTicker];
                  double[] lbConstraints = new double[numofTicker];
                  double[] ubConstraints = new double[numofTicker];
                  double[] secRisk = new double[numofTicker];
                  double[] yield = new double[numofTicker];
                  String[] indexticker = new String[numofTicker];

                  if (numofTicker >= 1)
                  {
                     for (int j = 0; j < numofTicker; j++)
                     {
                        lbConstraints[j] = pacd.get(j).getLbConstraint();
                        ubConstraints[j] = pacd.get(j).getUbConstraint();
                        historicalReturns[j] = pacd.get(j).getExpectedReturn();
                        secRisk[j] = pacd.get(j).getRiskSTD();
                        yield[j] = pacd.get(j).getYield();
                        indexticker[j] = pacd.get(j).getTicker();

                        /*if(theme.toUpperCase().contains("INCOME"))
                        {
                           if (assetName.toUpperCase().startsWith("BOND"))

                              historicalReturns[j]= historicalReturns[j] * yield[j];
                        }*/
                     }

                     mrData = historicaldailyreturns.getDailyReturnsArray(indexticker, destCurrency);
                     capMarketData = getCapitalMarketData(indexticker, lbConstraints, ubConstraints, historicalReturns, mrData);
                  }

                  assetDataMap.get(key).setPrimeAssetreturns(getPortfolioAssetExpectedReturns(capMarketData, historicalReturns, indexticker.length));
                  assetDataMap.get(key).setPrimeAssetweights(getPortfolioWeights(capMarketData, indexticker.length));
                  assetDataMap.get(key).setPrimeAssetrisk(getPortfolioAssetRisk(capMarketData, numofTicker, mrData, secRisk[0]));
               }
            }
         }
      }
      catch (Exception ex)
      {

      }
   }

   public double getRiskAdjustment(String theme, String assetName)
   {

      String key;
      read.lock();
      try
      {
         double value = 0.0;

         key = buildAssetKey(checkThemeName(theme), assetName);
         value = assetDataMap.get(key).getRisk_adjustment();


         return value;

      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      finally
      {
         read.unlock();
      }
      return 0.0;

   }

   public double getEnd_allocation(String theme, String assetName)
   {

      String key;
      read.lock();
      try
      {
         double value = 0.0;

         key = buildAssetKey(checkThemeName(theme), assetName);
         value = assetDataMap.get(key).getEnd_allocation();

         return value;

      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      finally
      {
         read.unlock();
      }
      return 0.0;

   }

   public double[] getAssetOrderedAvgReturns(String theme)
   {

      String key;
      read.lock();
      try
      {
         double[] value = new double[themeAssetMap.get(checkThemeName(theme)).size()];
         int i = 0;
         for (String assetName : themeAssetMap.get(checkThemeName(theme)))
         {
            key = buildAssetKey(checkThemeName(theme), assetName);
            value[i++] = assetDataMap.get(key).getAverageReturn();
         }

         return value;

      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      finally
      {
         read.unlock();
      }
      return null;

   }

   public String[] getAssetOrderedColor(String theme)
   {
      String key;
      read.lock();
      try
      {
         String[] value = new String[themeAssetMap.get(checkThemeName(theme)).size()];
         int i = 0;
         for (String assetName : themeAssetMap.get(checkThemeName(theme)))
         {
            key = buildAssetKey(checkThemeName(theme), assetName);
            value[i++] = assetDataMap.get(key).getColor();
         }

         return value;

      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      finally
      {
         read.unlock();
      }
      return null;
   }

   public double[] getAssetOrderedWeight(String theme, int offset)
   {
      String key;
      read.lock();
      try
      {
         double[] value = new double[themeAssetMap.get(checkThemeName(theme)).size()];
         int i = 0;
         for (String assetName : themeAssetMap.get(checkThemeName(theme)))
         {
            key = buildAssetKey(checkThemeName(theme), assetName);
            value[i++] = assetDataMap.get(key).getWeight(offset);
         }

         return value;

      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      finally
      {
         read.unlock();
      }
      return null;
   }


   private CapitalMarket getCapitalMarketData(String[] tickers,
                                              double[] lbConstraints, double[] ubConstraints,
                                              double[] expectedReturnsOfFunds, double[][] mrData)
   {

      double[][] weights;

      double[] risk = null;
      double[] returns = null;
      try
      {

         // Should never happen
         if (tickers == null || tickers.length < 1)
         {
            return null;
         }

         CapitalMarket instanceOfCapitalMarket = new CapitalMarket();
         EasyOptimal instanceOfEasyOptimal = new EasyOptimal();

         AssetParameters assetParameters = new AssetParameters();

         if (tickers.length > 1)
         {
            double[][] covarianceOfFunds = assetParameters.covarianceMatrix(mrData);
            // Here we evaluate the maximum expected return  of  the  Portfolio's  on
            // the Efficient Frontier.
            double maxReturn = instanceOfCapitalMarket.maxFrontierReturn(expectedReturnsOfFunds);

            // Here we evaluate the minimum expected return of the Portfolio's on  the
            // Efficient Frontier.
            double minReturn = instanceOfCapitalMarket.minFrontierReturn(expectedReturnsOfFunds);
            minReturn = (minReturn < 0) ? 0 : minReturn;

            //Add upperbound and lowerbound constraints
            instanceOfCapitalMarket.setConstraints(lbConstraints, ubConstraints);

            instanceOfCapitalMarket.calculateEfficientFrontier(
               //InvConst.MIN_CAPM_RETURNS,   // Minimum CAPM returns
               //InvConst.MAX_CAPM_RETURNS,  // Maximum CAPM returns
               minReturn,   // Minimum CAPM returns
               maxReturn,  // Maximum CAPM returns
               covarianceOfFunds,//Covariance matrix
               expectedReturnsOfFunds, // expectedReturns
               InvConst.PORTFOLIO_INTERPOLATION, // numberInterpolationPoints
               InvConst.PORTFOLIO_PRECISION // precision
            );

            //risk = instanceOfCapitalMarket.getEfficientFrontierPortfolioRisks(covarianceOfFunds);
            double[] risk1 = instanceOfCapitalMarket.getEfficientFrontierPortfolioRisks(covarianceOfFunds);
            double[] return1 = instanceOfCapitalMarket.getEfficientFrontierExpectedReturns();

            int minRiskOffset = getMin(risk1);
            double minRiskUtil = risk1[minRiskOffset];
            double minReturnUtil = return1[minRiskOffset];

            int maxReturnOffset = getMax(return1);
            double maxRiskUtil = risk1[maxReturnOffset];
            double maxReturnUtil = return1[maxReturnOffset];

            //double[] returnUtil = new double[] {minReturnUtil,maxReturnUtil};
            //double[] riskUtil = new double[] {minRiskUtil,maxReturnUtil};

            //double[] markUtility1 = instanceOfEasyOptimal.markowitzUtility(
            //   returnUtil,riskUtil, lbConstraints, ubConstraints,mrData,100,0.000000000001);

            instanceOfCapitalMarket.calculateEfficientFrontier(
               //InvConst.MIN_CAPM_RETURNS,   // Minimum CAPM returns
               //InvConst.MAX_CAPM_RETURNS,  // Maximum CAPM returns
               minReturnUtil,   // Minimum CAPM returns
               maxReturnUtil,  // Maximum CAPM returns
               covarianceOfFunds,//Covariance matrix
               expectedReturnsOfFunds, // expectedReturns
               InvConst.PORTFOLIO_INTERPOLATION, // numberInterpolationPoints
               InvConst.PORTFOLIO_PRECISION // precision
            );

            //risk = instanceOfCapitalMarket.getEfficientFrontierPortfolioRisks(covarianceOfFunds);
            risk1 = instanceOfCapitalMarket.getEfficientFrontierPortfolioRisks(covarianceOfFunds);
            return1 = instanceOfCapitalMarket.getEfficientFrontierExpectedReturns();

            int j = 0;
         }
         return instanceOfCapitalMarket;
      }
      catch (Exception e)
      {
         e.printStackTrace();
         weights = new double[1][1];
         weights[0][0] = 1.0;
         return null;
      }
   }

   public int getMax(double[] inputArray)
   {
      Double maxValue = inputArray[0];
      int offset = 0;
      for (int i = 0; i < inputArray.length; i++)
      {
         if (inputArray[i] > maxValue)
         {
            maxValue = inputArray[i];
            offset = i;
         }
      }
      //return maxValue;
      if (offset > 99)
      {
         offset = 99;
      }
      return offset;
   }

   // Method for getting the minimum value
   public int getMin(double[] inputArray)
   {
      double minValue = inputArray[0];
      int offset = 0;
      for (int i = 0; i < inputArray.length; i++)
      {
         if (inputArray[i] < minValue)
         {
            minValue = inputArray[i];
            offset = i;
         }
      }
      //return minValue;
      if (offset > 99)
      {
         offset = 99;
      }
      return offset;
   }

   private double[][] getPortfolioWeights(CapitalMarket capMarketData, Integer numTickers)
   {
      double[][] weights;

      try
      {
         if (numTickers == 1)
         {
            weights = new double[InvConst.PORTFOLIO_INTERPOLATION][numTickers];
            for (int i = 0; i < InvConst.PORTFOLIO_INTERPOLATION; i++)
            {
               weights[i][0] = 1.0;
            }
            return weights;
         }
         else
         {
            weights = capMarketData.getEfficientFrontierAssetWeights();
            return weights;
         }
      }
      catch (Exception e)
      {

         e.printStackTrace();

         weights = new double[1][1];
         weights[0][0] = 1.0;
         return weights;

      }
   }

   private double[] getPortfolioAssetRisk(CapitalMarket capMarketData, Integer numTickers, double[][] mrData, double secRisk)
   {
      double[] risk = null;

      AssetParameters assetParameters = new AssetParameters();

      try
      {
         if (numTickers == 1)
         {
            risk = new double[InvConst.PORTFOLIO_INTERPOLATION];
            for (int i = 0; i < InvConst.PORTFOLIO_INTERPOLATION; i++)
            {
               risk[i] = secRisk;
            }
            return risk;
         }
         else
         {

            double[][] covarianceOfFunds = assetParameters.covarianceMatrix(mrData);
            risk = capMarketData.getEfficientFrontierPortfolioRisks(covarianceOfFunds);
            for (int i = 0; i < risk.length; ++i)
            {
               risk[i] = StrictMath.sqrt(253.0) * risk[i];
            }
         }
         return risk;

      }
      catch (Exception e)
      {

         e.printStackTrace();

         risk = new double[1];
         risk[0] = 0.0;
         return risk;

      }
   }

   private double[] getPortfolioAssetExpectedReturns(CapitalMarket capMarketData, double[] histReturns, Integer numTickers)
   {
      double[] assetReturns = null;

      try
      {
         if (numTickers == 1)
         {
            assetReturns = new double[InvConst.PORTFOLIO_INTERPOLATION];
            for (int j = 0; j < InvConst.PORTFOLIO_INTERPOLATION; j++)
            {
               assetReturns[j] = histReturns[0];
            }
            return assetReturns;
         }
         else
         {
            assetReturns = capMarketData.getEfficientFrontierExpectedReturns();
         }

         return assetReturns;


      }
      catch (Exception e)
      {

         e.printStackTrace();

         assetReturns = new double[1];
         assetReturns[0] = 0.0;
         return assetReturns;

      }
   }

   private double[][] getCoVariance(double[][] historicalReturns) throws Exception
   {
      AssetParameters instanceOfAssetParameters = new AssetParameters();

      double[][] coVarMatrix = instanceOfAssetParameters.covarianceMatrix(historicalReturns);

      return coVarMatrix;
   }

   public HolisticOptimizedData getHolisticWeight(String theme, String tickers[], String dest_currency,
                                                  double[][] targetPAssetAllocation, Map<String, Double> primeAssetMap)
   {

         /*ArrayList <String> tickers = new ArrayList<String>();
         int j = 0;
         for (String theme: themeAssetMap.keySet())
         {
            for (String assetName : themeAssetMap.get(theme))
            {
               String key = buildAssetKey(theme, assetName);
               ArrayList<PrimeAssetClassData> pacd = assetDataMap.get(key).getOrderedPrimeAssetData();
               if (pacd != null && pacd.size() > 0)
               {
                  tickers.add(pacd.get(j++).getTicker());
               }
            }
         }*/

      //To use these returns, call getDailyReturns with the same tickers;
      // optimizer.loadFundDataFromDB(tickers);
      HolisticOptimizedData hodata = new HolisticOptimizedData();
      hoptimizer.loadAllPrimeAssetMap(getPrimeAssetDataList(theme));
      hoptimizer.loadFundDataFromDB(theme, tickers);
      CapitalMarket instanceOfCapitalMarket = new CapitalMarket();
      double[][] mrData = historicaldailyreturns.getDailyReturnsArray(tickers, dest_currency);
      double[][] coVarFunds = hoptimizer.getCoVarFunds(mrData);
      double[][] weights = hoptimizer.getWeights(instanceOfCapitalMarket, tickers, mrData, coVarFunds);
      double[] risk = instanceOfCapitalMarket.getEfficientFrontierPortfolioRisks(coVarFunds);
      double[] portReturns = instanceOfCapitalMarket.getEfficientFrontierExpectedReturns();

      //Compute minimum error vector by comparing to target and find the best weight fit
      double[] errorDiff = hoptimizer.getFundErrorVectorArray(tickers, targetPAssetAllocation, weights, primeAssetMap);

      MergeSort mms = MergeSort.getInstance();
      int[] fundOffset = new int[errorDiff.length];
      for (int i = 0; i < errorDiff.length; i++)
      {
         fundOffset[i] = i;
      }

      //Sort the squared error terms, and also the index which will point to the weights, risk and returns.
      mms.sort(errorDiff, fundOffset);

      //PRIME ASSET exposure can not be larger than the account exposure.
      //If PRIME ASSET funds are in IRA and it has only a 20% value than the upperbound for these
      //funds must be 0.2 or below combined
      //May have to throw out some solutions of efficient frontier where the combined numbers are higher
      //than 20%
      //Also we mau want to consturct a fundConstaint matrix similar to accountConstraint.


      double[] optFundWeight = new double[weights[0].length];
      for (int i = 0; i < weights[0].length; i++)
      {
         optFundWeight[i] = weights[fundOffset[0]][i];
      }

      hodata.setRbsatickers(tickers);
      hodata.setOffset(fundOffset[0]);
      hodata.setOptimizedWeights(optFundWeight);
      hodata.setRisk(risk);
      hodata.setPortReturns(portReturns);
      hodata.setCoVarOfFunds(coVarFunds);
      hodata.setWeights(weights);
      hodata.setMinSortedError(errorDiff);
      hodata.setFundOffset(fundOffset);

      return hodata;
   }

   public HolisticModelOptimizer getHoptimizer()
   {
      return hoptimizer;
   }

   public Integer getAssetAllocationPoints()
   {
      return InvConst.ASSET_INTERPOLATION - 1;
   }

   public Integer getPrimeAssetAllocationPoints()
   {
      return InvConst.PORTFOLIO_INTERPOLATION - 1;
   }


   private void loadSecurityData()
   {
      DBConnectionProvider dbconnection = DBConnectionProvider.getInstance();
      SQLData convert = new com.invessence.converter.SQLData();
      DataSource ds = dbconnection.getMySQLDataSource();
      try
      {
         read.lock();
         String storedProcName = "invdb.sel_sec_volatility";
         InvModelSP sp = new InvModelSP(ds, storedProcName, 0, 1);

         Map outMap = sp.assetDataFromDB(null);
         if (outMap != null)
         {
            ArrayList<Map<String, Object>> rows;
            rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
            if (rows != null)
            {
               int i = 0;
               for (Map<String, Object> map : rows)
               {
                  Map rs = (Map) rows.get(i);
                  SecurityData secdata = new
                     SecurityData(null // advisor
                     , convert.getStrData(rs.get("theme"))
                     , convert.getStrData(rs.get("ticker"))
                     , convert.getStrData(rs.get("name"))
                     , convert.getStrData(rs.get("assetclass"))
                     , convert.getStrData(rs.get("primeassetclass")) // String primeassetclass
                     , convert.getStrData(rs.get("type")) // String type
                     , convert.getStrData(rs.get("style")) // String style,
                     , 0.0 // double dailyprice
                     , 0 // int sortorder
                     , 0.0 // double rbsaWeight,
                     , convert.getStrData(rs.get("assetcolor")) // String assetcolor
                     , convert.getStrData(rs.get("primeassetcolor")) // String primeassetcolor
                     , convert.getStrData(rs.get("assetclass")) // String securityAssetClass
                     , convert.getStrData(rs.get("subassetName")) // String securitySubAssetClass
                     , convert.getStrData(rs.get("isin")) // String isin
                     , convert.getStrData(rs.get("cusip")) // String cusip
                     , convert.getStrData(rs.get("ric")) // String ric,
                     , convert.getStrData(rs.get("tradeCurrency")) // String tradeCurrency
                     , convert.getStrData(rs.get("settleCurrency")) // String settleCurrency
                     , null// Double exchangeRate
                     , null // Double settlePrice
                  );

                  String key = buildSecurityKey(secdata.getTicker(), secdata.getSettleCurrency());
                  securityDataMap.put(key, secdata);

                  i++;
               }
            }
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
      finally
      {
         read.unlock();
      }

   }

   private Double calculateStdDev(double numArray[])
   {
      Double sum = 0.0, standardDeviation = 0.0;

      if (numArray != null && numArray.length > 0)
      {

         for (Double num : numArray)
         {
            sum += num;
         }

         Double mean = sum / numArray.length;

         for (Double num : numArray)
         {
            standardDeviation += Math.pow(num - mean, 2);
         }

         return Math.sqrt(standardDeviation / numArray.length);
      }
      else
      {
         return 0.0;
      }
   }


   public void calcSecurityVolatality()
   {
      Double vol = 0.0;

      try
      {
         if (securityDataMap.size() > 0)
         {
            for (SecurityData secdata : securityDataMap.values())
            {
               double[] histdata = historicaldailyreturns.getDailyReturnsArraybyTicker(secdata.getTicker(), secdata.getSettleCurrency());
               if (histdata != null)
               {
                  secdata.setVolatility(calculateStdDev(histdata));
               }
            }
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
   }

   public SecurityData getSecurityData(String ticker, String currency)
   {
      String key = buildSecurityKey(ticker, currency);
      if (securityDataMap.containsKey(key))
      {
         return securityDataMap.get(key);
      }
      return null;
   }

}
