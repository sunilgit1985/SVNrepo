package com.invessence.dao.admin;

import java.util.*;
import javax.faces.bean.*;
import javax.sql.DataSource;

import com.invessence.converter.SQLData;
import com.invessence.data.*;
import com.invessence.data.common.TradeClientData;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

@ManagedBean(name = "adminDAO")
@ApplicationScoped
public class AdminDAO extends JdbcDaoSupport
{
   SQLData convert = new SQLData();

   public void updateProfile(InvessenceData invdata)
   {
      try
      {
         DataSource ds = getDataSource();
         AdminSP sp = new AdminSP(ds, "admin_updateProfile",0);
         sp.updateProfile(invdata.getAcctnum(),
                          invdata.getRiskIndex().intValue(),
                          invdata.getInitialInvestment(),
                          invdata.getKeepliquid(),
                          invdata.getTradepreference());
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   public void addDelIBPair(String action, Long acctnum, String ibstatus, String ibacctnum)
   {
      try
      {
         DataSource ds = getDataSource();
         AdminSP sp = new AdminSP(ds, "admin_sp_IB_Accounts_addmoddel",1);
         sp.addDelIBPair(action, acctnum, ibstatus, ibacctnum);
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   public void saveNextRebalDate(String nextRebaldate)
   {
      try
      {
         DataSource ds = getDataSource();
         AdminSP sp = new AdminSP(ds, "sp_invessence_switch_post", 2);
         sp.updateNextRebalDate("NEXT_REBALANCE", nextRebaldate);
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   public void reloadClientData()
   {
      try
      {
         DataSource ds = getDataSource();
         AdminSP sp = new AdminSP(ds, "sp_addClients2Trade", 99);
         sp.reloadClients4Trading();
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   public void updateExecutedTrades() {
      DataSource ds = getDataSource();
      AdminSP sp = new AdminSP(ds, "sp_updateExecutedTrades",99);
      sp.updateExecutedTrades();
   }


   public List<IBData> collectIBData(String filter)
   {
      DataSource ds = getDataSource();
      AdminSP sp = new AdminSP(ds, "admin_sel_collectIBData",100);
      List<IBData> ibData = new ArrayList<IBData>();

      Map outMap = sp.getIBData(filter);
      String lastname, firstname;
      if (outMap != null)
      {
         ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
         int i = 0;
         for (Map<String, Object> map : rows)
         {
            Map rs = (Map) rows.get(i);
            IBData data = new IBData();
            data.setClientAccountID(convert.getStrData(rs.get("IB_acctnum")));
            //data.setAccountAlias(convert.getStrData(rs.get("accountAlias")));
            //data.setCurrencyPrimary(convert.getStrData(rs.get("currencyPrimary")));
            lastname=convert.getStrData(rs.get("lastName"));
            firstname=convert.getStrData(rs.get("firstname"));
            if (lastname == null || lastname.length() == 0) {
               data.setName(convert.getStrData(rs.get("name")));
            }
            else {
               data.setName(lastname + "," + firstname);
            }

            // data.setAccountType(convert.getStrData(rs.get("accountStatus")));
            data.setCustomerType(convert.getStrData(rs.get("customerType")));
            data.setAccountCapabilities(convert.getStrData(rs.get("accountCapabilities")));
/*
            data.setTradingPermissions(convert.getStrData(rs.get("tradingPermissions")));
            data.setDateOpened(convert.getStrData(rs.get("dateOpened")));
            data.setDateClosed(convert.getStrData(rs.get("dateClosed")));
            data.setStreet(convert.getStrData(rs.get("street")));
            data.setStreet2(convert.getStrData(rs.get("street2")));
            data.setCity(convert.getStrData(rs.get("city")));
            data.setPostalCode(convert.getStrData(rs.get("postalCode")));
            data.setEmailPrimary(convert.getStrData(rs.get("emailPrimary")));
            data.setEmailSecondary(convert.getStrData(rs.get("emailSecondary")));
            data.setPhoneNo(convert.getStrData(rs.get("phoneNo")));
            data.setAltPhoneNo(convert.getStrData(rs.get("altPhoneNo")));
*/
            data.setState(convert.getStrData(rs.get("state")));
            data.setStartingCash(convert.getDoubleData(rs.get("startingCash")));
            data.setStatus(convert.getStrData(rs.get("status")));
            data.setAcctnum(convert.getStrData(rs.get("acctnum")));
            ibData.add(i, data);
            i++;
         }
      }
      return ibData;

   }

   public List<InvessenceData> collectInvData(String filter)
   {
      DataSource ds = getDataSource();
      AdminSP sp = new AdminSP(ds, "admin_sel_collectInvData",101);
      List<InvessenceData> invList = new ArrayList<InvessenceData>();

      Map outMap = sp.getInvData(filter);
      if (outMap != null)
      {
         ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
         int i = 0;
         for (Map<String, Object> map : rows)
         {
            Map rs = (Map) rows.get(i);
            InvessenceData data = new InvessenceData();

            data.setLogonID(convert.getLongData(rs.get("logonid")));
            data.setEmail(convert.getStrData(rs.get("email")));
            data.setFirstname(convert.getStrData(rs.get("firstname")));
            data.setLastname(convert.getStrData(rs.get("lastname")));
            data.setAcctnum(convert.getLongData(rs.get("acctnum")));
            data.setGoal(convert.getStrData(rs.get("goal")));
            data.setAcctType(convert.getStrData(rs.get("accttype")));
            data.setAge(convert.getIntData(rs.get("age")));
            data.setHorizon(convert.getIntData(rs.get("horizon")));
            data.setRiskIndex(convert.getDoubleData(rs.get("riskIndex")));
            data.setInitialInvestment(convert.getLongData(rs.get("initialInvestment")));
            data.setRecurringInvestment(convert.getLongData(rs.get("recurringInvestment")));
            data.setTradepreference(convert.getStrData(rs.get("tradepreference")));
            data.setKeepliquid(convert.getLongData(rs.get("keepliquid")));
            data.setLongTermGoal(convert.getIntData(rs.get("longTermGoal")));
            data.setStayInvested(convert.getIntData(rs.get("stayInvested")));
            data.setDependent(convert.getIntData(rs.get("dependent")));
            data.setTotalIncomeAnnulized(convert.getLongData(rs.get("totalIncomeAnnulized")));
            data.setTotalExpenseAnnulized(convert.getLongData(rs.get("totalExpenseAnnulized")));
            data.setTotalAsset(convert.getLongData(rs.get("totalAsset")));
            data.setTotalDebt(convert.getLongData(rs.get("totalDebt")));
            data.setLiquidnetworth(convert.getLongData(rs.get("liquidnetworth")));
            data.setNetworth(convert.getLongData(rs.get("networth")));
            data.setCreated(convert.getStrData(rs.get("created")));
            //data.setLastUpdated(convert.getStrData(rs.get("lastUpdated")));
            invList.add(i, data);
            i++;
         }
      }

      return invList;

   }

   public List<Position> loadVirtualPorfolio(Long acctnum) {
      try {
         DataSource ds = getDataSource();
         AdminSP sp = new AdminSP(ds, "admin_sel_virtual_portfolio",102);
         List<Position> posList = new ArrayList<Position>();

         Map outMap = sp.getVirtualPosition(acctnum);
         if (outMap != null)
         {
            ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
            int i = 0;
            for (Map<String, Object> map : rows)
            {
               Map rs = (Map) rows.get(i);
               Position data = new Position();

               data.setAcctnum(convert.getLongData(rs.get("acctnum")));
               data.setInstrumentid(convert.getLongData(rs.get("instrumentid")));
               data.setTicker(convert.getStrData(rs.get("ticker")));
               data.setAssetclass(convert.getStrData(rs.get("assetclass")));
               data.setSubclass(convert.getStrData(rs.get("subclass")));
               data.setColor(convert.getStrData(rs.get("color")));
               data.setName(convert.getStrData(rs.get("name")));
               data.setQty(convert.getIntData(rs.get("qty")));
               data.setWeight(convert.getDoubleData(rs.get("weight")));
               data.setCostBasisMoney(convert.getDoubleData(rs.get("origPrice")));
               data.setCostBasisMoney(convert.getDoubleData(rs.get("origInvested")));
               data.setMarkPrice(convert.getDoubleData(rs.get("price")));
               data.setPositionValue(convert.getDoubleData(rs.get("newValue")));
               data.setFirstname(convert.getStrData(rs.get("firstname")));
               data.setLastname(convert.getStrData(rs.get("lastname")));
               data.setClientAccountID(convert.getStrData(rs.get("IB_acctnum")));
               // data.setClientAccountID(convert.getStrData(rs.get("IB_acctnum")));
               posList.add(i, data);
               i++;
            }
            return  posList;
         }
      }
      catch (Exception ex) {
         ex.printStackTrace();
      }
      return null;
   }


   public List<TradeClientData> getProfileData(String filter) {
      DataSource ds = getDataSource();
      AdminSP sp = new AdminSP(ds, "sel_collectTradeProfile",103);
      List<TradeClientData> listProfiles = new ArrayList<TradeClientData>();
      Map outMap = sp.loadProfile(filter);
      if (outMap != null)
      {
         ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
         int i = 0;
         for (Map<String, Object> map : rows)
         {
            Map rs = (Map) rows.get(i);
            TradeClientData data = new TradeClientData();

            data.setAcctnum(convert.getLongData(rs.get("acctnum")));
            //data.setLogonid(convert.getLongData(rs.get("logonid")));
            data.setName(convert.getStrData(rs.get("firstname")) + " " + convert.getStrData(rs.get("lastname")));
            data.setClientAccountID(convert.getStrData(rs.get("IB_acctnum")));
            data.setTradePreference(convert.getStrData(rs.get("tradePreference")));
            data.setGoal(convert.getStrData(rs.get("goal")));
            data.setAccountType(convert.getStrData(rs.get("accttype")));
            data.setAge(convert.getIntData(rs.get("age")));
            data.setHorizon(convert.getIntData(rs.get("horizon")));
            data.setCalendarYear(convert.getIntData(rs.get("yearnum")));
            data.setRiskIndex(convert.getIntData(rs.get("riskIndex")));
            data.setInitialInvestment(convert.getIntData(rs.get("initialInvestment")));
            data.setKeepLiquid(convert.getIntData(rs.get("keepLiquid")));
            data.setActualInvestment(convert.getIntData(rs.get("actualCapital")));
            data.setRecurringInvestment(convert.getIntData(rs.get("recurringInvestment")));
            data.setObjective(convert.getIntData(rs.get("longTermGoal")));
            data.setStayInvested(convert.getIntData(rs.get("stayInvested")));
            data.setDependent(convert.getIntData(rs.get("dependent")));

            data.setTotalIncome(convert.getIntData(rs.get("totalIncomeAnnulized")));
            data.setTotalExpense(convert.getIntData(rs.get("totalExpenseAnnulized")));
            data.setTotalAsset(convert.getIntData(rs.get("totalAsset")));
            data.setTotalLiability(convert.getIntData(rs.get("totalDebt")));
            data.setLiquidAsset(convert.getIntData(rs.get("liquidnetworth")));
            // data.setNetWorth(convert.getIntData(rs.get("networth")));

            data.setSelectedchoice1(convert.getStrData(rs.get("ans1")));
            data.setSelectedchoice2(convert.getStrData(rs.get("ans2")));
            data.setSelectedchoice3(convert.getStrData(rs.get("ans3")));
            data.setSelectedchoice4(convert.getStrData(rs.get("ans4")));
            data.setSelectedchoice5(convert.getStrData(rs.get("ans5")));
            data.setSelectedchoice6(convert.getStrData(rs.get("ans6")));
            data.setSelectedchoice7(convert.getStrData(rs.get("ans7")));
            data.setSelectedchoice8(convert.getStrData(rs.get("ans8")));
            data.setSelectedchoice9(convert.getStrData(rs.get("ans9")));
            data.setSelectedchoice10(convert.getStrData(rs.get("ans10")));
            data.setSelectedchoice11(convert.getStrData(rs.get("ans11")));
            data.setSelectedchoice12(convert.getStrData(rs.get("ans12")));
            data.setSelectedchoice13(convert.getStrData(rs.get("ans13")));
            data.setSelectedchoice14(convert.getStrData(rs.get("ans14")));
            data.setSelectedchoice15(convert.getStrData(rs.get("ans15")));

            data.setProcessStatus(convert.getStrData(rs.get("processStatus")));
            data.setLastTraded(convert.getStrData(rs.get("lastTraded")));
            data.setReason(convert.getStrData(rs.get("reason")));
            data.setAssetAllocationOffset(convert.getDoubleData(rs.get("assetAllocationOffset")));
            data.setPosition(convert.getDoubleData(rs.get("position")));
            data.setAssetClass(convert.getStrData(rs.get("assetclass")));
            data.setCurrentAllocation(convert.getDoubleData(rs.get("currentAllocation")));
            data.setRequiredAllocation(convert.getDoubleData(rs.get("requiredAllocation")));
            data.setCreated(convert.getStrData(rs.get("created")));
            data.setLastUpdated(convert.getStrData(rs.get("lastUpdated")));
            listProfiles.add(i, data);
            i++;
         }
         return listProfiles;
      }
      return null;
   }

   public List<TradeDetails> loadTradesDetails(Long acctnum) {
      DataSource ds = getDataSource();
      AdminSP sp = new AdminSP(ds, "sel_displayTradeDetail",104);
      List<TradeDetails> tradeDetails = new ArrayList<TradeDetails>();
      Map outMap = sp.loadTradesDetails(acctnum);
      if (outMap != null)
      {
         ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
         int i = 0;
         for (Map<String, Object> map : rows)
         {
            Map rs = (Map) rows.get(i);
            TradeDetails data = new TradeDetails();

            data.setAcctnum(convert.getLongData(rs.get("acctnum")));
            //data.setLogonid(convert.getLongData(rs.get("logonid")));
            data.setClientAccountID(convert.getStrData(rs.get("clientAccountID")));
            data.setName(convert.getStrData(rs.get("name")));
            data.setTradedate(convert.getStrData(rs.get("tradedate")));
            Integer tQty = convert.getIntData(rs.get("adjustedQty"));
            if (tQty > 0)
               data.setTradedirection("Buy");
            else if (tQty < 0)
               data.setTradedirection("Sell");
            else
               data.setTradedirection("N/A");
            data.setAssetclass(convert.getStrData(rs.get("assetclass")));
            data.setTicker(convert.getStrData(rs.get("ticker")));
            data.setAccttype(convert.getStrData(rs.get("accttype")));

            data.setCurrentqty(convert.getDoubleData(rs.get("currentqty")));
            data.setCostBasisPrice(convert.getDoubleData(rs.get("costBasisPrice")));
            data.setCostBasisMoney(convert.getDoubleData(rs.get("costBasisMoney")));

            data.setCurrentValue(convert.getDoubleData(rs.get("currentValue")));
            data.setPnl(convert.getDoubleData(rs.get("pnl")));
            data.setNewqty(convert.getDoubleData(rs.get("newqty")));

            data.setNewValue(convert.getDoubleData(rs.get("newValue")));
            data.setTradeqty(convert.getDoubleData(rs.get("tradeqty")));
            data.setAdjustedQty(convert.getDoubleData(rs.get("adjustedQty")));
            data.setTradeprice(convert.getDoubleData(rs.get("tradeprice")));
            data.setTradeValue(convert.getDoubleData(rs.get("tradeValue")));

            data.setPriceperShare(convert.getDoubleData(rs.get("priceperShare")));
            data.setRealizedPnL(convert.getDoubleData(rs.get("realizedPnL")));
            data.setTradedPnL(convert.getDoubleData(rs.get("tradedPnL")));
            data.setRunningCashBal(convert.getDoubleData(rs.get("runningCashBal")));
            data.setPercentAllocated(convert.getDoubleData(rs.get("percentAllocated")));
            data.setSortOrder(convert.getIntData(rs.get("sortOrder")));
            tradeDetails.add(i, data);
            i++;
         }
         return tradeDetails;
      }
      return null;
   }

   public ArrayList<Map<String, Object>> getTradesAllocationData() {
      DataSource ds = getDataSource();
      AdminSP sp = new AdminSP(ds, "sel_displayTrades2Execute",199);
      List<TradeDetails> tradeDetails = new ArrayList<TradeDetails>();
      Map outMap = sp.getTradesAllocationData();
      if (outMap != null)
         return (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
      else
         return null;
   }

}

