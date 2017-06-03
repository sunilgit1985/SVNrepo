package com.invessence.dao.common;

import java.io.Serializable;
import java.util.*;
import javax.faces.bean.*;
import javax.sql.DataSource;

import com.invessence.converter.SQLData;
import com.invessence.dao.consumer.ConsumerListSP;
import com.invessence.data.*;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

@ManagedBean(name = "commonDAO")
@ApplicationScoped
public class CommonDAO extends JdbcDaoSupport implements Serializable
{
   SQLData convert = new SQLData();

   public ArrayList<ManageGoals> getListOfAccounts(Long logonid, Long acctnum) {
      DataSource ds = getDataSource();
      CommonSP sp = new CommonSP(ds, "sel_ClientProfileData2",0);
      ArrayList<ManageGoals> listProfiles = new ArrayList<ManageGoals>();
      Map outMap = sp.collectProfileData(logonid, acctnum);
      String action;
      try {
         if (outMap != null)
         {
            ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
            int i = 0;
            Integer actualCapital = 0;
            for (Map<String, Object> map : rows)
            {
               Map rs = (Map) rows.get(i);
               ManageGoals data = new ManageGoals();

               data.setAcctnum(convert.getLongData(rs.get("acctnum")));
               data.setEmail(convert.getStrData(rs.get("email")));

               data.setAdvisor(convert.getStrData(rs.get("advisor")));
               data.setTheme(convert.getStrData(rs.get("theme")));
               data.setLogonid(convert.getLongData(rs.get("logonid")));
               data.setLastname(convert.getStrData(rs.get("lastname")));
               data.setFirstname(convert.getStrData(rs.get("firstname")));
               data.setClientAccountID(convert.getStrData(rs.get("ClientAccountID")));

               String acctStatus = convert.getStrData(rs.get("acctstatus"));
               data.setAcctstatus(acctStatus);
               if (acctStatus.equalsIgnoreCase("pending")) {
                  data.setManaged(false);
                  actualCapital = convert.getIntData(rs.get("initialInvestment"));
               }
               else {
                  data.setManaged(true);
                  actualCapital = convert.getIntData(rs.get("actualCapital"));
               }
               data.setActualInvestment(actualCapital);
               data.setTradePreference(convert.getStrData(rs.get("tradePreference")));
               data.setGoal(convert.getStrData(rs.get("goal")));
               data.setAccountType(convert.getStrData(rs.get("accttype")));
               data.setAge(convert.getIntData(rs.get("age")));
               data.setHorizon(convert.getIntData(rs.get("horizon")));
               data.setRiskIndex(convert.getIntData(rs.get("riskIndex")));
               data.setInitialInvestment(convert.getIntData(rs.get("initialInvestment")));
               data.setKeepLiquid(convert.getIntData(rs.get("keepLiquid")));
               data.setRecurringInvestment(convert.getIntData(rs.get("recurringInvestment")));
               data.setObjective(convert.getIntData(rs.get("longTermGoal")));
               data.setStayInvested(convert.getIntData(rs.get("stayInvested")));
               data.setDateOpened(convert.getStrData(rs.get("dateOpened")));
               data.setDependent(convert.getIntData(rs.get("dependent")));

               data.setHouseholdwages(convert.getIntData(rs.get("householdwages")));
               data.setMortgagePayment(convert.getIntData(rs.get("householdPayment")));
               data.setOtherExpense(convert.getIntData(rs.get("miscExpenses")));
               data.setMoneymarket(convert.getIntData(rs.get("moneyMarket")));
               data.setInvestment(convert.getIntData(rs.get("investment")));
               data.setOtherIncome(convert.getIntData(rs.get("otherincome")));
               data.setOtherDebt(convert.getIntData(rs.get("otherDebt")));

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

               data.setCreated(convert.getStrData(rs.get("created")));
               listProfiles.add(i, data);
               i++;
            }
         }
         return listProfiles;
      }
      catch (Exception ex) {
            ex.printStackTrace();
      }
      return null;
   }

   public ManageGoals getSingleAccounts(Long acctnum) {
      DataSource ds = getDataSource();
      CommonSP sp = new CommonSP(ds, "sel_ClientProfileData2",0);
      Map outMap = sp.collectProfileData(null, acctnum);
      ManageGoals data = new ManageGoals();
      try {
         if (outMap != null)
         {
            ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
            int i = 0;
            Double actualCapital = 0.0;
            for (Map<String, Object> map : rows)
            {
               Map rs = (Map) rows.get(i);

               data.setAcctnum(convert.getLongData(rs.get("acctnum")));
               data.setEmail(convert.getStrData(rs.get("email")));

               data.setAdvisor(convert.getStrData(rs.get("advisor")));
               data.setTheme(convert.getStrData(rs.get("theme")));
               data.setLogonid(convert.getLongData(rs.get("logonid")));
               data.setLastname(convert.getStrData(rs.get("lastname")));
               data.setFirstname(convert.getStrData(rs.get("firstname")));
               data.setClientAccountID(convert.getStrData(rs.get("ClientAccountID")));

               String acctStatus = convert.getStrData(rs.get("acctstatus"));
               data.setAcctstatus(acctStatus);
               if (acctStatus.equalsIgnoreCase("pending")) {
                  data.setManaged(false);
               }
               else {
                  data.setManaged(true);
                  actualCapital = convert.getDoubleData(rs.get("actualCapital"));
                  if (actualCapital != null && actualCapital > 0)
                     data.setManagedtotalMoney(convert.getDoubleData(rs.get("actualCapital")));
               }
               data.setTradePreference(convert.getStrData(rs.get("tradePreference")));
               data.setGoal(convert.getStrData(rs.get("goal")));
               data.setAccountType(convert.getStrData(rs.get("accttype")));
               data.setAge(convert.getIntData(rs.get("age")));
               data.setHorizon(convert.getIntData(rs.get("horizon")));
               data.setRiskIndex(convert.getIntData(rs.get("riskIndex")));
               data.setInitialInvestment(convert.getIntData(rs.get("initialInvestment")));
               data.setKeepLiquid(convert.getIntData(rs.get("keepLiquid")));
               data.setRecurringInvestment(convert.getIntData(rs.get("recurringInvestment")));
               data.setObjective(convert.getIntData(rs.get("longTermGoal")));
               data.setStayInvested(convert.getIntData(rs.get("stayInvested")));
               data.setDateOpened(convert.getStrData(rs.get("dateOpened")));
               data.setDependent(convert.getIntData(rs.get("dependent")));

               data.setHouseholdwages(convert.getIntData(rs.get("householdwages")));
               data.setMortgagePayment(convert.getIntData(rs.get("householdPayment")));
               data.setOtherExpense(convert.getIntData(rs.get("miscExpenses")));
               data.setMoneymarket(convert.getIntData(rs.get("moneyMarket")));
               data.setInvestment(convert.getIntData(rs.get("investment")));
               data.setOtherIncome(convert.getIntData(rs.get("otherincome")));
               data.setOtherDebt(convert.getIntData(rs.get("otherDebt")));

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

               data.setCreated(convert.getStrData(rs.get("created")));
               i++;
            }
         }
         return data;
      }
      catch (Exception ex) {
         ex.printStackTrace();
      }
      return null;
   }

   public void saveUserIDPwd(UserData data) {

   }

   public String validateState(Long logonid, String state) {
      DataSource ds = getDataSource();
      CommonSP sp = new CommonSP(ds, "sp_validate_state",1);
      Map outMap = sp.validateState(logonid, state);
      String info="quota";
      if (outMap != null)
      {
         ArrayList<Map<String, Object>> rows = (ArrayList<Map<String, Object>>) outMap.get("#result-set-1");
         int i = 0;
         for (Map<String, Object> map : rows)
         {
            Map rs = (Map) rows.get(i);
            info=convert.getStrData(rs.get("license"));
            i++;
            break;
         }
      }
      return info;

   }


}