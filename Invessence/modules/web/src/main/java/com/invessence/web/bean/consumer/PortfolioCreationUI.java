package com.invessence.web.bean.consumer;

import java.util.*;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;
import javax.faces.event.*;

import com.invessence.web.bean.common.UserInterface;
import com.invessence.web.constant.*;
import com.invessence.web.dao.common.*;
import com.invessence.web.dao.consumer.*;
import com.invessence.web.data.common.*;
import com.invmodel.model.ModelUtil;
import com.invmodel.risk.data.*;
import org.apache.commons.logging.*;
import org.primefaces.event.*;

/**
 * Created by prashant on 11/16/2017.
 */
public class PortfolioCreationUI extends UserInterface
{

   @ManagedProperty("#{modelUtil}")
   public ModelUtil modelUtil;

   @ManagedProperty("#{consumerListDataDAO}")
   public ConsumerListDataDAO listDAO;

   @ManagedProperty("#{userInfoDAO}")
   public UserInfoDAO userInfoDAO;

   @ManagedProperty("#{consumerSaveDataDAO}")
   public ConsumerSaveDataDAO saveDAO;

   @ManagedProperty("#{tradeDAO}")
   public TradeDAO tradeDAO;


   public enum UIMode {
      New("N"),
      Edit("E"),
      Review("R"),
      Startover("S"),
      ChangeStrategy("C"),
      Confirm("A"),
      View("V"),
      Advisor("Advisor");

      String codeValue;

      UIMode(String codeValue)
      {
         this.codeValue = codeValue;
      }

      public String getCodeValue()
      {
         return codeValue;
      }

      private static final Map lookup =
         new HashMap();
      static {
         //Create reverse lookup hash map
         for(UIMode m : UIMode.values())
            lookup.put(m.getCodeValue(), m);
      }

      public static UIMode get(String value) {
         //the reverse lookup by simply getting
         //the value from the lookup HsahMap.
         return (UIMode) lookup.get(value);
      }
   }

   public enum ChangeStrategyOptions {
      Question,
      Direct
   }

   enum UIAssetChart {
      Pie("P"),
      Donut("D"),
      Bar("B");

      String assetchart;

      UIAssetChart(String assetchart)
      {
         this.assetchart = assetchart;
      }

      public String getAssetchart()
      {
         return assetchart;
      }
   }

   public Long beanAcctnum;
   public UIMode beanmode;
   public String backURL;
   public String interfaceMode;
   public String selectedCSOption; // Selected Change Strategy Option

   private CustomerData savedCustomer = null;
   public CustomerData customer = null;
   public RiskCalc riskCalc = null;

   // UI management variables
   public Boolean formEdit = true;
   public Boolean canOpenAccount = true;

   // Panel Controls
   public Boolean welcomeDialog;
   public Boolean disablegraphtabs, disabledetailtabs;
   public Boolean displayGoalGraph;
   public Boolean displayDataPanel;
   public Boolean displayConfirmPanel;
   public Boolean dataOK = true;

   // Buttons
   public Boolean disableChangeStragegyButton;

   @Override
   public Log getLogger()
   {
      return logger;
   }

   public PortfolioCreationUI()
   {
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

   public Long getBeanAcctnum()
   {
      return beanAcctnum;
   }

   public void setBeanAcctnum(Long beanAcctnum)
   {
      this.beanAcctnum = converter.getLongData(beanAcctnum);
   }

   public void setBeanmode(String beanmode)
   {
      this.beanmode = UIMode.valueOf(beanmode);
      if (this.beanmode == null)
         this.beanmode = UIMode.New;
   }

   public Integer getInterfaceIntMode()
   {
      if (interfaceMode.equalsIgnoreCase(UIMode.ChangeStrategy.getCodeValue())) {
         return 1;
      }
      if (interfaceMode.equalsIgnoreCase(UIMode.Confirm.getCodeValue())) {
         return 2;
      }
      if (interfaceMode.equalsIgnoreCase(UIMode.Review.getCodeValue())) {
         return 3;
      }
      return 0;
   }
   public String getInterfaceMode()
   {
      return interfaceMode;
   }

   public void setInterfaceMode(String interfaceMode)
   {
      this.interfaceMode = interfaceMode;
      if (interfaceMode != null && beanmode == null)
      {
         beanmode = UIMode.get(interfaceMode);
      }
   }

   public String getBackURL()
   {
      return backURL;
   }

   public void setBackURL(String backURL)
   {
      this.backURL = backURL;
   }

   public String getSelectedCSOption()
   {
      return selectedCSOption;
   }

   public void setSelectedCSOption(String selectedCSOption)
   {
      this.selectedCSOption = selectedCSOption;
   }

   public CustomerData getSavedCustomer()
   {
      return savedCustomer;
   }

   public CustomerData getCustomer()
   {
      return customer;
   }

   public RiskCalc getRiskCalc()
   {
      return riskCalc;
   }

   public Boolean getCanOpenAccount() {
      return canOpenAccount;
   }

   public void initUI() {
      formEdit = false;
      disablegraphtabs = true;
      disabledetailtabs = true;
      disableChangeStragegyButton = true;
      welcomeDialog = true;
      displayGoalGraph = false;
      displayDataPanel=false;
      displayConfirmPanel=false;
      backURL=null;

      setInterfaceMode(UIMode.New.toString());
      resetData();
   };


   public void preRenderView()
   {

      try
      {
         if (!FacesContext.getCurrentInstance().isPostback())
         {
            customer.setCalcFormula(RiskConst.CALCFORMULAS.C.toString());
            // For both new and existing client, this fetch is called.  It determines the default values.
            fetchClientData();

/*
            if(FacesContext.getCurrentInstance().getExternalContext().getSessionMap().get("ProfileCnf")!=null){
               setInterfaceMode(UIMode.Confirm.toString());
               // dsplStrategyCnfPnl=(Boolean)FacesContext.getCurrentInstance().getExternalContext().getSessionMap().get("ProfileCnf");
               FacesContext.getCurrentInstance().getExternalContext().getSessionMap().remove("ProfileCnf");
            }

            if(FacesContext.getCurrentInstance().getExternalContext().getSessionMap().get("ProfileCnf1")!=null){
               FacesContext.getCurrentInstance().getExternalContext().getSessionMap().remove("ProfileCnf1");
               setInterfaceMode(UIMode.New.toString());
            }
*/
         }
      }
      catch (Exception e)
      {
         resetData();
      }
   }

   public void resetData()
   {
      customer = new CustomerData();

      // This is short term solution.  Since Data needs DAO object to collect data.
      // We are passing it as collected on UI.
      customer.initDao(webutil, modelUtil, uiLayout,
                       listDAO, userInfoDAO,
                       saveDAO, tradeDAO,
                       messageText);
      customer.setDefault();
   }

   public void fetchClientData()
   {
      try
      {
         resetData();
         if (beanAcctnum != null && beanAcctnum > 0L)
         {
            loadProfileData(beanAcctnum);
            customer.setSaveVisitor(false);
            if (beanmode != null && beanmode == UIMode.ChangeStrategy)
            {
               savedCustomer = new CustomerData();
               savedCustomer.copyData(customer);  // Need a way to do clean copy.
            }
            else {
               setInterfaceMode(UIMode.Edit.toString());
            }
         }
         else
         {
            // 1) Remember we called New account from Dashboard.  So the first case is based on Dashboard.
            if(webutil.isUserLoggedIn())  {
               customer.setSaveVisitor(false);
            }

            setInterfaceMode(UIMode.New.toString());
            customer.loadNewClientData();

         }

         webMenuList = listCommonDAO.loadWebPagesMenuItems(customer.getAdvisor());
      }
      catch (Exception ex)
      {
         String stackTrace = ex.getMessage();
         webutil.alertSupport("PortfolioCreation.fetchClient", "Error:PortfolioCreation.fetchClient",
                              "error.fetchClient", stackTrace);
      }

   }


   public void loadProfileData(Long acctnum)
   {

      try
      {
         customer.loadProfileData(acctnum);
         customer.loadRiskData();
         formEdit = false;
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }


   public void onAllocSlider(SlideEndEvent event)
   {
//      System.out.println(event.getValue());
      customer.riskProfile.setCalcFormula(RiskConst.CALCFORMULAS.D.toString());
      customer.riskProfile.setScore(event.getValue());
      customer.riskProfile.setAssetScore(event.getValue());
      formEdit = true;
      createAssetPortfolio();
   }

   public void onPortfolioSlider(SlideEndEvent event)
   {
      //setDefaultRiskIndex(event.getValue());
      customer.riskProfile.setCalcFormula(RiskConst.CALCFORMULAS.D.toString());
      customer.riskProfile.setPortfolioScore(event.getValue());
      formEdit = true;
      createAssetPortfolio();
   }

   public void doAllocReset()
   {
      customer.riskProfile.setCalcFormula(RiskConst.CALCFORMULAS.C.toString());
      createAssetPortfolio();
//      System.out.println(" doAllocReset ind "+getAllocationIndex());
      customer.setSliderAllocationIndex(customer.riskProfile.getStandardScore(0).intValue());
   }

   public void refresh()
   {
      createAssetPortfolio();
   }

   public void createAssetPortfolio()
   {
         formEdit = true;
         riskCalc.calculate(1);
         customer.createAssetPortfolio();
         chart.createAssetChart(customer.getAssetData(), webutil);
         canOpenAccount = riskCalc.getKnockOutFlag();
   }

   public void saveProfile()
   {
      long acctnum;
      try
      {
         if (customer.getCanSaveData())
         {
            customer.saveProfile();
            formEdit = false;
         }
      }
      catch (Exception ex)
      {
         String stackTrace = ex.getMessage();
         webutil.alertSupport("ConsumerEdit.saveprofile", "Error:ConsumerEdit.SaveProfile",
                              "error.saveprofile", stackTrace);
      }

   }

   public void savePrefProfile(ActionEvent event)
   {
      createAssetPortfolio();
      customer.saveProfile();
      formEdit = false;
   }

   public void savePanelProfile()
   {
      customer.saveProfile();
      formEdit = false;
      // RequestContext.getCurrentInstance().openDialog("/pages/consumer/fundingDialog.xhtml");
   }


   // Page Manaagement
   public Boolean getEnableNextButton()
   {
      return (! pagemanager.isLastPage());
   }

   public Integer getCurrentPage() {
      return ((pagemanager != null) ? pagemanager.getPage() : 0);
   }

   public Boolean getEnablePrevButton()
   {
      return (!pagemanager.isFirstPage());
   }

   public void gotoPrevPage()
   {
      if (! pagemanager.isFirstPage())
      {
         pagemanager.prevPage();
         progressbar.previousProgress();
      }
   }

   public void gotoNextPage()
   {
      if (!pagemanager.isLastPage())
      {
         pagemanager.nextPage();
         progressbar.nextProgress();
         saveProfile();
      }
   }

   public void gotoRiskQuestions() {
      progressbar.nextProgress();
      pagemanager.setPage(1);
      uiLayout.doMenuAction("consumer","portfolioCreate/cEdit.xhtml");
   }

   public void gotoReview() {
      progressbar.nextProgress();
      uiLayout.doMenuAction("consumer","portfolioCreate/review.xhtml");
   }

   public void gotoPortfolioCreation()
   {
      pagemanager.setPage(1);
   }

   public void gotoCustody() {
      if (canOpenAccount)
      {
         alertAdvisor();
         uiLayout.doMenuAction("custody", "index.xhtml?acct=" + getCustomer().getAcctnum().toString() + "&l=" + getCustomer().getLogonid());
      }
      else {
         alertAdvisor();
         uiLayout.getDefaultDashBoard();
      }
   }

   public void gotoCSStrategy() {
      if (selectedCSOption == null) {
         pagemanager.setErrorMessage("Must choose one of the choices below");
         return;
      }

      if (selectedCSOption.equalsIgnoreCase(ChangeStrategyOptions.Question.toString()))
      {
         uiLayout.doMenuAction("custody", "portfolioCreate/cEdit.xhtml");
      }
      else {
         gotoReview();
      }
   }

   public void cancelCS() {
      if (backURL != null)
      {
         uiLayout.forwardURL(backURL);
         return;
      }
      uiLayout.getDefaultDashBoard();
   }

   // Data Management save/Updates

   public Double getExchangeRate(Double money) {
      Double exchRate = 1.0;
      if (listDAO != null)
      {
         String from = getCustomer().getTradeCurrency();
         String to = getCustomer().getSettleCurrency();
         if (from != null && to != null)
            exchRate = listDAO.getExchangeRate(from, to);
      }
      if (money != null && exchRate > 0.0) {
         return (money * exchRate);
      }
      return money;
   }

   public void saveAccount()
   {
      long acctnum;
      try
      {
         customer.saveProfile();

         if (customer.getDoesUserHavaLogonID())
         {
            gotoCustody(); // If user is already looged in then redirect to opne account page.
         }
         else
         {
            pagemanager.nextPage();
         }

      }
      catch (Exception ex)
      {
         String stackTrace = ex.getMessage();
         ex.printStackTrace();
         webutil.alertSupport("UOBProfile.saveAccount", "Error:UOBProfile.saveAccount",
                              "error.saveAccount", stackTrace);
      }

   }

   public String registerUser()
   {
      String msgheader, msg = "";
      try
      {
         if (! userInfoDAO.validateFormat(getCustomer().getEmail()))
         {
            msgheader = "signup.U000";
            msg = webutil.getMessageText().getDisplayMessage(msgheader, "This Email format is invalid!", null);
            return msg;
         }


         UserData userdata = new UserData();
         userdata.setFirstName(getCustomer().getFirstname());
         userdata.setLastName(getCustomer().getLastname());
         userdata.setFullName(getCustomer().getName());
         userdata.setRegfullname(getCustomer().getName());
         userdata.setEmail(getCustomer().getEmail());
         userdata.setUserID(getCustomer().getEmail());
         userdata.setIp(webutil.getClientIpAddr());

      if (userInfoDAO.validateUserID(userdata))
      {
         logger.debug("LOG: Validate UserID failed: " + getCustomer().getEmail());
         msgheader = "signup.U100";
         msg = webutil.getMessageText().getDisplayMessage(msgheader, "This Email is already registered!", null);
         return msg;
      }

         customer.saveProfile();  // We need to save Profile, in order to create a new account number.
         userdata.setAcctnum(getCustomer().getAcctnum());
         Integer myResetID = webutil.randomGenerator(0, 347896);
         userdata.setUserInfo(WebConst.ROLE_USER, getCustomer().getAdvisor(), getCustomer().getRep(), myResetID);
         long loginID = userInfoDAO.addUserInfo(userdata);

         if (loginID <= 0L)
         {
            logger.debug("ERROR: Had issue with this userid (" + userdata.getEmail() +") when attempting to save: " + loginID);
            msgheader = "signup.U106";
            msg = webutil.getMessageText().getDisplayMessage(msgheader, "There was some error when attempting to save this userid.  Please reach out to support desk.", null);
            // webutil.alertSupport("Userbean.saveUser", "Save -" + getCustomer().getEmail(), "Save Registration Error", null);
            return msg;
         }

         userdata.setLogonID(loginID);
         getCustomer().setLogonid(loginID);
         webutil.sendConfirmation(userdata, "W");
      }
      catch (Exception ex)
      {
         msgheader = "signup.EX.100";
         msg = webutil.getMessageText().getDisplayMessage(msgheader, "Exception: Create UserID/Pwd, problem attempting to create simpleuser", null);
         FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, msg, msgheader));
         // ex.printStackTrace();
         return msg;
      }
      return msg;
   }

   // Fine Tune Panel/Widget Management
   public void showFTPanel()
   {
/*    To redesign
      if (customer.getSavedRiskFormula() == null || customer.getSavedRiskFormula().isEmpty())
      {
         customer.setSavedRiskFormula(customer.getRiskCalcMethod());
//         System.out.println(" showFTPanel if  ind "+getAllocationIndex());
         customer.setSavedAllocSliderIndex(customer.getAllocationIndex());
      }
//      System.out.println(" showFTPanel ifouter  ind "+getAllocationIndex());
      setSliderAllocationIndex(getAllocationIndex());
      setDisplayFTPanel(true);
      setEnableChangeStrategy(false);
      setAltrOnChngStrategy(false);
//      System.out.println("riskVariance "+riskVariance);
      if(formEdit)
      {
         setCstmSliderMaxAlloc(((getAllocationIndex() + riskVariance) >= 99 ? 99 : getAllocationIndex() + riskVariance));
         setCstmSliderMinAlloc(((getAllocationIndex() - riskVariance) < 0 ? 0 : getAllocationIndex() - riskVariance));
      }else{
         setCstmSliderMaxAlloc(((riskCalculator.getRiskByQuestion().intValue() + riskVariance) >= 99 ? 99 : riskCalculator.getRiskByQuestion().intValue() + riskVariance));
         setCstmSliderMinAlloc(((riskCalculator.getRiskByQuestion().intValue() - riskVariance) < 0 ? 0 : riskCalculator.getRiskByQuestion().intValue() - riskVariance));
      }
*/

   }

   public void saveFTPanel() {
/*
      setSavedRiskFormula(getRiskCalcMethod());
//      System.out.println(" saveFTPanel ifouter  ind "+getAllocationIndex());
      setSavedAllocSliderIndex(getAllocationIndex());
      setSliderAllocationIndex(getAllocationIndex());
      if(formEdit){
         riskCalculator.setRiskOverride(Double.parseDouble(""+getAllocationIndex()));
      }else{
         riskCalculator.setRiskByQuestion(Double.parseDouble(""+getAllocationIndex()));
      }
      savePanelProfile();
      closeFTPanel();
*/
   }

   public void closeFTPanel() {
/*
      setDisplayFTPanel(false);
      setEnableChangeStrategy(true);
      setAltrOnChngStrategy(true);
      // RequestContext context = RequestContext.getCurrentInstance();
      //context.execute("PF('wvfineTunePanel.hide()')");
      //context.update("fineTunePanel");
*/
   }

   public void cancelFTPanel() {
/*
//      System.out.println("cancelFTPanel In");
      setRiskCalcMethod(getSavedRiskFormula());
      setSliderAllocationIndex(getSavedAllocSliderIndex());
      // riskCalculator.setRiskFormula(savedRiskFormula);
      setAllocationIndex(getSavedAllocSliderIndex());
      Double riskIndex = riskCalculator.calculateRisk();
      createAssetPortfolio(1, riskIndex);
      closeFTPanel();
//      System.out.println("cancelFTPanel Out");
*/
   }


   public void alertAdvisor() {

      customer.tradeDAO.saveTradeProcessIdentifier(customer.getAcctnum(),
                                          WebConst.TRADE_PROCESS_ALLOC,
                                          WebConst.TRADE_PROCESS_STAT_NEW,
                                          "Changed Strategy");
      customer.setCanSaveData(true);
      formEdit = true;
      customer.saveProfile();
   }

   // Charting management
   public void setDisplayHC2DDonutData(String ignore) {
      return;
   };

   public String getDisplayHC2DDonutData() {
      if (getChart() != null) {
         if (getChart().chartData != null)
            return getChart().chartData.toString();
      }
      String defaultValue = "[" +
         "{\"name\":\"Fixed Income\",\"y\":41,\"drilldown\":\"Fixed Income\",\"color\":\"#47566D\",\"amount\":45601}, " +
         "{\"name\":\"Equity\",\"y\":69,\"drilldown\":\"Equity\",\"color\":\"#333F50\",\"amount\":58641} ]";

      return defaultValue;
   }

   public void setDisplayRiskScore(Integer value) { return; }

      public Integer getDisplayRiskScore() {
      Integer score = 0;
      if (riskCalc != null) {
         score = riskCalc.getScore(0).intValue();
      }
      return score;
   }


}
