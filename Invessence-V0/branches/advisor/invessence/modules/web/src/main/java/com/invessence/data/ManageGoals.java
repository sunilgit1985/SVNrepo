package com.invessence.data;

import java.text.DecimalFormat;
import java.util.*;

import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;
import javax.faces.model.SelectItemGroup;

import com.invessence.constant.Const;
import com.invessence.data.advisor.TreeAssetFilter;
import com.invmodel.asset.AssetAllocationModel;
import com.invmodel.asset.data.*;
import com.invmodel.inputData.ProfileData;
import com.invmodel.portfolio.PortfolioModel;
import com.invmodel.portfolio.data.*;
import org.primefaces.context.RequestContext;
import org.primefaces.event.SelectEvent;
import org.primefaces.model.TreeNode;

/**
 * Created with IntelliJ IDEA.
 * User: pichaimanir
 * Date: 8/19/13
 * Time: 4:50 PM
 * To change this template use File | Settings | File Templates.
 */
public class ManageGoals extends ProfileData
{

   private ManageGoals manageGoalinstance = null;
   private AssetAllocationModel allocModel;

   private TreeAssetFilter treeAssetFilterModel;
   private PortfolioModel portfolioModel;
   private ProfileData profileInstance = null;
   private Long acctnum;
   private String clientAccountID;
   private Long logonid;
   private String userid;
   private String addmodflag;
   private String acctstatus;
   private String dateOpened;

   // Income/Expenses
   private Integer householdwages;
   private Integer mortgagePayment;
   private Integer otherIncome;
   private Integer otherExpense;

   // Asset/Liability
   private Integer moneymarket;
   private Integer autoLoan;
   private Integer investment;
   private Integer medical;
   private Integer mortgateEquity;
   private Integer mortgageLoan;
   private Integer otherSavings;
   private Integer otherDebt;
   private Double  stock;
   private Double  bond;
   private Double  accrual;


   private String selectedchoice1;
   private String selectedchoice2;
   private String selectedchoice3;
   private String selectedchoice4;
   private String selectedchoice5;
   private String selectedchoice6;
   private String selectedchoice7;
   private String selectedchoice8;
   private String selectedchoice9;
   private String selectedchoice10;
   private String selectedchoice11;
   private String selectedchoice12;
   private String selectedchoice13;
   private String selectedchoice14;
   private String selectedchoice15;

   private String model      = "D";
   private Integer assetyear = 0;
   private String active     = "A";
   private Integer displayAge;
   private String registeredState;
   private Boolean userAssetOverride = false;

   private String email, firstname, lastname;
   private List<DataPortfolio> portfolioList = new ArrayList<DataPortfolio>();
   private DataPortfolio selectedPortfolio;
   private List<DataPortfolio> selectedPortfolioList = null;
   Double  assetAllocationTotal = 0.0;
   private Double totalSharesAllocated = 0.0;
   private Double totalMoneyAllocated = 0.0;

   private TreeNode subclassDisplayNode;
   private TreeNode[] subclassFilterNode;

   public ManageGoals()
   {
      super();
      this.manageGoalinstance = this;
   }

   public ManageGoals getInstance()
   {
      return manageGoalinstance;
   }

   public TreeAssetFilter getTreeAssetFilterModel()
   {
      return treeAssetFilterModel;
   }

   public void setTreeAssetFilterModel(TreeAssetFilter treeAssetFilterModel)
   {
      this.treeAssetFilterModel = treeAssetFilterModel;
   }

   public AssetAllocationModel getAllocModel()
   {
      return allocModel;
   }

   public void setAllocModel(AssetAllocationModel allocModel)
   {
      this.allocModel = allocModel;
   }

   public PortfolioModel getPortfolioModel()
   {
      return portfolioModel;
   }

   public void setPortfolioModel(PortfolioModel portfolioModel)
   {
      this.portfolioModel = portfolioModel;
   }

   public ProfileData getSubInstance()
   {
      return manageGoalinstance;
   }

   public Long getAcctnum()
   {
      return acctnum;
   }

   public void setAcctnum(Long acctnum)
   {
      if (acctnum != null)
      {
         this.acctnum = acctnum;
      }
   }

   public String getClientAccountID()
   {
      return clientAccountID;
   }

   public void setClientAccountID(String clientAccountID)
   {
      this.clientAccountID = clientAccountID;
   }

   public Long getLogonid()
   {
      return logonid;
   }

   public void setLogonid(Long logonid)
   {
      this.logonid = logonid;
   }

   public String getUserid()
   {
      return userid;
   }

   public void setUserid(String userid)
   {
      this.userid = userid;
   }

   public String getAddmodflag()
   {
      return addmodflag;
   }

   public void setAddmodflag(String addmodflag)
   {
      this.addmodflag = addmodflag;
   }

   public String getAcctstatus()
   {
      return acctstatus;
   }

   public void setAcctstatus(String acctstatus)
   {
      this.acctstatus = acctstatus;
   }

   public String getDateOpened()
   {
      return dateOpened;
   }

   public void setDateOpened(String dateOpened)
   {
      this.dateOpened = dateOpened;
   }

   public Integer getHouseholdwages()
   {
      return householdwages;
   }

   public void setHouseholdwages(Integer householdwages)
   {
      this.householdwages = householdwages;
      setCurrentIncome(convertNumber(householdwages));
      addTotalIncome();
   }

   public Integer getMortgagePayment()
   {
      return mortgagePayment;
   }

   public void setMortgagePayment(Integer mortgagePayment)
   {
      this.mortgagePayment = mortgagePayment;
      addTotalExpense();
   }

   public Integer getOtherIncome()
   {
      return otherIncome;
   }

   public void setOtherIncome(Integer otherIncome)
   {
      this.otherIncome = otherIncome;
      addTotalIncome();
   }

   public Integer getOtherExpense()
   {
      return otherExpense;
   }

   public void setOtherExpense(Integer otherExpense)
   {
      this.otherExpense = otherExpense;
      addTotalExpense();
   }

   public Integer getMoneymarket()
   {
      return moneymarket;
   }

   public void setMoneymarket(Integer moneymarket)
   {
      this.moneymarket = moneymarket;
      addTotalAsset();
   }

   public Integer getAutoLoan()
   {
      return autoLoan;
   }

   public void setAutoLoan(Integer autoLoan)
   {
      this.autoLoan = autoLoan;
      addTotalLiability();
   }

   public Integer getInvestment()
   {
      return investment;
   }

   public void setInvestment(Integer investment)
   {
      this.investment = investment;
      addTotalAsset();
   }

   public Integer getMedical()
   {
      return medical;
   }

   public void setMedical(Integer medical)
   {
      this.medical = medical;
      addTotalLiability();
   }

   public Integer getMortgateEquity()
   {
      return mortgateEquity;
   }

   public void setMortgateEquity(Integer mortgateEquity)
   {
      this.mortgateEquity = mortgateEquity;
      addTotalAsset();
   }

   public Integer getMortgageLoan()
   {
      return mortgageLoan;
   }

   public void setMortgageLoan(Integer mortgageLoan)
   {
      this.mortgageLoan = mortgageLoan;
      addTotalLiability();
   }

   public Integer getOtherSavings()
   {
      return otherSavings;
   }

   public void setOtherSavings(Integer otherSavings)
   {
      this.otherSavings = otherSavings;
      addTotalAsset();
   }

   public Integer getOtherDebt()
   {
      return otherDebt;
   }

   public void setOtherDebt(Integer otherDebt)
   {
      this.otherDebt = otherDebt;
      addTotalLiability();
   }

   public Double getStock()
   {
      return stock;
   }

   public void setStock(Double stock)
   {
      this.stock = stock;
   }

   public Double getBond()
   {
      return bond;
   }

   public void setBond(Double bond)
   {
      this.bond = bond;
   }

   public Double getAccrual()
   {
      return accrual;
   }

   public void setAccrual(Double accrual)
   {
      this.accrual = accrual;
   }

   public Integer convertNumber(Integer num) {
      if (num == null)
         return 0;
      else
         return num;
   }

   public void addTotalIncome() {
       setTotalIncome((convertNumber(getHouseholdwages())+ convertNumber(getOtherIncome())));
   }

   public void addTotalExpense() {
      setTotalExpense((convertNumber(getMortgagePayment()) + convertNumber(getOtherExpense())));

   }

   public void addTotalAsset() {
      setLiquidAsset(convertNumber(getMoneymarket()));
      setTotalAsset(convertNumber(getMortgateEquity()) + convertNumber(getInvestment()) +
                       convertNumber(getOtherSavings()) + convertNumber(getMoneymarket()));

   }

   public void addTotalLiability() {
       setTotalLiability(convertNumber(getMortgageLoan()) + convertNumber(getAutoLoan()) +
                            convertNumber(getMedical()) + convertNumber(getOtherDebt()));
   }

   public String getSelectedchoice1()
   {
      return selectedchoice1;
   }

   public void setSelectedchoice1(String selectedchoice1)
   {
      this.selectedchoice1 = selectedchoice1;
   }

   public String getSelectedchoice2()
   {
      return selectedchoice2;
   }

   public void setSelectedchoice2(String selectedchoice2)
   {
      this.selectedchoice2 = selectedchoice2;
   }

   public String getSelectedchoice3()
   {
      return selectedchoice3;
   }

   public void setSelectedchoice3(String selectedchoice3)
   {
      this.selectedchoice3 = selectedchoice3;
   }

   public String getSelectedchoice4()
   {
      return selectedchoice4;
   }

   public void setSelectedchoice4(String selectedchoice4)
   {
      this.selectedchoice4 = selectedchoice4;
   }

   public String getSelectedchoice5()
   {
      return selectedchoice5;
   }

   public void setSelectedchoice5(String selectedchoice5)
   {
      this.selectedchoice5 = selectedchoice5;
   }

   public String getSelectedchoice6()
   {
      return selectedchoice6;
   }

   public void setSelectedchoice6(String selectedchoice6)
   {
      this.selectedchoice6 = selectedchoice6;
   }

   public String getSelectedchoice7()
   {
      return selectedchoice7;
   }

   public void setSelectedchoice7(String selectedchoice7)
   {
      this.selectedchoice7 = selectedchoice7;
   }


   public String getSelectedchoice8()
   {
      return selectedchoice8;
   }

   public void setSelectedchoice8(String selectedchoice8)
   {
      this.selectedchoice8 = selectedchoice8;
   }

   public String getSelectedchoice9()
   {
      return selectedchoice9;
   }

   public void setSelectedchoice9(String selectedchoice9)
   {
      this.selectedchoice9 = selectedchoice9;
   }

   public String getSelectedchoice10()
   {
      return selectedchoice10;
   }

   public void setSelectedchoice10(String selectedchoice10)
   {
      this.selectedchoice10 = selectedchoice10;
   }

   public String getSelectedchoice11()
   {
      return selectedchoice11;
   }

   public void setSelectedchoice11(String selectedchoice11)
   {
      this.selectedchoice11 = selectedchoice11;
   }

   public String getSelectedchoice12()
   {
      return selectedchoice12;
   }

   public void setSelectedchoice12(String selectedchoice12)
   {
      this.selectedchoice12 = selectedchoice12;
   }

   public String getSelectedchoice13()
   {
      return selectedchoice13;
   }

   public void setSelectedchoice13(String selectedchoice13)
   {
      this.selectedchoice13 = selectedchoice13;
   }

   public String getSelectedchoice14()
   {
      return selectedchoice14;
   }

   public void setSelectedchoice14(String selectedchoice14)
   {
      this.selectedchoice14 = selectedchoice14;
   }

   public String getSelectedchoice15()
   {
      return selectedchoice15;
   }

   public void setSelectedchoice15(String selectedchoice15)
   {
      this.selectedchoice15 = selectedchoice15;
   }

   public String getModel()
   {
      return model;
   }

   public void setModel(String model)
   {
      this.model = model;
   }

   public Integer getAssetyear()
   {
      return assetyear;
   }

   public void setAssetyear(Integer assetyear)
   {
      this.assetyear = assetyear;
   }

   public String getActive()
   {
      return active;
   }

   public void setActive(String active)
   {
      this.active = active;
   }

   public String getEmail()
   {
      return email;
   }

   public void setEmail(String email)
   {
      this.email = email;
   }

   public String getFirstname()
   {
      return firstname;
   }

   public void setFirstname(String firstname)
   {
      this.firstname = firstname;
   }

   public String getLastname()
   {
      return lastname;
   }

   public void setLastname(String lastname)
   {
      this.lastname = lastname;
   }

   public String getFullName() {
      String name = null;
      if (getLastname() != null)
         name = getLastname();

      if (getFirstname() != null) {
         if (name != null)
            name = name + ", " + getFirstname();
         else
            name =  getFirstname();
      }

      return name;
   }

   public void resetManagedGoalData() {
      // Master ProfileData
      // setName	(null);  Being reset at bottom.
      resetPortfolioData();

      // Manage Goal Data.
      setAcctnum(null);
      setClientAccountID(null);
      setLogonid(null);
      setUserid(null);
      setAddmodflag(null);
      setAcctstatus(null);
      setDateOpened(null);

      // Income/Expenses
      setHouseholdwages(null);
      setMortgagePayment	(null);
      setOtherIncome	(null);
      setOtherExpense	(null);

      // Asset/Liability
      setMoneymarket	(null);
      setAutoLoan	(null);
      setInvestment	(null);
      setMedical	(null);
      setMortgateEquity	(null);
      setMortgageLoan	(null);
      setOtherSavings	(null);
      setOtherDebt	(null);
      setStock(null);
      setBond(null);
      setAccrual(null);

      setSelectedchoice1	(null);
      setSelectedchoice2	(null);
      setSelectedchoice3	(null);
      setSelectedchoice4	(null);
      setSelectedchoice5	(null);
      setSelectedchoice6	(null);
      setSelectedchoice7	(null);
      setSelectedchoice8	(null);
      setSelectedchoice9	(null);
      setSelectedchoice10	(null);
      setSelectedchoice11	(null);
      setSelectedchoice12	(null);
      setSelectedchoice13	(null);
      setSelectedchoice14	(null);
      setSelectedchoice15	(null);

      setModel("D");
      setAssetyear(0);
      setActive("A");

      setEmail(null);
      setFirstname(null);
      setLastname(null);
      setRegisteredState(null);
      setUserAssetOverride(false);
      setName(null);
      setUserAssetOverride(false);

      if (portfolioList != null)
         portfolioList.clear();

      setSelectedPortfolio(null);

      if (selectedPortfolioList != null)
         selectedPortfolioList.clear();

      setAssetAllocationTotal(0.0);
      setTotalSharesAllocated(0.0);
      setTotalMoneyAllocated(0.0);

   }

   public void copyData(ManageGoals newgoals) {
      // Master ProfileData
      //setName(newgoals.getName());  Being set at bottom
      setDisplayAge(newgoals.getDisplayAge());
      setHorizon	(	newgoals.getHorizon	());
      setInitialInvestment	(	newgoals.getInitialInvestment	());
      setRecurringInvestment	(	newgoals.getRecurringInvestment	());
      setExperience	(	newgoals.getExperience	());
      setObjective	(	newgoals.getObjective	());
      setStayInvested	(	newgoals.getStayInvested	());
      setCharitableGoals	(	newgoals.getCharitableGoals	());
      setDependent	(	newgoals.getDependent	());
      setCurrentIncome	(	newgoals.getCurrentIncome	());
      setTotalIncome	(	newgoals.getTotalIncome	());
      setTotalExpense	(	newgoals.getTotalExpense	());
      setTotalAsset	(	newgoals.getTotalAsset	());
      setTotalLiability	(	newgoals.getTotalLiability	());
      setAccountTaxable	(	newgoals.getAccountTaxable	());
      setTaxrate	(	newgoals.getTaxrate	());
      setRisk	(	newgoals.getRisk	());
      setRiskIndex	(	newgoals.getRiskIndex	());

      // ManageGoal Data
      setAcctnum(newgoals.getAcctnum());
      setLogonid(newgoals.getLogonid());
      setUserid(newgoals.getUserid());
      setAddmodflag(newgoals.getAddmodflag());
      setGoal  (    newgoals.getGoal());
      setAccountType(newgoals.getAccountType());
      setName(newgoals.getName());
      setHouseholdwages(newgoals.getHouseholdwages());
      setMortgagePayment(newgoals.getMortgagePayment());
      setOtherIncome(newgoals.getOtherIncome());
      setOtherExpense(newgoals.getOtherExpense());
      setMoneymarket(newgoals.getMoneymarket());
      setAutoLoan(newgoals.getAutoLoan());
      setInvestment(newgoals.getInvestment());
      setMedical(newgoals.getMedical());
      setMortgateEquity(newgoals.getMortgateEquity());
      setMortgageLoan(newgoals.getMortgageLoan());
      setOtherSavings(newgoals.getOtherSavings());
      setOtherDebt(newgoals.getOtherDebt());
      setSelectedchoice1(newgoals.getSelectedchoice1());
      setSelectedchoice2(newgoals.getSelectedchoice2());
      setSelectedchoice3(newgoals.getSelectedchoice3());
      setSelectedchoice4(newgoals.getSelectedchoice4());
      setSelectedchoice5(newgoals.getSelectedchoice5());
      setSelectedchoice6(newgoals.getSelectedchoice6());
      setSelectedchoice7(newgoals.getSelectedchoice7());
      setSelectedchoice8(newgoals.getSelectedchoice8());
      setSelectedchoice9(newgoals.getSelectedchoice9());
      setSelectedchoice10(newgoals.getSelectedchoice10());
      setSelectedchoice11(newgoals.getSelectedchoice11());
      setSelectedchoice12(newgoals.getSelectedchoice12());
      setSelectedchoice13(newgoals.getSelectedchoice13());
      setSelectedchoice14(newgoals.getSelectedchoice14());
      setSelectedchoice15(newgoals.getSelectedchoice15());
      setAssetData	(	newgoals.getAssetData	());
      setPortfolioData	(	newgoals.getPortfolioData	());
      setFirstname(newgoals.getFirstname());
      setLastname(newgoals.getLastname());
      setRegisteredState(newgoals.getRegisteredState());
      setUserAssetOverride(false);
      setName(newgoals.getFirstname() + " " + newgoals.getLastname());
   }

   public Integer[] selectedChoices()
   {
         Integer no_of_questions = 7;
         Integer[] selectedChoices = new Integer[]{null, null, null, null, null, null, null};
         Integer riskIndex = 0;

         if (getSelectedchoice1() != null)
         {
            String choice = getSelectedchoice1();
            selectedChoices[0] = Integer.parseInt(getSelectedchoice1());
         }

         if (getSelectedchoice2() != null)
         {
            String choice = getSelectedchoice2();
            selectedChoices[1] = Integer.parseInt(getSelectedchoice2());

         }

         if (getSelectedchoice3() != null)
         {
            String choice = getSelectedchoice3();
            selectedChoices[2] = Integer.parseInt(getSelectedchoice3());
         }

         if (getSelectedchoice4() != null)
         {
            String choice = getSelectedchoice4();
            selectedChoices[3] = Integer.parseInt(getSelectedchoice4());
         }

         if (getSelectedchoice5() != null)
         {
            String choice = getSelectedchoice5();
            selectedChoices[4] = Integer.parseInt(getSelectedchoice5());
         }

         if (getSelectedchoice6() != null)
         {
            String choice = getSelectedchoice6();
            selectedChoices[5] = Integer.parseInt(getSelectedchoice6());
         }

         if (getSelectedchoice7() != null)
         {
            String choice = getSelectedchoice7();
            selectedChoices[6] = Integer.parseInt(getSelectedchoice7());
         }

         return selectedChoices;
   }

   public Boolean getRenderAge() {
      if (getGoal().equalsIgnoreCase("retirement")) {
         return true;
      }
      else {
         if (getDisplayAge() != null) {
            setDisplayAge(null);
         }
         return false;
      }
   }

   public Integer getDisplayAge()
   {
         return displayAge;
   }

   public void setDisplayAge(Integer displayAge)
   {
         this.displayAge = displayAge;
         setAge(displayAge);
   }

   public String getHorizonQuestion()
   {
      String question = "How many years do you plan to invest?";
      if (getGoal() != null) {
         if (getGoal().equalsIgnoreCase("retirement"))
            return "Number of years to your retirement?";
         if (getGoal().equalsIgnoreCase("home"))
            return "How many years until you purchase your home?";
         if (getGoal().equalsIgnoreCase("wedding"))
            return "Number of years to your wedding?";
         if (getGoal().equalsIgnoreCase("automobile"))
            return "How many years until you purchase automobile?";
         if (getGoal().equalsIgnoreCase("education"))
            return "How many years to your child's college graduation?";
      }
      return question;
   }


   public String getRegisteredState()
   {
      return registeredState;
   }

   public void setRegisteredState(String registeredState)
   {
      this.registeredState = registeredState;
   }

   public Boolean getUserAssetOverride()
   {
      return userAssetOverride;
   }

   public void setUserAssetOverride(Boolean userAssetOverride)
   {
      this.userAssetOverride = userAssetOverride;
   }

   public List<DataPortfolio> getPortfolioList()
   {
      return portfolioList;
   }

   public void setPortfolioList(List<DataPortfolio> portfolioList)
   {
      this.portfolioList = portfolioList;
   }


   public Double getAssetAllocationTotal()
   {
      return assetAllocationTotal;
   }

   public void setAssetAllocationTotal(Double assetAllocationTotal)
   {
      this.assetAllocationTotal = assetAllocationTotal;
   }

   public Double getTotalSharesAllocated()
   {
      return totalSharesAllocated;
   }

   public void setTotalSharesAllocated(Double totalSharesAllocated)
   {
      this.totalSharesAllocated = totalSharesAllocated;
   }

   public Double getTotalMoneyAllocated() {
      return this.totalMoneyAllocated;
   }

   public void setTotalMoneyAllocated(Double totalMoneyAllocated)
   {
      this.totalMoneyAllocated = totalMoneyAllocated;
   }

   public DataPortfolio getSelectedPortfolio()
   {
      return selectedPortfolio;
   }

   public void setSelectedPortfolio(DataPortfolio selectedPortfolio)
   {
      this.selectedPortfolio = selectedPortfolio;
   }

   public void loadAssetClass() {
      AssetClass[] aamc;
      try {
         setAssetData(null);
         aamc = getAllocModel().getAssetDistribution((ProfileData) this.getInstance());
         if (aamc != null)  {
            setAssetData(aamc);
            if (getUserAssetOverride())
               getAllocModel().overrideAssetWeight(aamc[0], this.getEditableAsset());

            loadEditableAssetClass(aamc[0].getAssetclass());
         }
      }
      catch (Exception ex) {
         ex.printStackTrace();
      }
   }

   public void loadPortfolio() {
      AssetClass[] aamc;
      Portfolio[] pfclass;
      MsgData data = new MsgData();
      try
      {
         Integer displayYear = 0;
         aamc = getAssetData();
         if (aamc != null)
         {
            pfclass = getPortfolioModel().getDistributionList(aamc,
                                                              (ProfileData) getInstance());
            if (pfclass != null)
            {
               setPortfolioData(pfclass);

               // Now refresh the Display List
               loadPortfolioList(displayYear);
            }
         }

      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   public void loadEditableAssetClass(Map<String,Asset> assetdata)
   {
      Double totalAlloc;
      String assetname;
      String cashAsset = "Cash";
      Double cashAlloc = 0.0;
      Double adjustment = 0.0;

      if (getEditableAsset() != null) {
         if (getAssetData() != null)  {
            getEditableAsset().clear();
            totalAlloc = 0.0;
            for (int loop=0; loop < getAssetData()[0].getOrderedAsset().size(); loop++) {
               assetname = getAssetData()[0].getOrderedAsset().get(loop);
               totalAlloc =  totalAlloc + assetdata.get(assetname).getWeight();
               if (assetname.equalsIgnoreCase(cashAsset)) {
                  cashAlloc = assetdata.get(assetname).getWeight();
               }
               getEditableAsset().add(loop,assetdata.get(assetname));
            }
            if (totalAlloc < 100.0) {
               adjustment = 100.0 - totalAlloc;
               cashAlloc =  cashAlloc + adjustment;
               assetdata.get("Cash").setWeight(cashAlloc);
               totalAlloc = 100.0;
            }
            if (totalAlloc > 100.0) {
               adjustment = totalAlloc - 100.0;
               if (cashAlloc > adjustment) {
                  cashAlloc =  cashAlloc - adjustment;
                  totalAlloc = totalAlloc - adjustment;
               }
               else {
                  totalAlloc = totalAlloc - cashAlloc;
                  cashAlloc = 0.0;
               }
               assetdata.get("Cash").setWeight(cashAlloc);
            }
            totalAlloc = (double) Math.round(totalAlloc);
            setAssetAllocationTotal(totalAlloc);
         }
      }
   }


   public void loadPortfolioList(Integer dataYear)
   {
         Double totalMoney=0.0;
         Double addedShares = 0.0;
         Double addedTotalMoney=0.0;
         Double weight=0.0;
         if (getPortfolioList() == null) {
            this.portfolioList = new ArrayList<DataPortfolio>();
         }

         if (getPortfolioData() != null) {
            getPortfolioList().clear();
            int rowSize = getPortfolioData()[dataYear].getPortfolio().size();
            totalMoney = getPortfolioData()[dataYear].getTotalMoney();
            for (int loop = 0; loop < rowSize; loop++)
            {
               PortfolioSecurityData pfList = getPortfolioData()[dataYear].getPortfolio().get(loop);
               if (totalMoney == 0)
                   weight=0.0;
               else
                    weight = pfList.getMoney()/totalMoney;
               addedTotalMoney += pfList.getMoney();
               addedShares +=  pfList.getShares();
               DataPortfolio dp = new DataPortfolio(pfList.getAssetclass(), pfList.getSubclass(), pfList.getColor(),
                                                    pfList.getTicker(), pfList.getName(), (int) pfList.getShares(),
                                                    pfList.getDailyprice(), pfList.getMoney(), pfList.getSortorder(),
                                                    pfList.getTickerWeights(), weight);
               getPortfolioList().add(loop, dp);
            }
            addedTotalMoney = Math.round(addedTotalMoney * 100.00) / 100.00; // round off..
            setTotalMoneyAllocated(addedTotalMoney);
            setTotalSharesAllocated(addedShares);
         }
   }

   public List<DataPortfolio> getSelectedPortfolioList()
   {
      return selectedPortfolioList;
   }

   public void setSelectedPortfolioList(List<DataPortfolio> selectedPortfolioList)
   {
      this.selectedPortfolioList = selectedPortfolioList;
   }



   public String displayMoney(Double money) {
      DecimalFormat df = new DecimalFormat("###,####,###.00");
      String strValue = df.format(money);
      return "$" + strValue;
   }

   public String displayShares(Integer shares) {
      DecimalFormat df = new DecimalFormat("###,####,###");
      String strValue = df.format(shares);
      return strValue;
   }

   public String displayPercent(Double value) {
      Integer newvalue;

      try {
         if (value > 1)
            newvalue = (int) (Math.round(value * 10.00)/10.00);
         else
            newvalue = (int) (Math.round(value * 100.00));

         DecimalFormat df = new DecimalFormat("###");
         String strValue = df.format(newvalue);
         return strValue + "%";
      }
      catch (Exception ex) {
         ex.printStackTrace();
      }
      return "";
   }

   public TreeNode getSubclassDisplayNode()
   {
      return subclassDisplayNode;
   }

   public void setSubclassDisplayNode(TreeNode subclassDisplayNode)
   {
      this.subclassDisplayNode = subclassDisplayNode;
   }

   public TreeNode[] getSubclassFilterNode()
   {
      return subclassFilterNode;
   }

   public void setSubclassFilterNode(TreeNode[] subclassFilterNode)
   {
      this.subclassFilterNode = subclassFilterNode;
   }
}
