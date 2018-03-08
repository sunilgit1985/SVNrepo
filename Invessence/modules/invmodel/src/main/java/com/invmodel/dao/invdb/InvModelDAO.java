package com.invmodel.dao.invdb;

import java.util.*;
import javax.sql.DataSource;

import com.invessence.converter.SQLData;
import com.invmodel.asset.data.Asset;
import com.invmodel.dao.*;
import com.invmodel.position.data.*;
import com.invmodel.portfolio.data.*;
import com.invmodel.rebalance.data.*;
import com.invmodel.inputData.*;
import com.invmodel.risk.data.*;
import org.springframework.jdbc.core.support.JdbcDaoSupport;


public class InvModelDAO extends JdbcDaoSupport
{
   private static InvModelDAO instance = null;
   DBConnectionProvider dbconnection = DBConnectionProvider.getInstance();
   SQLData convert = new SQLData();
   DataSource ds = dbconnection.getMySQLDataSource();

   public CurrentHolding loadDBHolding(Long logonid, Long p_acctnum, String advisor, String rep)
   {
      // DataSource ds = getDs();
      String storedProcName = "sel_position";
      InvModelSP sp = new InvModelSP(ds, storedProcName, 1, 0);
      CurrentHolding currentHolding = new CurrentHolding();
      currentHolding.setHoldingList(new ArrayList<HoldingData>());

      Map outMap = sp.loadDBData(logonid, p_acctnum, advisor, rep);

      Double longGain = 0.0,
         longLoss= 0.0,
         shortGain = 0.0,
         shortLoss = 0.0;

      if (outMap != null)
      {
         ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
         int i = 0;
         Double cashAvailable = 0.0;
         for (Map<String, Object> map : rows)
         {
            Map rs = (Map) rows.get(i);
            String ticker =  convert.getStrData(rs.get("symbol"));
            // Ticker test is added, because we are loading some data for display purpose.
            if (ticker == null || ticker.length() == 0)
               continue;

            // data is good.
            HoldingData data = new HoldingData();
            if (i == 0) {
               currentHolding.setLogonid(logonid);
               currentHolding.setAcctnum(convert.getLongData(rs.get("acctnum")));
               currentHolding.setClientAccountID(convert.getStrData(rs.get("clientAccountID")));
               currentHolding.setTotalFees(convert.getDoubleData(rs.get("ytdinvoiceFee")));
            }
            data.setTradeCurrency(convert.getStrData(rs.get("tradeCurrency")));
            data.setTicker(ticker);
            data.setAssetclass(convert.getStrData(rs.get("assetclass")));
            data.setSubclass(convert.getStrData(rs.get("subclass")));
            data.setDescription(convert.getStrData(rs.get("description")));
            data.setSide(convert.getStrData(rs.get("side")));
            data.setQty(convert.getDoubleData(rs.get("quantity")));
            data.setCostBasisPrice(convert.getDoubleData(rs.get("costBasisPrice")));
            data.setCostBasisMoney(convert.getDoubleData(rs.get("costBasisMoney")));
            data.setMarkPrice(convert.getDoubleData(rs.get("markPrice")));
            data.setPositionValue(convert.getDoubleData(rs.get("positionValue")));
            data.setFifoPnlUnrealized(convert.getDoubleData(rs.get("fifoPnlUnrealized")));
            data.setLevelOfDetail(convert.getStrData(rs.get("levelOfDetail")));
            data.setColor(convert.getStrData(rs.get("color")));
            data.setWeight(convert.getDoubleData(rs.get("weight")));
            data.setYield(convert.getDoubleData(rs.get("yield")));
            data.setExpenseRatio(convert.getDoubleData(rs.get("expenseRatio")));
            data.setRisk(convert.getDoubleData(rs.get("risk")));
            data.setExchangeRate(convert.getDoubleData(rs.get("exchangeRate")));
            data.setSettleQty(convert.getDoubleData(rs.get("settleQty")));
            data.setSettlePosition(convert.getDoubleData(rs.get("settleMoney")));
            data.setRelShortGain(convert.getDoubleData(rs.get("shortGain")));
            data.setRelShortLoss(convert.getDoubleData(rs.get("shortLoss")));
            data.setRelLongGain(convert.getDoubleData(rs.get("longGain")));
            data.setRelLongLoss(convert.getDoubleData(rs.get("longLoss")));

            // Revised by Prashant 3/7/2018
            currentHolding.addHoldingData(data);
            i++;
         }
      }

      return currentHolding;

   }

   public List<ProfileData> loadCustomerData4Rebal(Long logonid, Long acctnum, String filter) {
      // DataSource ds = getDs();
      InvModelSP sp = new InvModelSP(ds, "sel_collectTradeCustomerProfile",1, 1);
      List<ProfileData> profileList = new ArrayList<ProfileData>();
      Map outMap = sp.collectTradeCustomerProfile(logonid, acctnum);
      try {
         if (outMap != null)
         {
            ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
            int i = 0;
            for (Map<String, Object> map : rows)
            {
               Map rs = (Map) rows.get(i);
               ProfileData data = new ProfileData();
               String advisor = convert.getStrData(rs.get("advisor"));
               Long dbacctnum = convert.getLongData(rs.get("acctnum"));

               // Get UserRisk Info first...
               UserRiskProfile userRiskProfile = new UserRiskProfile(advisor, dbacctnum);
               data.setRiskProfile(userRiskProfile);

               data.setLogonid(convert.getLongData(rs.get("logonid")));
               data.setAcctnum(dbacctnum);
               data.setClientAccountID(convert.getStrData(rs.get("clientAccountID")));

               data.setAdvisor(advisor);
               data.setTheme(convert.getStrData(rs.get("theme")));
               data.setAccountType(convert.getStrData(rs.get("accttype")));
               data.setAge(convert.getIntData(rs.get("age")));
               data.setHorizon(convert.getIntData(rs.get("horizon")));
               Double investment = convert.getDoubleData(rs.get("investment"));
               data.setActualInvestment(investment);
               userRiskProfile.setTotalInvestment(investment);
               data.setAccountTaxable(userRiskProfile.getDefaultBooleanValue(RiskConst.TAXABLE,false));
               profileList.add(i, data);
               i++;
            }
         }
         return profileList;
      }
      catch (Exception ex) {
         ex.printStackTrace();
      }
      return null;
   }

   public Map<String, Asset> getAllocation(Long acctnum) {
      // DataSource ds = getDs();
      InvModelSP sp = new InvModelSP(ds, "sel_asset_alloc",1, 2);
      Map outMap = sp.collectAllocation(acctnum);
      try {
         if (outMap != null)
         {
            ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
            int i = 0;
            Map<String, Asset> uaseetdata = new HashMap<String, Asset>();
            String assetname;
            Boolean modelflag = false;
            Double savedweight = 0.0;
            for (Map<String, Object> map : rows)
            {
               Map rs = (Map) rows.get(i);
               if (! convert.getStrData(rs.get("allocationmodel")).equalsIgnoreCase("D"))
                  modelflag = true;
               assetname = convert.getStrData(rs.get("assetclass"));
               savedweight =  convert.getDoubleData(rs.get("weight"));
               savedweight = savedweight / 100.00;
               uaseetdata.put(assetname,
                              new Asset(assetname,
                                        "",
                                        savedweight,
                                        0.0,
                                        0.0,
                                        0.0,
                                        0.0,
                                        0.0));

               i++;
            }
            return (uaseetdata);
         }
      }
      catch (Exception ex) {
         ex.printStackTrace();
      }
      return null;
   }

   public List<PortfolioSubclass> getExcludedSubclass(Long acctnum) {
      // DataSource ds = getDs();
      InvModelSP sp = new InvModelSP(ds, "sel_ExcludedSubclass",1, 3);
      Map outMap = sp.collectSubClassExclusionList(acctnum);
      String asset;
      try {
         if (outMap != null)
         {
            ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
            int i = 0;
            List<PortfolioSubclass> excludeList = new ArrayList<PortfolioSubclass>();
            Portfolio pf = new Portfolio();
            for (Map<String, Object> map : rows)
            {
               Map rs = (Map) rows.get(i);
               PortfolioSubclass dp = new PortfolioSubclass();
               String assetname = convert.getStrData(rs.get("assetclass"));
               String subclassname = convert.getStrData(rs.get("subclass"));

               dp.setName(pf.getsubclasskey(assetname,subclassname));
               dp.setParentclass(assetname);
               dp.setSubasset(subclassname);
               excludeList.add(dp);
               i++;
            }
            return (excludeList);
         }
      }
      catch (Exception ex) {
         ex.printStackTrace();
      }
      return null;
   }

   public Map<String, ArrayList> loadDBExecutedTrades(Long acctnum)
   {
      // DataSource ds = getDs();
      String storedProcName = "sel_executedTrades";
      InvModelSP sp = new InvModelSP(ds, storedProcName,1, 4);
      Map<String, ArrayList> tradeMap = new HashMap<String, ArrayList>();

      ArrayList<ExecutedTradesData> executedList;
      Map outMap = sp.loadDBExecutedTrades(acctnum);
      if (outMap != null)
      {
         ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
         int i = 0;
         for (Map<String, Object> map : rows)
         {
            Map rs = (Map) rows.get(i);
            String ticker = convert.getStrData(rs.get("symbol"));
            if (tradeMap.containsKey(ticker)) {
               executedList = tradeMap.get(ticker);
               if (executedList == null)
                  executedList = new ArrayList<ExecutedTradesData>();
            }
            else {
               executedList = new ArrayList<ExecutedTradesData>();
            }

            ExecutedTradesData executedTradedata = new ExecutedTradesData(
               convert.getLongData(rs.get("acctnum")),
               convert.getStrData(rs.get("clientAccountID")),
               convert.getStrData(rs.get("ticker")),
               convert.getStrData(rs.get("confirmNumber")),
               convert.getStrData(rs.get("transactionSource")),
               convert.getStrData(rs.get("transactionType")),
               convert.getStrData(rs.get("transactionStatus")),
               convert.getStrData(rs.get("controlNumber")),
               convert.getDoubleData(rs.get("qty")),
               convert.getDoubleData(rs.get("tradePrice")),
               convert.getDoubleData(rs.get("netAmount")),
               convert.getDoubleData(rs.get("commission")),
               convert.getDoubleData(rs.get("otherFees")),
               convert.getStrData(rs.get("tradeDate")),
               convert.getStrData(rs.get("settDate")),
               convert.getStrData(rs.get("voidDate")),
               convert.getStrData(rs.get("currencyPrimary")),
               convert.getDoubleData(rs.get("fxRateToBase")),
               convert.getIntData(rs.get("daysExecuted"))
            );

            if (! tradeMap.containsKey(ticker))
               tradeMap.put(ticker,executedList);
            i++;
         }
      }
      return tradeMap;

   }


   public Map<String, SecurityTLHData> loadTLHSecurities()
   {
      // DataSource ds = getDs();
      String storedProcName = "sel_taxHarvestingSecurities";
      InvModelSP sp = new InvModelSP(ds, storedProcName,1, 99);
      Map<String, SecurityTLHData> tlhMap = new HashMap<String, SecurityTLHData>();

      Map outMap = sp.loadSecurityData();
      SecurityTLHData sd = null;
      if (outMap != null)
      {
         ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
         int i = 0;
         for (Map<String, Object> map : rows)
         {
            Map rs = (Map) rows.get(i);
            String ticker = convert.getStrData(rs.get("ticker"));
            if (! tlhMap.containsKey(ticker))
               sd = new SecurityTLHData();
            else
               sd = tlhMap.get(ticker);
            String tlhticker = convert.getStrData(rs.get("tlhticker"));
            sd.setTicker(ticker);
            sd.addTLHData(tlhticker,
                          convert.getStrData(rs.get("active")),
                          convert.getDoubleData(rs.get("price")),
                          convert.getDoubleData(rs.get("weight")),
                          convert.getStrData(rs.get("type")),
                          convert.getStrData(rs.get("style")),
                          convert.getStrData(rs.get("assetclass")),
                          convert.getStrData(rs.get("subclass"))
            );
            tlhMap.put(ticker,sd);
            i++;
         }
      }
      return tlhMap;

   }

   public Map<String, SecurityTLHData> loadTLHReverseSecurities()
   {
      // DataSource ds = getDs();
      String storedProcName = "sel_taxReverseSecurities";
      InvModelSP sp = new InvModelSP(ds, storedProcName,1, 99);
      Map<String, SecurityTLHData> tlhMap = new HashMap<String, SecurityTLHData>();
      ArrayList<TLHData>  tlhdataList = null;


      Map outMap = sp.loadSecurityData();
      if (outMap != null)
      {
         ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
         int i = 0;
         for (Map<String, Object> map : rows)
         {
            Map rs = (Map) rows.get(i);
            SecurityTLHData sd = new SecurityTLHData();
            String ticker = convert.getStrData(rs.get("ticker"));
            String tlhticker = convert.getStrData(rs.get("tlhticker"));
            sd.setTicker(ticker);
            sd.addTLHData(tlhticker,
                          convert.getStrData(rs.get("active")),
                          convert.getDoubleData(rs.get("price")),
                          convert.getDoubleData(rs.get("weight")),
                          convert.getStrData(rs.get("type")),
                          convert.getStrData(rs.get("style")),
                          convert.getStrData(rs.get("assetclass")),
                          convert.getStrData(rs.get("subclass"))
            );

            tlhMap.put(ticker,sd);
            i++;
         }
      }
      return tlhMap;

   }

   public void deleteTradeData(Long acctnum) {
      // DataSource ds = getDs();
      String storedProcName = "del_user_trade_preprocess";
      InvModelSP sp = new InvModelSP(ds, storedProcName,1, 11);
      sp.deleteTradeData(acctnum);
      }


   public void saveTradeData(ArrayList<UserTradePreprocess> rebalanceTradeData) {
      // DataSource ds = getDs();
      String storedProcName = "save_user_trade_preprocess";
      InvModelSP sp = new InvModelSP(ds, storedProcName,1, 10);
      for (UserTradePreprocess tData : rebalanceTradeData) {
         sp.saveTradeData(tData);
      }
   }

   public Map<Long, FamilyAccount> loadAllExternalPositions(Long familyacctnum)
   {
      // DataSource ds = getDs();

      // Had to remove this method for now.  Will have to use the standard sel_position to collect all data
      // based on logonid (As defined as master account holder or family account. -- Prashant Oct-30-2017
      String storedProcName = "sel_position";
      Map<Long, FamilyAccount> currentHolding = new HashMap<Long, FamilyAccount>();
/*
      InvModelSP sp = new InvModelSP(ds, storedProcName, 1, 12);

      Map outMap = sp.loadAllExternalPositions(familyacctnum);

      if (outMap != null)
      {
         ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
         if (rows != null)
         {
            int i = 0;
            Long datafamilyacctnum = null;
            FamilyAccount pd = null;
            for (Map<String, Object> map : rows)
            {
               Map rs = (Map) rows.get(i);
               datafamilyacctnum = convert.getLongData(rs.get("FamilyAccountNumber"));
               if (currentHolding.containsKey(datafamilyacctnum))
               {
                  pd = currentHolding.get(datafamilyacctnum);
               }
               else
               {
                  pd = new FamilyAccount(datafamilyacctnum);
               }

               boolean manage;
               if (convert.getStrData(rs.get("manage")).toUpperCase().startsWith("Y"))
                  manage = true;
               else
                  manage = false;

               pd.addInfo(convert.getStrData(rs.get("clientAccountID")),
                          0L,
                          convert.getStrData(rs.get("symbol")),
                          convert.getStrData(rs.get("description")),
                          "",
                          convert.getStrData(rs.get("assetClass")),
                          convert.getStrData(rs.get("assetClass")),
                          convert.getIntData(rs.get("quantity")),
                          convert.getDoubleData(rs.get("markPrice")),
                          convert.getDoubleData(rs.get("positionValue")),
                          convert.getDoubleData(rs.get("costBasisMoney")),
                          convert.getDoubleData(rs.get("fifoPnlUnrealized")),
                          0.0,
                          manage
               );
               currentHolding.put(datafamilyacctnum,pd);
               i++;
            }
         }
      }
*/
      return currentHolding;
   }

}