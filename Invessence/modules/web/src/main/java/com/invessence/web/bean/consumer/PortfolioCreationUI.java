package com.invessence.web.bean.consumer;

import java.lang.reflect.Array;
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
import com.invessence.web.util.*;
import com.invmodel.asset.data.AssetClass;
import com.invmodel.model.ModelUtil;
import com.invmodel.performance.data.ProjectionData;
import com.invmodel.portfolio.data.Portfolio;
import com.invmodel.risk.data.*;
import org.apache.commons.logging.*;
import org.primefaces.event.*;
import org.primefaces.model.chart.BarChartModel;

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

   @ManagedProperty("#{consumerAuditDataDAO}")
   public ConsumerAuditDataDAO auditDAO;

   @ManagedProperty("#{tradeDAO}")
   public TradeDAO tradeDAO;

   public enum UIMode
   {
      New("N"),//Status 0
      Edit("E"),//Status 0
//      Startover("S"),
      ChangeStrategy("C"),//Status 1
      Confirm("A"),//Status = 2
      Review("R"),//Status > 2
      View("V") ; //Status > 2
//      Advisor("1");//Status > 2;

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

      static
      {
         //Create reverse lookup hash map
         for (UIMode m : UIMode.values())
         {
            lookup.put(m.getCodeValue(), m);
         }
      }

      public static UIMode get(String value)
      {
         //the reverse lookup by simply getting
         //the value from the lookup HsahMap.
         return (UIMode) lookup.get(value);
      }
   }

   public enum ChangeStrategyOptions
   {
      Question,
      Direct
   }

   enum UIAssetChart
   {
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
   public Boolean disablegraphtabs, disabledetailtabs,disableApproveBtn=true;
   public Boolean displayGoalGraph;
   public Boolean displayDataPanel;
   public Boolean displayConfirmPanel;
   public Boolean displayFTPanel;
   public Boolean dataOK = true;

   // Buttons
   public Boolean disableChangeStragegyButton ,recurInvstPrdFlag,recurInvstAmtFlg;
   public Boolean csCheck1 = false, csCheck2 = false;


   @Override
   public Log getLogger()
   {
      return logger;
   }

   public PortfolioCreationUI()
   {
   }

   public void initUI()
   {
      formEdit = false;
      disablegraphtabs = true;
      disabledetailtabs = true;
      disableChangeStragegyButton = true;
      welcomeDialog = true;
      displayGoalGraph = false;
      displayDataPanel = false;
      displayConfirmPanel = false;
      backURL = null;
      displayFTPanel=false;
      csCheck1=false;
      csCheck2=false;
      selectedCSOption="";
      disableApproveBtn=true;
      recurInvstPrdFlag=false;
      recurInvstAmtFlg=false;
//      customer=resetData();
   }

   public void preRenderView()
   {

      try
      {
         if (!FacesContext.getCurrentInstance().isPostback())
         {
            // For both new and existing client, this fetch is called.  It determines the default values.
            fetchClientData();
            customer.setCalcFormula(RiskConst.CALCFORMULAS.C.toString());
         }
      }
      catch (Exception e)
      {
         resetData();
      }
   }

   public CustomerData resetData()
   {
      CustomerData customer = new CustomerData();
      if(beanmode.equals(UIMode.New)){
         setBeanAcctnum(null);
      }
      // This is short term solution.  Since Data needs DAO object to collect data.
      // We are passing it as collected on UI.
      customer.initDao(webutil, modelUtil, uiLayout,
                       listDAO, userInfoDAO,
                       saveDAO, tradeDAO,
                       messageText,auditDAO);
      customer.setDefault();
      return customer;
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

   public void setAuditDAO(ConsumerAuditDataDAO auditDAO)
   {
      this.auditDAO = auditDAO;
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
      {
         this.beanmode = UIMode.New;
      }
   }

   public Integer getInterfaceIntMode()
   {
      if (interfaceMode.equalsIgnoreCase(UIMode.New.getCodeValue()) || interfaceMode.equalsIgnoreCase(UIMode.Edit.getCodeValue()))
      {
         return 0;
      }
      if (interfaceMode.equalsIgnoreCase(UIMode.ChangeStrategy.getCodeValue()))
      {
         return 1;
      }
      else
      {
         if (interfaceMode.equalsIgnoreCase(UIMode.Confirm.getCodeValue()))
         {
            return 2;
         }
         else
         {
            return 3;
         }
//         if (interfaceMode.equalsIgnoreCase(UIMode.Review.getCodeValue()))
//         {
//            return 3;
//         }
      }

//      return 0;
   }

   public String getInterfaceMode()
   {
      return interfaceMode;
   }

   public void setInterfaceMode(String interfaceMode)
   {
      this.interfaceMode = interfaceMode;
      if (interfaceMode != null)
      {
         beanmode = UIMode.get(interfaceMode);
      }
      else
      {
         beanmode = UIMode.New;
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

   public Boolean getDisplayFTPanel()
   {
      return displayFTPanel;
   }

   public void setDisplayFTPanel(Boolean displayFTPanel)
   {
      this.displayFTPanel = displayFTPanel;
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

   public Boolean getCanOpenAccount()
   {
      return canOpenAccount;
   }

   public void setCanOpenAccount(Boolean flag)
   {
      canOpenAccount = flag;
   }

   public Boolean getCsCheck1()
   {
      return csCheck1;
   }

   public void setCsCheck1(Boolean csCheck1)
   {
      this.csCheck1 = csCheck1;
   }

   public Boolean getCsCheck2()
   {
      return csCheck2;
   }

   public void setCsCheck2(Boolean csCheck2)
   {
      this.csCheck2 = csCheck2;
   }

   public Boolean getConfirmationCSCheck() {
      return (csCheck1 && csCheck2);
   }

   public void fetchClientData()
   {
      try
      {
         customer=resetData();
         if (beanAcctnum != null && beanAcctnum > 0L)
         {
            loadProfileData(customer,beanAcctnum);
            customer.setSaveVisitor(false);
            if (beanmode != null && (beanmode == UIMode.ChangeStrategy || beanmode == UIMode.Confirm ||beanmode == UIMode.Edit))
            {
               savedCustomer = resetData();
               loadProfileData(savedCustomer,beanAcctnum);
            }
         }
         else
         {
            // 1) Remember we called New account from Dashboard.  So the first case is based on Dashboard.
            if (webutil.isUserLoggedIn())
            {
               customer.setSaveVisitor(false);
            }

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


   public void loadProfileData(CustomerData customer,Long acctnum)
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
      Integer eventValue;
      if (event != null) {
         eventValue = event.getValue();
         customer.riskProfile.setCalcFormula(RiskConst.CALCFORMULAS.D.toString());
         riskCalc.setRiskFormula(RiskConst.CALCFORMULAS.D);
         riskCalc.setAssetRisk(0,eventValue.doubleValue());
         formEdit = true;
         createAssetPortfolio();
      }
   }

   public void onPortfolioSlider(SlideEndEvent event)
   {
      Integer eventValue;
      if (event != null) {
         eventValue = event.getValue();
         customer.riskProfile.setCalcFormula(RiskConst.CALCFORMULAS.D.toString());
         riskCalc.setRiskFormula(RiskConst.CALCFORMULAS.D);
         riskCalc.setPortfolioRisk(0,eventValue.doubleValue());
         formEdit = true;
         createAssetPortfolio();
      }
   }

   public void doAllocReset()
   {
      customer.riskProfile.setCalcFormula(RiskConst.CALCFORMULAS.C.toString());
      riskCalc.setRiskFormula(RiskConst.CALCFORMULAS.C);
      // Note: createAssetPortfolio has calculate method call.  We just need to reset the switch.
      createAssetPortfolio();
      customer.setSliderAllocationIndex(riskCalc.getRiskScore().intValue());


//      riskCalc.setRiskFormula(RiskConst.CALCFORMULAS.C);
//      createAssetPortfolio();

   }

   public void refresh()
   {
      createAssetPortfolio();
   }

   public void createAssetPortfolio()
   {
      AssetClass[] aamc;
      Portfolio[] pfclass;
      try
      {
         formEdit = true;
         riskCalc.calculate();

         getCustomer().setAssetData(null);
         aamc = new AssetClass[1];
         aamc[0] = modelUtil.createAssetAllocation(riskCalc);
         if (aamc[0] != null)
         {
            getCustomer().setAssetData(aamc);
            pfclass = new Portfolio[1];
            pfclass[0] = modelUtil.createPortfolioAllocation(aamc[0], riskCalc);
            if (pfclass[0] != null)
            {
               getCustomer().setPortfolioData(pfclass);
               getCustomer().loadPortfolioList(0);
               getCustomer().rollupAssetClass(pfclass[0]);
               getCustomer().buildHistoricalReturns();
            }
            chart.createAssetChart(customer.getAssetData(), webutil);
            setCanOpenAccount(!riskCalc.getKnockOutFlag()); // Knockout returns true, so canOpen needs to be set false!
         }
      }
      catch (Exception ex)
      {
         ex.printStackTrace();
      }
   }

   public void createGlidePath() {
      Integer horizon = riskCalc.getDefaultHorizon();
      Integer withdrawl = (riskCalc.getWithDrwalPeriod() == null) ? 1 : riskCalc.getWithDrwalPeriod();

      /*
      riskCalc.setAge(50);
      riskCalc.setWithDrwalPeriod(5);
      riskCalc.setWithdrawlamount(20000.00);
      */

      ArrayList<ProjectionData> projectionDatas = modelUtil.createGlidePath(horizon + withdrawl, riskCalc);
      chart.createGlidePath(projectionDatas);
   }

   public BarChartModel getGlidePath() {
      return chart.getGlidePath();
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
      return (!pagemanager.isLastPage());
   }

   public Integer getCurrentPage()
   {
      return ((pagemanager != null) ? pagemanager.getPage() : 0);
   }

   public Boolean getEnablePrevButton()
   {
      return (!pagemanager.isFirstPage());
   }

   public void gotoPrevPage()
   {
      if (!pagemanager.isFirstPage())
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

   public void gotoRiskQuestions()
   {
      riskCalc.setRiskFormula(RiskConst.CALCFORMULAS.C);
      getCustomer().getRiskProfile().setCalcFormula(RiskConst.CALCFORMULAS.C.toString());
      createAssetPortfolio();
      progressbar.nextProgress();
      pagemanager.setPage(0);
      uiLayout.doMenuAction("consumer", "portfolioCreate/cEdit.xhtml");
   }

   public void gotoFinalConfim()
   {
      if (beanmode.equals(UIMode.Confirm))
      {
         uiLayout.doMenuAction("consumer", "portfolioCreate/finalConfirm.xhtml");
         return;
      }
      if (beanmode.equals(UIMode.ChangeStrategy))
      {
         uiLayout.doMenuAction("consumer", "portfolioCreate/finalCS.xhtml");
         return;
      }
      goBack();
   }

   public void gotoReview()
   {
      progressbar.nextProgress();
      saveProfile();
      if (canOpenAccount)
      {
         uiLayout.doMenuAction("consumer", "portfolioCreate/review.xhtml");
      }
      else
      {
         uiLayout.doMenuAction("consumer", "portfolioCreate/knockout.xhtml");
      }
   }

   public void goBack()
   {
      if (backURL != null)
      {
         uiLayout.forwardURL(backURL);
         return;
      }
//      uiLayout.getDefaultDashBoard();
      uiLayout.forwardURL(uiLayout.getDefaultDashBoard());
   }

   public void gotoPortfolioConfirm()
   {
      customer.setCanSaveData(true);
      formEdit = true;
      if (customer.getManaged())
      {
         customer.saveProfileAudit(); //Need to enhance for audit activity
      }
      customer.saveProfile();
      if (beanmode.equals(UIMode.Confirm) && customer.getManaged())
      {
         saveDAO.manageUserProfile(getCustomer().getAcctnum(), "E", getCustomer().getLogonid());
      }
      if (beanmode.equals(UIMode.ChangeStrategy) && customer.getManaged())
      {
         saveDAO.manageUserProfile(getCustomer().getAcctnum(), "R", getCustomer().getLogonid());
      }
      if (customer.getManaged())
      {
         alertAdvisor();
      }
      goBack();
   }


   public void gotoPortfolioCreation()
   {
      pagemanager.setPage(1);
   }

   public void gotoCustody()
   {
      if (beanmode.equals(UIMode.New) || beanmode.equals(UIMode.Edit))
      {
         if (canOpenAccount)
         {
            alertAdvisor();
            uiLayout.doMenuAction("custody", "index.xhtml?acct=" + getCustomer().getAcctnum().toString() + "&l=" + getCustomer().getLogonid());
         }
      }
      else
      {
         if (beanmode.equals(UIMode.ChangeStrategy)) {
//            alertAdvisor();
            uiLayout.doMenuAction("consumer", "portfolioCreate/finalCS.xhtml");

         }
         else if (beanmode.equals(UIMode.Confirm)) {
//            alertAdvisor();
            uiLayout.doMenuAction("consumer", "portfolioCreate/finalConfirm.xhtml");

         }
         else
         {
            uiLayout.getDefaultDashBoard();
         }
      }
   }

   public void gotoCSStrategy()
   {
      if (selectedCSOption == null)
      {
         pagemanager.setErrorMessage("Must choose one of the choices below");
         return;
      }

      if (selectedCSOption.equalsIgnoreCase(ChangeStrategyOptions.Question.toString()))
      {
         gotoRiskQuestions();
      }
      else
      {
         gotoReview();
      }
   }

   public void cancelCS()
   {
      goBack();
   }

   // Data Management save/Updates

   public Double getExchangeRate()
   {
      Double exchRate = 1.0;
      if (listDAO != null)
      {
         String from = getCustomer().getTradeCurrency();
         String to = getCustomer().getSettleCurrency();
         if (from != null && to != null)
         {
            exchRate = listDAO.getExchangeRate(from, to);
         }
      }
      return exchRate;
   }

   public Double getConvertMoneyToSettlementCurrency(Double money)
   {
      if (money != null)
      {
         Double exchRate = getExchangeRate();
         return (money * ((exchRate == null) ? 1.0 : exchRate));
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
         String defaultAdvsor= getWebutil().getWebprofile().getWebInfo().get("DEFAULT.ADVISOR");
         if (!userInfoDAO.validateEmail(getCustomer().getEmail()))
         {
            msgheader = "signup.U000";
            msg = webutil.getMessageText().getDisplayMessage(msgheader, "This email format is invalid. Please re-enter email address.", null);
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

            if(defaultAdvsor.equalsIgnoreCase("UOB"))
            {
               msg = webutil.getMessageText().getDisplayMessage("validator.uob.email.alreadyExist", "This email address is already registered.", null);
            }else{
               msg = webutil.getMessageText().getDisplayMessage(msgheader, "This email address is already registered!", null);
            }
            return msg;
         }

         customer.saveProfile();  // We need to save Profile, in order to create a new account number.
         userdata.setAcctnum(getCustomer().getAcctnum());
         Integer myResetID = webutil.randomGenerator(0, 347896);
         userdata.setUserInfo(WebConst.ROLE_USER, getCustomer().getAdvisor(), getCustomer().getRep(), myResetID);
         // TODO: Enable logon feature
         long loginID = userInfoDAO.addUserInfo(userdata);

         if (loginID <= 0L)
         {
            logger.debug("ERROR: Had issue with this userid (" + userdata.getEmail() + ") when attempting to save: " + loginID);
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
         msg = webutil.getMessageText().getDisplayMessage(msgheader, "Exception: Create UserID/Pwd, problem attempting to create simple user", null);
         FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, msg, msgheader));
         // ex.printStackTrace();
         return msg;
      }
      return msg;
   }

   // Fine Tune Panel/Widget Management
   public void showFTPanel()
   {
      setDisplayFTPanel(true);
   }

   public void closeFTPanel()
   {
      setDisplayFTPanel(false);
   }

   public void saveFTPanel()
   {
      closeFTPanel();
      riskCalc.setRiskFormula(RiskConst.CALCFORMULAS.D);
      getCustomer().getRiskProfile().setCalcFormula(RiskConst.CALCFORMULAS.D.toString());
      // This one will save the score in userRisk table as well
      riskCalc.setScore(0, riskCalc.getRiskScore());
      createAssetPortfolio();
      saveProfile();
   }

   public void cancelFTPanel()
   {
      closeFTPanel();
      // Just change the mode and let calculate function recalculate the new score.
      riskCalc.setRiskFormula(RiskConst.CALCFORMULAS.C);
      getCustomer().getRiskProfile().setCalcFormula(RiskConst.CALCFORMULAS.C.toString());
      // Note: createAssetPortfolio has calculate call.
      createAssetPortfolio();
   }

   public void allocDecrement() {
      Double thisScore = riskCalc.getRiskScore();
      if (thisScore > riskCalc.getScoreLowerBound())
      {
//         riskCalc.setRiskScore(thisScore - 1.0);
         customer.riskProfile.setCalcFormula(RiskConst.CALCFORMULAS.D.toString());
         riskCalc.setRiskFormula(RiskConst.CALCFORMULAS.D);
//         riskCalc.setIntRiskScore(riskCalc.getIntRiskScore()-1);
         riskCalc.setRiskScore(riskCalc.getIntRiskScore().doubleValue() - 1.0);
         riskCalc.setAssetRisk(0,riskCalc.getIntRiskScore().doubleValue() - 1.0);
         formEdit = true;
         createAssetPortfolio();
      }

   }

   public void allocIncrement() {
      Double thisScore = riskCalc.getRiskScore();
      if (thisScore < riskCalc.getScoreUpperBound())
      {
//         riskCalc.setRiskScore(thisScore + 1.0);

         customer.riskProfile.setCalcFormula(RiskConst.CALCFORMULAS.D.toString());
         riskCalc.setRiskFormula(RiskConst.CALCFORMULAS.D);
//         riskCalc.setIntRiskScore(riskCalc.getIntRiskScore() + 1);
         riskCalc.setRiskScore(riskCalc.getIntRiskScore().doubleValue() + 1.0);
         riskCalc.setAssetRisk(0,riskCalc.getIntRiskScore().doubleValue() + 1.0);
         formEdit = true;
         createAssetPortfolio();
      }
   }

   public void alertAdvisor()
   {
      customer.tradeDAO.saveTradeProcessIdentifier(customer.getAcctnum(),
                                                   WebConst.TRADE_PROCESS_ALLOC,
                                                   WebConst.TRADE_PROCESS_STAT_NEW,
                                                   beanmode.toString());

   }

   // Charting management
   public void setDisplayHC2DDonutData(String ignore)
   {
      return;
   }

   ;

   public String getDisplayHC2DDonutData()
   {
      if (getChart() != null)
      {
         if (getChart().chartData != null)
         {
            return getChart().chartData.toString();
         }
      }
      String defaultValue = "[" +
         "{\"name\":\"Fixed Income\",\"y\":41,\"drilldown\":\"Fixed Income\",\"color\":\"#47566D\",\"amount\":45601}, " +
         "{\"name\":\"Equity\",\"y\":69,\"drilldown\":\"Equity\",\"color\":\"#333F50\",\"amount\":58641} ]";

      return defaultValue;
   }

   public void setDisplayRiskScore(Integer value)
   {
      return;
   }

   public Integer getDisplayRiskScore()
   {
      Integer score = 0;
      if (riskCalc != null)
      {
         score = riskCalc.getScore(0).intValue();
      }
      return score;
   }

   public Boolean getDisableApproveBtn()
   {
      return disableApproveBtn;
   }

   public void setDisableApproveBtn(Boolean disableApproveBtn)
   {
      this.disableApproveBtn = disableApproveBtn;
   }
   public void enableApproveBtn()
   {
      setDisableApproveBtn(true);
      if (beanmode.equals(UIMode.ChangeStrategy) && getCsCheck1() && getCsCheck2())
      {
         setDisableApproveBtn(false);
      }
      else if (beanmode.equals(UIMode.Confirm) && getCsCheck1())
      {
         setDisableApproveBtn(false);
      }
   }
   public void enableChangeStragegyButton(){
      if(getSelectedCSOption()!=null && !getSelectedCSOption().trim().equalsIgnoreCase("")){
         setDisableChangeStragegyButton(false);
      }else{
         setDisableChangeStragegyButton(true);
      }
   }

   public Boolean getDisableChangeStragegyButton()
   {
      return disableChangeStragegyButton;
   }

   public void setDisableChangeStragegyButton(Boolean disableChangeStragegyButton)
   {
      this.disableChangeStragegyButton = disableChangeStragegyButton;
   }

   public void enableRecurInvstPnl(){
         recurInvstPrdFlag= true;
        // recurInvstPrdFlag = getCustomer().getRecurringInvestment() != null && getCustomer().getRecurringInvestment() > 0;

   }

   public Boolean getRecurInvstPrdFlag()
   {
      return recurInvstPrdFlag;
   }

   public void setRecurInvstPrdFlag(Boolean recurInvstPrdFlag)
   {
      this.recurInvstPrdFlag = recurInvstPrdFlag;
   }

   public Boolean getRecurInvstAmtFlg()
   {
      return recurInvstAmtFlg;
   }

   public void setRecurInvstAmtFlg(Boolean recurInvstAmtFlg)
   {
      this.recurInvstAmtFlg = recurInvstAmtFlg;
   }
}
