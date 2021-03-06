package com.invessence.web.data.common;

import java.util.*;
import java.util.List;
import java.util.Map;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;

import com.invessence.converter.JavaUtil;
import com.invessence.emailer.data.MsgData;
import com.invessence.web.constant.*;
import com.invessence.web.dao.common.*;
import com.invessence.web.dao.consumer.*;
import com.invessence.web.data.*;
import com.invessence.web.data.consumer.RiskCalculator;
import com.invessence.web.util.*;
import com.invmodel.Const.InvConst;
import com.invmodel.asset.data.*;
import com.invmodel.inputData.ProfileData;
import com.invmodel.model.ModelUtil;
import com.invmodel.performance.OptHistoricalReport;
import com.invmodel.performance.data.ProjectionData;
import com.invmodel.portfolio.data.*;
import com.invmodel.risk.data.*;
import org.apache.commons.logging.*;

/**
 * Created with IntelliJ IDEA.
 * User: pichaimanir
 * Date: 8/19/13
 * Time: 4:50 PM
 * To change this template use File | Settings | File Templates.
 */
public class CustomerData extends ProfileData
{
   protected final Log logger = LogFactory.getLog(getClass());

   @ManagedProperty("#{webutil}")
   public WebUtil webutil;

   @ManagedProperty("#{uiLayout}")
   public UILayout uiLayout;

   @ManagedProperty("#{modelUtil}")
   public ModelUtil modelUtil;

   @ManagedProperty("#{consumerListDataDAO}")
   public ConsumerListDataDAO listDAO;

   @ManagedProperty("#{userInfoDAO}")
   public UserInfoDAO userInfoDAO;

   @ManagedProperty("#{consumerSaveDataDAO}")
   public ConsumerSaveDataDAO saveDAO;


   @ManagedProperty("#{consumerAuditDataDAO}")
   public ConsumerAuditDataDAO auditDAO;

   @ManagedProperty("#{tradeDAO}")
   public TradeDAO tradeDAO;

   @ManagedProperty("#{webMessage}")
   public WebMessage messageText;

   private JavaUtil javautil = new JavaUtil();

   public USMaps usstates = USMaps.getInstance();

   private CustomerData manageGoalinstance;

   private Boolean saveVisitor;
   private Integer numofaccounts;
   private String advisorDisplayName;
   private String userid;
   private String addmodflag;
   private String dateOpened;
   private String role, privileges;
   private String created;
   private String phone;

   private AccountFinancials accountFinancials;

   private Integer assetyear = 0;
   private String registeredState;
   private Boolean userAssetOverride;

   private String portfolioName;

   private String email, firstname, lastname;
   private String customName;
   public List<DataPortfolio> displayPortfolioList = new ArrayList<DataPortfolio>();
   public DataPortfolio selectedPortfolio;
   public List<DataPortfolio> selectedPortfolioList = null;
   public Double assetAllocationTotal = 0.0;
   public Double totalSharesAllocated = 0.0;
   public Double totalMoneyAllocated = 0.0;

   private Double managedassetAllocationTotal = 0.0;
   private Double managedtotalMoney = 0.0;


   private String externalPositionFile;

   //private TreeNode subclassDisplayNode;
   //private TreeNode[] subclassFilterNode;
   public Map<String, ManagedSubclassData> subassetList = new HashMap<String, ManagedSubclassData>();
   public ArrayList<ManagedSubclassData> orderedSubclass;
   public List<PortfolioSubclass> excludedSubAsset = new ArrayList<PortfolioSubclass>();

   public Map<String, String> advisorBasket;
   private Boolean managed, editable, isUnopened, canSaveData;
   public String managedFlag, currentStatus;
   private Integer sliderAllocationIndex, sliderPortfolioIndex;

   private Boolean enableChangeStrategy;
   private Boolean displayFTPanel;
   private String savedRiskFormula;
   private Integer savedAllocSliderIndex;
   private Boolean doesUserHavaLogonID;
   private String cstmAccountLabel;
//   private String tradeCurrency;
//   private String settleCurrency;
//   private Double userExchangeRate;


   public void initDao(WebUtil webutil, ModelUtil modelUtil, UILayout uiLayout,
                       ConsumerListDataDAO listDAO, UserInfoDAO userInfoDAO,
                       ConsumerSaveDataDAO saveDAO, TradeDAO tradeDAO,
                       WebMessage messageText, ConsumerAuditDataDAO auditDAO)
   {
      setWebutil(webutil);
      setModelUtil(modelUtil);
      setUiLayout(uiLayout);
      setListDAO(listDAO);
      setUserInfoDAO(userInfoDAO);
      setSaveDAO(saveDAO);
      setTradeDAO(tradeDAO);
      setMessageText(messageText);
      setAuditDAO(auditDAO);
   }


   public void setWebutil(WebUtil webutil)
   {
      this.webutil = webutil;
   }

   public void setUiLayout(UILayout uiLayout)
   {
      this.uiLayout = uiLayout;
   }

   public void setModelUtil(ModelUtil modelUtil)
   {
      this.modelUtil = modelUtil;
   }

   public void setListDAO(ConsumerListDataDAO listDAO)
   {
      this.listDAO = listDAO;
   }

   public void setUserInfoDAO(UserInfoDAO userInfoDAO)
   {
      this.userInfoDAO = userInfoDAO;
   }

   public void setSaveDAO(ConsumerSaveDataDAO saveDAO)
   {
      this.saveDAO = saveDAO;
   }

   public void setTradeDAO(TradeDAO tradeDAO)
   {
      this.tradeDAO = tradeDAO;
   }

   public void setMessageText(WebMessage messageText)
   {
      this.messageText = messageText;
   }

   public WebUtil getWebutil()
   {
      return webutil;
   }

   public UILayout getUiLayout()
   {
      return uiLayout;
   }

   public ConsumerListDataDAO getListDAO()
   {
      return listDAO;
   }

   public ConsumerSaveDataDAO getSaveDAO()
   {
      return saveDAO;
   }

   public WebMessage getMessageText()
   {
      return messageText;
   }

   public JavaUtil getJavautil()
   {
      return javautil;
   }

   public USMaps getUsstates()
   {
      return usstates;
   }

   public void setUsstates(USMaps usstates)
   {
      this.usstates = usstates;
   }

   public Log getLogger()
   {
      return logger;
   }

   public CustomerData()
   {
      super();
      manageGoalinstance = this;
      displayPortfolioList = new ArrayList<DataPortfolio>();
      selectedPortfolio = new DataPortfolio();
      selectedPortfolioList = null;
      subassetList = new HashMap<String, ManagedSubclassData>();
      orderedSubclass = new ArrayList<ManagedSubclassData>();
      excludedSubAsset = new ArrayList<PortfolioSubclass>();
      accountFinancials = new AccountFinancials();
      riskProfile = new UserRiskProfile();
      // resetCustomerData();
   }

   public CustomerData getInstance()
   {
      return manageGoalinstance;
   }

   public ModelUtil getModelUtil()
   {
      return modelUtil;
   }

   public Boolean getManaged()
   {
      return ((managed == null) ? false : managed);
   }

   public void setManaged(Boolean managed)
   {
      this.managed = managed;
   }

   public Boolean isUnopened()
   {
      return (isUnopened == null) ? false : isUnopened;
   }

   public Boolean getUnopened()
   {
      return isUnopened;
   }

   public void setUnopened(Boolean unopened)
   {
      isUnopened = unopened;
   }

   public Boolean getEditable()
   {
      return ((editable == null) ? true : editable);
   }

   public void setEditable(Boolean editable)
   {
      this.editable = editable;
   }

   public Boolean getCanIEditAccount()
   {
      try
      {
         if (webutil.isUserLoggedIn())
         {
            if (getWebutil().getUserInfoData().getAuthorities().contains(WebConst.ROLE_TEST) || getRole().equalsIgnoreCase(WebConst.ROLE_OWNER) ||
               (getRole().equalsIgnoreCase(WebConst.ROLE_USER) && getPrivileges().equalsIgnoreCase(WebConst.ACCESS_USER_FULL)))
            {
               return true;
            }
         }
         return false;
      }
      catch (Exception ex)
      {
         return false;
      }
   }

   public String getManagedFlag()
   {
      return managedFlag;
   }

   public void setManagedFlag(String managedFlag)
   {
      this.managedFlag = managedFlag;
   }

   public String getCurrentStatus()
   {
      return currentStatus;
   }

   public void setCurrentStatus(String currentStatus)
   {
      this.currentStatus = currentStatus;
   }

   public Integer getSliderAllocationIndex()
   {
      return sliderAllocationIndex;
   }

   public void setSliderAllocationIndex(Integer sliderAllocationIndex)
   {
      this.sliderAllocationIndex = sliderAllocationIndex;
   }

   public Integer getSliderPortfolioIndex()
   {
      return sliderPortfolioIndex;
   }

   public void setSliderPortfolioIndex(Integer sliderPortfolioIndex)
   {
      this.sliderPortfolioIndex = sliderPortfolioIndex;
   }

   public Boolean getEnableChangeStrategy()
   {
      return enableChangeStrategy;
   }

   public void setEnableChangeStrategy(Boolean enableChangeStrategy)
   {
      if (webutil != null)
      {
         if (webutil.getWebprofile().getMode().equalsIgnoreCase("demo"))
         {
            enableChangeStrategy = true;  // If in demo mode, then leave this button enabled/rendered.
         }
      }
      this.enableChangeStrategy = enableChangeStrategy;
   }

   public Boolean getDisplayFTPanel()
   {
      return (displayFTPanel == null) ? false : displayFTPanel;
   }

   public void setDisplayFTPanel(Boolean displayFTPanel)
   {
      this.displayFTPanel = displayFTPanel;
   }

   public Boolean getCanSaveData()
   {
      return (canSaveData == null) ? true : canSaveData;
   }

   public void setCanSaveData(Boolean canSaveData)
   {
      this.canSaveData = canSaveData;
   }

   public void setSavedRiskFormula(String savedRiskFormula)
   {
      this.savedRiskFormula = savedRiskFormula;
   }

   public void setDoesUserHavaLogonID(Boolean doesUserHavaLogonID)
   {
      this.doesUserHavaLogonID = doesUserHavaLogonID;
   }


   public void setSavedAllocSliderIndex(Integer savedAllocSliderIndex)
   {
      this.savedAllocSliderIndex = savedAllocSliderIndex;
   }

   public Double getTotalRisk()
   {
      Double value = 0.0;
      if (getPortfolioData() != null)
      {
         if (getAssetyear() != null && getPortfolioData().length > getAssetyear())
         {
            value = getPortfolioData()[getAssetyear()].getTotalRisk();
         }
         else
         {
            value = getPortfolioData()[0].getTotalRisk();
         }
      }
      return value;
   }

   public String getSavedRiskFormula()
   {
      return savedRiskFormula;
   }

   public Integer getSavedAllocSliderIndex()
   {
      return savedAllocSliderIndex;
   }

   public Boolean getDoesUserHavaLogonID()
   {
      return ((doesUserHavaLogonID == null) ? false : doesUserHavaLogonID);
   }

   public Double getTotalExpectedReturns()
   {
      Double value = 0.0;
      if (getPortfolioData() != null)
      {
         if (getAssetyear() != null && getPortfolioData().length > getAssetyear())
         {
            value = getPortfolioData()[getAssetyear()].getExpReturns();
         }
         else
         {
            value = getPortfolioData()[0].getExpReturns();
         }
      }
      return value;
   }

   public Double getEstimatedGoal()
   {
      Double value = accountFinancials.getInvestment().doubleValue();
      Integer finalyear;
      if (getProjectionData() != null)
      {
         finalyear = getProjectionData().length;
         value = getProjectionData()[finalyear - 1].getTotalCapitalWithGains();
      }
      return value;
   }

   public Boolean getSaveVisitor()
   {
      return saveVisitor;
   }

   public void setSaveVisitor(Boolean saveVisitor)
   {
      this.saveVisitor = saveVisitor;
   }

   public Integer getNumofaccounts()
   {
      return numofaccounts;
   }

   public void setNumofaccounts(Integer numofaccounts)
   {
      this.numofaccounts = numofaccounts;
   }

   public String getAdvisorDisplayName()
   {
      return advisorDisplayName;
   }

   public void setAdvisorDisplayName(String advisorDisplayName)
   {
      this.advisorDisplayName = advisorDisplayName;
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
      return (getManaged() ? "Active" : "Pending");
   }

   public String getDisplayDateOpened()
   {
      return javautil.displayDateFormat(dateOpened);
   }

   public String getDateOpened()
   {
      return dateOpened;
   }

   public void setDateOpened(String dateOpened)
   {
      this.dateOpened = dateOpened;
   }

   public String getRole()
   {
      return role;
   }

   public void setRole(String role)
   {
      this.role = role;
   }

   public String getPrivileges()
   {
      return privileges;
   }

   public void setPrivileges(String privileges)
   {
      this.privileges = privileges;
   }

   public String getCreated()
   {
      return created;
   }

   public void setCreated(String created)
   {
      this.created = created;
   }

   public String getPhone()
   {
      return phone;
   }

   public void setPhone(String phone)
   {
      this.phone = phone;
   }


   public Integer convertNumber(Integer num)
   {
      if (num == null)
      {
         return 0;
      }
      else
      {
         return num;
      }
   }

   public AccountFinancials getAccountFinancials()
   {
      return accountFinancials;
   }

   public void setAccountFinancials(AccountFinancials accountFinancials)
   {
      this.accountFinancials = accountFinancials;
   }

   public Integer getAssetyear()
   {
      return assetyear;
   }

   public void setAssetyear(Integer assetyear)
   {
      this.assetyear = assetyear;
   }

   public String getPortfolioName()
   {
      return portfolioName;
   }

   public void setPortfolioName(String portfolioName)
   {
      this.portfolioName = portfolioName;
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

   @Override
   public String getName()
   {
      String name = super.getName();
      if (name == null)
      {
         if (getFirstname() != null)
         {
            name = getFirstname();
         }

         if (getLastname() != null)
         {
            if (name != null)
            {
               name = name + ", " + getLastname();
            }
            else
            {
               name = getLastname();
            }
         }
      }

      return name;
   }

   @Override
   public void setName(String name)
   {
      super.setName(name);
   }

   public void setCalcFormula(String formula)
   {
      riskProfile.setCalcFormula(formula);
   }

   @Override
   public void setDefault()
   {
      super.setDefault();
      setLogonid(webutil.getLogonid());

      resetAdvisor();  // Reset Advisor
      loadBasketInfo();
      riskProfile = new UserRiskProfile(getAdvisor(), getAcctnum());

      accountFinancials = new AccountFinancials();

      setDoesUserHavaLogonID(webutil.isUserLoggedIn());
      setSaveVisitor(true);
      // BY default, both Trade/Settle Currency are same.  User can override the Trade on UI
      setTradeCurrency(webutil.getWebprofile().getInfo("DEFAULT.CURRENCY"));
      setSettleCurrency(webutil.getWebprofile().getInfo("DEFAULT.CURRENCY"));

   }

   @Override
   public void resetData()
   {
      // Manage Goal Data.
      if (getDoesUserHavaLogonID())
      {
         super.resetData();
      }
      else
      {
         resetAdvisor();  // Reset Advisor
         loadBasketInfo();
         riskProfile = new UserRiskProfile(getAdvisor(), getAcctnum());
         super.resetData();
         setUserid(null);
         setPortfolioName(null);
         setAddmodflag(null);
         setDateOpened(null);
         setManaged(false);
         setRole(null);
         setPrivileges(null);
         setNumofaccounts(0);

         setAssetyear(0);

         setEmail(null);
         setFirstname(null);
         setLastname(null);
         setRegisteredState(null);
         setUserAssetOverride(false);
         setName(null);
         setUserAssetOverride(false);
         setPhone(null);

         if (displayPortfolioList != null)
         {
            displayPortfolioList.clear();
         }

         setSelectedPortfolio(null);

         if (selectedPortfolioList != null)
         {
            selectedPortfolioList.clear();
         }

         setAssetAllocationTotal(0.0);
         setTotalSharesAllocated(0.0);
         setTotalMoneyAllocated(0.0);
         setManagedassetAllocationTotal(0.0);
         setManagedtotalMoney(0.0);

         if (excludedSubAsset != null)
         {
            excludedSubAsset.clear();
         }
         if (subassetList != null)
         {
            subassetList.clear();
         }
         if (orderedSubclass != null)
         {
            orderedSubclass.clear();
         }

         if (advisorBasket == null)
         {
            advisorBasket = new HashMap<String, String>();
         }
         else
         {
            advisorBasket.clear();
         }
         sliderAllocationIndex = 0;
         sliderPortfolioIndex = 0;

         setSavedRiskFormula(null);
         setSavedAllocSliderIndex(null);

         accountFinancials = new AccountFinancials();
         setDisplayFTPanel(false);
         setCanSaveData(true);
      }
   }

   public void resetCustomerData()
   {
      resetData();
   }

   public void resetAdvisor()
   {

      if (webutil != null)
      {
         if (webutil.isUserLoggedIn())
         {
            if (getAdvisor() == null)
            {
               setAdvisor(webutil.getUserInfoData().getAdvisor());
            }
            if (getRep() == null)
            {
               setRep(webutil.getUserInfoData().getRep());
            }
         }
         else
         {
            if (webutil.getWebprofile() != null)
            {
               if (getAdvisor() == null || getAdvisor().isEmpty())
               {
                  setAdvisor(webutil.getWebprofile().getDefaultAdvisor());
               }
               if (getRep() == null || getRep().isEmpty())
               {
                  setRep(webutil.getWebprofile().getDefaultRep());
               }
            }
         }
      }
   }

   public void copyData(CustomerData newgoals)
   {
      // Master ProfileData
      //setName(newgoals.getName());  Being set at bottom
      setPortfolioName(newgoals.getPortfolioName());
      setAge(newgoals.getAge());
      setHorizon(newgoals.getHorizon());
      setInitialInvestment(newgoals.getInitialInvestment());
      setRecurringInvestment(newgoals.getRecurringInvestment());
      setExperience(newgoals.getExperience());
      setObjective(newgoals.getObjective());
      setStayInvested(newgoals.getStayInvested());
      setCharitableGoals(newgoals.getCharitableGoals());
      setDependent(newgoals.getDependent());
      setAccountTaxable(newgoals.getAccountTaxable());
      setTaxrate(newgoals.getTaxrate());
      setRiskIndex(newgoals.getRiskIndex());

      // ManageGoal Data
      setAcctnum(newgoals.getAcctnum());
      setLogonid(newgoals.getLogonid());
      setUserid(newgoals.getUserid());
      setAdvisor(newgoals.getAdvisor());
      setRep(newgoals.getRep());
      setAddmodflag(newgoals.getAddmodflag());
      setGoal(newgoals.getGoal());
      setAccountType(newgoals.getAccountType());
      setName(newgoals.getName());
      setAssetData(newgoals.getAssetData());
      setPortfolioData(newgoals.getPortfolioData());
      setFirstname(newgoals.getFirstname());
      setLastname(newgoals.getLastname());
      setRegisteredState(newgoals.getRegisteredState());
      setUserAssetOverride(false);
      setName(newgoals.getFirstname() + " " + newgoals.getLastname());
      setSettleCurrency(newgoals.getSettleCurrency());
      setTradeCurrency(newgoals.getTradeCurrency());

      accountFinancials = newgoals.accountFinancials;
   }

   public String getHorizonQuestion()
   {
      String question = "How many years do you plan to invest?";
      if (getGoal() != null)
      {
         if (getGoal().equalsIgnoreCase("retirement"))
         {
            return "Number of years to your retirement?";
         }
         if (getGoal().equalsIgnoreCase("home"))
         {
            return "How many years until you purchase your home?";
         }
         if (getGoal().equalsIgnoreCase("wedding"))
         {
            return "Number of years to your wedding?";
         }
         if (getGoal().equalsIgnoreCase("automobile"))
         {
            return "How many years until you purchase automobile?";
         }
         if (getGoal().equalsIgnoreCase("education"))
         {
            return "How many years to your child's college graduation?";
         }
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
      return (userAssetOverride == null ? false : userAssetOverride);
   }

   public void setUserAssetOverride(Boolean userAssetOverride)
   {
      this.userAssetOverride = userAssetOverride;
   }

   public List<DataPortfolio> getDisplayPortfolioList()
   {
      return displayPortfolioList;
   }

   public void setDisplayPortfolioList(List<DataPortfolio> displayPortfolioList)
   {
      this.displayPortfolioList = displayPortfolioList;
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

   public Double getTotalMoneyAllocated()
   {
      return totalMoneyAllocated;
   }

   public void setTotalMoneyAllocated(Double totalMoneyAllocated)
   {
      Double lowerbound = getDefaultInvestment() - 0.05;
      Double upperbound = getDefaultInvestment() + 0.05;
      if (totalMoneyAllocated >= lowerbound && totalMoneyAllocated <= upperbound)
      {
         this.totalMoneyAllocated = getDefaultInvestment();
      }
      else
      {
         this.totalMoneyAllocated = totalMoneyAllocated;
      }
   }

   public Double getManagedassetAllocationTotal()
   {
      return managedassetAllocationTotal;
   }

   public void setManagedassetAllocationTotal(Double managedassetAllocationTotal)
   {
      this.managedassetAllocationTotal = managedassetAllocationTotal;
   }

   public Double getManagedtotalMoney()
   {
      return managedtotalMoney;
   }

   public void setManagedtotalMoney(Double managedtotalMoney)
   {
      this.managedtotalMoney = managedtotalMoney;
   }

   public DataPortfolio getSelectedPortfolio()
   {
      return selectedPortfolio;
   }

   public void setSelectedPortfolio(DataPortfolio selectedPortfolio)
   {
      this.selectedPortfolio = selectedPortfolio;
   }

/*
   public void resetAllocationIndex() {
      setAllocationIndex(allocModel.getAllocationIndex(getProfileInstance());;
   }

   public void resetPortfolioIndex() {
      setPortfolioIndex(portfolioModel.getPortfolioIndex(getProfileInstance()));
   }
*/

   public void loadBasketInfo()
   {

      if (getTheme() == null)
      {
         setTheme(webutil.getWebprofile().getModel());
      }

      if (getAccountTaxable())
      {
         setAdvisorBasket(listDAO.getBasket(getAdvisor(), "T"));
      }
      else
      {
         setAdvisorBasket(listDAO.getBasket(getAdvisor(), "R"));
      }

      setBasket(getAdvisorBasket().get(getTheme()));
   }


   public void buildAssetClass()
   {
      AssetClass[] aamc;
      try
      {
         setAssetData(null);
         aamc = modelUtil.buildAllocation(getProfileInstance());
         if (aamc != null)
         {
            setAssetData(aamc);
         }
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   public void buildPortfolio()
   {
      AssetClass[] aamc;
      Portfolio[] pfclass;
      MsgData data = new MsgData();
      try
      {
         Integer displayYear = 0;
         aamc = getAssetData();
         if (aamc != null)
         {
            pfclass = modelUtil.buildPortfolio(aamc,
                                               getProfileInstance());
            if (pfclass != null)
            {
               setPortfolioData(pfclass);
               // Now refresh the Display List
               loadPortfolioList(displayYear);
            }
            rollupAssetClass(pfclass[0]);
         }

      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   public void buildGoalsData()
   {

      Integer numOfYears = 20;
      if (getGoalData() != null && getGoalData().getTerm() != null)
      {
         numOfYears = getGoalData().getTerm().intValue();
      }
      else
      {
         if (getHorizon() == null)
         {
            numOfYears = ((65 - getAge()) > 20) ? 20 : (65 - getAge());
         }
         else
         {
            numOfYears = getHorizon();
         }

         if (numOfYears < 5)
         {
            numOfYears = 5;
         }
      }


      ArrayList<ProjectionData[]> perfData = modelUtil.buildProjectionData(getProfileInstance());
      setProjectionData(perfData.get(0));
      modelUtil.goalTracking(getProfileInstance());

   }

   public void totalAssetClassWeights(Map<String, Asset> assetdata, Integer offset)
   {
      Double totalAlloc;
      Double assetWeight;
      String assetname;
      Double cashAlloc = 0.0;
      Double adjustment = 0.0;

      if (getEditableAsset() == null)
      {
         recreateEditableAsset();
      }
      else
      {
         if (getAssetData() != null)
         {
            getEditableAsset().clear();
            totalAlloc = 0.0;
            for (int loop = 0; loop < getAssetData()[offset].getOrderedAsset().size(); loop++)
            {
               assetname = getAssetData()[offset].getOrderedAsset().get(loop);
               Asset asset = assetdata.get(assetname);
               setEditableAsset(asset);
               assetWeight = asset.getActualweight();
               totalAlloc = totalAlloc + assetWeight;
            }
            totalAlloc = (Math.round(totalAlloc) * 100.0);
            setAssetAllocationTotal(totalAlloc);
         }
      }
   }

   public void reloadManagedAssetClass(Map<String, Asset> assetdata, int year)
   {
      Double totalAlloc = 0.0;
      String assetname;
      Asset asset;
      String cashAsset = "Cash";
      Double cashAlloc = 0.0;
      Double adjustment = 0.0;

      setManagedassetAllocationTotal(0.0);
      setManagedtotalMoney(0.0);
      if (getEditableAsset() != null)
      {
         if (getAssetData() != null)
         {
            Integer numOfAsset = getAssetData().length;
            if (numOfAsset >= year)
            {
               setManagedassetAllocationTotal(0.0);
               setManagedtotalMoney(0.0);
               for (int loop = 0; loop < getAssetData()[year].getOrderedAsset().size(); loop++)
               {
                  assetname = getAssetData()[year].getOrderedAsset().get(loop);
                  asset = getAssetData()[year].getAsset(assetname);
                  if (assetdata.containsKey(assetname))
                  {
                     asset.setHoldingweight(assetdata.get(assetname).getHoldingweight());
                     asset.setHoldingRisk(assetdata.get(assetname).getHoldingRisk());
                     asset.setHoldingReturn(assetdata.get(assetname).getHoldingReturn());
                     asset.setHoldingValue(assetdata.get(assetname).getHoldingValue());
                     setManagedassetAllocationTotal(getManagedassetAllocationTotal() + assetdata.get(assetname).getHoldingweight());
                     setManagedtotalMoney(getManagedtotalMoney() + assetdata.get(assetname).getHoldingValue());
                  }
                  else
                  {
                     asset.setHoldingweight(0.0);
                     asset.setHoldingRisk(0.0);
                     asset.setHoldingReturn(0.0);
                     asset.setHoldingValue(0.0);
                  }
               }
            }
         }
      }
   }

   public void loadPortfolioList(Integer dataYear)
   {
      Double totalMoney = 0.0;
      Double addedShares = 0.0;
      Double addedTotalMoney = 0.0;
      Double weight = 0.0;
      if (getDisplayPortfolioList() == null)
      {
         displayPortfolioList = new ArrayList<DataPortfolio>();
      }

      if (getPortfolioData() != null)
      {
         displayPortfolioList.clear();
         int rowSize = getPortfolioData()[dataYear].getPortfolio().size();
         totalMoney = getPortfolioData()[dataYear].getTotalMoney();
         for (int loop = 0; loop < rowSize; loop++)
         {
            PortfolioSecurityData pfList = getPortfolioData()[dataYear].getPortfolio().get(loop);
            if (totalMoney == 0)
            {
               weight = 0.0;
            }
            else
            {
               weight = pfList.getMoney() / totalMoney;
            }
            addedTotalMoney += pfList.getMoney();
            addedShares += pfList.getShares();
            DataPortfolio dp = new DataPortfolio(pfList.getAssetclass(), pfList.getSubclass(), pfList.getColor(),
                                                 pfList.getTicker(), pfList.getName(), (int) pfList.getShares(),
                                                 pfList.getDailyprice(), pfList.getMoney(), pfList.getSortorder(),
                                                 pfList.getTickerWeights(), weight,
                                                 pfList.getIsin(), pfList.getCusip(), pfList.getRic(),
                                                 pfList.getTradeCurrency(), pfList.getExchangeRate(), pfList.getSettleCurrency(),
                                                 pfList.getSettleShares(), pfList.getSettleMoney(), pfList.getSettleMoney());
            getDisplayPortfolioList().add(loop, dp);
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

   public List<PortfolioSubclass> getExcludedSubAsset()
   {
      return excludedSubAsset;
   }

   public void setExcludedSubAsset(List<PortfolioSubclass> excludedSubAsset)
   {
      this.excludedSubAsset = excludedSubAsset;
   }

   public Map<String, ManagedSubclassData> getSubassetList()
   {
      return subassetList;
   }

   public void setSubassetList(Map<String, ManagedSubclassData> subassetList)
   {
      this.subassetList = subassetList;
   }

   public ArrayList<ManagedSubclassData> getOrderedSubclass()
   {
      return orderedSubclass;
   }

   public void setOrderedSubclass(ArrayList<ManagedSubclassData> orderedSubclass)
   {
      this.orderedSubclass = orderedSubclass;
   }

   public String getExternalPositionFile()
   {
      return externalPositionFile;
   }

   public void setExternalPositionFile(String externalPositionFile)
   {
      this.externalPositionFile = externalPositionFile;
   }

   public Map<String, String> getAdvisorBasket()
   {
      return advisorBasket;
   }

   public void setAdvisorBasket(Map<String, String> advisorBasket)
   {
      this.advisorBasket = advisorBasket;
   }

   public String getThisBasket()
   {
      return getBasket();
   }

   // This happens in dropdown.  They select the KEY, so we are setting both KEY and value.
   public void setThisBasket(String value)
   {
      if (value == null)
      {
         setBasket(value, InvConst.DEFAULT_BASKET);
         setTheme(InvConst.DEFAULT_THEME);
      }
      else
      {
         if (advisorBasket.containsKey(value))
         {
            setBasket(value, advisorBasket.get(value));
            setTheme(value);
         }
      }
   }

   public void rollupAssetClass(Portfolio pfclass)
   {
      Map<String, Asset> tallyAssetclass = new LinkedHashMap<String, Asset>();
      Double totalMoney = 0.0;
      Double remainMoney = getDefaultInvestment();
      if (pfclass != null  && pfclass.getPortfolio().size() > 0)
      {
         String displayName;
         Double allocwght;
         String color;
         for (PortfolioSecurityData seclist : pfclass.getPortfolio())
         {
            String assetname = seclist.getAssetclass();
            Asset origData = getAssetData()[0].getAsset(assetname);
            if (origData != null)
            {
               displayName = origData.getDisplayName();
               allocwght = origData.getAllocweight();
               color = origData.getColor();
            }
            else
            {
               displayName = seclist.getAssetclass();
               allocwght = seclist.getWeight();
               color = seclist.getColor();
            }
            Double wght = seclist.getWeight();
            Double money = seclist.getMoney();
            Double summoney = 0.0;

            totalMoney += money;
            remainMoney -= money;

            if (!tallyAssetclass.containsKey(assetname))
            {
               Asset asset = new Asset();
               Double newwght = 0.0;
               if (totalMoneyAllocated > 0.0)
               {
                  newwght = money / totalMoneyAllocated;
               }

               asset.setAsset(assetname);
               asset.setDisplayName(displayName);
               asset.setColor(color);
               asset.setValue(money);
               asset.setActualweight(newwght);
               asset.setUserweight(newwght);
               asset.setAllocweight(allocwght);
               asset.setValue(money);
               tallyAssetclass.put(assetname, asset);
            }
            else
            {
               Asset asset = tallyAssetclass.get(assetname);
               // asset.setDisplayName(origData.getDisplayName());
               summoney = money + asset.getValue();
               Double newwght = 0.0;
               if (totalMoneyAllocated > 0.0)
               {
                  newwght = summoney / totalMoneyAllocated;
               }
               asset.setActualweight(newwght);
               asset.setUserweight(newwght);
               // asset.setAllocweight(wght + asset.getAllocweight());
               asset.setValue(summoney);
               // asset.setColor(origData.getColor());
               tallyAssetclass.put(assetname, asset);
            }
         }

         // Final adjustements to Cash
         String cash = "Cash";
         if (remainMoney > 0)
         {
            if (tallyAssetclass.containsKey(cash))
            {
               tallyAssetclass.get(cash).setValue(tallyAssetclass.get(cash).getValue() + remainMoney);
            }
            else
            {
               // For some reason, no cash was allocated on Portfolio.  So create a cash bucket.
               Asset asset = tallyAssetclass.get(cash);
               Double newwght = remainMoney / totalMoneyAllocated;
               asset.setAsset(asset.getAsset());
               asset.setDisplayName(asset.getAsset());
               asset.setColor(asset.getColor());
               asset.setActualweight(newwght);
               asset.setUserweight(newwght);
               asset.setAllocweight(newwght);
               asset.setValue(remainMoney);
               tallyAssetclass.put(cash, asset);
            }
         }

         // After the tally is done, lets reallocate to whole
         if (tallyAssetclass.size() > 0)
         {
            recreateEditableAsset();
            AssetClass[] aamc = new AssetClass[tallyAssetclass.size()];
            Integer i = 0;
            aamc[i] = new AssetClass();
            for (Asset newData : tallyAssetclass.values())
            {
               // for (Asset assetdata : tallyAssetclass.values()) {
               String name = newData.getAsset();
               setEditableAsset(newData);
               aamc[i].addAssetClass(name, newData.getDisplayName(), newData.getColor(),
                                     newData.getAllocweight(), newData.getAvgReturn());
               aamc[i].getAssetclass().get(name).setValue(newData.getValue());
               aamc[i].getAssetclass().get(name).setUserweight(newData.getUserweight());
               aamc[i].getAssetclass().get(name).setActualweight(newData.getActualweight());
            }
            setAssetData(aamc);
         }
      }
   }

   public Boolean getHasClientID()
   {

      return (getClientAccountID() != null && !getClientAccountID().isEmpty());


   }

   public Boolean getHasPosition()
   {
      return (getClientAccountID() != null)
         && (getActualInvestment() != null && getActualInvestment() > 0.0);
   }

   public Boolean getReqPrflCnf()
   {
      if (getManaged() && getCurrentStatus().equalsIgnoreCase("CONFIRMATION"))
      {
         return true;
      }
      else
      {
         return false;
      }
   }

   public String getDisplayActiveAcctNum()
   {
      if (getManaged())
      {
         return getClientAccountID();
      }
      else
      {
         return getCurrentStatus();
      }
   }

   public void saveVisitor(String message)
   {

      try
      {
         if (getSaveVisitor())
         {
            UserData data = new UserData();
            data.setAcctnum(getAcctnum());
            data.setAdvisor(webutil.getWebprofile().getDefaultAdvisor());
            data.setRep(webutil.getWebprofile().getDefaultRep());
            data.setEmail(null);
            data.setIp(webutil.getClientIpAddr());
            data.setMessage(message);
            if (saveDAO != null)
            {
               saveDAO.saveVisitor(data);
            }
            setSaveVisitor(false);
         }
      }
      catch (Exception ex)
      {

      }
   }

   public Boolean registerUser()
   {
      try
      {
         UserData userdata = new UserData();
         userdata.setFirstName(getFirstname());
         userdata.setLastName(getLastname());
         userdata.setFullName(getName());
         userdata.setEmail(getEmail());
         userdata.setUserID(getEmail());
         userdata.setIp(webutil.getClientIpAddr());
         userdata.setAcctnum(getAcctnum());
         String msgheader, msg;

         if (userInfoDAO.validateUserID(userdata))
         {
            logger.debug("LOG: Validate UserID failed: " + getEmail());
            msgheader = "signup.U100";
            msg = webutil.getMessageText().getDisplayMessage(msgheader, "This Email is already registered!", null);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, msg, msgheader));
         }
         else
         {
            Integer myResetID = webutil.randomGenerator(0, 347896);
            userdata.setUserInfo(WebConst.ROLE_USER, getAdvisor(), getRep(), myResetID);
            long loginID = userInfoDAO.addUserInfo(userdata);

            if (loginID <= 0L)
            {
               logger.debug("ERROR: Had issue with this userid when attempting to save: " + loginID);
               msgheader = "signup.U106";
               msg = webutil.getMessageText().getDisplayMessage(msgheader, "There was some error when attempting to save this userid.  Please reach out to support desk.", null);
               webutil.redirecttoMessagePage("ERROR", msg, "Failed Signup" + msgheader);
               webutil.alertSupport("Userbean.saveUser", "Save -" + getEmail(), "Save Registration Error", null);
            }
            userdata.setLogonID(loginID);
            setLogonid(loginID);
            webutil.sendConfirmation(userdata, "W");

            setDoesUserHavaLogonID(true);
            return true;
         }
         return false;
      }
      catch (Exception ex)
      {
         String msgheader = "signup.EX.100";
         String msg = webutil.getMessageText().getDisplayMessage(msgheader, "Exception: Create UserID/Pwd, problem attempting to create simpleuser", null);
         FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, msg, msgheader));
         ex.printStackTrace();
      }
      return false;
   }

   public void setAccountType()
   {
      if (getAccountTaxable())
      {
         setAccountType("Taxable");
      }
      else
      {
         setAccountType("Non-Taxable");
      }

   }

   public void setDefaults()
   {
      UserInfoData uid = webutil.getUserInfoData();
      if (uid != null)
      {
         setAdvisor(uid.getAdvisor()); // Portfolio solves the null issue, or blank issue.
         setRep(uid.getRep()); // Portfolio solves the null issue, or blank issue.
         setLogonid(uid.getLogonID());
         loadBasketInfo();
      }

      // age = riskProfile.getDefaultAge();
      // horizon = riskProfile.getDefaultHorizon();
      // initialInvestment = riskProfile.getDefaultInitialInvestment().intValue();
      // recurringInvestment = riskProfile.getDefaultRecurringInvestment().intValue();
   }


   public void loadNewClientData()
   {
      try
      {
         listDAO.getNewClientProfileData((CustomerData) this.getInstance());
         riskProfile.fetchUserRiskData(getAdvisor(), null);
         if (!webutil.isUserLoggedIn())
         {
            setSaveVisitor(true); // If it is new client, then save Visitor's info.
         }
         setDefaults();
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }


   public void loadProfileData(Long acctnum)
   {

      try
      {

         if (webutil.isUserLoggedIn())
         {
            UserInfoData uid = webutil.getUserInfoData();
            if (uid != null)
            {
               setAdvisor(uid.getAdvisor()); // Portfolio solves the null issue, or blank issue.
               setRep(uid.getRep()); // Portfolio solves the null issue, or blank issue.
               setLogonid(uid.getLogonID());
            }
            else
            {
               setAdvisor(webutil.getWebprofile().getDefaultAdvisor()); // Portfolio solves the null issue, or blank issue.
               setRep(webutil.getWebprofile().getDefaultRep()); // Portfolio solves the null issue, or blank issue.
               // setLogonid(null);
            }
            setAcctnum(acctnum);
            listDAO.getProfileData(getInstance());
         }

      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   public void loadRiskData()
   {
      riskProfile.fetchUserRiskData(getAdvisor(), getAcctnum());
   }

   public void loadRiskData(Long acctnum, RiskCalculator riskCalculator)
   {
      try
      {
         listDAO.getRiskProfileData(acctnum, riskCalculator);
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   public void saveProfile()
   {
      Long acctnum;
      try
      {
         // setDefaults();
         acctnum = saveDAO.saveProfileData(getInstance());
         if (acctnum > 0)
         {
            saveVisitor(null);
            setSaveVisitor(false);
            setAcctnum(acctnum);
            riskProfile.saveAllData();
            // saveDAO.saveRiskProfile(riskProfile);
            saveDAO.saveFinancials(getInstance());
            if (getAssetData() != null)
            {
               saveDAO.saveAllocation(getInstance());
            }
            if (getPortfolioData() != null)
            {
               saveDAO.savePortfolio(getInstance());
            }
         }
         // FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "Data Saved", "Data Saved"));
      }
      catch (Exception ex)
      {
         String stackTrace = ex.getMessage();
         webutil.alertSupport("CustomerData.saveprofile", "Error:CustomerData.SaveProfile",
                              "error.saveprofile", stackTrace);
         ex.printStackTrace();
      }

   }

   // Deprecated
   public void saveProfile(RiskCalculator riskcalculator)
   {
      Long acctnum;
      try
      {
         // setDefaults();
         acctnum = saveDAO.saveProfileData(getInstance());
         if (acctnum > 0)
         {
            saveVisitor(null);
            setAcctnum(acctnum);
            if (riskProfile != null && riskProfile.getALLRiskScores().size() != 0)
            {
               riskProfile.saveAllData();
            }
            else
            {
               saveDAO.saveRiskProfile(acctnum, riskcalculator);
            }
            saveDAO.saveFinancials(getInstance());
            saveDAO.saveAllocation(getInstance());
            saveDAO.savePortfolio(getInstance());
         }
         // FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "Data Saved", "Data Saved"));
      }
      catch (Exception ex)
      {
         String stackTrace = ex.getMessage();
         webutil.alertSupport("CustomerData.saveprofile", "Error:CustomerData.SaveProfile",
                              "error.saveprofile", stackTrace);
         ex.printStackTrace();
      }

   }

   public void saveProfileAudit()
   {
      try
      {
         auditDAO.auditClientProfile(getInstance().getAcctnum());
      }
      catch (Exception ex)
      {
         String stackTrace = ex.getMessage();
         webutil.alertSupport("CustomerData.saveProfileAudit", "Error:CustomerData.saveProfileAudit",
                              "error.saveProfileAudit", stackTrace);
         ex.printStackTrace();
      }

   }

   public void createAssetPortfolio()
   {
      AssetClass[] aamc;
      Portfolio[] pfclass;
      try
      {
         setAssetData(null);
         aamc = modelUtil.buildAllocation(getProfileInstance());
         if (aamc != null)
         {
            setAssetData(aamc);
            pfclass = modelUtil.buildPortfolio(aamc, getProfileInstance());
            if (pfclass != null)
            {
               setPortfolioData(pfclass);
               loadPortfolioList(0);
               rollupAssetClass(pfclass[0]);
               buildHistoricalReturns();
            }
         }
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   public void createAssetPortfolio(Integer noOfYears, Double riskIndex)
   {

      try
      {
         String tTheme = getTheme();
         if (isAccountTaxable())
         {
            if (!tTheme.startsWith("T."))
            {
               setTheme("T." + tTheme);
            }
         }
         else
         {
            if (tTheme.startsWith("T."))
            {
               setTheme(tTheme.substring(2));
            }
         }

         setRiskIndex(riskIndex);
         setNumOfAllocation(noOfYears);
         setNumOfPortfolio(noOfYears);
         buildAssetClass();
         buildPortfolio();
         buildHistoricalReturns();
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   public void createDynaAssetPortfolio(Integer noOfYears, Double riskIndex, String Theme)
   {

      try
      {
         setTheme(Theme);
         setRiskIndex(riskIndex);
         setNumOfAllocation(noOfYears);
         setNumOfPortfolio(noOfYears);
         buildAssetClass();
         buildPortfolio();
         buildHistoricalReturns(Theme);
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   public void createPortfolio(Integer noOfYears)
   {

      try
      {
         setNumOfPortfolio(noOfYears);
         buildPortfolio();
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   public void buildHistoricalReturns()
   {
      OptHistoricalReport optHistoricalReport = new OptHistoricalReport();
      optHistoricalReport.calcuatePerformance(getTheme(), getPortfolioData());

   }

   public void buildHistoricalReturns(String theme)
   {
      OptHistoricalReport optHistoricalReport = new OptHistoricalReport();
      optHistoricalReport.calcuatePerformance(theme, getPortfolioData());

   }

   public void rollupAssetClassByPosList(List<Position> pfclass, Double dtotalMoneyAllocated)
   {
      Map<String, Asset> tallyAssetclass = new LinkedHashMap<String, Asset>();
      Double totalMoney = 0.0;
      if (pfclass != null)
      {
         for (int i = 0; i < pfclass.size(); i++)
         {
            String assetname = pfclass.get(i).getAssetclass();
            Double wght = pfclass.get(i).getWeight();
            Double money = pfclass.get(i).getPositionValue();
            String color = pfclass.get(i).getColor();
            Double summoney = 0.0;

            totalMoney += money;

            if (!tallyAssetclass.containsKey(assetname))
            {
               Asset asset = new Asset();
               Double newwght = money;
               asset.setAsset(assetname);
               asset.setColor(color);
               asset.setValue(money);
               asset.setActualweight(newwght);
               asset.setUserweight(newwght);
               asset.setAllocweight(newwght);
               asset.setValue(money);
               tallyAssetclass.put(assetname, asset);
            }
            else
            {
               Asset asset = tallyAssetclass.get(assetname);
               summoney = money + asset.getValue();
               Double newwght = summoney;
               asset.setActualweight(newwght);
               asset.setUserweight(newwght);
               asset.setAllocweight(wght + asset.getAllocweight());
               asset.setValue(summoney);
               tallyAssetclass.put(assetname, asset);
            }
         }
      }


      // After the tally is done, lets reallocate to whole
      if (tallyAssetclass.size() > 0)
      {
         recreateEditableAsset();
         AssetClass[] aamc = new AssetClass[tallyAssetclass.size()];
         Integer i = 0;
         aamc[i] = new AssetClass();
         for (Asset assetdata : tallyAssetclass.values())
         {
            Asset origAssetData = aamc[i].getAssetclass().get(assetdata.getAsset());
            if (origAssetData != null)
            {
               origAssetData.setUserweight(assetdata.getUserweight());
               origAssetData.setActualweight(assetdata.getActualweight());
               origAssetData.setValue(assetdata.getValue());
            }
            else
            {
               aamc[i].addAssetClass(assetdata.getAsset(), assetdata.getDisplayName(), assetdata.getColor(),
                                     assetdata.getAllocweight(), assetdata.getAvgReturn());
               aamc[i].getAssetclass().get(assetdata.getAsset()).setValue(assetdata.getValue());
               aamc[i].getAssetclass().get(assetdata.getAsset()).setUserweight(assetdata.getUserweight());
               aamc[i].getAssetclass().get(assetdata.getAsset()).setActualweight(assetdata.getActualweight() / totalMoney);

            }
            assetdata.setActualweight(assetdata.getActualweight() / totalMoney);
            assetdata.setUserweight(assetdata.getUserweight() / totalMoney);
            setEditableAsset(assetdata);
         }
         aamc[i].setTotalInvested(totalMoney);
//         System.out.println("aamc"+aamc);
         setAssetData(aamc);

      }
//      System.out.println("aamc");
   }

   public void updateProfileData(CustomerData objCustomerData)
   {

      Long acctnum;
      try
      {
         System.out.println("after update acctnum " + objCustomerData.getCustomName());
         acctnum = saveDAO.saveProfileData(objCustomerData);
         System.out.println("after update acctnum " + acctnum);
      }
      catch (Exception ex)
      {
         String stackTrace = ex.getMessage();
//      webutil.alertSupport("CustomerData.updateProfileData", "Error:CustomerData.updateProfileData",
//                           "error.saveprofile", stackTrace);
         System.out.println("Error while updating profile " + ex);
         ex.printStackTrace();
      }
   }

   public String getCstmAccountLabel()
   {
      return cstmAccountLabel;
   }

   public void setCstmAccountLabel(String cstmAccountLabel)
   {
      this.cstmAccountLabel = cstmAccountLabel;
   }

   public String getCustomName()
   {
      return customName;
   }

   public void setCustomName(String customName)
   {
      this.customName = customName;
   }

   public ConsumerAuditDataDAO getAuditDAO()
   {
      return auditDAO;
   }

   public void setAuditDAO(ConsumerAuditDataDAO auditDAO)
   {
      this.auditDAO = auditDAO;
   }
}
